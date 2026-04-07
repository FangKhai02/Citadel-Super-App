@extends('voyager::master')

@section('page_title', 'View Corporate Director Details')

@section('page_header')
<h1 class="page-title">
    <i class="voyager-person"></i>
    Corporate Director Details for {{ $corporate->corporateDetail->entity_name }}
    <a href="{{ route('edit.corporate.user.details', ['id' => $corporate->id]) }}" class="btn btn-info">
        <i class="glyphicon glyphicon-pencil"></i> <span class="hidden-xs hidden-sm">Change Director</span>
    </a>
    <a href="{{ route('voyager.corporate-client.index') }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
    </a>
</h1>
@stop

@section('content')
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-bordered" style="padding-bottom:5px;">

                <!-- Name -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Full Name</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->userDetails->name ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Id Number -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">ID Number</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->userDetails->identity_card_number ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- DOB -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Date of Birth</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ \Carbon\Carbon::parse($corporate->userDetails->dob)->format('d-m-Y') ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Mobile Number -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Mobile Number</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->userDetails->mobile_country_code . ' ' .$corporate->userDetails->mobile_number ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Email Address -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Email Address</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->userDetails->email ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Address -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Address</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->userDetails->address ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Postcode -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Postcode</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->userDetails->postcode ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- City -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">City</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->userDetails->city ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- State -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">State</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->userDetails->state ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Country -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Country</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->userDetails->country ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- IC Documents -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Documents</h3>
                </div>
                <div class="panel-body">
                    <!-- Front IC Document -->
                    <div class="form-group">
                        <label>Front IC:</label>
                        @if(isset($corporate->userDetails->identity_card_front_image_key))
                        <x-document-display :document="$corporate->userDetails->identity_card_front_image_key" title="View Front IC Document" />
                        @else
                        <p>-</p>
                        @endif
                    </div>

                    <!-- Back IC Document -->
                    <div class="form-group">
                        <label>Back IC:</label>
                        @if(isset($corporate->userDetails->identity_card_back_image_key))
                        <x-document-display :document="$corporate->userDetails->identity_card_back_image_key" title="View Back IC Document" />
                        @else
                        <p>-</p>
                        @endif
                    </div>
                </div>
                <hr style="margin:0;">

                <!-- Selfie Image -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Selfie</h3>
                </div>
                <div class="panel-body">
                    @if(isset($corporate->userDetails->selfie_image_key))
                    <x-document-display :document="$corporate->userDetails->selfie_image_key" title="Selfie" />
                    @else
                    <p>-</p>
                    @endif
                </div>
                <hr style="margin:0;">
            </div>
        </div>
    </div>
</div>
@stop
