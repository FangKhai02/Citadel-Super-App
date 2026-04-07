<div class="row-dashboard">
    <!-- Daily Card -->
    <div class="card">
        <div class="icon">
            <i class="voyager-calendar"></i>
        </div>
        <div class="card-content">
            <h4>{{ $title }} - Daily</h4>
            <h4 style="font-size: 20px; font-weight: 600; color: #333;"> {{$data['daily']}}</h4>
        </div>
    </div>

    <!-- Monthly Card -->
    <div class="card">
        <div class="icon" style="background: #e8f5e9; color: #4CAF50;">
            <i class="voyager-alarm-clock"></i>
        </div>
        <div class="card-content">
            <h4>{{ $title }} - Monthly</h4>
            <h4 style="font-size: 20px; font-weight: 600; color: #333;"> {{$data['monthly']}}</h4>
        </div>
    </div>

    <!-- Yearly Card -->
    <div class="card">
        <div class="icon" style="background: #ffebee; color: #F44336;">
            <i class="voyager-trophy"></i>
        </div>
        <div class="card-content">
            <h4>{{ $title }} - Yearly</h4>
            <h4 style="font-size: 20px; font-weight: 600; color: #333;"> {{$data['yearly']}}</h4>
        </div>
    </div>
</div>
