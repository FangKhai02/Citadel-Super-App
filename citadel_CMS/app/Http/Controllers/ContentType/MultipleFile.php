<?php

namespace App\Http\Controllers\ContentType;

use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use TCG\Voyager\Http\Controllers\ContentTypes\BaseType;

class MultipleFile extends BaseType
{
    protected function generatePath()
    {
        return $this->slug . DIRECTORY_SEPARATOR . date('FY') . DIRECTORY_SEPARATOR;
    }

    /**
     * @return string
     */
    protected function generateFileName($file, $path)
    {
        // if (isset($this->options->preserveFileUploadName) && $this->options->preserveFileUploadName) {
        //     $filename = basename($file->getClientOriginalName(), '.' . $file->getClientOriginalExtension());
        //     $filename_counter = 1;
        //     // Make sure the filename does not exist, if it does make sure to add a number to the end 1, 2, 3, etc...
        //     while (\Storage::disk(config('voyager.storage.disk'))->exists($path . $filename . '.' . $file->getClientOriginalExtension())) {
        //         $filename = basename($file->getClientOriginalName(), '.' . $file->getClientOriginalExtension()) . (string)($filename_counter++);
        //     }
        // } else {
        //     $filename = \Str::random(20);
        //     // Make sure the filename does not exist, if it does, just regenerate
        //     while (\Storage::disk(config('voyager.storage.disk'))->exists($path . $filename . '.' . $file->getClientOriginalExtension())) {
        //         $filename = \Str::random(20);
        //     }
        // }

        $filename = basename($file->getClientOriginalName(), '.' . $file->getClientOriginalExtension());
        $filename_counter = 1;

        // Make sure the filename does not exist, if it does make sure to add a number to the end 1, 2, 3, etc...
        while (Storage::disk(config('voyager.storage.disk'))->exists($path . $filename . '.' . $file->getClientOriginalExtension())) {
            $filename = basename($file->getClientOriginalName(), '.' . $file->getClientOriginalExtension()) . (string)($filename_counter++);
        }
        return $filename;
    }

    /**
     * @return string
     */
    public function handle()
    {
        $filesPath = [];
        $files = $this->request->file($this->row->field);

        // Merge with existing files if present
        $existing = $this->request->input('existing_' . $this->row->field);
        if ($existing) {
            $existingFiles = json_decode($existing, true);
            if (is_array($existingFiles)) {
                $filesPath = array_merge($filesPath, $existingFiles);
            }
        }

        if (!$files) {
            return json_encode($filesPath);
        }

        foreach ($files as $file) {
            if (!$file->isValid()) {
                continue;
            }
            $path = $this->generatePath();
            $filename = $this->generateFileName($file, $path);
            $filePath = $path . $filename . '.' . $file->getClientOriginalExtension();
            $file->storeAs(
                $path,
                $filename . '.' . $file->getClientOriginalExtension(),
                config('voyager.storage.disk', 'public')
            );
            array_push($filesPath, [
                'download_link' => $path.$filename.'.'.$file->getClientOriginalExtension(),
                'original_name' => $file->getClientOriginalName(),
            ]);
        }

        return json_encode($filesPath);
    }
}
