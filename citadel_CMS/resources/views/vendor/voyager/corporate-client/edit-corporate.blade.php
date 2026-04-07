@extends('voyager::master')

@section('page_title', 'Edit Corporate Details')

@section('page_header')
<h1 class="page-title">
    <i class="voyager-person"></i>
    Edit Corporate Client Details for {{ $corporate->corporateDetail->entity_name }}
    <a href="{{ route('voyager.corporate-client.index') }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
    </a>
</h1>
@stop

@section('content')
<div class="page-content container-fluid">
    <form action="{{ route('update.corporate.client', $corporate->id) }}" method="POST" enctype="multipart/form-data">
        @csrf
        @method('PUT')
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered" style="padding-bottom:5px;">
                    <!-- Corporate ID (Read-only) -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Corporate ID</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" class="form-control" value="{{ $corporate->corporate_client_id }}" readonly>
                    </div>
                    <hr style="margin:0;">

                    <!-- Entity Name -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Entity Name</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="entity_name" class="form-control" value="{{ old('entity_name', $corporate->corporateDetail->entity_name) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Entity Type -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Type of Entity</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="entity_type" class="form-control" value="{{ old('entity_type', $corporate->corporateDetail->entity_type) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Registration Number -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Registration Number</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="registration_number" class="form-control" value="{{ old('registration_number', $corporate->corporateDetail->registration_number) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Date of Incorporation -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Date of Incorporation</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="date" name="date_incorporation" class="form-control"
                               value="{{ old('date_incorporation', \Carbon\Carbon::parse($corporate->corporateDetail->date_incorporation)->format('Y-m-d')) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Place of Incorporation -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Place of Incorporation</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="place_incorporation" class="form-control" value="{{ old('place_incorporation', $corporate->corporateDetail->place_incorporation) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Business Type -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Business Type</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="business_type" class="form-control" value="{{ old('business_type', $corporate->corporateDetail->business_type) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Registered Address -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Registered Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <textarea name="registered_address" class="form-control">{{ old('registered_address', $corporate->corporateDetail->registered_address) }}</textarea>
                    </div>
                    <hr style="margin:0;">

                    <!-- Registered Address - Postcode -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Registered Address - Postcode</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="postcode" class="form-control" value="{{ old('postcode', $corporate->corporateDetail->postcode) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Registered Address - City -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Registered Address - City</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="city" class="form-control" value="{{ old('city', $corporate->corporateDetail->city) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Registered Address - State -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Registered Address - State</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="state" class="form-control" value="{{ old('state', $corporate->corporateDetail->state) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Registered Address - Country -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Registered Address - Country</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="country" class="form-control" value="{{ old('country', $corporate->corporateDetail->country) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Business Address -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Business Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <textarea name="business_address" class="form-control">{{ old('business_address', $corporate->corporateDetail->business_address) }}</textarea>
                    </div>
                    <hr style="margin:0;">

                    <!-- Business Address - Postcode -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Business Address - Postcode</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="business_postcode" class="form-control" value="{{ old('business_postcode', $corporate->corporateDetail->business_postcode) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Business Address - City -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Business Address - City</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="business_city" class="form-control" value="{{ old('business_city', $corporate->corporateDetail->business_city) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Business Address - State -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Business Address - State</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="business_state" class="form-control" value="{{ old('business_state', $corporate->corporateDetail->business_state) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Business Address - Country -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Business Address - Country</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input type="text" name="business_country" class="form-control" value="{{ old('business_country', $corporate->corporateDetail->business_country) }}">
                    </div>
                    <hr style="margin:0;">

                    <!-- Company Documents -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Company Documents</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="company_document">Upload New Company Document</label>
                            @if(isset($corporate->corporateDetail->company_document))
                            <x-document-display :document="$corporate->corporateDetail->company_document" title="Company Document" />
                            @endif
                            <input type="file" name="company_document" id="company_document" class="form-control">
                        </div>
                    </div>
                    <hr style="margin:0;">

                    <!-- Onboarding Agreement -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Onboarding Agreement</h3>
                    </div>
                    <div class="panel-body">
                        @if(isset($corporate->corporateDetail->digital_signature_key))
                        <x-document-display :document="$corporate->corporateDetail->digital_signature_key" title="Onboarding Agreement" />
                        @endif
                        <div class="form-group">
                            <label for="digital_signature_key">Upload New Onboarding Agreement:</label>
                            <input type="file" name="digital_signature_key" id="digital_signature_key" class="form-control">
                        </div>
                    </div>
                    <hr style="margin:0;">
                </div>
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
@stop
