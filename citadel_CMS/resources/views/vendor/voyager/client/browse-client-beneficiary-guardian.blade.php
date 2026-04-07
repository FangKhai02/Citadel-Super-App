@extends('voyager::master')

@section('page_title', __('Beneficiary Guardians for Client'))
@section('page_header')
    <h1 class="page-title">
        <i class="voyager-info-circled"></i>
        Beneficiary Guardians for {{ $userDetails->name }}
        <a href="{{ route('voyager.client.index') }}" class="btn btn-warning">
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
                            <th>No.</th>
<!--                            <th>Client Name</th>-->
                            <th>Guardian Name</th>
                            <th>Beneficiary Name</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($beneficiaryGuardian as $key => $guardian)
                            <tr>
                                <td>{{ $key + 1 }}</td>
<!--                                <td>{{ $guardian->client->userDetails->name ?? '-' }}</td>-->
                                <td>{{ $guardian->full_name ?? '-' }}</td>
                                <td>  @if($guardian->beneficiaries->isNotEmpty())
                                    @foreach($guardian->beneficiaries as $beneficiary)
                                    {{ $beneficiary->full_name }}@if(!$loop->last), @endif
                                    @endforeach
                                    @else
                                    -
                                    @endif
                                </td>
                                <td class="no-sort no-click bread-actions">
                                    <!-- ADD READ BUTTON -->
                                    <a href="{{ route('view.client.beneficiary.guardian', ['client_id' => $client->id, 'id' => $guardian->id]) }}" title="View" class="btn btn-sm btn-warning pull-right view">
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
