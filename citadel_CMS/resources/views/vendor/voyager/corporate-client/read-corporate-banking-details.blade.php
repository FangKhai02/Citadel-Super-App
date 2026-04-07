@extends('voyager::master')

@section('page_title', __('View Corporate Banking Details'))

@section('page_header')
<h1 class="page-title">
    <i class="voyager-wallet"></i>
    {{ __('View Corporate Banking Details') }}
</h1>
<a href="{{ route('browse.corporate.banking.details', ['corporate_client_id' => $corporateClient->id]) }}" class="btn btn-warning">
    <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
</a>
@stop

@section('content')
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-bordered" style="padding-bottom:5px;">

                @php
                $fields = [
                'Bank Name' => $corporateBankDetails->bank_name,
                'Account Number' => $corporateBankDetails->account_number,
                'Account Holder Name' => $corporateBankDetails->account_holder_name,
                'Bank Address' => $corporateBankDetails->bank_address,
                'Bank Postcode' => $corporateBankDetails->postcode,
                'Bank City' => $corporateBankDetails->city,
                'Bank State' => $corporateBankDetails->state,
                'Bank Country' => $corporateBankDetails->country,
                'SWIFT Code' => $corporateBankDetails->swift_code,
                ];
                @endphp

                @foreach($fields as $label => $value)
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">{{ __($label) }}</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $value ?? '-' }}</p>
                </div>
                <hr style="margin:0;">
                @endforeach

                <!-- Bank Account Proof -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">{{ __('Bank Account Proof') }}</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    @if(isset($corporateBankDetails->bank_account_proof_key))
                    <x-document-display :document="$corporateBankDetails->bank_account_proof_key" title="{{ __('View Bank Account Proof') }}" />
                    @else
                    <p>-</p>
                    @endif
                </div>

            </div><!-- panel -->
        </div>
    </div>
</div>
@stop
