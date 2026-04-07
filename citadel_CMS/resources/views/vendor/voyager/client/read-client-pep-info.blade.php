@extends('voyager::master')

@section('page_title', 'View Client PEP Info')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-info-circled"></i>
        View Client PEP Info
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

                    <!-- Is PEP -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">PEP Status</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>
                            <span class="label label-info">{{ $pepInfo->pep ? 'Yes' : 'No' }}</span>
                        </p>
                    </div>
                    <hr style="margin:0;">

                    <!-- PEP Category -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">PEP Type</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $pepInfo->pep_type ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Immediate Family Name -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Full Name of Immediate Family</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $pepInfo->pep_immediate_family_name ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- PEP Position -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Current Position / Designation</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $pepInfo->pep_position ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- PEP Organisation -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Organisation / Entity</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $pepInfo->pep_organisation ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- PEP Attachment -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">PEP Supporting Document</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        @if(isset($pepInfo->pep_supporting_documents_key))
                        <x-document-display :document="$pepInfo->pep_supporting_documents_key" title="View PEP Attachment" />
                        @else
                            <p>-</p>
                        @endif
                    </div>
                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
