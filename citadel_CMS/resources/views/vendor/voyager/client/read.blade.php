@extends('voyager::master')

@section('page_title', 'View Client Identity')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-person"></i>
        View Client Identity
        <a href="{{ route('voyager.client.index') }}" class="btn btn-warning">
            <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
        </a>
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered" style="padding-bottom:5px;">

                    <!-- Client ID -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Client ID</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $client->client_id ?? '-' }}</p>
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

                        <!-- Date of Birth -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Date of Birth</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->dob ? \Carbon\Carbon::parse($userDetails->dob)->format('d/m/Y') : '-' }}</p>
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

                        <!-- Gender -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Gender</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->gender ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Marital Status -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Marital Status</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->marital_status ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Resident Status -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Residential Status</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->resident_status ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Nationality -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Nationality</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->nationality ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

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

                        <!-- Agent Name -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Agent</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>
                                <!-- If the column is agent_id -->
                                @if($client->agent_id)
                                <!-- If agent_id is not null, display the agent's name -->
                                {{ optional($client->agent)->userDetails->name ?? 'N/A' }}
                                <!-- Use optional() to handle null safely -->
                                @else
                                N/A <!-- Display 'N/A' if agent_id is null -->
                                @endif
                            </p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Created Datetime -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Created Datetime</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $client->created_at ? \Carbon\Carbon::parse($client->created_at)->format('d/m/Y H:i:s') : '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Created By -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Created By</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $client->created_by ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Updated Datetime -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Updated Datetime</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $client->updated_at ? \Carbon\Carbon::parse($client->updated_at)->format('d/m/Y H:i:s') : '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Updated By -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Updated By</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $client->updated_by ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Proof of Address -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Proof of Address</h3>
                        </div>
                        <x-document-display :document="$userDetails->proof_of_address_file_key ?: $userDetails->corresponding_address_proof_key" title="Proof of Address" />
                        <hr style="margin:0;">

                        <!-- Onboarding Agreement PDF -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Onboarding Agreement PDF</h3>
                        </div>
                        <x-document-display :document="$userDetails->onboarding_agreement_key" title="Onboarding Agreement PDF" />

                        <!-- IC Document -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Document ID</h3>
                        </div>
                        <x-document-display :document="$userDetails->identity_card_front_image_key" title="Front IC" />
                        <x-document-display :document="$userDetails->identity_card_back_image_key" title="Back IC" />

                        <!-- Selfie Document -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Selfie</h3>
                        </div>
                        <x-document-display :document="$userDetails->selfie_image_key" title="Selfie Document" />
                        <hr style="margin:0;">

                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
