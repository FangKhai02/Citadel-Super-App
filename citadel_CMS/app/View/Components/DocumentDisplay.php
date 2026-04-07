<?php

namespace App\View\Components;

use Illuminate\View\Component;

class DocumentDisplay extends Component
{
    public $document;
    public $title;

    public function __construct($document, $title)
    {
        $this->document = $document;
        $this->title = $title;
    }

    public function render()
    {
        return view('components.document-display');
    }
}
