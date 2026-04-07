@extends('voyager::master')

@section('page_title', __('Edit Corporate Banking Details'))

@section('page_header')
<h1 class="page-title">
    <i class="voyager-wallet"></i>
    {{ __('Edit Corporate Banking Details') }}
    <a href="{{ route('browse.corporate.banking.details', ['corporate_client_id' => $corporateClient->id]) }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">{{ __('Return to List') }}</span>
    </a>
</h1>
@stop

@section('content')
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-md-12">
            <form action="{{ route('update.corporate.banking.details', ['corporate_client_id' => $corporateClient->id]) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')

                <div class="panel panel-bordered" style="padding-bottom:5px;">
                    @php
                    $fields = [
                    'Bank Name' => 'bank_name',
                    'Bank Account Number' => 'account_number',
                    'Account Holder Name' => 'account_holder_name',
                    'Bank Address' => 'bank_address',
                    'Postcode' => 'postcode',
                    'City' => 'city',
                    'State' => 'state',
                    'Country' => 'country',
                    'SWIFT Code' => 'swift_code',
                    ];
                    @endphp

                    @foreach($fields as $label => $field)
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">{{ __($label) }}</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input
                            type="text"
                            name="{{ $field }}"
                            class="form-control"
                            value="{{ old($field, $corporateBankDetails->$field) }}"
                            placeholder="{{ __($label) }}">
                    </div>
                    <hr style="margin:0;">
                    @endforeach

                    <!-- Bank Account Proof -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">{{ __('Bank Account Proof') }}</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        @if(isset($corporateBankDetails->bank_account_proof_key))
                        <x-document-display :document="$corporateBankDetails->bank_account_proof_key" title="{{ __('Current Bank Account Proof') }}" />
                        @endif
                        <label>{{ __('Upload New Bank Account Proof') }}</label>
                        <input type="file" name="bank_account_proof_key" class="form-control">
                    </div>

                </div><!-- panel -->
                <!-- Submit Button -->
                <div class="row">
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-primary">
                            <i class="glyphicon glyphicon-save"></i> Save Changes
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
@stop
