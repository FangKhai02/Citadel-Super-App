@extends('voyager::auth-templet')

@section('content')
    <p>Enter Your Email: </p>

    <form action="{{ route('password.email') }}" method="POST">
        {{ csrf_field() }}

        <div class="form-group form-group-default" id="emailGroup">
            <label>{{ __('voyager::generic.email') }}</label>
            <div class="controls">
                <input type="text" name="email" id="email" value="{{ old('email') }}"
                       placeholder="{{ __('voyager::generic.email') }}" class="form-control" required>
            </div>
        </div>

        <button type="submit" class="btn btn-danger login-button">
            <span class="signingin hidden"><span class="voyager-refresh"></span> Sending Email...</span>
            <span class="signin"> Send Email </span>
        </button>

        <a href="{{route('voyager.dashboard')}}"
           class="text-decoration-none btn btn-block login-button btn-block pull-right">
            BACK
        </a>
    </form>


    <div style="clear:both"></div>

    @if (session('status'))
        <div class="alert alert-success" role="alert">
            {{ session('status') }}
            <div id="countdown"></div>
        </div>

        <script>
            var timeLeft = 10;
            var elem = document.getElementById('countdown');
            var timerId = setInterval(countdown, 1000);
            function countdown() {
                if (timeLeft == -1) {
                    clearTimeout(timerId);
                    window.location.href = "{{route('voyager.dashboard')}}";
                } else {
                    elem.innerHTML = 'Will redirect to login page in ' + timeLeft + ' seconds.';
                    timeLeft--;
                }
            }
        </script>
    @endif
    @if(Session::has('userNotExist'))
        <p style="color: red">{{Session::get('userNotExist')}}</p>
    @endif
@stop

@section('post_js')
    <script>
        var btn = document.querySelector('button[type="submit"]');
        btn.addEventListener('click', function(ev){
            // if (form.checkValidity()) {
            //     btn.querySelector('.signingin').className = 'signingin';
            //     btn.querySelector('.signin').className = 'signin hidden';
            // } else {
            //     ev.preventDefault();
            // }
        });

    </script>
@endsection
