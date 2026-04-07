<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Delete Request Form</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Inter', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      background: #f5f7fa;
    }

    .form-container {
      background: #ffffff;
      padding: 2rem;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 400px;
      text-align: center;
    }

    .form-container img {
      width: 120px;
      margin-bottom: 1rem;
    }

    .form-container h2 {
      margin-bottom: 1.5rem;
      font-size: 1.5rem;
      color: #333333;
    }

    .form-group {
      margin-bottom: 1rem;
      text-align: left;
    }

    .form-group label {
      display: block;
      font-size: 0.875rem;
      color: #666666;
      margin-bottom: 0.5rem;
    }

    .form-group input, .form-group textarea {
      width: 100%;
      padding: 0.75rem;
      border: 1px solid #dcdcdc;
      border-radius: 5px;
      font-size: 0.875rem;
      color: #333333;
      outline: none;
      transition: border-color 0.3s ease;
    }

    .form-group input:focus, .form-group textarea:focus {
      border-color: #007BFF;
    }

    .submit-btn {
      width: 100%;
      padding: 0.75rem;
      background: #007BFF;
      color: #ffffff;
      border: none;
      border-radius: 5px;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .submit-btn:hover {
      background-color: #0056b3;
    }

    .footer {
      margin-top: 1.5rem;
      font-size: 0.75rem;
      color: #999999;
    }

    .alert {
        text-align: center;
        color: #ff0000;
        margin-bottom: 1rem;
        background-color: rgba(255, 0, 0, 0.1);
        padding: 8px;
        font-size: 14px;
    }
  </style>
</head>
<body>
  <div class="form-container">
    <img src="https://sgp1.digitaloceanspaces.com/nexstream-dev/citadel/users/December2024/K80W097Uy0avpWpV92fA.png" alt="Logo">
    <h2>Delete Request</h2>

    @if(session('duplicate'))
      <div class="alert" style="color: red;">{{ session('duplicate') }}</div>
    @endif
    @if(session('error'))
      <div class="alert">{{ session('error') }}</div>
    @endif
    @if(session('success'))
      <div class="alert" style="color: green;">{{ session('success') }}</div>
    @endif
    

    <form method="POST" action="{{ route('account-delete-request.submit') }}">
      @csrf
      <div class="form-group">
        <label for="email">Email Address</label>
        <input 
          type="email" 
          id="email" 
          name="email" 
          value="{{ old('email')}}" 
          placeholder="Enter your email" 
          required>
        @error('email')
          <small style="color: red;">{{ $message }}</small>
        @enderror
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input 
          type="password" 
          id="password" 
          name="password" 
          placeholder="Enter your password"
          required>
        @error('password')
          <small style="color: red;">{{ $message }}</small>
        @enderror
      </div>
      <div class="form-group">
        <label for="reason">Reason for Deletion</label>
        <textarea 
          id="reason" 
          name="reason" 
          rows="4" 
          placeholder="Enter your reason for requesting deletion" 
          required>{{ old('reason') }}</textarea>
        @error('reason')
          <small style="color: red;">{{ $message }}</small>
        @enderror
      </div>
        <button type="submit" class="submit-btn">Submit</button>
    </form>

    <div class="footer">
      <p>Please ensure your data is backed up before proceeding.</p>
    </div>
  </div>
</body>
</html>
