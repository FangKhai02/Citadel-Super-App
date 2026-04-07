<?php

namespace App\Http\Controllers\Voyager;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Http\Controllers\VoyagerController as BaseVoyagerController;
use Firebase\JWT\JWT;

class VoyagerController extends BaseVoyagerController
{
    public function index()
    {
        $user = Auth::user();
        $request = request(); // ✅ Get the request object here if needed

        // Get the Metabase site URL from the environment
        $METABASE_SITE_URL = config('app.METABASE_SITE_URL');
        $METABASE_SECRET_KEY = config('app.METABASE_SECRET_KEY');

        // Function to generate Metabase iframe URL
        $generateIframeUrl = function ($questionId) use ($METABASE_SECRET_KEY, $METABASE_SITE_URL) {
            $payload = [
                "resource" => ["dashboard" => $questionId],
                "params" => (object) []
            ];
            $token = JWT::encode($payload, $METABASE_SECRET_KEY, 'HS256');
            return $METABASE_SITE_URL . "/embed/dashboard/" . $token . "#bordered=true&titled=false";
        };

        // Determine which dashboard the user can view
        if ($user->hasPermission('view_dashboard_sales') && $user->hasPermission('view_dashboard_agent')) {
            // Both Sales & Agent permissions
            $iframeUrl1 = (in_array(config('app.env'), ['local', 'staging']))
                ? $generateIframeUrl(2)  // Local environment
                : $generateIframeUrl(3); // Production environment
        } elseif ($user->hasPermission('view_dashboard_sales')) {
            // Only Sales permission
            $iframeUrl1 = (in_array(config('app.env'), ['local', 'staging']))
                ? $generateIframeUrl(3)  // Local environment
                : $generateIframeUrl(4); // Production environment
        } elseif ($user->hasPermission('view_dashboard_agent')) {
            // Only Agent permission
            $iframeUrl1 = (in_array(config('app.env'), ['local', 'staging']))
                ? $generateIframeUrl(4)  // Local environment
                : $generateIframeUrl(5); // Production environment
        } else {
            // No permissions
            $iframeUrl1 = null;
        }

        return Voyager::view('voyager::index', compact('iframeUrl1'));
    }
}
