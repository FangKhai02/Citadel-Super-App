<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use App\Models\ProductRolloverHistory;
use App\Http\Controllers\Custom\CustomVoyagerBaseController;

class ProductRolloverHistoryController extends CustomVoyagerBaseController
{
    //--------------------Checker Start--------------------
    public function showRolloverChecker(Request $request)
    {
        $rollover = ProductRolloverHistory::whereIn('status_checker', ['REJECT_CHECKER', 'PENDING_CHECKER'])->get();

        $columns = [
            'client_name'         => 'Client Name',
            'agreement_file_name' => 'Fund Agreement',
            'fund_status'         => 'Fund Status',
            'amount'              => 'Amount',
            'status_checker'      => 'Status Checker',
            'created_at'          => 'Created At',
        ];

        $data = $rollover->map(function ($rolloverChecker) {
            return [
                'id'                  => $rolloverChecker->id,
                'client_name'         => $rolloverChecker->productOrder->getClientNameAttribute(),
                'agreement_file_name' => $rolloverChecker->productOrder->agreement_file_name,
                'fund_status'         => $rolloverChecker->productOrder->status,
                'amount'              => $rolloverChecker->amount,
                'status_checker'      => str_replace('_', ' ', $rolloverChecker->status_checker),
                'created_at'          => $rolloverChecker->created_at->format('Y-m-d H:i:s')];
        });

        $pageTitle   = "Rollover - Checker";
        $icon        = 'voyager-check';
        $returnRoute = route('voyager.product-rollover-history.index');
        $modelSlug   = 'product-rollover-history-checker';
        $parentId    = null;
        $baseRoute   = 'admin';
        $view        = false;
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editRolloverChecker($id)
    {
        $rolloverDetails = ProductRolloverHistory::findOrFail($id);

        $columns = [
            'status_checker' => 'Checker Status',
            'remark_checker' => 'Remark Checker',
        ];

        // Define data types for form inputs
        $dataTypes = [
            'status_checker' => 'dropdown',
            'remark_checker' => 'text',
        ];

        // Dropdown options for status_checker
        $dropdownOptions = [
            'status_checker' => [
                //'PENDING_CHECKER' => 'Pending Checker',
                'APPROVE_CHECKER' => 'Approved Checker',
                'REJECT_CHECKER'  => 'Rejected Checker',
            ],
        ];

        // Prepare data for the form
        $data = $rolloverDetails->only(['id', 'status_checker', 'remark_checker']);

        // Page details
        $pageTitle      = "Edit Rollover Checker";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'product-rollover-history-checker';
        $view           = false;
        $returnRoute    = route('product_rollover_history_checker.show');
        $hideViewButton = true;

        return view('voyager::custom-bread.edit-add', compact(
            'pageTitle',
            'view',
            'columns',
            'dataTypes',
            'dropdownOptions',
            'data',
            'parentId',
            'baseRoute',
            'modelSlug',
            'returnRoute',
            'hideViewButton'
        ));
    }

    public function updateRolloverChecker(Request $request, $id)
    {
        $rollover = ProductRolloverHistory::findOrFail($id);

        $validated = $request->validate([
            'status_checker' => 'required|in:PENDING_CHECKER,APPROVE_CHECKER,REJECT_CHECKER',
            'remark_checker' => 'nullable|string|max:255',
        ]);

        $user = Auth::user();

        if ($validated['status_checker'] == 'APPROVE_CHECKER') {
            $rollover->checker_updated_at = now();
            if ($user && isset($user->email)) {
                $rollover->checked_by = $user->email;
            }
        } else {
            $rollover->checker_updated_at = now();
            $rollover->status             = 'REJECTED';
            if ($user && isset($user->email)) {
                $rollover->checked_by = $user->email;
            }
        }

        $rollover->status_checker = $validated['status_checker'];
        $rollover->remark_checker = $validated['remark_checker'];
        $rollover->save();

        return redirect()->route('product_rollover_history_checker.show')->with([
            'message'    => 'Rollover Checker updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectEditRolloverChecker($id)
    {
        return redirect()->route('product_rollover_history_checker.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }
    //--------------------Checker End--------------------

    public function showRolloverApproval(Request $request)
    {
        $rollover = ProductRolloverHistory::whereIn('status_approver', ['REJECT_APPROVER', 'PENDING_APPROVER'])->get();

        $columns = [
            'client_name'         => 'Client Name',
            'agreement_file_name' => 'Fund Agreement',
            'fund_status'         => 'Fund Status',
            'amount'              => 'Amount',
            'status_checker'      => 'Status Checker',
            'created_at'          => 'Created At',
        ];

        $data = $rollover->map(function ($rolloverApproval) {
            return [
                'id'                  => $rolloverApproval->id,
                'client_name'         => $rolloverApproval->productOrder->getClientNameAttribute(),
                'agreement_file_name' => $rolloverApproval->productOrder->agreement_file_name,
                'fund_status'         => $rolloverApproval->productOrder->status,
                'amount'              => $rolloverApproval->amount,
                'status_approver'     => str_replace('_', ' ', $rolloverApproval->status_approver),
                'created_at'          => $rolloverApproval->created_at->format('Y-m-d H:i:s'),
            ];
        });

        $pageTitle   = "Rollover - Approval";
        $icon        = 'voyager-star';
        $returnRoute = route('voyager.product-rollover-history.index');
        $modelSlug   = 'product-rollover-history-approver';
        $parentId    = null;
        $baseRoute   = 'admin';
        $view        = false;
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editRolloverApprover($id)
    {
        $rollover = ProductRolloverHistory::findOrFail($id);

        // Restrict access if status_checker is not APPROVED
        if ($rollover->status_checker !== 'APPROVE_CHECKER') {
            return redirect()->route('product_rollover_history_approver.show')->with([
                'message'    => 'Only records with status approved by checker can be edited.',
                'alert-type' => 'error',
            ]);
        }

        $columns = [
            'status_approver' => 'Approver Status',
            'remark_approver' => 'Remark Approver',
        ];

        $dataTypes = [
            'status_approver' => 'dropdown',
            'remark_approver' => 'text',
        ];

        $dropdownOptions = [
            'status_approver' => [
                //'PENDING_APPROVER' => 'Pending Approver',
                'APPROVE_APPROVER' => 'Approve Approver',
                'REJECT_APPROVER'  => 'Reject Approver',
            ],
        ];

                                                                               // Prepare data for the form
        $data = $rollover->only(['id', 'status_approver', 'remark_approver']); // Fetch only required fields

        // Page details
        $pageTitle      = "Edit Rollover Approver";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'product-rollover-history-approver';
        $returnRoute    = route('product_rollover_history_approver.show');
        $hideViewButton = true;

        return view('voyager::custom-bread.edit-add', compact(
            'pageTitle',
            'columns',
            'dataTypes',
            'dropdownOptions',
            'data',
            'parentId',
            'baseRoute',
            'modelSlug',
            'returnRoute',
            'hideViewButton'
        ));
    }

    public function updateRolloverApprover(Request $request, $id)
    {
        $rollover = ProductRolloverHistory::findOrFail($id);

        if ($rollover->status_checker !== 'APPROVE_CHECKER') {
            return redirect()->route('product_rollover_history_approver.show')->with([
                'message'    => 'Only records with status_checker as APPROVED can be updated.',
                'alert-type' => 'error',
            ]);
        }

        $validated = $request->validate([
            'status_approver' => 'required|in:PENDING_APPROVER,APPROVE_APPROVER,REJECT_APPROVER',
            'remark_approver' => 'nullable|string|max:255',
        ]);

        $user = Auth::user();

        if ($validated['status_approver'] == 'APPROVE_APPROVER') {
            $rollover->status              = 'APPROVED';
            $rollover->approver_updated_at = now();
            if ($user && isset($user->email)) {
                $rollover->approved_by = $user->email;
            }
        } else {
            $rollover->approver_updated_at = now();
            $rollover->status              = 'REJECTED';
            if ($user && isset($user->email)) {
                $rollover->checked_by = $user->email;
            }
        }

        $rollover->status_approver = $validated['status_approver'];
        $rollover->remark_approver = $validated['remark_approver'];
        $rollover->save();

        if ($rollover->productOrder->status == 'MATURED') {
            //REFUND, ROLLOVER, FULL_REDEMPTION, REALLOCATION, EARLY_REDEMPTION
            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/product-order/activate/reallocation-rollover-redemption?id=' . $rollover->productOrder->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);
        }

        return redirect()->route('product_rollover_history_approver.show')->with([
            'message'    => 'Rollover Approver updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectEditRolloverApprover($id)
    {
        return redirect()->route('product_rollover_history_approver.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }
}
