@extends('voyager::master')

@section('page_title', 'Edit Corporate Details')

@section('page_header')
<h1 class="page-title">
    <i class="voyager-person"></i>
    Edit Director Details for {{ $corporate->corporateDetail->entity_name }}
    <a href="{{ route('voyager.corporate-client.index') }}" class="btn btn-warning">
        <i class="glyphicon glyphicon-list"></i> <span class="hidden-xs hidden-sm">Return to List</span>
    </a>
</h1>
@stop

@section('content')
<div class="page-content container-fluid">
    <form id="updateCorporateClientDetails" action="{{ route('update.corporate.user.details', $corporate->id) }}" method="POST" enctype="multipart/form-data">
        @csrf
        @method('PUT')

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered" style="padding-bottom:5px;">
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Existing Account Holder</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <input
                            type="text"
                            name="existing_acc"
                            class="form-control @error('existing_acc') is-invalid @enderror"
                            value="{{ old('existing_acc', $client->client_id) }}"
                            readonly
                            required
                        >
                        @error('existing_acc')
                        <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                        @enderror
                    </div>
                    <hr style="margin:0;">

                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">New Account Holder</h3>
                    </div>
                    <div class="panel-body">
                        <div class="input-group" style="width: 100%;">
                            <input type="text" name="new_acc" id="searchInput"
                                   class="form-control @error('new_acc') is-invalid @enderror"
                                   placeholder="Search Client ID" autocomplete="off" required>
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                            </div>
                        </div>
                        <ul id="searchResults" class="list-group" style="position: relative; z-index: 1; width: 100%; max-height: 200px; overflow-y: auto; display: none;">
                            @foreach(App\Models\Client::whereNotIn('id', App\Models\CorporateClient::pluck('client_id'))->get() as $availableClient)
                            <li class="list-group-item" data-value="{{ $availableClient->client_id }}">{{ $availableClient->client_id }}</li>
                            @endforeach
                        </ul>
                    </div>
                    <hr style="margin:0;">
                    <!-- Remarks Field -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Remarks</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <textarea
                            name="remarks"
                            class="form-control @error('remarks') is-invalid @enderror"
                            rows="5"
                            placeholder="Enter remarks here"
                            required>{{ old('remarks') }}</textarea>
                        @error('remarks')
                        <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                        @enderror
                    </div>
                    <hr style="margin:0;">

                    <!-- Supporting Documents Field -->
                    <div class="panel-heading" style="border-bottom:0;">
                        <h3 class="panel-title">Supporting Documents</h3>
                    </div>
                    <div class="panel-body" style="padding-top:0;">
                        <!-- Display existing corporate documents -->
                        @if ($corporateDocs->isNotEmpty())
                            @foreach ($corporateDocs as $file)
                                <div data-field-name="{{ $file->key }}">
                                    <!-- Remove link -->
                                    <a href="{{ route('remove.corporate.file', ['id' => $corporate->id, 'file' => $file->id]) }}"
                                       class="voyager-x remove-multi-file"
                                       style="margin-left: 10px;"
                                       onclick="return confirm('Are you sure you want to remove this file?');">
                                    </a>

                                    <x-document-display :document="$file->company_document_key" :title="'{{ $file->company_document_name }}'" />
                                    <!-- Document Display component -->
                                </div>
                            @endforeach
                        @endif

                        <input
                            type="file"
                            name="supporting_documents[]"
                            class="form-control @error('supporting_documents') is-invalid @enderror"
                            multiple
                            accept=".pdf,.doc,.docx,.jpg,.png,.jpeg"
                            required
                        >

                        <small class="form-text text-muted">
                            You can upload multiple files. Supported formats: PDF, DOC, DOCX, JPG, PNG.
                        </small>
                        @error('supporting_documents')
                        <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                        @enderror
                    </div>

                    <hr style="margin:0;">
                </div>
            </div>
        </div>

        <!-- Submit Button -->
        <div class="row">
            <div class="col-md-12">
                <button type="submit" class="btn btn-primary" aria-label="Save changes to corporate details">
                    <i class="glyphicon glyphicon-save"></i> Save Changes
                </button>
            </div>
        </div>
    </form>

    <script>
        const searchInput = document.getElementById('searchInput');
        const searchResults = document.getElementById('searchResults');

        // Show the dropdown when the input field is focused
        searchInput.addEventListener('focus', () => {
            searchResults.style.display = 'block';
        });

        // Hide the dropdown when the input field loses focus, but only if no item is selected
        searchInput.addEventListener('blur', () => {
            setTimeout(() => {
                searchResults.style.display = 'none';
            }, 200); // Slight delay to allow click event
        });

        // Filter the list based on input value
        searchInput.addEventListener('input', () => {
            const searchTerm = searchInput.value.toLowerCase();
            const listItems = searchResults.querySelectorAll('li');

            let hasResults = false;
            listItems.forEach(item => {
                const itemValue = item.getAttribute('data-value').toLowerCase();
                if (searchTerm && !itemValue.startsWith(searchTerm)) {
                    item.style.display = 'none';
                } else {
                    item.style.display = 'block';
                    hasResults = true;
                }
            });

            if (!hasResults) {
                searchResults.style.display = 'none';
            }
        });

        // Handle selection from the search results list
        searchResults.addEventListener('click', (event) => {
            if (event.target.tagName === 'LI') {
                const selectedValue = event.target.getAttribute('data-value');
                searchInput.value = selectedValue;
                searchResults.style.display = 'none';
            }
        });

        // Close the dropdown if clicked outside
        document.addEventListener('click', (event) => {
            if (!event.target.closest('.input-group')) {
                searchResults.style.display = 'none';
            }
        });
    </script>
</div>
@stop
