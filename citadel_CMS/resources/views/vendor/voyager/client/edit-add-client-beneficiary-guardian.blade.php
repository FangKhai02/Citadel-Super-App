@extends('voyager::master')

@section('page_title', isset($beneficiaryGuardian) ? 'Edit Beneficiary Guardian' : 'Create Beneficiary Guardian')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-person"></i>
        {{ isset($beneficiaryGuardian) ? 'Edit Beneficiary Guardian' : 'Create Beneficiary Guardian' }}
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <form role="form" 
                          action="{{ isset($beneficiaryGuardian) ? route('update.beneficiary.guardian', ['client_id' => $client->id, 'id' => $beneficiaryGuardian->id]) : route('store.client.beneficiaries.guardian', ['id' => $client->id]) }}" 
                          method="POST" 
                          enctype="multipart/form-data">
                        {{ csrf_field() }}
                        @if(isset($beneficiaryGuardian))
                            {{ method_field('PUT') }}
                        @endif

                            <!-- Guardian Full Name -->
                            <div class="form-group">
                                <label for="full_name">Guardian Full Name</label>
                                <input type="text" name="full_name" class="form-control" value="{{ $beneficiaryGuardian->full_name ?? '' }}" required>
                            </div>

                            <!-- NRIC / Passport No. -->
                            <div class="form-group">
                                <label for="identity_card_number">NRIC / Passport No.</label>
                                <input type="text" name="identity_card_number" class="form-control" value="{{ $beneficiaryGuardian->identity_card_number ?? '' }}" required>
                            </div>

                            <!-- Date of Birth -->
                            <div class="form-group">
                                <label for="dob">Date of Birth</label>
                                <input type="date" name="dob" class="form-control" value="{{ $beneficiaryGuardian->dob ?? '' }}" required>
                            </div>

                            <!-- Gender -->
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select name="gender" class="form-control" required>
                                    <option value="">Select Gender</option>
                                    <option value="Male" {{ isset($beneficiaryGuardian) && $beneficiaryGuardian->gender == 'Male' ? 'selected' : '' }}>Male</option>
                                    <option value="Female" {{ isset($beneficiaryGuardian) && $beneficiaryGuardian->gender == 'Female' ? 'selected' : '' }}>Female</option>
                                </select>
                            </div>

                            <!-- Marital Status -->
                            <div class="form-group">
                                <label for="marital_status">Marital Status</label>
                                <select name="marital_status" class="form-control">
                                    <option value="">Select Marital Status</option>
                                    <option value="Single" {{ isset($beneficiaryGuardian) && $beneficiaryGuardian->marital_status == 'Single' ? 'selected' : '' }}>Single</option>
                                    <option value="Married" {{ isset($beneficiaryGuardian) && $beneficiaryGuardian->marital_status == 'Married' ? 'selected' : '' }}>Married</option>
                                </select>

                            <!-- Resident Status -->
                            <div class="form-group">
                                <label for="residential_status">Resident Status</label>
                                <input type="text" name="residential_status" class="form-control" value="{{ $beneficiaryGuardian->residential_status ?? '' }}">
                            </div>

                            <!-- Nationality -->
                            <div class="form-group">
                                <label for="nationality">Nationality</label>
                                <input type="text" name="nationality" class="form-control" value="{{ $beneficiaryGuardian->nationality ?? '' }}">
                            </div>

                            <!-- Address -->
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" name="address" class="form-control" value="{{ $beneficiaryGuardian->address ?? '' }}">
                            </div>

                            <!-- Postcode -->
                            <div class="form-group">
                                <label for="postcode">Postcode</label>
                                <input type="text" name="postcode" class="form-control" value="{{ $beneficiaryGuardian->postcode ?? '' }}">
                            </div>

                            <!-- City -->
                            <div class="form-group">
                                <label for="city">City</label>
                                <input type="text" name="city" class="form-control" value="{{ $beneficiaryGuardian->city ?? '' }}">
                            </div>

                            <!-- State -->
                            <div class="form-group">
                                <label for="state">State</label>
                                <input type="text" name="state" class="form-control" value="{{ $beneficiaryGuardian->state ?? '' }}">
                            </div>

                            <!-- Country -->
                            <div class="form-group">
                                <label for="country">Country</label>
                                <input type="text" name="country" class="form-control" value="{{ $beneficiaryGuardian->country ?? '' }}">
                            </div>

                            <!-- Mobile Number -->
                            <div class="form-group">
                                <label for="mobile">Mobile Number</label>
                                <input type="text" name="mobile" class="form-control" value="{{ $beneficiaryGuardian->mobile ?? '' }}" required>
                            </div>

                            <!-- Email -->
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" name="email" class="form-control" value="{{ $beneficiaryGuardian->email ?? '' }}">
                            </div>

                            <!-- Address Proof -->
                            <div class="form-group">
                                <label for="address_proof">Address Proof</label>
                                <input type="file" name="address_proof">
                                @if(isset($beneficiaryGuardian) && $beneficiaryGuardian->address_proof)
                                    <a href="{{ asset('storage/' . $beneficiaryGuardian->address_proof) }}" target="_blank">View Address Proof</a>
                                @endif
                            </div>

                            <!-- IC Document -->
                            <div class="form-group">
                                <label for="ic_document">IC Document</label>
                                <input type="file" name="ic_document">
                                @if(isset($beneficiaryGuardian) && $beneficiaryGuardian->ic_document)
                                    <a href="{{ asset('storage/' . $beneficiaryGuardian->ic_document) }}" target="_blank">View IC Document</a>
                                @endif
                            </div>
                        </div>

                        <div class="panel-footer">
                            <button type="submit" class="btn btn-primary save">{{ isset($beneficiaryGuardian) ? 'Update' : 'Create' }}</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@stop
