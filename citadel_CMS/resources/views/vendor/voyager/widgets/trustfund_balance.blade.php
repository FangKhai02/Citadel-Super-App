<div class="card" style="display: flex; flex-direction: column; padding: 50px; background: #F8FAFC; border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); color: #333;">
        <div style="display: flex; align-items: center; margin-bottom: 15px;">
            <div class="icon" style="background: rgba(76, 175, 80, 0.1); color: #4CAF50;">
                <i class="voyager-dollar"></i>
            </div>
            <h4 style="font-size: 20px; font-weight: 700; color: #333; margin-left: 15px;">Remaining Fund Size by Product</h4>
        </div>
        
        <ul style="list-style: none; padding: 0; margin: 0; font-size: 16px; color: #555; line-height: 1.8;">
            @foreach ($products as $product)
                @php
                    $percentage = ($product->tranche_size > 0) 
                        ? ($product->total_purchased / $product->tranche_size) * 100 
                        : 100;
                @endphp
                <li style="margin-bottom: 12px;">
                    <div style="display: flex; align-items: center;">
                        <!-- Circular Percentage -->
                        <div style="width: 42px; height: 42px; border-radius: 50%; background: radial-gradient(circle, rgba(76,175,80,0.2) 30%, rgba(255,255,255,1) 90%); display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: bold; color: #4CAF50; margin-right: 12px;">
                            {{ round($percentage) }}%
                        </div>
                        <div style="flex: 1;">
                            <strong style="color: #333;">{{ $product->code }}</strong>: 
                            RM{{ number_format($product->total_purchased, 2) }} / RM{{ number_format($product->tranche_size, 2) }}
                            <!-- Progress Bar -->
                            <div style="height: 8px; width: 100%; background: #E0E0E0; border-radius: 10px; margin-top: 5px; position: relative; overflow: hidden;">
                                <div style="height: 100%; width: {{ $percentage }}%; background: linear-gradient(90deg, #4CAF50 0%, #81C784 100%); border-radius: 10px; transition: width 0.4s ease-in-out;"></div>
                            </div>
                        </div>
                    </div>
                </li>
            @endforeach
        </ul>
    </div>