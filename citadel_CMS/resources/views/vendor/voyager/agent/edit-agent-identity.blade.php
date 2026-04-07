@extends('voyager::master')

@section('page_title', 'Edit Agent')

@section('page_header')
<h1 class="page-title">
    <i class="voyager-person"></i>
    Edit Details for Agent {{ $userDetails->name }}
</h1>
@stop

@section('content')
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-bordered">
                <form role="form"
                      action="{{ route('update.agent.identity', $agent->id) }}"
                      method="POST" enctype="multipart/form-data">
                    {{ csrf_field() }}
                    {{ method_field('PUT') }}

                    <div class="panel-body">

                        <!-- Agency Name -->
<!--                        <div class="form-group">-->
<!--                            <label for="agency_name">Agency Name</label>-->
<!--                            <input type="text" name="agency_name" class="form-control"-->
<!--                                   value="{{ $agent->agency->agency_name ?? 'N/A' }}" disabled>-->
<!--                        </div>-->

                        <!-- Recruit Manager -->
<!--                        <div class="form-group">-->
<!--                            <label for="recruit_manager_name">Recruit Manager</label>-->
<!--                            <input type="text" name="recruit_manager_name" class="form-control"-->
<!--                                   value="{{ optional($agent->recruitManager)->userDetails->name ?? 'No Name Available' }}" disabled>-->
<!--                        </div>-->

                        <!-- Agent Agreement Date -->
                        <div class="form-group">
                            <label for="agency_agreement_date">Agency Agreement Date</label>
                            <input type="text" name="agency_agreement_date" class="form-control" id="agency_agreement_date"
                                   value="{{ old('agency_agreement_date', $agent->agency->agency_agreement_date ?? '-') }}"
                                   placeholder="DD/MM/YYYY">
                        </div>

                        <!--                        <div class="form-group">-->
<!--                            <label for="agency_name">Agency Agreement Date</label>-->
<!--                            <input type="text" name="agency_agreement_date" class="form-control"-->
<!--                                   value="{{ $agent->agency->agency_agreement_date ?? '-' }}"-->
<!--                                   placeholder="DD/MM/YYYY">-->
<!--                        </div>-->


                        <!-- Agent Role -->
                        <div class="form-group">
                            <label for="agent_role_name">Agent Role</label>
                            <select name="agent_role_id" class="form-control">
                                <option value="">Select Role</option>
                                @foreach($roles as $role)
                                <option value="{{ $role->id }}"
                                        @if($role->id == $agent->agent_role_id) selected @endif>
                                    {{ $role->role_description }}
                                </option>
                                @endforeach
                            </select>
                        </div>

                        <!-- Referral Code -->
<!--                        <div class="form-group">-->
<!--                            <label for="referral_code">Referral Code</label>-->
<!--                            <input type="text" name="referral_code" class="form-control"-->
<!--                                   value="{{ $agent->referral_code }}" disabled>-->
<!--                        </div>-->

                        <!-- Status (Editable) -->
                        <div class="form-group">
                            <label for="status">Status</label>
                            <select name="status" class="form-control">
                                <option value="ACTIVE" {{ $agent->status == 'ACTIVE' ? 'selected' : '' }}>Active</option>
                                <option value="SUSPENDED" {{ $agent->status == 'SUSPENDED' ? 'selected' : '' }}>Suspended</option>
                                <option value="TERMINATED" {{ $agent->status == 'TERMINATED' ? 'selected' : '' }}>Terminated</option>
                            </select>
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
