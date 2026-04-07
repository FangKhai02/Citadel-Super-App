@extends('voyager::master')

@section('page_title', __('Dashboard'))
@section('page_header')
    <div class="dashboard-title">
        <span class="page-title" style="font-size: 24px; margin-right: 20px;">Overview</span>
    </div>

    <style>
    .card-title {
        font-size: 20px;
        font-weight: 600;
        margin-bottom: 10px;
        color: #333;
    }
    .row-dashboard {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 20px;
    }
    .card {
            /* width: 300px; Set a fixed width */
            flex: 1;
            max-width: 100%; /* Ensures responsiveness */
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            min-width: 220px;
            text-align: left;
            display: flex;
            align-items: center;
            gap: 15px;
    }
    .card .icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        background: #e3f2fd;
        font-size: 24px;
        color: #2196F3;
        width: 60px;
        height: 60px;
        font-size: 28px;
        margin-right: 15px;
    }
    .card-content {
            display: flex;
            flex-direction: column;
    }
    .card h4 {
        margin-bottom: 5px;
        color: #333;
        font-size: 18px;
    }
    .card p {
        margin: 3px 0;
        color: #555;
        font-size: 14px;
    }
        
    </style>
@stop

@section('content')
    <div class="page-content browse container-fluid">
        <div class="row-dashboard">
                    <iframe
                    src="{{$iframeUrl1}}"
                    frameborder="0"
                    width="2000"
                    height="1000"
                    allowtransparency
                    style="display: block;
                        background: transparent;
                        border: none;"
                    >
                    </iframe>
        </div>
    </div>
@endsection
