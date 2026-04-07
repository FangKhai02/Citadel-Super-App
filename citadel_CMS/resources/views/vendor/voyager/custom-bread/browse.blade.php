@extends('voyager::master')
@php
$slug = str_replace('-', '_', $modelSlug);
@endphp
@section('page_title', __($pageTitle))

@section('page_header')
<h1 class="page-title">
    <i class="{{ $icon }}"></i>
    {{ $pageTitle }}
    @if (!isset($parent))
    <a href="{{ $returnRoute }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> Return to Parent List
    </a>
    @endif
    @if (Auth::user()->hasPermission('add_' . $slug) && !isset($add))
    <a href="{{ url($baseRoute . $parentId . '/' . $modelSlug . '/create') }}" class="btn btn-success">
        <i class="voyager-plus"></i> Add New
    </a>
    @endif
</h1>
@stop

@section('content')
<div class="page-content browse container-fluid">
    <div class="panel panel-bordered">
        <div class="panel-body">
            <div class="table-responsive" style="min-height: 500px;">
            <table id="dataTable" class="table table-hover">
                <thead>
                <tr>
                    @foreach ($columns as $key => $label)
                    <th>{{ $label }}</th>
                    @endforeach
                    <th class="actions text-right dt-not-orderable">Actions</th>
                </tr>
                </thead>
                <tbody>
                @forelse ($data as $item)
                <tr>
                    @foreach ($columns as $key => $label)
                    <td>
                        <!-- Handle the file columns (dividend_csv_key, etc.) -->
                        @if (in_array($key, ['dividend_csv_key', 'commission_csv_key','agreement_key']) && isset($item->$key))
                        @if (!empty($item->$key))
                        @php
                        $fileName = basename($item->$key); // Extract file name from path
                        @endphp
                        <a href="{{ Storage::disk(config('voyager.storage.disk'))->url($item->$key) }}" target="_blank">
                            {{ $fileName }}
                        </a>
                        @else
                        {{ __('No file available') }}
                        @endif
                        @else
                        <!-- For other columns, check if the data exists and handle accordingly -->
                        @if (isset($item->$key))
                        {{ $item->$key }}
                        @elseif (is_array($item) && array_key_exists($key, $item))
                            @if (in_array($key, ['dividend_csv_key', 'commission_csv_key','withdrawal_csv_key','agreement_key']))
                                <a href="{{ !filter_var($item[$key], FILTER_VALIDATE_URL) ? Util::getS3PDFDownloadUrl($item[$key]) : $item[$key] }}" target="_blank">
                                    {{ $item[$key] }}
                                </a>
                            @else
                                {{ $item[$key] }}
                            @endif
                        @else
                        N/A
                        @endif
                        @endif
                    </td>
                    @endforeach
                    <td class="no-sort no-click bread-actions">
                        @if (Auth::user()->hasPermission('delete_' . $slug) && !isset($delete))
                        @csrf
                            @method('DELETE')
                            <a href="javascript:;" title="Delete" class="btn btn-sm btn-danger pull-right delete"
                                data-id="{{ isset($item->id) ? $item->id : $item['id'] }}" id="delete-{{ isset($item->id) ? $item->id : $item['id'] }}">

                                <i class="voyager-trash"></i> <span class="hidden-xs hidden-sm">Delete</span>
                            </a>
                        @endif
                        @if(Auth::user()->hasPermission('edit_' . $slug) && !isset($edit))
                        <a href="{{ url($baseRoute . $parentId . '/' . $modelSlug . '/' . (isset($item->id) ? $item->id : $item['id']) . '/edit') }}" title="Edit" class="btn btn-sm btn-primary pull-right edit">
                            <i class="voyager-edit"></i> <span class="hidden-xs hidden-sm">Edit</span>
                        </a>
                        @endif
                        @if (Auth::user()->hasPermission('view_' . $slug) && !isset($view))
                        <a href="{{ url($baseRoute . $parentId . '/' . $modelSlug . '/' . (isset($item->id) ? $item->id : $item['id'])) }}" title="View" class="btn btn-sm btn-warning pull-right view">
                            <i class="voyager-eye"></i> <span class="hidden-xs hidden-sm">View</span>
                        </a>
                        @endif
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="{{ count($columns) + 1 }}" class="text-center">No records found.</td>
                </tr>
                @endforelse
                </tbody>
            </table>
            </div>
        </div>
    </div>

    <div class="modal modal-danger fade" tabindex="-1" id="delete_modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="{{ __('voyager::generic.close') }}"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title"><i class="voyager-trash"></i>Are you sure you want to delete this?</h4>
                </div>
                <div class="modal-footer">
                    <form action="#" id="delete_form" method="POST">
                        {{ method_field('DELETE') }}
                        {{ csrf_field() }}
                        <input type="submit" class="btn btn-danger pull-right delete-confirm" value="{{ __('voyager::generic.delete_confirm') }}">
                    </form>
                    <button type="button" class="btn btn-default pull-right" data-dismiss="modal">{{ __('voyager::generic.cancel') }}</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>

@stop

@section('javascript')
<script>
    $(document).ready(function() {
        $('#dataTable').DataTable({
            columnDefs: [
                {
                    targets: 'dt-not-orderable', // Targets columns with this class
                    searchable: false, // Disable search
                    orderable: false   // Disable sorting
                }
            ]
        });


        var deleteFormAction;
        $('td').on('click', '.delete', function (e) {
            let itemId = $(this).data('id'); // Get the item ID from the button
            let deleteUrl = '{{ url("$baseRoute$parentId/$modelSlug") }}/' + itemId + '/delete'; // Construct the URL
            $('#delete_form').attr('action', deleteUrl); // Set the form action
            $('#delete_modal').modal('show'); // Show the modal
        });

    });
</script>
@endsection
