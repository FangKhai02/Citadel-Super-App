@extends('voyager::master')

@section('page_title', 'View Corporate Shareholder')

@section('page_header')
<h1 class="page-title">
    <i class="voyager-person"></i>
    View Corporate Shareholder of {{ $corporate_shareholder -> name }}
    <a href="{{ route('browse.corporate.shareholders', ['corporate_client_id' => $corporate->id]) }}" class="btn btn-warning">
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
                    <p>{{ $corporate_shareholder -> name ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Share Percentage -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Share Percentage</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate_shareholder->percentage_of_shareholdings ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Address -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Address</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate_shareholder->address ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Email -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Email Address</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate_shareholder->email ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Mobile Number -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Mobile Number</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate_shareholder->mobile_country_code . ' ' .$corporate_shareholder->mobile_number ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- PEP Status -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">PEP Status</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate_shareholder->pepInfo->pep_status ? 'Yes' : 'No' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- PEP Type -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">PEP Type</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate_shareholder->pepInfo->pep_type ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Full Name of Immediate Family -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Full Name of Immediate Family</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate_shareholder->pepInfo->pep_immediate_family_name ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Current Position / Designation -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Current Position / Designation</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate_shareholder->pepInfo->pep_position ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Organisation / Entity -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Organisation / Entity</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate_shareholder->pepInfo->pep_organisation ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- PEP Document -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">PEP Supporting Document</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    @if(isset($corporate_shareholder->pepInfo->pep_supporting_documents_key))
                    <x-document-display :document="$corporate_shareholder->pepInfo->pep_supporting_documents_key" title="View PEP Document" />
                    @else
                    <p>-</p>
                    @endif
                </div>
                <hr style="margin:0;">

                <!-- IC Document -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">IC Document</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    @if(isset($corporate_shareholder->identity_card_front_image_key))
                    <x-document-display :document="$corporate_shareholder->identity_card_front_image_key" title="View Front IC Document" />
                    @else
                    <p>-</p>
                    @endif
                    @if(isset($corporate_shareholder->identity_card_front_image_key))
                    <x-document-display :document="$corporate_shareholder->identity_card_back_image_key" title="View Back IC Document" />
                    @else
                    <p>-</p>
                    @endif
                </div>
                <hr style="margin:0;">
            </div>
        </div>
    </div>
</div>
@stop
