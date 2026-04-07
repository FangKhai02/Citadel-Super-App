<?php

namespace App\FormFields;

use TCG\Voyager\FormFields\AbstractHandler;

class MultipleFileHandler extends AbstractHandler
{
    protected $codename = 'multiple_file';

    public function createContent($row, $dataType, $dataTypeContent, $options)
    {
        return view('voyager::formfields.multiple_file', [
            'row'             => $row,
            'options'         => $options,
            'dataType'        => $dataType,
            'dataTypeContent' => $dataTypeContent,
        ]);
    }
} 