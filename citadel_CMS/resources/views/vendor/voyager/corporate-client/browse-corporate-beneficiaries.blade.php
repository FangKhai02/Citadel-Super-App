@extends('voyager::master')

@section('page_title', __('Beneficiaries for Client'))
@section('page_header')
<h1 class="page-title">
    <i class="voyager-info-circled"></i>
    Beneficiaries for {{ $corporateClient->corporateDetail->entity_name }}
    <a href="{{ route('voyager.corporate-client.index') }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
    </a>
</h1>
@stop

@section('content')
<div class="page-content browse container-fluid">
    <div class="panel panel-bordered">
        <div class="panel-body">
            <table id="dataTable" class="table table-hover">
                <thead>
                <tr>
                    <th>Full Name</th>
                    <th>Guardian Name</th>
                    <th>Relationship To Settlor</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                @forelse ($beneficiaries as $key => $beneficiary)
                <tr>
                    <td>{{ $beneficiary->full_name }}</td>
                    <td>
                        @if ($beneficiary->corporateGuardians)
                        {{ $beneficiary->corporateGuardians->full_name }}<br>
                        @else
                        -
                        @endif
                    </td>
                    <td> {{ $beneficiary->relationship_to_settlor }}</td>
                    <td class="no-sort no-click bread-actions">
                        <a href="{{ route('read.corporate.beneficiary', ['corporate_client_id' => $corporateClient->id, 'beneficiary_id' => $beneficiary->id]) }}" title="View" class="btn btn-sm btn-warning view">
                            <i class="voyager-eye"></i> <span class="hidden-xs hidden-sm">View</span>
                        </a>
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="6">No beneficiaries found.</td>
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
            "lengthChange": false,
            "searching": false
        });
    });
</script>
@endsection
