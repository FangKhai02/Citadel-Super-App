@extends('voyager::master')

@section('page_title', 'View Beneficiary Guardian')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-person"></i>
        View Corporate Guardian
        <a href="{{ route('browse.corporate.guardians', ['corporate_client_id' => $corporate->id]) }}" class="btn btn-warning">
            <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
        </a>
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered" style="padding-bottom:5px;">
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Guardian to Beneficiary Relationship</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <div class="list-group">
                            @if($corporateGuardian && $beneficiaries->isNotEmpty())
                            @foreach($beneficiaries as $beneficiary)
                            <a href="{{ route('read.corporate.beneficiary', [
                    'corporate_client_id' => $corporate->id,
                    'beneficiary_id' => $beneficiary->id
                ]) }}" class="list-group-item">
                                <p class="list-group-item-text">
                                    <strong>Beneficiary: </strong> {{ $beneficiary->full_name ?? 'N/A' }}
                                </p>
                                <p class="list-group-item-text">
                                    <strong>Relationship to Beneficiary:</strong> {{ $beneficiary->relationship_to_guardian ?? 'N/A' }}
                                </p>
                            </a>
                            @endforeach
                            @else
                            <p>No guardians available for this beneficiary.</p>
                            @endif
                        </div>
                    </div>
                </div><!-- panel -->

                <div class="panel panel-bordered" style="padding-bottom:5px;">
                    <!-- Guardian Full Name -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Full Name</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporateGuardian->full_name ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- NRIC / Passport No. -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">ID Number</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporateGuardian->identity_card_number ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Date of Birth -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Date of Birth</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporateGuardian->dob ? \Carbon\Carbon::parse($corporateGuardian->dob)->format('d-m-Y') : '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Gender -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Gender</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporateGuardian->gender ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Marital Status -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Marital Status</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporateGuardian->marital_status ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Resident Status -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Residential Status</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporateGuardian->residential_status ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Nationality -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Nationality</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporateGuardian->nationality ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Address -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>
                        {{
                        ($corporateGuardian->address ? $corporateGuardian->address . ', ' : '') .
                        ($corporateGuardian->postcode ? $corporateGuardian->postcode . ', ' : '') .
                        ($corporateGuardian->city ? $corporateGuardian->city . ', ' : '') .
                        ($corporateGuardian->state ? $corporateGuardian->state . ', ' : '') .
                        ($corporateGuardian->country ? $corporateGuardian->country : '-')
                        }}
                        </p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Email -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Email Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporateGuardian->email ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Mobile Number -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Mobile Number</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporateGuardian->mobile_country_code . $corporateGuardian->mobile_number ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- IC Document -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Document ID</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        @if(isset($corporateGuardian) && $corporateGuardian->identity_card_front_image_key && $corporateGuardian->identity_card_front_image_key)
                            <x-document-display :document="$corporateGuardian->identity_card_front_image_key" title="View Front Document ID" />
                            <x-document-display :document="$corporateGuardian->identity_card_back_image_key" title="View Back Document ID" />
                        @else
                            <p>-</p>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop
