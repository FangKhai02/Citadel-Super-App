@extends('voyager::master')

@section('page_title', 'Edit Client PEP Info')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-info-circled"></i>
        Edit Corporate Client PEP Info for {{ $userDetails->name }}
            <a href="{{ route('voyager.corporate-client.index') }}" class="btn btn-warning">
                <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
            </a>
    </h1>

@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <div class="panel-body">
                        <form action="{{ route('update.corporate.pep.info', $corporate->id) }}" method="POST" enctype="multipart/form-data">
                            @csrf
                            @method('PUT') <!-- Use PUT for editing -->

                            <div class="form-group">
                                <label for="pep">Is PEP?</label>
                                <br/>
                                <input type="checkbox"
                                       name="pep"
                                       class="toggleswitch"
                                       data-on="Yes"
                                       data-off="No"
                                       value="1"
                                       {{ $pepInfo->pep ? 'checked' : '' }}>
                            </div>

                            <div class="form-group">
                                <label for="pep_type">PEP Category</label>
                                <select name="pep_type" class="form-control" id="pep_type" required>
                                    <option value="self" {{ old('pep_type', $pepInfo->pep_type) === 'self' ? 'selected' : '' }}>Self</option>
                                    <option value="family" {{ old('pep_type', $pepInfo->pep_type) === 'family' ? 'selected' : '' }}>Family</option>
                                    <option value="associate" {{ old('pep_type', $pepInfo->pep_type) === 'associate' ? 'selected' : '' }}>Associate</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="pep_immediate_family_name">Full Name of Immediate Family</label>
                                <input type="text" name="pep_immediate_family_name" class="form-control" id="pep_immediate_family_name" value="{{ old('pep_immediate_family_name', $pepInfo->pep_immediate_family_name) }}">
                            </div>

                            <div class="form-group">
                                <label for="pep_position">PEP Position / Designation</label>
                                <input type="text" name="pep_position" class="form-control" id="pep_position" value="{{ old('pep_position', $pepInfo->pep_position) }}" required>
                            </div>

                            <div class="form-group">
                                <label for="pep_organisation">PEP Organisation / Entity</label>
                                <input type="text" name="pep_organisation" class="form-control" id="pep_organisation" value="{{ old('pep_organisation', $pepInfo->pep_organisation) }}" required>
                            </div>

                            <div class="form-group @if($pepInfo->pep_supporting_documents_key) has-image @endif">
                                <label class="control-label" for="pep_supporting_documents_key">PEP Attachment</label>
                                <input type="file" name="pep_supporting_documents_key">
                                @if($pepInfo->pep_supporting_documents_key)
                                <x-document-display :document=" $pepInfo->pep_supporting_documents_key" title="PEP Attachment" />
                                @endif
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="glyphicon glyphicon-save"></i> Save Changes
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop

@push('javascript')
    <script>
        $(document).ready(function () {
            $('.toggleswitch').bootstrapToggle(); // Initialize the toggle
        });
    </script>
@endpush
