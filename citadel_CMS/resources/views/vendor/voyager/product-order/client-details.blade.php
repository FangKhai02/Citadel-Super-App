@extends('voyager::master')

@section('page_title', 'View Client Details')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-person"></i>
        View Client Details
        <a href="{{ route('voyager.product-order.index') }}" class="btn btn-warning">
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
                            <p>{{ $userDetails->name ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- NRIC / Passport No. -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">NRIC / Passport No.</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->identity_card_number ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Address -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Address</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->address ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Mobile Number -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Mobile Number</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->mobile_country_code . $userDetails->mobile_number ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Email -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Email</h3>
                        </div>
                        <div class="panel-body" style="padding-top:0;">
                            <p>{{ $userDetails->email ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Order ID -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Order ID</h3>
                        </div>
                        <div class="panel-body
                            " style="padding-top:0;">
                            <p>{{ $productOrder->id ?? '-' }}</p>
                        </div>
                        <hr style="margin:0;">

                        <!-- Payment ID -->
                        <div class="panel-heading" style="border-bottom:0;">
                            <h3 class="panel-title">Payment ID</h3>
                        </div>
                        <div class="panel-body
                            " style="padding-top:0;">
                            <p>{{ $productOrder->payment_transaction_id ?? '-' }}</p>
                        </div>

                </div><!-- panel -->
            </div>
        </div>
    </div>
@stop
