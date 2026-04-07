<div class="panel-body" style="padding-top:0;">
    @if($document)
        @if (in_array(pathinfo($document, PATHINFO_EXTENSION), ['pdf', 'docx', 'xlsx', 'html', 'txt', 'csv']))
        <a href="{{ !filter_var($document, FILTER_VALIDATE_URL) ? Util::getS3PDFDownloadUrl($document) : $document }}" target="_blank" class="btn btn-primary">
            Download Document
        </a>
        @else
            <img class="img-responsive"
                 src="{{ !filter_var($document, FILTER_VALIDATE_URL) ? ($document != '' ? Util::getS3PDFDownloadUrl($document) : $document) : $document }}"
                 alt="Document"
                 style="max-width:200px; height:auto; clear:both; display:block; padding:2px; border:1px solid #ddd; margin-bottom:10px; cursor: pointer;"
                 data-toggle="modal" data-target="#imagePreviewModal" data-image-url="{{ !filter_var($document, FILTER_VALIDATE_URL) ? Util::getS3PDFDownloadUrl($document) : $document }}">
        @endif
    @else
        <p>No document uploaded</p>
    @endif
</div>

<!-- Image Preview Modal -->
<div class="modal fade" id="imagePreviewModal" tabindex="-1" role="dialog" aria-labelledby="imagePreviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="position: absolute; left: 15px;">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" style="text-align: center;">
                <img id="modalImage" src="" class="img-fluid" alt="Image Preview" style="max-width: 100%; height: auto;">
            </div>
        </div>
    </div>
</div>


@section('javascript')
    <script>
        $('[data-toggle="modal"]').on('click', function () {
            var imageUrl = $(this).data('image-url');
            $('#modalImage').attr('src', imageUrl);
    });
    </script>
@stop
