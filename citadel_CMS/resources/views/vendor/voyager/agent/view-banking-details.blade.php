@extends('voyager::master')

@section('page_title', 'View Agent Banking Details')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-wallet"></i>
        View Agent Banking Details
    </h1>
    <a href="{{ route('voyager.agent.index') }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
    </a>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered" style="padding-bottom:5px;">

                    <!-- Bank Name -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Bank Name</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $bankDetails->bank_name ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Bank Account Number -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Bank Account Number</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $bankDetails->account_number ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Account Holder Name -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Account Holder Name</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $bankDetails->account_holder_name ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Bank Address -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Bank Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $bankDetails->bank_address ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Postcode -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Postcode</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $bankDetails->postcode ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- City -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">City</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $bankDetails->city ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- State -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">State</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $bankDetails->state ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Country -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Country</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $bankDetails->country ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Swift Code -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">SWIFT Code</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $bankDetails->swift_code ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Bank Account Proof -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Bank Account Proof</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        @if(isset($bankDetails->bank_account_proof_key))
                            <p>
                            <x-document-display :document="$bankDetails->bank_account_proof_key" :title="'Bank Account Proof'"/>
                            </p>
                        @else
                            <p>-</p>
                        @endif
                    </div>

                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
