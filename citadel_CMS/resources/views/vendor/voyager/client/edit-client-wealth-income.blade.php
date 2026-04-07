@extends('voyager::master')

@section('page_title', 'Edit Client Wealth & Income')

@section('page_header')
    <h1 class="page-title">
        <i class="voyager-info-circled"></i>
        Edit Client Wealth & Income for {{ $userDetails->name }}
    </h1>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <div class="panel-body">
                        <form action="{{ route('update.client.individual.wealth.income', $client->id) }}" method="POST" enctype="multipart/form-data">
                            @csrf
                            @method('PUT') <!-- Use PUT for editing -->
                            <div class="form-group">
                                <label for="annual_income_declaration">Annual Income Declaration (RM)</label>
                                <select name="annual_income_declaration" class="form-control" id="annual_income_declaration" required>
                                    <option value="" disabled >Select Annual Income</option>
                                    <option value="Below RM50,000" {{ old('annual_income_declaration', $clientIndividualWealthIncome->annual_income_declaration) === 'Below RM50,000' ? 'selected' : '' }}>Below RM 50,000</option>
                                    <option value="RM50,000 - RM100,000" {{ old('annual_income_declaration', $clientIndividualWealthIncome->annual_income_declaration) === 'RM50,000 - RM100,000' ? 'selected' : '' }}>RM 50,000 - RM 100,000</option>
                                    <option value="RM100,001 - RM150,000" {{ old('annual_income_declaration', $clientIndividualWealthIncome->annual_income_declaration) === 'RM100,001 - RM150,000' ? 'selected' : '' }}>RM 100,001 - RM 150,000</option>
                                    <option value="RM150,000 - RM200,000" {{ old('annual_income_declaration', $clientIndividualWealthIncome->annual_income_declaration) === 'RM150,000 - RM200,000' ? 'selected' : '' }}>RM 150,000 - RM 200,000</option>
                                    <option value="RM200,001 - RM300,000" {{ old('annual_income_declaration', $clientIndividualWealthIncome->annual_income_declaration) === 'RM200,001 - RM300,000' ? 'selected' : '' }}>RM 200,001 - RM 300,000</option>
                                    <option value="More than RM300,000" {{ old('annual_income_declaration', $clientIndividualWealthIncome->annual_income_declaration) === 'More than RM300,000' ? 'selected' : '' }}>More than RM 300,000</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="source_of_income">Source of Income</label>
                                <select name="source_of_income" class="form-control" id="source_of_income" required>
                                    <option value="" disabled >Select Source of Income</option>
                                    <option value="Savings/Deposits" {{ old('source_of_income', $clientIndividualWealthIncome->source_of_income) === 'Savings/Deposits' ? 'selected' : '' }}>Savings/Deposits</option>
                                    <option value="Inheritance" {{ old('source_of_income', $clientIndividualWealthIncome->source_of_income) === 'Inheritance' ? 'selected' : '' }}>Inheritance</option>
                                    <option value="Employment/Business Income" {{ old('source_of_income', $clientIndividualWealthIncome->source_of_income) === 'Employment/Business Income' ? 'selected' : '' }}>Employment/Business Income</option>
                                    <option value="Other Sources of Income" {{ old('source_of_income', $clientIndividualWealthIncome->source_of_income) === 'Other Sources of Income' ? 'selected' : '' }}>Other Sources of Income</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="source_of_income_remark">Source of Income Remark</label>
                                <textarea name="source_of_income_remark" class="form-control" id="source_of_income_remark" rows="3">{{ old('source_of_income_remark', $clientIndividualWealthIncome->source_of_income_remark) }}</textarea>
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop

@push('javascript')
    <script>
        $(document).ready(function () {
            $('.toggleswitch').bootstrapToggle(); // Initialize the toggle
        });
    </script>
@endpush
