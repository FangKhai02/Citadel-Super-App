@extends('voyager::master')

@section('page_title', __('Beneficiaries for Client'))
@section('page_header')
    <h1 class="page-title">
        <i class="voyager-info-circled"></i>
        Beneficiaries for {{ $userDetails->name }}
        <a href="{{ route('voyager.client.index') }}" class="btn btn-warning">
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
                            <th>No.</th>
                            <th>Full Name</th>
                            <th>Guardian Name</th>
                            <th>Relationship to Settlor</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($beneficiaries as $key => $beneficiary)
                            <tr>
                                <td>{{ $key + 1 }}</td>
                                <td>{{ $beneficiary->full_name }}</td>
                                <td>{{ $beneficiary->guardians->first()->full_name ?? '-' }}</td>
                                <td>{{ $beneficiary->relationship_to_settlor ?? '-' }}</td>
                                <td class="no-sort no-click bread-actions">
                                     <!-- ADD READ BUTTON -->
                                    <a href="{{ route('view.client.beneficiary', ['client_id' => $client->id, 'id' => $beneficiary->id]) }}" title="View" class="btn btn-sm btn-warning pull-right view">
                                        <i class="voyager-eye"></i> <span class="hidden-xs hidden-sm">View</span>
                                    </a>
                                    <!-- <a href="{{ route('edit.client.beneficiaries', ['client_id' => $client->id, 'id' => $beneficiary->id]) }}" title="Edit" class="btn btn-sm btn-primary pull-right edit">
                                        <i class="voyager-edit"></i> <span class="hidden-xs hidden-sm">Edit</span>
                                    </a> -->
                                </td>
                            </tr>
                        @endforeach
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
                "lengthChange": false,  // Disables the 'Show <x> entries' dropdown
                "searching": false      // Disables the search box
            });
        });
    </script>
@endsection
