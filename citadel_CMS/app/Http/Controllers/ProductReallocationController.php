<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ProductReallocation;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use App\Http\Controllers\Custom\CustomVoyagerBaseController;

class ProductReallocationController extends CustomVoyagerBaseController
{
    //--------------------Checker Start--------------------
    public function showReallocationChecker(Request $request)
    {
        $reallocation = ProductReallocation::whereIn('status_checker', ['REJECT_CHECKER', 'PENDING_CHECKER'])->get();

        $columns = [
            'client_name'         => 'Client Name',
            'agreement_file_name' => 'Fund Agreement',
            'fund_status'         => 'Fund Status',
            'amount'              => 'Amount',
            'reallocate_product_code' => 'Reallocate Product Code',
            'status_checker'      => 'Status Checker',
            'created_at'          => 'Created At',
        ];

        $data = $reallocation->map(function ($reallocationChecker) {
            return [
                'id'                  => $reallocationChecker->id,
                'client_name'         => $reallocationChecker->productOrder->getClientNameAttribute(),
                'agreement_file_name' => $reallocationChecker->productOrder->agreement_file_name,
                'fund_status'         => $reallocationChecker->productOrder->status,
                'amount'              => $reallocationChecker->amount,
                'reallocate_product_code' => $reallocationChecker->reallocateProduct->code,
                'status_checker'      => str_replace('_', ' ', $reallocationChecker->status_checker),
                'created_at'          => $reallocationChecker->created_at->format('Y-m-d H:i:s')];
        });

        $pageTitle   = "Reallocation - Checker";
        $icon        = 'voyager-check';
        $returnRoute = route('voyager.product-reallocation.index');
        $modelSlug   = 'product-reallocation-checker';
        $parentId    = null;
        $baseRoute   = 'admin';
        $view        = false;
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editReallocationChecker($id)
    {
        $productRellocation = ProductReallocation::findOrFail($id);

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
        $data = $productRellocation->only(['id', 'status_checker', 'remark_checker']);

        // Page details
        $pageTitle      = "Edit Reallocation Checker";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'product-reallocation-checker';
        $view           = false;
        $returnRoute    = route('product_reallocation_checker.show');
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

    public function updateReallocationChecker(Request $request, $id)
    {
        $productRellocation = ProductReallocation::findOrFail($id);

        $validated = $request->validate([
            'status_checker' => 'required|in:PENDING_CHECKER,APPROVE_CHECKER,REJECT_CHECKER',
            'remark_checker' => 'nullable|string|max:255',
        ]);

        $user = Auth::user();

        if ($validated['status_checker'] == 'APPROVE_CHECKER') {
            $productRellocation->checker_updated_at = now();
            if ($user && isset($user->email)) {
                $productRellocation->checked_by = $user->email;
            }
        } else {
            $productRellocation->checker_updated_at = now();
            $productRellocation->status             = 'REJECTED';
            if ($user && isset($user->email)) {
                $productRellocation->checked_by = $user->email;
            }
        }

        $productRellocation->status_checker = $validated['status_checker'];
        $productRellocation->remark_checker = $validated['remark_checker'];
        $productRellocation->save();

        return redirect()->route('product_reallocation_checker.show')->with([
            'message'    => 'Reallocation Checker updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectEditReallocationChecker($id)
    {
        return redirect()->route('product_reallocation_checker.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }
    //--------------------Checker End--------------------

    //--------------------Approver Start--------------------
    public function showReallocationApproval(Request $request)
    {
        $reallocation = ProductReallocation::whereIn('status_approver', ['REJECT_APPROVER', 'PENDING_APPROVER'])->get();

        $columns = [
            'client_name'         => 'Client Name',
            'agreement_file_name' => 'Fund Agreement',
            'fund_status'         => 'Fund Status',
            'amount'              => 'Amount',
            'status_checker'      => 'Status Checker',
            'created_at'          => 'Created At',
        ];

        $data = $reallocation->map(function ($reallocationApproval) {
            return [
                'id'                  => $reallocationApproval->id,
                'client_name'         => $reallocationApproval->productOrder->getClientNameAttribute(),
                'agreement_file_name' => $reallocationApproval->productOrder->agreement_file_name,
                'fund_status'         => $reallocationApproval->productOrder->status,
                'amount'              => $reallocationApproval->amount,
                'status_checker'      => str_replace('_', ' ', $reallocationApproval->status_approver),
                'created_at'          => $reallocationApproval->created_at->format('Y-m-d H:i:s')];
        });

        $pageTitle   = "Reallocation - Approval";
        $icon        = 'voyager-star';
        $returnRoute = route('voyager.product-reallocation.index');
        $modelSlug   = 'product-reallocation-approver';
        $parentId    = null;
        $baseRoute   = 'admin';
        $view        = false;
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editReallocationApprover($id)
    {
        $productRellocation = ProductReallocation::findOrFail($id);

        if ($productRellocation->status_checker !== 'APPROVE_CHECKER') {
            return redirect()->route('product_reallocation_approver.show')->with([
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
        $data = $productRellocation->only(['id', 'status_approver', 'remark_approver']); // Fetch only required fields

        // Page details
        $pageTitle      = "Edit Reallocation Approver";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'product-reallocation-approver';
        $returnRoute    = route('product_reallocation_approver.show');
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

    public function updateReallocationApprover(Request $request, $id)
    {
        $productRellocation = ProductReallocation::findOrFail($id);

        if ($productRellocation->status_checker !== 'APPROVE_CHECKER') {
            return redirect()->route('product_reallocation_approver.show')->with([
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
            $productRellocation->status              = 'APPROVED';
            $productRellocation->approver_updated_at = now();
            if ($user && isset($user->email)) {
                $productRellocation->approved_by = $user->email;
            }
        } else {
            $productRellocation->approver_updated_at = now();
            $productRellocation->status              = 'REJECTED';
            if ($user && isset($user->email)) {
                $productRellocation->checked_by = $user->email;
            }
        }

        $productRellocation->status_approver = $validated['status_approver'];
        $productRellocation->remark_approver = $validated['remark_approver'];
        $productRellocation->save();

        //Check if the productOrder status is MATURED
        if ($productRellocation->productOrder->status === 'MATURED') {
            //REFUND, ROLLOVER, FULL_REDEMPTION, REALLOCATION, EARLY_REDEMPTION
            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/product-order/activate/reallocation-rollover-redemption?id=' . $productRellocation->productOrder->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);
        }

        return redirect()->route('product_reallocation_approver.show')->with([
            'message'    => 'Reallocation Approver updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectEditReallocationApprover($id)
    {
        return redirect()->route('product_reallocation_approver.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }
    //--------------------Approver End--------------------
}
