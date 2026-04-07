@extends('voyager::auth-templet')

@section('content')
    <p>Reset Password: </p>

    <form action="{{ route('password.reset.submit') }}" method="POST">
        @csrf
        <input type="hidden" name="token" value="{{ $token }}">

        <div class="form-group form-group-default" id="emailGroup">
            <label for="email">{{ __('E-Mail Address') }}</label>
            <div class="controls">
                <input id="email" type="email" class="form-control"
                       name="email" value="{{ $email ?? old('email') }}"
                       required readonly="{{isset($email)}}">
            </div>
        </div>

        <div class="form-group form-group-default" id="passwordGroup">
            <label for="password">{{ __('Password') }}</label>
            <div class="controls">
                <input id="password" type="password"
                       class="form-control"
                       name="password" required>
            </div>
        </div>

        <div class="form-group form-group-default" id="confirmPasswordGroup">
            <label for="password-confirm">{{ __('Confirm Password') }}</label>
            <div class="controls">
                <input id="password-confirm" type="password" class="form-control"
                       name="password_confirmation" required>
            </div>
        </div>

        <button type="submit" class="btn btn-block login-button">
            <span class="signingin hidden"><span class="voyager-refresh"></span> {{ __('Resetting') }}...</span>
            <span class="signin">{{ __('Reset Password') }}</span>
        </button>
    </form>

    <div style="clear:both"></div>
@stop
