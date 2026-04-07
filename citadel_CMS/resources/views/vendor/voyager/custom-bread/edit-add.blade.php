@extends('voyager::master')

@section('page_title', __($pageTitle))

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-edit"></i> {{ $pageTitle }}
        <a href="{{ $returnRoute }}" class="btn btn-warning">
            <i class="glyphicon glyphicon-list"></i> Return to List
        </a>
        @if(!$hideViewButton && isset($data['id']))
            <a href="{{ url($baseRoute . $parentId . '/' . $modelSlug . '/' . $data['id']) }}" class="btn btn-primary">
                <i class="voyager-eye"></i> View
            </a>
        @endif
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <!-- Display Validation Errors -->
                @if ($errors->any())
                    <div class="alert alert-danger">
                        <ul>
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif

                <div class="panel panel-bordered" style="padding-bottom:5px;">
                @if ($modelSlug == null) 
                <form action="{{ url( $baseRoute . '/' . $parentId ) }}" method="POST">
                    @csrf
                    @method('PUT')
                @else
                    <!-- Form for Adding or Editing -->
                    <form action="{{ isset($data['id']) ? url($baseRoute . $parentId . '/' . $modelSlug . '/' . $data['id'] . '/update') : url($baseRoute . $parentId . '/' . $modelSlug . '/store') }}" 
                        method="POST"
                        enctype="multipart/form-data">
                        @csrf
                        @if(isset($data['id']))
                            @method('PUT') <!-- If data['id'] exists, this is an update -->
                        @else
                            <!-- This is an add operation, no method change required -->
                        @endif
                @endif
                        <div class="panel-body">
                            @foreach ($columns as $key => $label)
                                <div class="form-group  col-md-12 ">
                                    <label class="control-label" for="name">{{ $label }}</label>
                                    <!-- Check for input type -->
                                    @php
                                        $inputType = $dataTypes[$key] ?? 'text'; // Default to 'text' if no type is specified
                                    @endphp

                                    @if($inputType == 'parent-disable')
                                        <input
                                            type="text"
                                            class="form-control"
                                            name="{{ $key }}_disabled"
                                            value="{{ $parentValue }}"
                                            placeholder="{{ $label }}"
                                            disabled
                                        >
                                        <!-- Hidden field to include value in form submission -->
                                        <input
                                            type="hidden"
                                            name="{{ $key }}"
                                            value="{{ $parentId }}"
                                        >
                                    @elseif($inputType == 'text')
                                        <input
                                            type="text"
                                            class="form-control"
                                            name="{{ $key }}"
                                            value="{{ old($key, $data[$key] ?? '') }}"
                                            placeholder="{{ $label }}"
                                            @if(isset($requiredFields[$key]) && $requiredFields[$key] === true) required @endif
                                        >
                                    @elseif($inputType == 'dropdown')
                                        <select class="form-control" name="{{ $key }}" @if(isset($requiredFields[$key]) && $requiredFields[$key] === true) required @endif>
                                            <option value="" disabled selected>Please select</option>
                                            @foreach($dropdownOptions[$key] as $optionValue => $optionLabel)
                                                <option value="{{ $optionValue }}" {{ (old($key, $data[$key] ?? '') == $optionValue) ? 'selected' : '' }}>
                                                    {{ $optionLabel }}
                                                </option>
                                            @endforeach
                                        </select>
                                    @elseif($inputType == 'date')
                                        <input
                                            type="date"
                                            class="form-control"
                                            name="{{ $key }}"
                                            value="{{ old($key, $data[$key] ?? '') }}"
                                            placeholder="{{ $label }}"
                                            @if(isset($requiredFields[$key]) && $requiredFields[$key] === true) required @endif
                                        >
                                    @elseif($inputType == 'number')
                                        <input
                                            type="number"
                                            class="form-control"
                                            name="{{ $key }}"
                                            value="{{ old($key, $data[$key] ?? '') }}"
                                            placeholder="{{ $label }}"
                                            @if(isset($requiredFields[$key]) && $requiredFields[$key] === true) required @endif
                                        >
                                    @elseif($inputType == 'file')
                                        @if(isset($data) && $data[$key])
                                            <x-document-display :document="$data[$key]" :title="$label"/>
                                        @endif
                                        <input type="file" name="{{ $key }}">
                                    @endif
                                </div>
                                <hr style="margin:0;">
                            @endforeach
                        </div>

                        <div class="panel-footer">
                            <button type="submit" class="btn btn-success">
                                <i class="voyager-check"></i> {{ isset($data['id']) ? 'Save Changes' : 'Add New' }}
                            </button>
                        </div>
                    </form>
                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop

@section('javascript')
    <script>
        $(document).ready(function() {
            console.log('{{ isset($data['id']) ? 'Edit' : 'Add' }} view initialized.');
        });
    </script>
@endsection
