@extends('voyager::master')

@section('page_title', __('Banking Details for Corporate'))

@section('page_header')
<h1 class="page-title">
    <i class="voyager-info-circled"></i>
    Corporate Banking Details for {{ $corporateClient->corporateDetail->entity_name }}
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
                    <th>Bank Name</th>
                    <th>Account Holder Name</th>
                    <th>SWIFT Code</th>
                    <th>Created Datetime</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                @forelse ($corporateBankDetails as $key => $detail)
                <tr>
                    <td>{{ $detail->bank_name }}</td>
                    <td>{{ $detail->account_holder_name }}</td>
                    <td>{{ $detail->swift_code }}</td>
                    <td>{{ $detail->created_at }}</td>
                    <td class="no-sort no-click bread-actions">
                        <a href="{{ route('read.corporate.banking.details', ['corporate_client_id' => $corporateClient->id, 'bankDetails_id' => $detail->id]) }}"
                           class="btn btn-sm btn-primary me-2">
                            <i class="voyager-eye"></i> <span class="hidden-xs hidden-sm">View</span>
                        </a>
<!--                        <a href="{{ route('delete.corporate.banking.details', ['corporate_client_id' => $corporateClient->id, 'bankDetails_id' => $detail->id]) }}"-->
<!--                           class="btn btn-sm btn-danger"-->
<!--                           onclick="return confirm('Are you sure you want to delete this bank details?')">-->
<!--                            <i class="voyager-trash"></i> <span class="hidden-xs hidden-sm"> Delete </span>-->
<!--                        </a>-->
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="7" class="text-center">No banking details found for this client.</td>
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
            "lengthChange": false,  // Disable 'Show entries'
            "searching": true,      // Enable search box
            "ordering": true        // Enable column sorting
        });
    });
</script>
@endsection
