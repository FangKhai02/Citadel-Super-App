@extends('voyager::master')

@section('page_title', 'Edit Corporate Shareholder')

@section('page_header')
<h1 class="page-title">
    <i class="voyager-person"></i>
    Edit Corporate Shareholder for {{ $corporate_shareholder->name }}
    <a href="{{ route('browse.corporate.shareholders', ['corporate_client_id' => $corporateClient->id]) }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">{{ __('Return to List') }}</span>
    </a>
</h1>
@stop


@section('content')
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-bordered">
                <form role="form" action="{{ route('update.corporate.shareholder', ['corporate_client_id' => $corporateClient->id , 'shareholder_id' => $corporate_shareholder->id]) }}" method="POST" enctype="multipart/form-data">
                    {{ csrf_field() }}
                    {{ method_field('PUT') }}

                    <div class="panel-body">
                        <!-- Full Name -->
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" name="name" class="form-control" value="{{ old('name', $corporate_shareholder->name) }}">
                        </div>

                        <!-- Share Percentage -->
                        <div class="form-group">
                            <label for="percentage_of_shareholdings">Share Percentage</label>
                            <input type="text" name="percentage_of_shareholdings" class="form-control" value="{{ old('percentage_of_shareholdings', $corporate_shareholder->percentage_of_shareholdings) }}">
                        </div>

                        <!-- Address -->
                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" name="address" class="form-control" value="{{ old('address', $corporate_shareholder->address) }}">
                        </div>

                        <!-- Email -->
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" name="email" class="form-control" value="{{ old('email', $corporate_shareholder->email) }}">
                        </div>

                        <!-- Mobile Country Code -->
                        <div class="form-group">
                            <label for="mobile_country_code">Mobile Country Code</label>
                            <input type="text" name="mobile_country_code" class="form-control" value="{{ old('mobile_country_code', $corporate_shareholder->mobile_country_code) }}">
                        </div>

                        <!-- Mobile Number -->
                        <div class="form-group">
                            <label for="mobile_number">Mobile Number</label>
                            <input type="text" name="mobile_number" class="form-control" value="{{ old('mobile_number', $corporate_shareholder->mobile_number) }}">
                        </div>

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

                        <!-- PEP Type -->
                        <div class="form-group">
                            <label for="pep_type">PEP Category</label>
                            <select name="pep_type" class="form-control" id="pep_type" required>
                                <option value="self" {{ old('pep_type', $pepInfo->pep_type) === 'self' ? 'selected' : '' }}>Self</option>
                                <option value="family" {{ old('pep_type', $pepInfo->pep_type) === 'family' ? 'selected' : '' }}>Family</option>
                                <option value="associate" {{ old('pep_type', $pepInfo->pep_type) === 'associate' ? 'selected' : '' }}>Associate</option>
                            </select>
                        </div>

                        <!-- Full Name of Immediate Family -->
                        <div class="form-group">
                            <label for="pep_immediate_family_name">Full Name of Immediate Family</label>
                            <input type="text" name="pep_immediate_family_name" class="form-control" value="{{ old('pep_immediate_family_name', $pepInfo->pep_immediate_family_name) }}">
                        </div>

                        <!-- Current Position / Designation -->
                        <div class="form-group">
                            <label for="pep_position">Current Position / Designation</label>
                            <input type="text" name="pep_position" class="form-control" value="{{ old('pep_position', $pepInfo->pep_position) }}">
                        </div>

                        <!-- Organisation / Entity -->
                        <div class="form-group">
                            <label for="pep_organisation">Organisation / Entity</label>
                            <input type="text" name="pep_organisation" class="form-control" value="{{ old('pep_organisation', $pepInfo->pep_organisation) }}">
                        </div>

                        <!-- PEP Document -->
                        <div class="form-group">
                            <label for="pep_supporting_documents_key">PEP Supporting Document</label>
                            <input type="file" name="pep_supporting_documents_key" class="form-control">
                            @if($pepInfo->pep_supporting_documents_key)
                            <x-document-display :document="$corporate_shareholder->pepInfo->pep_supporting_documents_key" title="View Pep Document" />
<!--                            <img src="{{ asset('storage/' . $pepInfo->pep_supporting_documents_key) }}" alt="PEP Document" style="max-width: 200px;">-->
                            @endif
                        </div>

                        <!-- IC Document -->
                        <div class="form-group">
                            <label for="Front IC Document">IC Front Document</label>
                            <input type="file" name="identity_card_front_image_key" class="form-control">
                            @if($corporate_shareholder->identity_card_front_image_key)
                            <x-document-display :document="$corporate_shareholder->identity_card_front_image_key" title="View Front IC Document" />
<!--                            <img src="{{ asset('storage/' . $corporate_shareholder->identity_card_front_image_key) }}" alt="IC Front Document" style="max-width: 200px;">-->
                            @endif
                            <label for="Back IC Document">IC Back Document</label>
                            <input type="file" name="identity_card_back_image_key" class="form-control">
                            @if($corporate_shareholder->identity_card_back_image_key)
                            <x-document-display :document="$corporate_shareholder->identity_card_back_image_key" title="View Back IC Document" />
<!--                            <img src="{{ asset('storage/' . $corporate_shareholder->identity_card_back_image_key) }}" alt="IC Back Document" style="max-width: 200px;">-->
                            @endif
                        </div>
                    </div>
                    <!-- Submit Button -->
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
@stop
