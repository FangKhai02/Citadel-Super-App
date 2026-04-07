@extends('voyager::master')

@section('page_title', __('Shareholders for Corporate'))
@section('page_header')
<h1 class="page-title">
    <i class="voyager-info-circled"></i>
    Shareholders for {{ $corporate->corporateDetail->entity_name }}
    <a href="{{ route('voyager.corporate-client.index') }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
    </a>
</h1>
@stop

<!--@section('css')-->
<!--<style>-->
<!--    .custom-dropdown-menu .custom-dropdown-item:hover {-->
<!--        background-color: #f5f5f5; /* Background color on hover */-->
<!--        color: #007bff; /* Change text color on hover */-->
<!--    }-->
<!--</style>-->
<!--@endsection-->


@section('content')
<div class="page-content browse container-fluid">
    <div class="panel panel-bordered">
        <div class="panel-body">
            <table id="dataTable" class="table table-hover">
                <thead>
                <tr>
                    <th>No.</th>
                    <th>Full Name</th>
                    <th>Share Percentage</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                @forelse ($shareholders as $key => $item)
                <tr>
                    <td>{{ $key + 1 }}</td>
                    <td>{{ $item->name }}</td>
                    <td>{{ $item->percentage_of_shareholdings }}%</td>
                    <td class="no-sort no-click bread-actions">
                        <!-- View Corporate Shareholder -->
                        <a href="{{ route('read.corporate.shareholder', ['corporate_client_id' => $corporate->id, 'shareholder_id' => $item->id]) }}"
                           class="btn btn-sm btn-primary me-2">
                            <i class="voyager-eye"></i> <span class="hidden-xs hidden-sm"> View </span>
                        </a>
                        <!-- Delete Corporate Shareholder -->
<!--                        <a href="{{ route('delete.corporate.shareholder', ['corporate_client_id' => $corporate->id, 'shareholder_id' => $item->id]) }}"-->
<!--                           class="btn btn-sm btn-danger"-->
<!--                           onclick="return confirm('Are you sure you want to delete this shareholder?')">-->
<!--                            <i class="voyager-trash"></i> <span class="hidden-xs hidden-sm"> Delete </span>-->
<!--                        </a>-->
                    </td>

                </tr>
                @empty
                <tr>
                    <td colspan="4" class="text-center">No shareholders found for this corporate client.</td>
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
            "lengthChange": false,  // Disables the 'Show <x> entries' dropdown
            "searching": true,      // Enables the search box
            "ordering": true        // Enables column-based sorting
        });
    });
</script>
@endsection
