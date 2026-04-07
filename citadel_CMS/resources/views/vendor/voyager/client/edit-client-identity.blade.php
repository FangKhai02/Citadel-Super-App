@extends('voyager::master')

@section('page_title', 'Edit Client Identity')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-person"></i>
        Edit Client Identity
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <form role="form" action="{{ route('update.client.identity', $client->id) }}" method="POST"
                        enctype="multipart/form-data">
                        {{ csrf_field() }}
                        {{ method_field('PUT') }}

                        <div class="panel-body">
                            <!-- Agent Full Name -->
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <input type="text" name="name" class="form-control" value="{{ $userDetails->name }}"
                                    disabled>
                            </div>

                            <!-- NRIC / Passport No. -->
                            <div class="form-group">
                                <label for="identity_card_number">ID Number</label>
                                <input type="text" name="identity_card_number" class="form-control"
                                    value="{{ $userDetails->identity_card_number }}" disabled>
                            </div>

                            <!-- Date of Birth -->
                            <div class="form-group">
                                <label for="dob">Date of Birth</label>
                                <input type="date" name="dob" class="form-control" value="{{ $userDetails->dob }}"
                                       disabled>
                            </div>

                            <!-- Mobile Number --><div class="form-group">
                                <label for="mobile_number">Mobile Number</label>
                                <input type="text" name="mobile_country_code" class="form-control mb-2"
                                       value="{{ $userDetails->mobile_country_code }}" placeholder="Enter country code" required>
                                <p></p>
                                <input type="text" name="mobile_number" class="form-control"
                                       value="{{ $userDetails->mobile_number }}" placeholder="Enter mobile number" required>
                            </div>

                            <!-- Email -->
                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" name="email" class="form-control" value="{{ $userDetails->email }}"
                                    required>
                            </div>

                            <!-- Gender -->
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select name="gender" class="form-control" disabled>
                                    <option value="" disabled {{ is_null($userDetails->gender) ? 'selected ' : '' }}>
                                        Select Gender</option>
                                    <option value="male" {{ $userDetails->gender == 'male' ? 'selected' : '' }}>Male
                                    </option>
                                    <option value="female" {{ $userDetails->gender == 'female' ? 'selected' : '' }}>Female
                                    </option>
                                </select>
                            </div>

                            <!-- Marital Status -->
                            <div class="form-group">
                                <label for="marital_status">Marital Status</label>
                                <select name="marital_status" class="form-control" required>
                                    <option value="" disabled
                                        {{ is_null($userDetails->marital_status) ? 'selected' : '' }}>Select Marital Status
                                    </option>
                                    <option value="single" {{ $userDetails->marital_status == 'single' ? 'selected' : '' }}>
                                        Single</option>
                                    <option value="married"
                                        {{ $userDetails->marital_status == 'married' ? 'selected' : '' }}>Married</option>
                                </select>
                            </div>

                            <!-- Resident Status -->
                            <div class="form-group">
                                <label for="residential_status">Residential Status</label>
                                <select name="residential_status" class="form-control" required>
                                    <option value="" disabled
                                        {{ is_null($userDetails->residential_status) ? 'selected ' : '' }}>Select Resident
                                        Status</option>
                                    <option value="citizen"
                                        {{ $userDetails->residential_status == 'resident' ? 'selected' : '' }}>Resident
                                    </option>
                                    <option value="foreigner"
                                        {{ $userDetails->residential_status == 'non-resident' ? 'selected' : '' }}>
                                        Non-Resident</option>
                                </select>
                            </div>

                            <!-- Permanent Address -->
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" name="address" class="form-control"
                                    value="{{ $userDetails->address }}" disabled>
                            </div>

                            <!-- Postcode -->
                            <div class="form-group">
                                <label for="postcode">Postcode</label>
                                <input type="text" name="postcode" class="form-control"
                                       value="{{ $userDetails->postcode }}" disabled>
                            </div>

                            <!-- City -->
                            <div class="form-group">
                                <label for="city">City</label>
                                <input type="text" name="city" class="form-control" value="{{ $userDetails->city }}"
                                       disabled>
                            </div>

                            <!-- State -->
                            <div class="form-group">
                                <label for="state">State</label>
                                <input type="text" name="state" class="form-control" value="{{ $userDetails->state }}"
                                       disabled>
                            </div>

                            <!-- Country -->
                            <div class="form-group">
                                <label for="country">Country</label>
                                <input type="text" name="country" class="form-control"
                                    value="{{ $userDetails->country }}" disabled>
                            </div>

                            <!-- Proof of Address -->
                            <div
                                class="form-group
                                @if ($userDetails->proof_of_address_file_key) has-image @endif">
                                <label class="control-label" for="proof_of_address_file_key">Proof of Address</label>
                                <input type="file" name="proof_of_address_file_key" disabled>
                                @if ($userDetails->proof_of_address_file_key)
                                <img src="{{ asset('storage/' . $userDetails->proof_of_address_file_key) }}"
                                     alt="Proof of Address">
                                @endif
                            </div>

                            <!-- Onboarding Agreement -->
                            <div
                                class="form-group
                                @if ($userDetails->onboarding_agreement_key) has-image @endif">
                                <label class="control-label" for="onboarding_agreement_key">Onboarding Agreement PDF</label>
                                <input type="file" name="onboarding_agreement_key" disabled>
                                @if ($userDetails->onboarding_agreement_key)
                                <img src="{{ asset('storage/' . $userDetails->onboarding_agreement_key) }}"
                                     alt="Onboarding Agreement">
                                @endif
                            </div>

                            <!-- IC Document -->
                            <div
                                class="form-group
                                @if ($userDetails->ic_document) has-image @endif">
                                <label class="control-label" for="ic_document">Document ID</label>
                                <input type="file" name="ic_document" disabled>
                                @if ($userDetails->identity_card_front_image_key && $userDetails->identity_card_back_image_key)
                                    <img src="{{ asset('storage/' . $userDetails->identity_card_front_image_key) }}" alt="Front Document ID">
                                <p></p>
                                <img src="{{ asset('storage/' . $userDetails->identity_card_back_image_key) }}" alt="Back Document ID">
                                @endif
                            </div>
                            <!-- Selfie Document -->
                            <div
                                class="form-group
                                @if ($userDetails->selfie_image_key) has-image @endif">
                                <label class="control-label" for="selfie_image_key">Selfie</label>
                                <input type="file" name="selfie_image_key">
                                @if ($userDetails->selfie_image_key)
                                    <img src="{{ asset('storage/' . $userDetails->selfie_image_key) }}"
                                        alt="Selfie Document">
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
