@extends('voyager::master')

@section('page_title', 'View Beneficiary Guardian')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-person"></i>
        View Beneficiary Guardian
        <a href="{{ route('browse.client.beneficiaries.guardian', ['client_id' => $client->id]) }}" class="btn btn-warning">
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
                            @foreach($individualBeneficiaryGuardian as $beneficiary)
                            <a href="{{ route('view.client.beneficiary', ['client_id' => $client->id , 'id' => $beneficiary->id]) }}" class="list-group-item">
                                <h5 class="list-group-item-heading">{{ $beneficiary->full_name }}</h5>
                                <p class="list-group-item-text">
                                    <strong>Relationship to Beneficiary:</strong>
                                    {{ $beneficiary->pivot->relationship_to_beneficiary ?? 'N/A' }}
                                </p>
                            </a>
                            @endforeach
                        </div>
                    </div><!-- panel-body -->
                </div><!-- panel -->

                <div class="panel panel-bordered" style="padding-bottom:5px;">
                    <!-- Guardian Full Name -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Full Name</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $individualGuardian->full_name ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- NRIC / Passport No. -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">ID Number</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $individualGuardian->identity_card_number ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Date of Birth -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Date of Birth</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $individualGuardian->dob ? \Carbon\Carbon::parse($individualGuardian->dob)->format('d/m/Y') : '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Gender -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Gender</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $individualGuardian->gender ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Marital Status -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Marital Status</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $individualGuardian->marital_status ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Resident Status -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Residential Status</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $individualGuardian->residential_status ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Nationality -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Nationality</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $individualGuardian->nationality ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Address -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>
                        {{
                        ($individualGuardian->address ? $individualGuardian->address . ', ' : '') .
                        ($individualGuardian->postcode ? $individualGuardian->postcode . ', ' : '') .
                        ($individualGuardian->city ? $individualGuardian->city . ', ' : '') .
                        ($individualGuardian->state ? $individualGuardian->state . ', ' : '') .
                        ($individualGuardian->country ? $individualGuardian->country : '-')
                        }}
                        </p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Postcode -->
<!--                    <div class="panel-heading" style="border-bottom:0;">-->
<!--                        <h3 class="panel-title">Postcode</h3>-->
<!--                    </div>-->
<!--                    <div class="panel-body" style="padding-top:0;">-->
<!--                        <p>{{ $individualGuardian->postcode ?? '-' }}</p>-->
<!--                    </div>-->
<!--                    <hr style="margin:0;">-->

                    <!-- City -->
<!--                    <div class="panel-heading" style="border-bottom:0;">-->
<!--                        <h3 class="panel-title">City</h3>-->
<!--                    </div>-->
<!--                    <div class="panel-body" style="padding-top:0;">-->
<!--                        <p>{{ $individualGuardian->city ?? '-' }}</p>-->
<!--                    </div>-->
<!--                    <hr style="margin:0;">-->

                    <!-- State -->
<!--                    <div class="panel-heading" style="border-bottom:0;">-->
<!--                        <h3 class="panel-title">State</h3>-->
<!--                    </div>-->
<!--                    <div class="panel-body" style="padding-top:0;">-->
<!--                        <p>{{ $individualGuardian->state ?? '-' }}</p>-->
<!--                    </div>-->
<!--                    <hr style="margin:0;">-->

                    <!-- Country -->
<!--                    <div class="panel-heading" style="border-bottom:0;">-->
<!--                        <h3 class="panel-title">Country</h3>-->
<!--                    </div>-->
<!--                    <div class="panel-body" style="padding-top:0;">-->
<!--                        <p>{{ $individualGuardian->country ?? '-' }}</p>-->
<!--                    </div>-->
<!--                    <hr style="margin:0;">-->

                    <!-- Email -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Email Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $individualGuardian->email ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Mobile Number -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Mobile Number</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $individualGuardian->mobile_country_code . $individualGuardian->mobile_number ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Address Proof -->
<!--                    <div class="panel-heading" style="border-bottom:0;">-->
<!--                        <h3 class="panel-title">Address Proof</h3>-->
<!--                    </div>-->
<!--                    <div class="panel-body" style="padding-top:0;">-->
<!--                        @if(isset($individualGuardian) && $individualGuardian->address_proof)-->
<!--                            <p><a href="{{ asset('storage/' . $individualGuardian->address_proof_key) }}" target="_blank">View Address Proof</a></p>-->
<!--                        @else-->
<!--                            <p>-</p>-->
<!--                        @endif-->
<!--                    </div>-->
<!--                    <hr style="margin:0;">-->

                    <!-- IC Document -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Document ID</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        @if(isset($individualGuardian) && $individualGuardian->identity_card_front_image_key && $individualGuardian->identity_card_front_image_key)
                            <x-document-display :document="$individualGuardian->identity_card_front_image_key" title="View Front Document ID" />
                            <x-document-display :document="$individualGuardian->identity_card_back_image_key" title="View Back Document ID" />
                        @else
                            <p>-</p>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop
