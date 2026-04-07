@extends('voyager::master')

@section('page_title', 'Edit Agency Details')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-company"></i>
        Edit Agency Details for {{ $userDetails->name }}
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <form role="form"
                          action="{{ route('update.agency.details', $agent->id) }}"
                          method="POST" enctype="multipart/form-data">
                        {{ csrf_field() }}
                        {{ method_field('PUT') }}

                        <div class="panel-body">

                            <!-- Agency Name -->
                            <div class="form-group">
                                <label for="agency_name">Agency Name</label>
                                <input type="text" name="agency_name" class="form-control"
                                       value="{{ $agent->agency->agency_name ?? 'N/A' }}" disabled>
                            </div>

                            <!-- Recruit Manager -->
                            <div class="form-group">
                                <label for="recruit_manager_name">Recruit Manager</label>
                                <input type="text" name="recruit_manager_name" class="form-control"
                                       value="{{ optional($agent->recruitManager)->userDetails->name ?? 'No Name Available' }}" disabled>
                            </div>

                            <!-- Agent Role -->
                            <div class="form-group">
                                <label for="agent_role_name">Agent Role</label>
                                <input type="text" name="agent_role_name" class="form-control"
                                    value="{{ $agent->getRoleDisplayName() }}">
                            </div>

                            <!-- Referral Code -->
                            <div class="form-group">
                                <label for="referral_code">Referral Code</label>
                                <input type="text" name="referral_code" class="form-control"
                                       value="{{ $agent->referral_code }}" disabled>
                            </div>

                            <!-- Status (Editable) -->
                            <div class="form-group">
                                <label for="status">Status</label>
                                <br/>
                                <input type="checkbox"
                                       name="status"
                                       class="toggleswitch"
                                       data-on="Active"
                                       data-off="Inactive"
                                       value="1"
                                       {{ $agent->status ? 'checked' : '' }}
                                >
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

@push('javascript')
    <script>
        $(document).ready(function () {
            $('.toggleswitch').bootstrapToggle(); // Initialize the toggle

            $('form').on('submit', function() {
                // If the toggle is not checked, set its value to 0
                if (!$('#status').prop('checked')) {
                    $('#status').val(0); // Sets value to 0 if unchecked
                }
            });
        });
    </script>
@endpush
