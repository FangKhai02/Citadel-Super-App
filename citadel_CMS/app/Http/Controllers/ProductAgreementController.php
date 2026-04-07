<?php

namespace App\Http\Controllers;

use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use TCG\Voyager\Http\Controllers\VoyagerBaseController;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Events\BreadDataAdded;
use TCG\Voyager\Events\BreadDataUpdated;
use App\Models\ProductAgreement;
use Illuminate\Support\Facades\Storage;

class ProductAgreementController extends VoyagerBaseController
{
    /**
     * POST BRE(A)D - Store data.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('add', app($dataType->model_name));

        // Validate fields with ajax
        $val = $this->validateBread(
            $request->except('upload_document'), // Exclude the field
            $dataType->addRows
        )->validate();

        // Handle the HTML file upload for the document_editor
        if ($request->hasFile('upload_document')) {
            // Validate the uploaded HTML file
            $request->validate([
                'upload_document' => 'nullable|mimes:html|max:10240', // Max size is 10MB
            ]);

            // Get the uploaded HTML file
            $htmlFile = $request->file('upload_document');

            // Read the contents of the uploaded HTML file
            $htmlContent = file_get_contents($htmlFile->getPathname());
        } else {
            // Handle the case where no file is uploaded
            $htmlContent = null;
        }

        // Create a new instance of the model
        $data = new $dataType->model_name();

        // Insert or update the data
        $data = $this->insertUpdateData($request, $slug, $dataType->addRows, $data);

        // Save the HTML content into the document_editor field
        $data->document_editor = $htmlContent;

        // Save the ProductAgreement model
        $data->save();

        event(new BreadDataAdded($dataType, $data));

        if (!$request->has('_tagging')) {
            if (auth()->user()->can('browse', $data)) {
                $redirect = redirect()->route("voyager.{$dataType->slug}.index");
            } else {
                $redirect = redirect()->back();
            }

            return $redirect->with([
                'message'    => __('voyager::generic.successfully_added_new') . " {$dataType->getTranslatedAttribute('display_name_singular')}",
                'alert-type' => 'success',
            ]);
        } else {
            return response()->json(['success' => true, 'data' => $data]);
        }
    }


    public function update(Request $request, $id)
    {
        $slug = $this->getSlug($request);
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Compatibility with Model binding.
        $id = $id instanceof \Illuminate\Database\Eloquent\Model ? $id->{$id->getKeyName()} : $id;

        $model = app($dataType->model_name);
        $query = $model->query();

        // Apply scope if applicable
        if ($dataType->scope && method_exists($model, 'scope'.ucfirst($dataType->scope))) {
            $query = $query->{$dataType->scope}();
        }

        // Include soft-deleted models if applicable
        if ($model && in_array(SoftDeletes::class, class_uses_recursive($model))) {
            $query = $query->withTrashed();
        }

        $data = $query->findOrFail($id);

        // Check permission
        $this->authorize('edit', $data);

        // Validate fields with ajax
        $val = $this->validateBread($request->all(), $dataType->editRows, $dataType->name, $id)->validate();

        // Handle single file upload
        foreach ($dataType->editRows as $row) {
            if ($row->type === 'file' && $request->hasFile($row->field)) {
                // Remove the old file if a new file is uploaded
                $oldFile = $data->{$row->field};
                if ($oldFile) {
                    Storage::disk(config('voyager.storage.disk'))->delete($oldFile);
                }

                // Store new file and update the field
                $file = $request->file($row->field);
                $path = $file->store('uploads', config('voyager.storage.disk'));
                $data->{$row->field} = $path;
                // Update the overwrite file
                $data->overwrite_agreement_key = json_encode([
                    [
                        'download_link' => $path,
                        'original_name' => $data->name
                    ]
                ]);
            }
        }

        // Handle document editor content
        if ($request->has('document_editor')) {
            $newContent = $request->input('document_editor');
            $originalHtml = $data->document_editor;

            // Only proceed if content is different
            if (trim($newContent) !== trim($this->extractHtmlBody($originalHtml))) {
                // Merge only the body content
                $mergedHtml = $this->replaceHtmlBody($originalHtml, $newContent);
                $data->document_editor = $mergedHtml;

                if ($request->boolean('override_upload_document')) {
                    // Ensure .html extension is added
                    $baseName = pathinfo($data->name, PATHINFO_FILENAME); // Strip extension if present
                    $fileName = $baseName . '.html';

                    $relativePath = 'product-agreement/' . now()->format('FY') . '/';
                    $fullPath = $relativePath . $fileName;

                    try {
                        $saved = Storage::disk(config('voyager.storage.disk'))->put($fullPath, $mergedHtml);

                        if ($saved) {
                            Log::info("✅ File successfully saved to S3: $fullPath");

                            $data->overwrite_agreement_key = json_encode([
                                [
                                    'download_link' => $fullPath,
                                    'original_name' => $fileName
                                ]
                            ]);
                            $data->save();

                            Log::info("✅ overwrite_agreement_key updated in database.");
                        } else {
                            Log::warning("⚠️ Failed to save file to S3: $fullPath");
                        }
                    } catch (\Exception $e) {
                        Log::error("❌ Exception while saving to S3: " . $e->getMessage());
                    }
                }
            }
        }

        $editRowsExcludingDocumentEditor = $dataType->editRows->filter(function ($row) {
            return $row->field !== 'document_editor';
        });

        // Update the remaining data using Voyager's insertUpdateData function
        $this->insertUpdateData($request, $slug, $editRowsExcludingDocumentEditor, $data);

        if ($request->boolean('override_document_editor') && $request->hasFile('upload_document')) {
            $htmlFile = $request->file('upload_document');
            // Read the contents of the uploaded HTML file
            $htmlContent = file_get_contents($htmlFile->getPathname());
            // Update the document editor with the new content
            $data->document_editor = $htmlContent;
            $data->save(); // Save the updated content to the database
        }

        event(new BreadDataUpdated($dataType, $data));

        // Redirect based on permissions
        if (auth()->user()->can('browse', app($dataType->model_name))) {
            $redirect = redirect()->route("voyager.{$dataType->slug}.show",$data->id);
        } else {
            $redirect = redirect()->back();
        }

        return $redirect->with([
            'message'    => __('voyager::generic.successfully_updated')." {$dataType->getTranslatedAttribute('display_name_singular')}",
            'alert-type' => 'success',
        ]);
    }

    private function replaceHtmlBody($originalHtml, $newBodyContent)
    {
        // Clean up new content (optional, if needed)
        $newBodyContent = trim($newBodyContent);

        // Replace <body>...</body> content using regex
        $updatedHtml = preg_replace(
            '/<body[^>]*>.*<\/body>/si',
            '<body>' . $newBodyContent . '</body>',
            $originalHtml
        );

        return $updatedHtml;
    }

    private function extractHtmlBody($html)
    {
        if (preg_match('/<body[^>]*>(.*?)<\/body>/is', $html, $matches)) {
            return trim($matches[1]);
        }

        // Fallback: return entire HTML if <body> not found
        return $html;
    }

}
