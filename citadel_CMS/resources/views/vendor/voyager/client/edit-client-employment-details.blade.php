@extends('voyager::master')

@section('page_title', 'Edit Client Employment Details')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-briefcase"></i>
        Edit Client Employment Details for {{ $userDetails->name }}
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <div class="panel-body">
                        <form action="{{ route('update.client.employment.details', $client->id) }}" method="POST">
                            @csrf
                            @method('PUT')

                            <div class="form-group">
                                <label for="employment_type">Employment Type</label>
                                <select class="form-control" id="employment_type" name="employment_type" required>
                                    <option value="" disabled {{ empty($clientEmploymentDetails->employment_type) ? 'selected' : '' }}>Select Employment Type</option>
                                    <option value="Full-time" {{ $clientEmploymentDetails->employment_type == 'Full-time' ? 'selected' : '' }}>Full-time</option>
                                    <option value="Part-time" {{ $clientEmploymentDetails->employment_type == 'Part-time' ? 'selected' : '' }}>Part-time</option>
                                    <option value="Contract" {{ $clientEmploymentDetails->employment_type == 'Contract' ? 'selected' : '' }}>Contract</option>
                                    <option value="Temporary" {{ $clientEmploymentDetails->employment_type == 'Temporary' ? 'selected' : '' }}>Temporary</option>
                                    <option value="Internship" {{ $clientEmploymentDetails->employment_type == 'Internship' ? 'selected' : '' }}>Internship</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="employer_name">Name of Employer</label>
                                <input type="text" class="form-control" id="employer_name" name="employer_name" value="{{ $clientEmploymentDetails->employer_name }}" required>
                            </div>

                            <div class="form-group">
                                <label for="industry_type">Industry Type</label>
                                <select class="form-control" id="industry_type" name="industry_type" required>
                                    <option value="" disabled {{ empty($clientEmploymentDetails->industry_type) ? 'selected' : '' }}>Select Industry Type</option>
                                    <option value="Technology" {{ $clientEmploymentDetails->industry_type == 'Technology' ? 'selected' : '' }}>Technology</option>
                                    <option value="Healthcare" {{ $clientEmploymentDetails->industry_type == 'Healthcare' ? 'selected' : '' }}>Healthcare</option>
                                    <option value="Finance" {{ $clientEmploymentDetails->industry_type == 'Finance' ? 'selected' : '' }}>Finance</option>
                                    <option value="Education" {{ $clientEmploymentDetails->industry_type == 'Education' ? 'selected' : '' }}>Education</option>
                                    <option value="Retail" {{ $clientEmploymentDetails->industry_type == 'Retail' ? 'selected' : '' }}>Retail</option>
                                    <option value="Other" {{ $clientEmploymentDetails->industry_type == 'Other' ? 'selected' : '' }}>Other</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="job_title">Job Title</label>
                                <input type="text" class="form-control" id="job_title" name="job_title" value="{{ $clientEmploymentDetails->job_title }}" required>
                            </div>

                            <div class="form-group">
                                <label for="employer_address">Employer Address</label>
                                <input type="text" class="form-control" id="employer_address" name="employer_address" value="{{ $clientEmploymentDetails->employer_address }}" required>
                            </div>

                            <div class="form-group">
                                <label for="employer_postcode">Postcode</label>
                                <input type="text" class="form-control" id="employer_postcode" name="employer_postcode" value="{{ $clientEmploymentDetails->employer_postcode }}" required>
                            </div>

                            <div class="form-group">
                                <label for="employer_city">City</label>
                                <input type="text" class="form-control" id="employer_city" name="employer_city" value="{{ $clientEmploymentDetails->employer_city }}" required>
                            </div>

                            <div class="form-group">
                                <label for="employer_state">State</label>
                                <input type="text" class="form-control" id="employer_state" name="employer_state" value="{{ $clientEmploymentDetails->employer_state }}" required>
                            </div>

                            <div class="form-group">
                                <label for="employer_country">Country</label>
                                <input type="text" class="form-control" id="employer_country" name="employer_country" value="{{ $clientEmploymentDetails->employer_country }}" required>
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop

@push('javascript')
    <script>
        // Add any necessary JavaScript here
    </script>
@endpush
