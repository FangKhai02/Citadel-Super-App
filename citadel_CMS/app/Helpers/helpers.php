<?php
    if (!function_exists('getFlagEmoji')) {
        function getFlagEmoji($country)
        {
            $flags = [
                'Malaysia' => '🇲🇾',
                'United States' => '🇺🇸',
                'USA' => '🇺🇸',
                'United Kingdom' => '🇬🇧',
                'UK' => '🇬🇧',
                'Afghanistan' => '🇦🇫',
                'Indonesia' => '🇮🇩',
                'Canada' => '🇨🇦',
                'Australia' => '🇦🇺',
                'N/A' => '❓',
            ];
    
            return $flags[$country] ?? '🏳'; // Default to a white flag if not found
        }
    }
    
?>