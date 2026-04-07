<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use TCG\Voyager\Http\Controllers\VoyagerBaseController;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Events\BreadDataAdded;
use App\Models\BankFileUpload;
use App\Models\Checker;

class BankFileUploadController extends VoyagerBaseController
{
    public function store(Request $request)
    {
        $slug = $this->getSlug($request);
        $dataType = Voyager::model('DataType')->where('slug', $slug)->first();

        // Check user permissions
        $this->authorize('add', app($dataType->model_name));

        // Validate request data
        $validatedData = $this->validateBread($request->all(), $dataType->addRows)->validate();

        // Store uploaded file in S3
        $filePath = $this->uploadFile($request->file('upload_document'));

        // Create Bank File Upload entry
        $data = $this->createBankFileUpload($filePath, $request);

        // Create associated Checker entry
        $checker = $this->createCheckerEntry($data->id, $request->remarks);

        // Update the bank_file_upload record with the checker_id
        $data->checker_id = $checker->id;
        $data->save();

        // Trigger event after adding data
        event(new BreadDataAdded($dataType, $data));

        // Handle redirection or JSON response
        return $this->handleResponse($request, $dataType, $data);
    }

    //TODO get file from db, update status to approved or fail from backend.
    private function uploadFile($file)
    {
        return $file->store('bank_uploads', 's3');
    }

    private function createBankFileUpload($filePath, Request $request)
    {
        return BankFileUpload::create([
            'upload_document' => $filePath,
            'description' => $request->description,
            'remarks' => $request->remarks,
            'status' => 'PENDING',
            'created_by' => auth()->id(),
        ]);
    }

    private function createCheckerEntry($bankFileUploadId, $remarks)
    {
        return Checker::create([
            'bank_file_upload_id' => $bankFileUploadId,
            'status' => 'PENDING'
        ]);
    }

    private function handleResponse(Request $request, $dataType, $data)
    {
        if ($request->has('_tagging')) {
            return response()->json(['success' => true, 'data' => $data]);
        }

        // Check user permissions for redirect
        $redirect = auth()->user()->can('browse', $data)
            ? redirect()->route("voyager.{$dataType->slug}.index")
            : redirect()->back();

        return $redirect->with([
            'message' => __('voyager::generic.successfully_added_new') . " {$dataType->getTranslatedAttribute('display_name_singular')}",
            'alert-type' => 'success',
        ]);
    }
}
