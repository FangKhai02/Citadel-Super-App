@extends('voyager::master')

@section('page_title', __($pageTitle))

@section('page_header')
    <h1 class="page-title">
        <i class="{{ $icon }}"></i>
        {{ $pageTitle }}
        @if ($edit)
            <a href="{{ url($baseRoute . $parentId . '/' . $modelSlug . '/' . $data->id . '/edit') }}" class="btn btn-primary">
                <i class="voyager-edit"></i> Edit
            </a>
        @endif
        @if ($delete)
            <form action="{{ url($baseRoute . $parentId . '/' . $modelSlug . '/' . $data['id']) }}" 
                  method="POST" 
                  style="display:inline;">
                @csrf
                @method('DELETE')
                <button type="submit" class="btn btn-danger">
                    <i class="voyager-trash"></i> Delete
                </button>
            </form>
        @endif

        <a href="{{ $returnRoute }}" class="btn btn-warning">
            <i class="glyphicon glyphicon-list"></i> Return to List
        </a>
    </h1>
@stop

@section('content')
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-bordered" style="padding-bottom:5px;">
                @foreach ($columns as $key => $label)
                <div class="panel-heading" style="border-bottom:0;">
                    <h3 class="panel-title">{{ $label }}</h3>
                </div>
                <div class="panel-body" style="padding-top:0;">
                    @if ($key === 'guardian' )
                        @if (!empty($data->guardian) )
                            @if (!empty($data->client) )
                                <div class="list-group">
                                    <a href="{{ route('view.client.beneficiary.guardian', ['client_id' => $data->client->id, 'id' =>  $data->guardian->id]) }}" class="list-group-item">
                                        <h5 class="list-group-item-heading">{{ $guardian->full_name ?? 'N/A' }}</h5>
                                        <p class="list-group-item-text">
                                            <strong>Relationship to Guardian:</strong> {{ $pivot->relationship_to_beneficiary ?? 'N/A' }}
                                        </p>
                                    </a>
                                </div>
                            @else
                                <div class="list-group">
                                    <a href="{{ route('read.corporate.guardian', ['corporate_client_id' => $data->corporate->id, 'guardian_id' =>  $data->guardian->id]) }}" class="list-group-item">
                                        <h5 class="list-group-item-heading">{{ $data->guardian->full_name ?? 'N/A' }}</h5>
                                        <p class="list-group-item-text">
                                            <strong>Relationship to Guardian:</strong> {{ $data->beneficiary->relationship_to_guardian ?? 'N/A' }}
                                        </p>
                                    </a>
                                </div>
                            @endif
                        @else
                            <p>No guardians available for this beneficiary.</p>
                        @endif
                    @elseif ($key === 'document_id' && isset($dataType[$key]) && $dataType[$key] === 'list-link')
                    <div class="list-group">
                        @if (!empty($data->document_id) && is_array($data->document_id))
                        @foreach ($data->document_id as $item)
                        <div>
                            @if (isset($item['url']) && preg_match('/\.(jpg|jpeg|png)$/i', $item['url']))
                            <x-document-display :document="$item['url']" title="Front IC" />
                            @else
                            <a href="{{ isset($item['url']) ? asset($item['url']) : '#' }}" target="_blank" class="btn btn-primary">
                                View Document
                            </a>
                            @endif
                        </div>
                        @endforeach
                        @else
                        <p>No documents available.</p>
                        @endif
                    </div>
                    @elseif (isset($dataType[$key]) && $dataType[$key] === 'image')
                        <x-document-display :document="$data->$key" title="Image" />
                    @else
                        <p>{{ is_object($data) ? $data->$key : ($data[$key] ?? '-') }}</p>
                    @endif
                </div>
                <hr style="margin:0;">
                @endforeach
            </div>
        </div>
    </div>
</div>
@stop

@section('javascript')
    <script>
    </script>
@endsection
