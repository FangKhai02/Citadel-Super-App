<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use TCG\Voyager\Models\Setting;
use TCG\Voyager\Facades\Voyager;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use App\Models\ProductCommissionHistory;
use Illuminate\Support\Facades\Validator;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Http\Controllers\Custom\CustomVoyagerBaseController;
use Firebase\JWT\JWT;

class ProductCommissionHistoryController extends CustomVoyagerBaseController
{
    //****************** START AGENT COMMISSION DASHBOARD **********************//

    public function browseProductCommissionAgentDashboard(Request $request){
        // Get the Metabase site URL from the environment
        $METABASE_SITE_URL = config('app.METABASE_SITE_URL');
        $METABASE_SECRET_KEY = config('app.METABASE_SECRET_KEY');

        // Function to generate Metabase iframe URL
        $generateIframeUrl = function ($questionId) use ($METABASE_SECRET_KEY, $METABASE_SITE_URL) {
            $payload = [
                "resource" => ["question" => $questionId],
                "params" => (object) []
            ];
            $token = JWT::encode($payload, $METABASE_SECRET_KEY, 'HS256');
            return $METABASE_SITE_URL . "/embed/question/" . $token . "#bordered=true&titled=true";
        };

        // Generate iframe URLs
        if(config('app.env') == 'local'){
            $iframeUrl = $generateIframeUrl(15);
        }else{
            $iframeUrl = $generateIframeUrl(15);
        }

        return view('metabase-dashboard', compact('iframeUrl'));
    }
    //****************** START AGENCY COMMISSION DASHBOARD **********************//

