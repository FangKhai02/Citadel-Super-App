@extends('voyager::master')

@section('page_title', 'View Corporate Details')

@section('page_header')
<h1 class="page-title">
    <i class="voyager-person"></i>
    Corporate Details for {{ $corporate->corporateDetail->entity_name ?? 'N/A' }}
    <a href="{{ route('voyager.corporate-client.index') }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
    </a>
</h1>
@stop

@section('content')
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-bordered" style="padding-bottom:5px;">

                <!-- Corporate ID -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Corporate ID</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporate_client_id ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Name of Entity -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Name</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->entity_name ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Type of Entity -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Type of Entity</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ isset($corporate->corporateDetail->entity_type) ? ucwords(str_replace('_', ' ', strtolower($corporate->corporateDetail->entity_type))) : '-' }}</p>
                </div>

                <hr style="margin:0;">

                <!-- Registration Number -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Registration Number</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->registration_number ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Date of Incorporation -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Date of Incorporation</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->date_incorporation ? \Carbon\Carbon::parse($corporate->corporateDetail->date_incorporation)->format('d M Y') : '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Place of Incorporation -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Place of Incorporation</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->place_incorporation ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Business Type -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Business Type</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ isset($corporate->corporateDetail->business_type) ? ucwords(str_replace('_', ' ', strtolower($corporate->corporateDetail->business_type))) : '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Registered Address -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Registered Address</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->registered_address ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Registered Address - Postcode -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Registered Address Postcode</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->postcode ?? '-' }}</p></div>
                <hr style="margin:0;">

                <!-- Registered Address - City -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Registered Address City</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->city ?? '-' }}</p></div>
                <hr style="margin:0;">

                <!-- Registered Address - State -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Registered Address State</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->state ?? '-' }}</p></div>
                <hr style="margin:0;">

                <!-- Registered Address - Country -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Registered Address Country</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->country ?? '-' }}</p></div>
                <hr style="margin:0;">


                <!-- Business Address -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Business Address</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->business_address ?? '-' }}</p>
                </div>
                <hr style="margin:0;">

                <!-- Business Address - Postcode -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Business Address Postcode</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->business_postcode ?? '-' }}</p></div>
                <hr style="margin:0;">

                <!-- Business Address - City -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Business Address City</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->business_city ?? '-' }}</p></div>
                <hr style="margin:0;">

                <!-- Business Address - State -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Business Address State</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->business_state ?? '-' }}</p></div>
                <hr style="margin:0;">

                <!-- Business Address - Country -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Business Address Country</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $corporate->corporateDetail->business_country ?? '-' }}</p></div>
                <hr style="margin:0;">

                <!-- Agent's Name -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Agent</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    <p>{{ $agentUserDetail ? $agentUserDetail->name : '-' }}</p>
                </div>

                <!-- Corporate Documents -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-bordered">
                            <div class="panel-heading" style="border-bottom:0;">
                                <h3 class="panel-title">Documents</h3>
                            </div>
                            <div class="panel-body">
                                @foreach($corporateDocs as $document)
                                <div class="form-group">
                                    <label>{{ $document->company_document_name ?? 'Document' }}:</label>
                                    <x-document-display :document="$document->company_document_key" :title="$document->company_document_name ?? 'Untitled Document'" />
                                </div>
                                @endforeach
                                @if($corporateDocs->isEmpty())
                                <p>No documents available for this corporate client.</p>
                                @endif
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Onboarding Agreement -->
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">Onboarding Agreement</h3>
                </div>
                <div class="panel-body">
                    @if(isset($corporate->corporateDetail->digital_signature_key))
                    <x-document-display :document="$corporate->corporateDetail->digital_signature_key" title="Onboarding Agreement" />
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
