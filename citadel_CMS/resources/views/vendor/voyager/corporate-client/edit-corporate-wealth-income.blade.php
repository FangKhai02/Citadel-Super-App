@extends('voyager::master')

@section('page_title', 'Edit Corporate Wealth & Income')

@section('page_header')
<h1 class="page-title">
    <i class="voyager-info-circled"></i>
    Edit Corporate Wealth & Income for {{ $corporate->corporateDetail->entity_name }}
    <a href="{{ route('voyager.corporate-client.index') }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
    </a>
</h1>
@stop

@section('content')
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-bordered">
                <div class="panel-body">
                    <form action="{{ route('update.corporate.wealth.income', ['corporate_client_id' => $corporate->id]) }}" method="POST">
                        @csrf
                        @method('PUT')

                        <div class="form-group">
                            <label for="annual_income_declaration">Annual Income Declaration</label>
                            <textarea name="annual_income_declaration" class="form-control" id="annual_income_declaration" rows="4">{{ old('annual_income_declaration', $corporate->annual_income_declaration) }}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="source_of_income">Source of Income</label>
                            <textarea name="source_of_income" class="form-control" id="source_of_income" rows="4">{{ old('source_of_income', $corporate->source_of_income) }}</textarea>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="glyphicon glyphicon-save"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div><!-- panel -->
        </div>
    </div>
</div>
@stop
