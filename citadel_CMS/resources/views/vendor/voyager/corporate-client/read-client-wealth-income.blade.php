@extends('voyager::master')

@section('page_title', 'View Corporate Wealth & Income')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-info-circled"></i>
        View Corporate Wealth & Income for {{ $corporate->corporateDetail->entity_name }}
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

                    <!-- Annual Income Declaration -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Annual Income Declaration</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporate->annual_income_declaration ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">

                    <!-- Source of Income -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Source of Income</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <p>{{ $corporate->source_of_income ?? '-' }}</p>
                    </div>
                    <hr style="margin:0;">
                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
