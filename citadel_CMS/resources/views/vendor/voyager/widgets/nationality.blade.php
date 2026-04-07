    <div class="card" style="display: flex; flex-direction: column; padding: 50px; background: #F8FAFC; border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); color: #333; flex:0; min-width: 450px;">
        <div style="display: flex; align-items: center; margin-bottom: 15px;">
            <div class="icon">
                <i class="voyager-people"></i>
            </div>
            <h4 style="font-size: 20px; font-weight: 700; color: #333; margin-left: 15px;">Clients by Nationality</h4>
        </div>
        
        <ul style="list-style: none; padding: 0; margin: 0; font-size: 16px; color: #555; line-height: 1.8;">
            @foreach ($nationalities as $nationality)
                <li style="display: flex; align-items: center; gap: 8px; padding: 5px 0;">
                <span style="
    font-size: 30px;
    text-shadow: 0 0 10px rgba(0, 255, 255, 0.8), 
                 0 0 20px rgba(0, 255, 255, 0.6), 
                 0 0 30px rgba(0, 255, 255, 0.4);
">
    {{ getFlagEmoji($nationality->nationality) }}
</span>

                    <span><strong>{{ $nationality->nationality ?? "N/A" }}</strong>: {{ $nationality->user_count }}</span>
                </li>
            @endforeach
        </ul>

        <p style="font-size: 13px; color: #777; margin-top: 12px; display: flex; align-items: center;">
            <i class="voyager-refresh" style="margin-right: 6px;"></i> Live client count by nationality
        </p>
    </div>