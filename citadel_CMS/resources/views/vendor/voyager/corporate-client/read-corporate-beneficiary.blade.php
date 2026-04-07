@extends('voyager::master')

@section('page_title', 'View Beneficiaries')

@section('page_header')
<h1 class="page-title">
    <i class="voyager-person"></i>
    View Corporate Beneficiary
    <a href="{{ route('browse.corporate.beneficiaries', ['corporate_client_id' => $corporate->id]) }}" class="btn btn-warning">
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
                    <h3 class="panel-title">Beneficiary to Guardian Relationship</h3>
                </div>

                <div class="panel-body" style="padding-top:0;">
                    <div class="list-group">
                        @if($corporateGuardian)
                        <a href="{{ route('read.corporate.guardian', ['corporate_client_id' => $corporate->id, 'guardian_id' => $corporateGuardian->id]) }}" class="list-group-item">
                            <p class="list-group-item-text">
                                <strong>Guardian: </strong> {{ $corporateGuardian->full_name ?? 'N/A' }}</p>
                            <p class="list-group-item-text">
                                <strong>Relationship to Guardian:</strong> {{ $beneficiary->relationship_to_guardian ?? 'N/A' }}
                            </p>
                        </a>
                        @else
                        <p>No guardians available for this beneficiary.</p> <!-- Fallback message -->
                        @endif
                    </div>
                </div><!-- panel-body -->
            </div><!-- panel -->

            <div class="panel panel-bordered" style="padding-bottom:5px;">

                <!-- Relationship to Settlor -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Relationship to Settlor</h3>
                </div>
                <div class="panel-body
                    " style="padding-top:0;">
                    <p>{{ $beneficiary->relationship_to_settlor ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Full Name -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Full Name</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $beneficiary->full_name ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- NRIC / Passport No. -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">ID Number</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $beneficiary->identity_card_number ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Date of Birth -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Date of Birth</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $beneficiary->dob ? \Carbon\Carbon::parse($beneficiary->dob)->format('d-m-Y') : '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Gender -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Gender</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $beneficiary->gender ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Marital Status -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Marital Status</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $beneficiary->marital_status ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Resident Status -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Residential Status</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $beneficiary->residential_status ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Nationality -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Nationality</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $beneficiary->nationality ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Address -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Address</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>
                        {{
                        ($beneficiary->address ? $beneficiary->address . ', ' : '') .
                        ($beneficiary->postcode ? $beneficiary->postcode . ', ' : '') .
                        ($beneficiary->city ? $beneficiary->city . ', ' : '') .
                        ($beneficiary->state ? $beneficiary->state . ', ' : '') .
                        ($beneficiary->country ? $beneficiary->country : '-')
                        }}
                    </p>
                </div>
                <hr style="margin:0;">

                <!-- Email -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Email Address</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $beneficiary->email ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Mobile Number -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Mobile Number</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $beneficiary->mobile_country_code . $beneficiary->mobile_number ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- IC Document -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Document ID</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    @if($beneficiary && $beneficiary->identity_card_front_image_key && $beneficiary->identity_card_back_image_key)
                    <x-document-display :document="$beneficiary->identity_card_front_image_key" title="View Front Document ID" />
                    <x-document-display :document="$beneficiary->identity_card_back_image_key" title="View Back Document ID" />
                    @else
                    <p>-</p>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>
@stop
