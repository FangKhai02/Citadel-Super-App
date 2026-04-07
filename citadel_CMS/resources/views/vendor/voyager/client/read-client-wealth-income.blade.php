@extends('voyager::master')

@section('page_title', 'View Client Wealth & Income')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-info-circled"></i>
        View Client Wealth & Income for {{ $userDetails->name }}
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
                    
                    <!-- Annual Income Declaration -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Annual Income Declaration</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientWealthIncome->annual_income_declaration ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Source of Income -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Source of Income</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientWealthIncome->source_of_income ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Source of Income Remark -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Source of Income Remark</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $clientWealthIncome->source_of_income_remark ?? '-' }}</p>
                    </div>
                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
