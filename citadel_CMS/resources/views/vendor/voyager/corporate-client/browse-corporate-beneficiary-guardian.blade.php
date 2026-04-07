@extends('voyager::master')

@section('page_title', __('Beneficiary Guardians for Client'))

@section('page_header')
<h1 class="page-title">
    <i class="voyager-info-circled"></i>
    Guardians for {{ $corporate->corporateDetail->entity_name }}
    <a href="{{ route('voyager.corporate-client.index') }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
    </a>
</h1>
@stop

@section('content')
@include('voyager::alerts')
<div class="page-content browse container-fluid">
    <div class="panel panel-bordered">
        <div class="panel-body">
            <table id="dataTable" class="table table-hover">
                <thead>
                <tr>
                    <th>Guardian Name</th>
                    <th>Beneficiary Name</th>
                    <th>Relationship to Beneficiary</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                @forelse ($beneficiaryGuardians as $guardian)
                <tr>
                    <td>{{ $guardian->full_name ?? '-' }}</td>
                    <td>
                        @forelse ($guardian->beneficiaries as $beneficiary)
                        {{ $beneficiary->full_name }}{{ !$loop->last ? ', ' : '' }}
                        @empty
                        -
                        @endforelse
                    </td>
                    <td>@forelse ($guardian->beneficiaries as $beneficiary)
                        {{ $beneficiary->relationship_to_guardian }}{{ !$loop->last ? ', ' : '' }}
                        @empty
                        -
                        @endforelse</td>
                    <td class="no-sort no-click bread-actions">
                        <a href="{{ route('read.corporate.guardian', ['corporate_client_id' => $corporate->id, 'guardian_id' => $guardian->id]) }}" title="View" class="btn btn-sm btn-warning view">
                            <i class="voyager-eye"></i> <span class="hidden-xs hidden-sm">View</span>
                        </a>
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="4" class="text-center">@lang('No guardians found for this client.')</td>
                </tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection

@section('javascript')
<script>
    $(document).ready(function() {
        $('#dataTable').DataTable({
            paging: false, // Disable pagination
            searching: false, // Disable searching
            columnDefs: [
                { orderable: false, targets: 'no-sort' }, // Disable sorting for specific columns
            ],
        });
    });
</script>
@endsection
