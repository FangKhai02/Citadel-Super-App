@extends('voyager::master')

@section('page_title', 'View Client Employment Details')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-briefcase"></i>
        View Client Employment Details
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

                    <!-- Employment Type -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Employment Type</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientEmploymentDetails->employment_type ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Name of Employer -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Name of Employer</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientEmploymentDetails->employer_name ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Industry Type -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Industry Type</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ ucfirst($clientEmploymentDetails->industry_type) ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Job Title -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Job Title</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientEmploymentDetails->job_title ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Employer Address -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Employer Address</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientEmploymentDetails->employer_address ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Postcode -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Postcode</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientEmploymentDetails->employer_postcode ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- City -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">City</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientEmploymentDetails->employer_city ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- State -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">State</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientEmploymentDetails->employer_state ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Country -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Country</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientEmploymentDetails->employer_country ?? '-' }}</p>
                    </div>
                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
