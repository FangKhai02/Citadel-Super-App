@if(isset($dataTypeContent->{$row->field}) && is_array(json_decode($dataTypeContent->{$row->field}, true)))
    @foreach(json_decode($dataTypeContent->{$row->field}, true) as $file)
        <div data-field-name="{{ $row->field }}">
            @if(is_string($file))
                <a class="fileType" target="_blank"
                   href="{{ Storage::disk(config('voyager.storage.disk'))->url($file) }}"
                   data-file-name="{{ basename($file) }}" data-id="{{ $dataTypeContent->getKey() }}">
                    {{ basename($file) }}
                </a>
                <a href="#" class="voyager-x remove-multi-file"></a>
            @elseif(is_array($file) && isset($file['download_link']))
                <a class="fileType" target="_blank"
                   href="{{ Storage::disk(config('voyager.storage.disk'))->url($file['download_link']) }}"
                   data-file-name="{{ $file['original_name'] ?? basename($file['download_link']) }}" data-id="{{ $dataTypeContent->getKey() }}">
                    {{ $file['original_name'] ?? basename($file['download_link']) }}
                </a>
                <a href="#" class="voyager-x remove-multi-file"></a>
            @elseif(is_object($file) && isset($file->download_link))
                <a class="fileType" target="_blank"
                   href="{{ Storage::disk(config('voyager.storage.disk'))->url($file->download_link) }}"
                   data-file-name="{{ $file->original_name ?? basename($file->download_link) }}" data-id="{{ $dataTypeContent->getKey() }}">
                    {{ $file->original_name ?? basename($file->download_link) }}
                </a>
                <a href="#" class="voyager-x remove-multi-file"></a>
            @endif
        </div>
    @endforeach
@endif
<input type="file" name="{{ $row->field }}[]" multiple @if(isset($options->accept)) accept="{{ $options->accept }}" @endif class="form-control"/> 