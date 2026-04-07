@php
    $edit = !is_null($dataTypeContent->getKey());
    $add  = is_null($dataTypeContent->getKey());
@endphp

@extends('voyager::master')

@section('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
@stop

@section('page_title', __('voyager::generic.'.($edit ? 'edit' : 'add')).' '.$dataType->getTranslatedAttribute('display_name_singular'))

@section('page_header')
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i>
        {{ __('voyager::generic.'.($edit ? 'edit' : 'add')).' '.$dataType->getTranslatedAttribute('display_name_singular') }}
    </h1>
    @include('voyager::multilingual.language-selector')
@stop

@section('content')
    <div class="page-content edit-add container-fluid">
        <div class="row">
            <div class="col-md-12">

                <div class="panel panel-bordered">
                    <!-- form start -->
                    <form role="form"
                            class="form-edit-add"
                            action="{{ $edit ? route('voyager.'.$dataType->slug.'.update', $dataTypeContent->getKey()) : route('voyager.'.$dataType->slug.'.store') }}"
                            method="POST" enctype="multipart/form-data"
                            id="myForm"
                            >
                        <!-- PUT Method if we are editing -->
                        @if($edit)
                            {{ method_field("PUT") }}
                        @endif

                        <!-- CSRF TOKEN -->
                        {{ csrf_field() }}

                        <div class="panel-body">

                            @if (count($errors) > 0)
                                <div class="alert alert-danger">
                                    <ul>
                                        @foreach ($errors->all() as $error)
                                            <li>{{ $error }}</li>
                                        @endforeach
                                    </ul>
                                </div>
                            @endif

                            <!-- Adding / Editing -->
                            @php
                                $dataTypeRows = $dataType->{($edit ? 'editRows' : 'addRows' )};
                            @endphp

                            @foreach($dataTypeRows as $row)
                                <!-- GET THE DISPLAY OPTIONS -->
                                @php
                                    $display_options = $row->details->display ?? NULL;
                                    if ($dataTypeContent->{$row->field.'_'.($edit ? 'edit' : 'add')}) {
                                        $dataTypeContent->{$row->field} = $dataTypeContent->{$row->field.'_'.($edit ? 'edit' : 'add')};
                                    }
                                @endphp
                                @if (isset($row->details->legend) && isset($row->details->legend->text))
                                    <legend class="text-{{ $row->details->legend->align ?? 'center' }}" style="background-color: {{ $row->details->legend->bgcolor ?? '#f0f0f0' }};padding: 5px;">{{ $row->details->legend->text }}</legend>
                                @endif

                                <div class="form-group @if($row->type == 'hidden') hidden @endif col-md-{{ $display_options->width ?? 12 }} {{ $errors->has($row->field) ? 'has-error' : '' }}" @if(isset($display_options->id)){{ "id=$display_options->id" }}@endif>
                                    {{ $row->slugify }}
                                    <label class="control-label" for="name">{{ $row->getTranslatedAttribute('display_name') }}</label>
                                    @include('voyager::multilingual.input-hidden-bread-edit-add')
                                    @if ($add && isset($row->details->view_add))
                                        @include($row->details->view_add, ['row' => $row, 'dataType' => $dataType, 'dataTypeContent' => $dataTypeContent, 'content' => $dataTypeContent->{$row->field}, 'view' => 'add', 'options' => $row->details])
                                    @elseif ($edit && isset($row->details->view_edit))
                                        @include($row->details->view_edit, ['row' => $row, 'dataType' => $dataType, 'dataTypeContent' => $dataTypeContent, 'content' => $dataTypeContent->{$row->field}, 'view' => 'edit', 'options' => $row->details])
                                    @elseif (isset($row->details->view))
                                        @include($row->details->view, ['row' => $row, 'dataType' => $dataType, 'dataTypeContent' => $dataTypeContent, 'content' => $dataTypeContent->{$row->field}, 'action' => ($edit ? 'edit' : 'add'), 'view' => ($edit ? 'edit' : 'add'), 'options' => $row->details])
                                    @elseif ($row->type == 'relationship')
                                        @include('voyager::formfields.relationship', ['options' => $row->details])
                                    @else
                                        {!! app('voyager')->formField($row, $dataType, $dataTypeContent) !!}
                                    @endif

                                    @foreach (app('voyager')->afterFormFields($row, $dataType, $dataTypeContent) as $after)
                                        {!! $after->handle($row, $dataType, $dataTypeContent) !!}
                                    @endforeach
                                    @if ($errors->has($row->field))
                                        @foreach ($errors->get($row->field) as $error)
                                            <span class="help-block">{{ $error }}</span>
                                        @endforeach
                                    @endif
                                </div>
                            @endforeach

                        </div><!-- panel-body -->

                        <input type="hidden" id="override_document_editor" name="override_document_editor" value="0">
                        <input type="hidden" id="override_upload_document" name="override_upload_document" value="0">
                        <div class="panel-footer">
                            @section('submit-buttons')
                                <button type="button" id="previewButton" class="btn btn-info" style="margin-right: 10px;">
                                    <i class="voyager-eye"></i> Preview Agreement
                                </button>
                                <button type="submit" id="formSubmit" class="btn btn-primary save">{{ __('voyager::generic.save') }}</button>
                            @stop
                            @yield('submit-buttons')
                        </div>
                    </form>

                    <div style="display:none">
                        <input type="hidden" id="upload_url" value="{{ route('voyager.upload') }}">
                        <input type="hidden" id="upload_type_slug" value="{{ $dataType->slug }}">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade modal-danger" id="confirm_delete_modal">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="voyager-warning"></i> {{ __('voyager::generic.are_you_sure') }}</h4>
                </div>

                <div class="modal-body">
                    <h4>{{ __('voyager::generic.are_you_sure_delete') }} '<span class="confirm_delete_name"></span>'</h4>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">{{ __('voyager::generic.cancel') }}</button>
                    <button type="button" class="btn btn-danger" id="confirm_delete">{{ __('voyager::generic.delete_confirm') }}</button>
                </div>
            </div>
        </div>
    </div>
    <!-- End Delete File Modal -->


    <!-- Modal for confirming file override upon form submission -->
    <div class="modal fade" id="fileOverrideModal" tabindex="-1" role="dialog" aria-labelledby="fileOverrideModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="fileOverrideModalLabel">Confirm File Override</h4>
                </div>
                <div class="modal-body">
                    You have uploaded a new file. Do you want to override the Document Editor with the new file? Any changes made in the editor will be discarded if you choose to override.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" onclick="handleConfirmOverride(false)">No, Keep Changes</button>
                    <button type="button" class="btn btn-primary" onclick="handleConfirmOverride(true)">Yes, Override</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Preview Modal -->
    <div class="modal fade" id="previewModal" tabindex="-1" role="dialog" aria-labelledby="previewModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="previewModalLabel">Document Preview</h4>
                </div>
                <div class="modal-body">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe id="previewFrame" class="embed-responsive-item" src=""></iframe>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
<!-- Modal for confirming file override 2 upon form submission -->
<div class="modal fade" id="fileOverrideModal2" tabindex="-1" role="dialog" aria-labelledby="fileOverrideModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button
                    type="button"
                    class="close"
                    data-dismiss="modal"
                    aria-label="Close"
                >
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="fileOverrideModalLabel2">Confirm File Override</h4>
            </div>
            <div class="modal-body">
                You have modified the Document Editor with the new file. Any changes made in the Upload Document will be discarded if you choose to override.
                <br><br>
                <strong class="text-danger">Warning:</strong> Do not edit or remove placeholder variables like <code>${...}</code>. These are required for the document to work properly.

                <hr>
            </div>
            <div class="modal-footer">
                <button
                    type="button"
                    class="btn btn-primary"
                    onclick="handleConfirmOverride2(true)"
                >
                    Override
                </button>
                <button
                    type="button"
                    class="btn btn-default"
                    data-dismiss="modal"
                >
                    Close
                </button>
            </div>
        </div>
    </div>
</div>
@stop

@section('javascript')
<script>
    $(document).ready(function () {
    @if($edit)
        let fileUploaded = false;
        let originalEditorContent = '';

        function handleFileUpload() {
            fileUploaded = true;
        }


        // Initialize TinyMCE content tracking
        const initEditor = () => {
            const editor = tinymce.get('richtextdocument_editor');
            if (editor) {
                originalEditorContent = editor.getContent({ format: 'html' }).trim();
                editor.on('init', function () {
                    originalEditorContent = this.getContent({ format: 'html' }).trim();
                });
            }
        };
        function hasEditorChanged() {
            const editor = tinymce.get('richtextdocument_editor');
            if (!editor) return false;

            const currentContent = editor.getContent({ format: 'html' }).trim();
            const oriContent = document.getElementById("richtextdocument_editor").value;

            // 🔍 Extract only the <body> content from original HTML
            const bodyContent = (() => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(oriContent, 'text/html');
                return doc.body.innerHTML.trim();
            })();

            const currentBodyContent = (() => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(currentContent, 'text/html');
                return doc.body.innerHTML.trim();
            })();

            // 🧩 Check if placeholders have been changed
            const originalPlaceholders = extractPlaceholders(bodyContent);
            const currentPlaceholders = extractPlaceholders(currentContent);
            const placeholdersChanged =
                JSON.stringify([...originalPlaceholders].sort()) !==
                JSON.stringify([...currentPlaceholders].sort());

            if (placeholdersChanged) {
                toastr.error('You cannot change the variables in ${...} syntax');
                return 'invalid';
            }

            if (bodyContent === currentBodyContent) {
                console.log("✅ No changes in body content.");
                return false;
            }
            
            // 🔍 Show simple change log
            console.group('📝 Editor content changed');
            console.log('%cOriginal Body Content:', 'color: gray; font-weight: bold;');
            console.log(bodyContent);
            console.log('%cCurrent Body Content:', 'color: green; font-weight: bold;');
            console.log(currentBodyContent);
            console.groupEnd();

            toastr.info('Content changed.');
            return true;
        }

        function extractPlaceholders(content) {
            const regex = /\$\{[^}]+\}/g;
            return content.match(regex) || [];
        }

        function handleSubmit(event) {
            event.preventDefault();
            const editorChangeResult = hasEditorChanged();

            if (fileUploaded) {
                $('#fileOverrideModal').modal('show');
            } else if (editorChangeResult === 'invalid' ) {
                toastr.error('Submission blocked: You have modified the required variables in ${...}');
            }else if (editorChangeResult) {
                $('#fileOverrideModal2').modal('show');
            } else {
                submitForm();
            }
        }


        window.handleConfirmOverride = function (overrideEditor) {
            $('#override_document_editor').val(overrideEditor ? 1 : 0);
            submitForm();
        }

        window.handleConfirmOverride2 = function (overrideFileUpload) {
            $('#override_upload_document').val(overrideFileUpload ? 1 : 0);
            submitForm();
        }

        function submitForm() {
            document.getElementById("myForm").submit();
        }

        function handlePreview() {
            const editor = tinymce.get('richtextdocument_editor');
            if (!editor) {
                toastr.error('Document editor not found. Please refresh the page.');
                return;
            }

            const newContent = editor.getContent();
            const oriContent = document.getElementById('richtextdocument_editor').value;
            const fullHtml = replaceHtmlBody(oriContent, newContent);

            if (!fullHtml) {
                toastr.warning('No content to preview');
                return;
            }

            $('#previewModal .modal-body').html('<div class="text-center"><i class="fas fa-spinner fa-spin"></i> Generating preview...</div>');
            $('#previewModal').modal('show');

            const backendUrl = '{{ config('app.citadel_backend') }}api/backend/cms/pdfTemplate';
            const formData = new FormData();
            formData.append('id', '{{ $dataTypeContent->getKey() }}');
            formData.append('content', fullHtml);

            fetch(backendUrl, {
                method: 'POST',
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    if (data.link) {
                        $('#previewModal .modal-body').html(`
                    <div class="text-center">
                        <a href="${data.link}" class="btn btn-primary btn-lg" target="_blank" download>
                            <i class="fas fa-download"></i> Download PDF Preview
                        </a>
                        <div class="mt-3">
                            <small class="text-muted">The preview will open in a new tab</small>
                        </div>
                    </div>
                `);
                    } else {
                        toastr.error('Failed to generate PDF preview');
                        $('#previewModal').modal('hide');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    toastr.error('Error generating PDF preview');
                    $('#previewModal').modal('hide');
                });
        }

        function replaceHtmlBody(originalHtml, newBodyContent) {
            const parser = new DOMParser();
            const originalDoc = parser.parseFromString(originalHtml, 'text/html');
            const newBodyDoc = parser.parseFromString(`<body>${newBodyContent}</body>`, 'text/html');

            const originalBody = originalDoc.body;
            originalBody.innerHTML = '';

            Array.from(newBodyDoc.body.childNodes).forEach(node => {
                originalBody.appendChild(originalDoc.importNode(node, true));
            });

            return '<!DOCTYPE html>\n' + formatHtml(originalDoc.documentElement.outerHTML);
        }

        function formatHtml(html) {
            return html
                // Step 1: Unescape Freemarker template tags
                .replace(/&lt;#(.*?)&gt;/g, '<#$1>')
                .replace(/&lt;\/#(.*?)&gt;/g, '</#$1>')
                .replace(/&lt;!--#(.*?)--&gt;/g, '</#$1>')
                .replace(/<!--#(.*?)-->/g, '</#$1>')

                // Step 2: Format HTML
                .replace(/(>)(<)(\/*)/g, '$1\n$2$3') // Add newline between tags
                .replace(/([^\n])<\/\s*([a-zA-Z0-9]+)>/g, '$1</$2>') // Clean up closing tags
                .replace(/\n+/g, '\n') // Collapse multiple newlines
                .replace(/src\s*=\s*"http\/\/[^"]*\/\${(.*?)}/g, 'src="${$1}"')
                .trim();
        }

        initEditor();
        $('#fileInput').on('change', handleFileUpload);
        $('#formSubmit').on('click', handleSubmit);
        $('#previewButton').on('click', handlePreview);
    @endif
    });

    // Media delete logic
    var params = {};
    var $file;

    function deleteHandler(tag, isMulti) {
        return function () {
            $file = $(this).siblings(tag);
            params = {
                slug: '{{ $dataType->slug }}',
                filename: $file.data('file-name'),
                id: $file.data('id'),
                field: $file.parent().data('field-name'),
                multi: isMulti,
                _token: '{{ csrf_token() }}'
            };
            $('.confirm_delete_name').text(params.filename);
            $('#confirm_delete_modal').modal('show');
        };
    }

    $('document').ready(function () {
        $('.toggleswitch').bootstrapToggle();

        $('.form-group input[type=date]').each(function (idx, elt) {
            if (elt.hasAttribute('data-datepicker')) {
                elt.type = 'text';
                $(elt).datetimepicker($(elt).data('datepicker'));
            } else if (elt.type != 'date') {
                elt.type = 'text';
                $(elt).datetimepicker({
                    format: 'L',
                    extraFormats: ['YYYY-MM-DD']
                }).datetimepicker($(elt).data('datepicker'));
            }
        });

    @if ($isModelTranslatable)
            $('.side-body').multilingual({ editing: true });
    @endif

        $('.side-body input[data-slug-origin]').each(function (i, el) {
            $(el).slugify();
        });

        $('.form-group').on('click', '.remove-multi-image', deleteHandler('img', true));
        $('.form-group').on('click', '.remove-single-image', deleteHandler('img', false));
        $('.form-group').on('click', '.remove-multi-file', deleteHandler('a', true));
        $('.form-group').on('click', '.remove-single-file', deleteHandler('a', false));

        $('#confirm_delete').on('click', function () {
            $.post('{{ route('voyager.'.$dataType->slug.'.media.remove') }}', params, function (response) {
                if (response?.data?.status === 200) {
                    toastr.success(response.data.message);
                    $file.parent().fadeOut(300, function () {
                        $(this).remove();
                    });
                } else {
                    toastr.error("Error removing file.");
                }
            });
            $('#confirm_delete_modal').modal('hide');
        });

        $('[data-toggle="tooltip"]').tooltip();
    });
</script>
@stop
