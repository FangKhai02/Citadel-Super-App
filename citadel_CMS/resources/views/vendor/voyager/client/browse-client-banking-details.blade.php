@extends('voyager::master')

@section('page_title', __('Banking Details for Client'))
@section('page_header')
    <h1 class="page-title">
        <i class="voyager-info-circled"></i>
<!--        Banking Details for {{ $userDetails->name }}-->
        Client Bank Management
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
                            <th>Bank Name</th>
                            <th>Account Holder Name</th>
                            <th>Bank Account Number</th>
                            <th>Created Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($bankDetails as $key => $bankDetail)
                            <tr>
                                <td>{{ $key + 1 }}</td>
                                <td>{{ $bankDetail->bank_name }}</td>
                                <td>{{ $bankDetail->account_holder_name }}</td>
                                <td>{{ $bankDetail->account_number }}</td>
                                <td>{{ $bankDetail->created_at }}</td>
                                <td class="no-sort no-click bread-actions">
                                    <a href="{{ route('view.client.banking.details', ['client_id' => $client->id, 'id' => $bankDetail->id]) }}" title="View" class="btn btn-sm btn-warning pull-right view">
                                        <i class="voyager-eye"></i> <span class="hidden-xs hidden-sm">View</span>
                                    </a>
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
