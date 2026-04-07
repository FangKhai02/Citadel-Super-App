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
                            <h3 class="panel-title">NRIC / Passport No.</h3>
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
                            <p>{{ $userDetails->mobile_number ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Email -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Email</h3>
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
                            <h3 class="panel-title">Resident Status</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->residential_status ?? '-' }}</p>
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

                        <!-- Identity Proof -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Identity Proof</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            @if(isset($userDetails) && $userDetails->identity_proof)
                            <x-document-display :document="$userDetails->identity_proof" title="View Identity Proof" />
                            @else
                                <p>-</p>
                            @endif
                        </div>
                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
