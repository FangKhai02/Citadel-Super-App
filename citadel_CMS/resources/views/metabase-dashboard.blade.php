@extends('voyager::master')

@section('content')
    <body style="overflow: hidden">
    <iframe
        src="{{$iframeUrl}}"
        frameborder="0"
        width="100%"
        height="600"
        allowtransparency
        style="display: block;
            background: #FFF;
            border: none;
            height: 93vh;
            width: 95vw;"
    ></iframe>
    </body>
@endsection
