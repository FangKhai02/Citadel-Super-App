<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class DeleteRequestController extends Controller
{
    // Display the form
    public function showForm(Request $request)
    {
        return view('delete-request');
    }

    // Handle form submission
    public function handleRequest(Request $request)
    {

        // // API URL
        $apiUrl = 'https://api.citadel.nexstream.com.my/citadelBackend/api/app/user/delete/web';

        // Send the POST request to the API
        $response = Http::post($apiUrl, [
            'email' => $request->email,
            'password' => $request->password,
            'reason' => $request->reason,
        ]);

        // Check the response status
        if ($response->successful()) {
            $response_object = json_decode($response->getBody()->getContents());
            if ($response_object->code != '200') {
                return redirect()->back()->with('error', $response_object->message);
            }
            // Save email in a cookie
            return redirect()->back()
                ->with('success', json_decode($response->getBody())->message);
        } elseif ($response->clientError()) {
            return redirect()->back()->with('error', 'Invalid credentials or request.');
        } elseif ($response->serverError()) {
            return redirect()->back()->with('error', 'Server error. Please try again later.');
        } else {
            return redirect()->back()->with('error', 'Unexpected error occurred.');
        }
    }
}