    public function browseProductCommissionAgencyDashboard(Request $request){
        // Get the Metabase site URL from the environment
        $METABASE_SITE_URL = config('app.METABASE_SITE_URL');
        $METABASE_SECRET_KEY = config('app.METABASE_SECRET_KEY');

        // Function to generate Metabase iframe URL
        $generateIframeUrl = function ($questionId) use ($METABASE_SECRET_KEY, $METABASE_SITE_URL) {
            $payload = [
                "resource" => ["question" => $questionId],
                "params" => (object) []
            ];
            $token = JWT::encode($payload, $METABASE_SECRET_KEY, 'HS256');
            return $METABASE_SITE_URL . "/embed/question/" . $token . "#bordered=true&titled=true";
        };

        // Generate iframe URLs
        $iframeUrl = $generateIframeUrl(44);

        return view('metabase-dashboard', compact('iframeUrl'));
    }
    //-------------------------Checker Start-------------------------
    public function showCommissionChecker(Request $request)
    {
        $showableStatuses   = ['PENDING_CHECKER', 'REJECT_CHECKER'];
        $commissionCheckers = ProductCommissionHistory::select('id', 'commission_file_id', 'commission_csv_key', 'status_checker', 'created_at')
            ->whereIn('status_checker', $showableStatuses)
            ->get();

        $columns = [
            'commission_file_id' => 'Commission File Name',
            'commission_csv_key' => 'Commission File',
            'status_checker'     => 'Status',
            'created_at'         => 'Created At',
        ];

        $data = $commissionCheckers->map(function ($commissionChecker) {
            return [
                'id'                 => $commissionChecker->id,
                'commission_file_id' => $commissionChecker->commission_file_id,
                'commission_csv_key' => $commissionChecker->commission_csv_key,
                'status_checker'     => str_replace('_', ' ', $commissionChecker->status_checker),
                'created_at'         => $commissionChecker->created_at->format('Y-m-d H:i:s')];
        });

        $pageTitle   = "Commission Management - Checker";
        $icon        = 'voyager-check';
        $returnRoute = route('voyager.product-commission-history.index');
        $modelSlug   = 'commission_checker';
        $parentId    = null;
        $baseRoute   = 'admin';
        $view        = false;
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editCommissionChecker($id)
    {
        // Fetch the specific commission record
        $commission    = ProductCommissionHistory::findOrFail($id);
        $rejectChecker = $commission->status_checker == 'REJECT_CHECKER';

        // Define columns and their labels (only status and remark are editable)
        $columns = [
            'status_checker'  => 'Checker Status',
            'remarks_checker' => 'Remark Checker',
        ];

        // Define data types for form inputs
        $dataTypes = [
            'status_checker'  => 'dropdown',
            'remarks_checker' => 'text',
        ];

        // Dropdown options for status_checker
        $dropdownOptions = [
            'status_checker' => [
                'APPROVE_CHECKER' => 'Approved Checker',
                'REJECT_CHECKER'  => 'Rejected Checker',
            ],
        ];

        // Prepare data for the form
        $data = $commission->only(['id', 'status_checker', 'remarks_checker']);
        if ($rejectChecker) {
            $columns['commission_csv_key']   = 'Commission File';
            $dataTypes['commission_csv_key'] = 'file'; // File input for commission_csv_key
            $data['commission_csv_key']      = $commission->commission_csv_key;
        }

        // Page details
        $pageTitle      = "Edit Commission Checker";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'commission_checker';
        $view           = false;
        $returnRoute    = route('commission_checker.show', ['id' => $commission->id]);
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

    public function updateCommissionChecker(Request $request, $id)
    {
        // Fetch the specific commission record
        $commission = ProductCommissionHistory::findOrFail($id);

        // Create a validator instance
        $validator = Validator::make($request->all(), [
            'status_checker'     => 'required|in:PENDING_CHECKER,APPROVE_CHECKER,REJECT_CHECKER', // Assuming these are the valid statuses for the checker
            'remarks_checker'    => 'nullable|string|max:255',
            'commission_csv_key' => 'nullable|file|mimes:xlsx', // Assuming the file is an Excel file
        ]);

        // Check if validation fails
        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }

        // Get validated data
        $validated = $validator->validated();

        // Get the authenticated user
        $user = Auth::user();

        // Check if the status_checker is APPROVE_CHECKER
        if ($validated['status_checker'] == 'APPROVE_CHECKER') {
            // Save the current timestamp in the checked_at column
            $commission->checked_at = now();

            // Check if the user is authenticated and has an email
            if ($user && isset($user->email)) {
                // Save the authenticated user's email in the checked_by column
                $commission->checked_by = $user->email;
            }
        }

        // Update fields with validated data
        $commission->status_checker  = $validated['status_checker'];
        $commission->remarks_checker = $validated['remarks_checker'];
        // Save the updated commission
        $commission->save();

        if ($request->hasFile('commission_csv_key')) {
            $folderPath                     = 'commission-csv/' . now()->format('Y/m/d');
//            $commission->commission_csv_key = $request->file('commission_csv_key')->store($folderPath, 's3');
            $commission->updated_commission_csv_key = $request->file('commission_csv_key')->store($folderPath, 's3');;
//            $commission->commission_file_id = $request->file('commission_csv_key')->getClientOriginalName();
            $commission->save();

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/commission/update-commission-excel?id=' . $commission->id;
            Http::get($fullUrl);
            // Add a 5-second delay (non-blocking)
            sleep(5);
        }

        // Redirect with a success message
        return redirect()->route('commission_checker.show', ['id' => $commission->id])->with([
            'message'    => 'Commission Checker updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectEditCommissionChecker($id)
    {
        return redirect()->route('commission_checker.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }
    //-------------------------Checker End-------------------------

    //-------------------------Approver Start-------------------------
    public function showCommissionApproval(Request $request)
    {
        $showableStatuses    = ['PENDING_APPROVER', 'REJECT_APPROVER'];
        $commissionApprovals = ProductCommissionHistory::select('commission_file_id', 'commission_csv_key', 'status_approver', 'remarks_approver', 'created_at', 'id')
            ->whereIn('status_approver', $showableStatuses)
            ->where('status_checker', 'APPROVE_CHECKER')
            ->get(); // Ensure 'id' is selected

        $columns = [
            'commission_file_id' => 'Commission File Name',
            'commission_csv_key' => 'Commission File',
            'status_approver'    => 'Status',
            'created_at'         => 'Created At',
        ];

        $data = $commissionApprovals->map(function ($commissionApproval) {
            return [
                'id'                 => $commissionApproval->id,
                'commission_file_id' => $commissionApproval->commission_file_id,
                'commission_csv_key' => $commissionApproval->commission_csv_key,
                'status_approver'    => str_replace('_', ' ', $commissionApproval->status_approver),
                'created_at'         => $commissionApproval->created_at->format('Y-m-d H:i:s'),
            ];
        });

        $pageTitle   = "Commission Management - Approver";
        $icon        = 'voyager-star';
        $returnRoute = route('voyager.product-commission-history.index');
        $modelSlug   = 'commission_approval';
        $parentId    = null;
        $baseRoute   = 'admin';
        $view        = false;
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editCommissionApprover($id)
    {
        // Fetch the specific commission record
        $commission     = ProductCommissionHistory::findOrFail($id);
        $rejectApprover = $commission->status_approver == 'REJECT_APPROVER';

        // Restrict access if status_approver is not APPROVED
        if ($commission->status_checker !== 'APPROVE_CHECKER') {
            return redirect()->route('commission_approval.show')->with([
                'message'    => 'Only records with status approved by checker can be edited.',
                'alert-type' => 'error',
            ]);
        }

        // Define columns and their labels (only status and remark are editable)
        $columns = [
            'status_approver'  => 'Approver Status',
            'remarks_approver' => 'Remark Approver',
        ];

        // Define data types for form inputs
        $dataTypes = [
            'status_approver'  => 'dropdown',
            'remarks_approver' => 'text',
        ];

        // Dropdown options for status_approver
        $dropdownOptions = [
            'status_approver' => [
                //'PENDING_APPROVER' => 'Pending Approver',
                'APPROVE_APPROVER' => 'Approve Approver',
                'REJECT_APPROVER'  => 'Reject Approver',
            ],
        ];

        $data = $commission->only(['id', 'status_approver', 'remarks_approver']); // Fetch only required fields
        if ($rejectApprover) {
            $columns['commission_csv_key']   = 'Commission File';
            $dataTypes['commission_csv_key'] = 'file'; // File input for commission_csv_key
            $data['commission_csv_key']      = $commission->commission_csv_key;
        }

        // Page details
        $pageTitle      = "Edit Commission Approver";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'commission_approval';
        $returnRoute    = route('commission_approval.show', ['id' => $commission->id]);
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

    public function updateCommissionApprover(Request $request, $id)
    {
        // Fetch the specific commission record
        $commission = ProductCommissionHistory::findOrFail($id);

        // Validate input
        $validated = $request->validate([
            'status_approver'    => 'required|in:PENDING_APPROVER,APPROVE_APPROVER,REJECT_APPROVER',
            'remarks_approver'   => 'nullable|string|max:255',
            'commission_csv_key' => 'nullable|file|mimes:xlsx',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        // Check if the status_approver is APPROVE_APPROVER
        if ($validated['status_approver'] == 'APPROVE_APPROVER') {
            // Save the current timestamp in the approved_at column
            $commission->approved_at = now();

            // Check if the user is authenticated and has an email
            if ($user && isset($user->email)) {
                // Save the authenticated user's email in the approved_by column
                $commission->approved_by = $user->email;
            }
        }

        // Update fields
        $commission->status_approver  = $validated['status_approver'];
        $commission->remarks_approver = $validated['remarks_approver'];
        // Save the updated commission
        $commission->save();

        if ($request->hasFile('commission_csv_key')) {
            $folderPath                     = 'commission-csv/' . now()->format('Y/m/d');
            $commission->updated_commission_csv_key = $request->file('commission_csv_key')->store($folderPath, 's3');;
//            $commission->commission_file_id = $request->file('commission_csv_key')->getClientOriginalName();
            $commission->save();

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/commission/update-commission-excel?id=' . $commission->id;
            Http::get($fullUrl);
            // Add a 5-second delay (non-blocking)
            sleep(5);
        }

        return redirect()->route('commission_approval.show', ['id' => $commission->id])->with([
            'message'    => 'Commission Approver updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectEditCommissionApprover($id)
    {
        return redirect()->route('commission_approver.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }

    //-------------------------Approver End-------------------------
    public function edit(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        if (strlen($dataType->model_name) != 0) {
            $model = app($dataType->model_name);
            $query = $model->query();

            // Use withTrashed() if model uses SoftDeletes and if toggle is selected
            if ($model && in_array(SoftDeletes::class, class_uses_recursive($model))) {
                $query = $query->withTrashed();
            }
            if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope' . ucfirst($dataType->scope))) {
                $query = $query->{$dataType->scope}();
            }
            $dataTypeContent = call_user_func([$query, 'findOrFail'], $id);
        } else {
            // If Model doest exist, get data from table name
            $dataTypeContent = DB::table($dataType->name)->where('id', $id)->first();
        }

        foreach ($dataType->editRows as $key => $row) {
            $dataType->editRows[$key]['col_width'] = isset($row->details->width) ? $row->details->width : 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'edit');

        // Check permission
        $this->authorize('edit', $dataTypeContent);

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        // Eagerload Relations
        $this->eagerLoadRelations($dataTypeContent, $dataType, 'edit', $isModelTranslatable);

        $view = 'voyager::bread.edit-add';

        if (view()->exists("voyager::$slug.edit-add")) {
            $view = "voyager::$slug.edit-add";
        }

        // Retrieve the setting value as before
        $setting = Setting::where('key', 'admin.commission.bank.result.update.sample.file')->first();
        $settingValue = $setting ? $setting->value : null;

        $fileUrl = '';
        if ($settingValue) {
            $files = json_decode($settingValue, true);

            if (! empty($files) && isset($files[0]['download_link'])) {
                $downloadLink = $files[0]['download_link'];

                // Append "citadel" between the AWS_URL and download link only if the environment is staging
                if (config('app.env') !== 'production') {
                    $fileUrl = config('app.aws_url') . '/citadel/' . $downloadLink;
                } else {
                    $fileUrl = config('app.aws_url') . '/citadel/' . $downloadLink;
                }
            }
        }

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable', 'fileUrl'));
    }

    public function generateBankFile(Request $request, $id)
    {
        try {
            $productCommissionHistory = ProductCommissionHistory::findOrFail($id);

            // Prepare a list to capture missing approvals
            $notApproved = [];

            // Check if the checker has approved
            if ($productCommissionHistory->status_checker !== 'APPROVE_CHECKER') {
                $notApproved[] = 'Checker';
            }

            // Check if the approver has approved
            if ($productCommissionHistory->status_approver !== 'APPROVE_APPROVER') {
                $notApproved[] = 'Approver';
            }

            // If any approval is missing, return with an error message listing them
            if (! empty($notApproved)) {
                $errorMessage = 'Commission has not been approved by: ' . implode(', ', $notApproved);
                return redirect()->back()->with([
                    'message'    => $errorMessage,
                    'alert-type' => 'error',
                ]);
            }

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/commission/generate-bank-file?id=' . $productCommissionHistory->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);

            return redirect()->route('voyager.product-commission-history.index')->with([
                'message'    => 'Commission Bank File generation in process, check your email for the bank file shortly',
                'alert-type' => 'success',
            ]);
        } catch (\Exception $e) {
            // Handle exceptions and return to the browse view with an error message
            return redirect()->route('voyager.product-commission-history.index')->with([
                'message'    => 'An error occurred: ' . $e->getMessage(),
                'alert-type' => 'error',
            ]);
        }
    }

    public function updateCommissionPayment(Request $request, $id)
    {
        try {
            $productCommissionHistory = ProductCommissionHistory::findOrFail($id);

            // Check if the checker has approved
            if (is_null($productCommissionHistory->bank_result_csv)) {
                return redirect()->back()->with([
                    'message'    => 'Need to upload a Excel file',
                    'alert-type' => 'error',
                ]);
            }

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/commission/update-commission-payment?id=' . $productCommissionHistory->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);

            return redirect()->route('voyager.product-commission-history.index')->with([
                'message'    => 'Commission Payment Update is in process, check your email for the results shortly',
                'alert-type' => 'success',
            ]);
        } catch (\Exception $e) {
            // Handle exceptions and return to the browse view with an error message
            return redirect()->route('voyager.product-commission-history.index')->with([
                'message'    => 'An error occurred: ' . $e->getMessage(),
                'alert-type' => 'error',
            ]);
        }
    }
}
