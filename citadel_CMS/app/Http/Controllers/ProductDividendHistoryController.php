<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Custom\CustomVoyagerBaseController;
use App\Models\ProductDividendHistory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class ProductDividendHistoryController extends CustomVoyagerBaseController
{
    public function generateBankFile(Request $request, $id)
    {
        try {
            $productDividendHistory = ProductDividendHistory::findOrFail($id);

            // Prepare a list to capture missing approvals
            $notApproved = [];

            // Check if the checker has approved
            if ($productDividendHistory->status_checker !== 'APPROVE_CHECKER') {
                $notApproved[] = 'Checker';
            }

            // Check if the approver has approved
            if ($productDividendHistory->status_approver !== 'APPROVE_APPROVER') {
                $notApproved[] = 'Approver';
            }

            // If any approval is missing, return with an error message listing them
            if (! empty($notApproved)) {
                $errorMessage = 'Dividend has not been approved by: ' . implode(', ', $notApproved);
                return redirect()->back()->with([
                    'message'    => $errorMessage,
                    'alert-type' => 'error',
                ]);
            }

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/dividend/generate-bank-file?id=' . $productDividendHistory->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);

            return redirect()->route('voyager.dividend-history.index')->with([
                'message'    => 'Dividend Bank File generation in process, check your email for the bank file shortly',
                'alert-type' => 'success',
            ]);
        } catch (\Exception $e) {
            // Handle exceptions and return to the browse view with an error message
            return redirect()->route('voyager.dividend-history.index')->with([
                'message'    => 'An error occurred: ' . $e->getMessage(),
                'alert-type' => 'error',
            ]);
        }
    }

    public function updateDividendPayment(Request $request, $id)
    {
        try {
            $productDividendHistory = ProductDividendHistory::findOrFail($id);

            // Check if the checker has approved
            if(is_null($productDividendHistory->bank_result_csv)){
                return redirect()->back()->with([
                    'message'    => 'Need to upload a CSV file',
                    'alert-type' => 'error',
                ]);
            }

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/dividend/update-dividend-payment?id=' . $productDividendHistory->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);

            return redirect()->route('voyager.dividend-history.index')->with([
                'message'    => 'Dividend Payment Update is in process, check your email for the results shortly',
                'alert-type' => 'success',
            ]);
        } catch (\Exception $e) {
            // Handle exceptions and return to the browse view with an error message
            return redirect()->route('voyager.dividend-history.index')->with([
                'message'    => 'An error occurred: ' . $e->getMessage(),
                'alert-type' => 'error',
            ]);
        }
    }
}
