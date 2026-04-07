@extends('voyager::master')

@section('page_title', 'Agent Details')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-person"></i>
       Agent Details
        <a href="{{ route('voyager.agent.index') }}" class="btn btn-warning">
            <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
        </a>
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered" style="padding-bottom:5px;">

                    <!-- Agent ID -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Agent ID</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $agent->agent_id ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Referral Code -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Referral Code</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $agent->referral_code ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Full Name -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Full Name</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $userDetails->name ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- NRIC / Passport No. -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">ID Number</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $userDetails->identity_card_number ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Agent Role -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Agent Role</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $agent->role->role_description ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Agency Agreement Date -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Agency Agreement Date</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ \Carbon\Carbon::parse($agent->agency->agreement_date)->format('d-m-Y') ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">


                    <!-- Status -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Status</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $agent->status ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Recruiting Manager -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Recruiting Manager</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>@if($agent->recruitManager && $agent->recruitManager->userDetails)
                            {{ $agent->recruitManager->userDetails->name }}
                            @else
                            No Recruiting Manager
                            @endif
                        </p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Recruiting Manager Role-->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Recruiting Manager Role</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                    <p>@if($agent->recruitManager && $agent->recruitManager->userDetails)
                        {{ $agent->recruitManager->role->role_description }}
                        @else
                        N/A
                        @endif</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Mobile Number -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Mobile Number</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $userDetails->mobile_country_code . $userDetails->mobile_number ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Email -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Email Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $userDetails->email ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Date of Birth -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Date of Birth</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ \Carbon\Carbon::parse($userDetails->dob)->format('d-m-Y') ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Gender -->
<!--                    <div class="panel-heading" style="border-bottom:0;">-->
<!--                        <h3 class="panel-title">Gender</h3>-->
<!--                    </div>-->
<!--                    <div class="panel-body" style="padding-top:0;">-->
<!--                        <p>{{ $userDetails->gender ?? '-' }}</p>-->
<!--                    </div>-->
<!--                    <hr style="margin:0;">-->

                    <!-- Address -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $userDetails->address ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Postcode -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Postcode</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $userDetails->postcode ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- City -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">City</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $userDetails->city ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- State -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">State</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $userDetails->state ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Country -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Country</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $userDetails->country ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Created Datetime -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Created Datetime</h3>
                    </div>
                    <div class="panel-body
                        " style="padding-top:0;">
                        <p>{{ \Carbon\Carbon::parse($agent->created_at)->format('d/m/Y H:i:s') }}</p>
                    </div>

                    <!-- Created By -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Created By</h3>
                    </div>
                    <div class="panel-body
                        " style="padding-top:0;">
                        <p>{{ $agent->created_by ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Updated Datetime -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Updated Datetime</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $agent->updated_at ? \Carbon\Carbon::parse($agent->updated_at)->format('d/m/Y H:i:s') : '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Updated By -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Updated By</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $agent->updated_by ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Onboarding Agreement -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Onboarding Agreement</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <x-document-display :document="$agent->userDetails->onboarding_agreement_key" title="Agency Agreement Document" />
                    </div>
                    <hr style="margin:0;">

                    <!-- Agency Agreement -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Agency Agreement for Agent</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <x-document-display :document="$agent->agency_agreement_key" title="Agency Agreement Document" />
                    </div>
                    <hr style="margin:0;">

                    <!-- IC Document -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Document ID</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                    <x-document-display :document="$userDetails->identity_card_front_image_key" title="Front Document ID" />
                    <x-document-display :document="$userDetails->identity_card_back_image_key" title="Back Document ID" />
                    </div>
                    <hr style="margin:0;">

                    <!-- Selfie Document -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Selfie</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                    <x-document-display :document="$userDetails->selfie_image_key" title="Selfie Document" />
                    </div>


                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
