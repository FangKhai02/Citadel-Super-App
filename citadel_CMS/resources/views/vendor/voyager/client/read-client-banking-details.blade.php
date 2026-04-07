@extends('voyager::master')

@section('page_title', 'View Client Banking Details')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-wallet"></i>
<!--        View Client Banking Details-->
        Client Bank
        <a href="{{ route('browse.client.banking.details' , ['client_id' => $client->id] ) }}" class="btn btn-warning">
            <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
        </a>
    </h1>
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
                        <h3 class="panel-title">Account Number</h3>
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

<!--                     Bank Address -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ ($bankDetails->bank_address ?? '') . ', ' . ($bankDetails->city ?? ''). ', ' .($bankDetails->postcode ?? '')  . ', ' . ($bankDetails->state ?? '') . ', ' . ($bankDetails->country ?? '') }}</p>
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
                        <h3 class="panel-title">Proof of Bank Account</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        @if(isset($bankDetails->bank_account_proof_key))
                        <x-document-display :document="$bankDetails->bank_account_proof_key" title="View Bank Account Proof" />
                        @else
                            <p>-</p>
                        @endif
                    </div>

                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
