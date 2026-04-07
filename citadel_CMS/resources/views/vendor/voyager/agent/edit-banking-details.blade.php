@extends('voyager::master')

@section('page_title', 'Edit Agent Banking Details')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-wallet"></i>
        Edit Agent Banking Details
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <form role="form"
                          action="{{ route('update.agent.banking.details', $agent->id) }}"
                          method="POST" enctype="multipart/form-data">
                        {{ csrf_field() }}
                        {{ method_field('PUT') }}

                        <div class="panel-body">
                            <!-- Bank Name -->
                            <div class="form-group">
                                <label for="bank_name">Bank Name</label>
                                <input type="text" name="bank_name" class="form-control"
                                       value="{{ $bankingDetails->bank_name ?? '' }}" required>
                            </div>

                            <!-- Bank Account Number -->
                            <div class="form-group">
                                <label for="account_number">Account Number</label>
                                <input type="text" name="account_number" class="form-control"
                                       value="{{ $bankingDetails->account_number ?? '' }}" required>
                            </div>

                            <!-- Account Holder Name -->
                            <div class="form-group">
                                <label for="account_holder_name">Account Holder Name</label>
                                <input type="text" name="account_holder_name" class="form-control"
                                       value="{{ $bankingDetails->account_holder_name ?? '' }}" required>
                            </div>

                            <!-- Bank Address -->
<!--                            <div class="form-group">-->
<!--                                <label for="permanent_address">Bank Address</label>-->
<!--                                <input type="text" name="bank_address" class="form-control"-->
<!--                                       value="{{ $bankingDetails->bank_address ?? '' }}">-->
<!--                            </div>-->

                            <!-- Postcode -->
<!--                            <div class="form-group">-->
<!--                                <label for="postcode">Postcode</label>-->
<!--                                <input type="text" name="postcode" class="form-control"-->
<!--                                       value="{{ $bankingDetails->postcode ?? '' }}">-->
<!--                            </div>-->

                            <!-- City -->
<!--                            <div class="form-group">-->
<!--                                <label for="city">City</label>-->
<!--                                <input type="text" name="city" class="form-control"-->
<!--                                       value="{{ $bankingDetails->city ?? '' }}">-->
<!--                            </div>-->

                            <!-- State -->
<!--                            <div class="form-group">-->
<!--                                <label for="state">State</label>-->
<!--                                <input type="text" name="state" class="form-control"-->
<!--                                       value="{{ $bankingDetails->state ?? '' }}">-->
<!--                            </div>-->

                            <!-- Country -->
<!--                            <div class="form-group">-->
<!--                                <label for="country">Country</label>-->
<!--                                <input type="text" name="country" class="form-control"-->
<!--                                       value="{{ $bankingDetails->country ?? '' }}">-->
<!--                            </div>-->

                            <!-- Swift Code -->
                            <div class="form-group">
                                <label for="swift_code">SWIFT Code</label>
                                <input type="text" name="swift_code" class="form-control"
                                       value="{{ $bankingDetails->swift_code ?? '' }}">
                            </div>

                            <!-- Bank Account Proof -->
                            <div class="form-group
                                @if($bankingDetails->bank_account_proof_key)
                                    has-image
                                @endif">
                                <label class="control-label" for="bank_account_proof_key">Bank Account Proof</label>
                                <input type="file" name="bank_account_proof_key">
                                @if($bankingDetails->bank_account_proof_key)
                                    <x-document-display :document="$bankingDetails->bank_account_proof_key" :title="'Bank Account Proof'"/>
                                @endif
                            </div>

                        </div>

                        <div class="panel-footer">
                            <button type="submit" class="btn btn-primary save">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@stop
