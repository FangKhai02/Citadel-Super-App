@extends('voyager::master')

@section('page_title', 'Browse Agent Downline')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-person"></i>
        Agent Downline Management
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        @include('voyager::alerts')
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <div class="panel-body">
                        @if ($isServerSide)
                            <form method="get" class="form-search">
                                <div id="search-input" class="row align-items-center">
                                    <div class="col-md-3 mb-2">
                                        <label for="search_key" class="form-label">Search By:</label>
                                        <select id="search_key" name="key" class="form-control">
                                            @foreach ($searchNames as $key => $name)
                                                <option value="{{ $key }}"
                                                    @if ($search->key == $key || (empty($search->key) && $key == $defaultSearchKey)) selected @endif>{{ $name }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <label for="filter" class="form-label">Filter:</label>
                                        <select id="filter" name="filter" class="form-control">
                                            <option value="contains" @if ($search->filter == 'contains') selected @endif>
                                                {{ __('voyager::generic.contains') }}</option>
                                            <option value="equals" @if ($search->filter == 'equals') selected @endif>=
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <label for="search_value" class="form-label">Search Value:</label>
                                        <div class="input-group">
                                            <input type="text" id="search_vlaue" class="form-control"
                                                placeholder="{{ __('voyager::generic.search') }}" name="s"
                                                value="{{ $search->value }}">
                                            <span class="input-group-append">
                                                <button class="btn btn-info" type="submit">
                                                    <i class="voyager-search"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                @if (Request::has('sort_order') && Request::has('order_by'))
                                    <input type="hidden" name="sort_order" value="{{ Request::get('sort_order') }}">
                                    <input type="hidden" name="order_by" value="{{ Request::get('order_by') }}">
                                @endif
                            </form>
                        @endif
                        <div class="table-responsive" style="min-height: 500px;">
                            <table id="dataTable" class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Agent Name</th>
                                        <th>Role</th>
                                        <th>P2P</th>
                                        <th>RMgr</th>
                                        <th>SM</th>
                                        <th>AVP</th>
                                        <th>VP</th>
                                        <th>SVP</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($hierarchies as $hierarchy)
                                        <tr>
                                            <td>{{ $hierarchy['agent'] }}</td>
                                            <td>{{ $hierarchy['role'] }}</td>
                                            <td>{{ $hierarchy['manager'] }}</td>
                                            <td>{{ $hierarchy['recruit_manager'] }}</td>
                                            <td>{{ $hierarchy['sm'] }}</td>
                                            <td>{{ $hierarchy['avp'] }}</td>
                                            <td>{{ $hierarchy['vp'] }}</td>
                                            <td>{{ $hierarchy['svp'] }}</td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        @if ($isServerSide)
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <div role="status" class="show-res" aria-live="polite">
                                        {{ trans_choice('voyager::generic.showing_entries', $agents->total(), [
                                            'from' => $agents->firstItem(),
                                            'to' => $agents->lastItem(),
                                            'all' => $agents->total(),
                                        ]) }}
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <nav aria-label="Page navigation" class="float-right">
                                        {{ $agents->appends([
                                                's' => $search->value,
                                                'filter' => $search->filter,
                                                'key' => $search->key,
                                                'order_by' => $orderBy,
                                                'sort_order' => $sortOrder,
                                            ])->links('pagination::bootstrap-4') }}
                                    </nav>
                                </div>
                            </div>
                        @endif

                    </div>
                </div>
            </div>
        </div>
    </div>
@stop
