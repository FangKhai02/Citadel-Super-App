<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use TCG\Voyager\Models\Setting;
use TCG\Voyager\Facades\Voyager;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use App\Models\ProductWithdrawalHistory;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Http\Controllers\Custom\CustomVoyagerBaseController;

class ProductEarlyRedemptionHistoryController extends CustomVoyagerBaseController
{

    protected $withdrawalReadColumns;
    protected $withdrawalReadData;
    public function index(Request $request)
    {
        // GET THE SLUG, ex. 'posts', 'pages', etc.
        $slug = $this->getSlug($request);

        // GET THE DataType based on the slug
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('browse', app($dataType->model_name));

        $getter = $dataType->server_side ? 'paginate' : 'get';

        $search = (object) ['value' => $request->get('s'), 'key' => $request->get('key'), 'filter' => $request->get('filter')];


        $orderBy = $request->get('order_by', $dataType->order_column);
        $sortOrder = $request->get('sort_order', $dataType->order_direction);
        $usesSoftDeletes = false;
        $showSoftDeleted = false;

        // Next Get or Paginate the actual content from the MODEL that corresponds to the slug DataType
        if (strlen($dataType->model_name) != 0) {
            $model = app($dataType->model_name);

            $query = $model::select($dataType->name.'.*');

            if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope'.ucfirst($dataType->scope))) {
                $query->{$dataType->scope}();
            }

            // Use withTrashed() if model uses SoftDeletes and if toggle is selected
            if ($model && in_array(SoftDeletes::class, class_uses_recursive($model)) && Auth::user()->can('delete', app($dataType->model_name))) {
                $usesSoftDeletes = true;

                if ($request->get('showSoftDeleted')) {
                    $showSoftDeleted = true;
                    $query = $query->withTrashed();
                }
            }

            // If a column has a relationship associated with it, we do not want to show that field
            $this->removeRelationshipField($dataType, 'browse');

            if ($search->value != '' && $search->key && $search->filter) {
                $search_filter = ($search->filter == 'equals') ? '=' : 'LIKE';
                $search_value = ($search->filter == 'equals') ? $search->value : '%' . $search->value . '%';

                if ($search->key === 'product_early_redemption_history_hasone_product_early_redemption_history_relationship') {
                    // Searching by client name
                    $query->where(function ($query) use ($search_filter, $search_value) {
                        $query->whereHas('productOrder.client.userDetails', function ($query) use ($search_filter, $search_value) {
                            $query->where('name', $search_filter, $search_value);
                        })
                            ->orWhereHas('productOrder.corporateClient.corporateDetail', function ($query) use ($search_filter, $search_value) {
                                $query->where('entity_name', $search_filter, $search_value);
                            });
                    });
                }elseif ($search->key === 'product_early_redemption_history_belongsto_product_order_relationship') {
                    $query->whereHas('productOrder', function ($query) use ($search_filter, $search_value) {
                        $query->where('agreement_file_name', $search_filter, $search_value);
                    });
                } else {
                    // Default search
                    $query->where($search->key, $search_filter, $search_value);
                }
            }

            if ($orderBy && (in_array($orderBy, $dataType->fields()) || !empty($row))) {
                $querySortOrder = (!empty($sortOrder)) ? $sortOrder : 'desc';
                if (!empty($row)) {
                    $query->select([
                        $dataType->name.'.*',
                        'joined.'.$row->details->label.' as '.$orderBy,
                    ])->leftJoin(
                        $row->details->table.' as joined',
                        $dataType->name.'.'.$row->details->column,
                        'joined.'.$row->details->key
                    );
                }

                $dataTypeContent = call_user_func([
                    $query->orderBy($orderBy, $querySortOrder),
                    $getter,
                ]);
            } elseif ($model->timestamps) {
                $dataTypeContent = call_user_func([$query->latest($model::CREATED_AT), $getter]);
            } else {
                $dataTypeContent = call_user_func([$query->orderBy($model->getKeyName(), 'DESC'), $getter]);
            }

            // Replace relationships' keys for labels and create READ links if a slug is provided.
            $dataTypeContent = $this->resolveRelations($dataTypeContent, $dataType);
        } else {
            // If Model doesn't exist, get data from table name
            $dataTypeContent = call_user_func([DB::table($dataType->name), $getter]);
            $model = false;
        }

        $searchNames = [];
        if ($dataType->server_side) {
            $searchNames = $dataType->browseRows->mapWithKeys(function ($row) {
                return [$row['field'] => $row->getTranslatedAttribute('display_name')];
            })->toArray();

//            // Add "id_number" at the beginning of the array
//            $searchNames = ['agent_belongsto_user_detail_relationship_3' => 'ID Number'] + $searchNames;
        }

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($model);

        // Eagerload Relations
        $this->eagerLoadRelations($dataTypeContent, $dataType, 'browse', $isModelTranslatable);

        // Check if server side pagination is enabled
        $isServerSide = isset($dataType->server_side) && $dataType->server_side;

        // Check if a default search key is set
        $defaultSearchKey = $dataType->default_search_key ?? null;

        // Actions
        $actions = [];
        if (!empty($dataTypeContent->first())) {
            foreach (Voyager::actions() as $action) {
                $action = new $action($dataType, $dataTypeContent->first());

                if ($action->shouldActionDisplayOnDataType()) {
                    $actions[] = $action;
                }
            }
        }

        // Define showCheckboxColumn
        $showCheckboxColumn = false;
        if (Auth::user()->can('delete', app($dataType->model_name))) {
            $showCheckboxColumn = true;
        } else {
            foreach ($actions as $action) {
                if (method_exists($action, 'massAction')) {
                    $showCheckboxColumn = true;
                }
            }
        }

        // Define orderColumn
        $orderColumn = [];
        if ($orderBy) {
            $index = $dataType->browseRows->where('field', $orderBy)->keys()->first() + ($showCheckboxColumn ? 1 : 0);
            $orderColumn = [[$index, $sortOrder ?? 'desc']];
        }

        // Define list of columns that can be sorted server side
        $sortableColumns = $this->getSortableColumns($dataType->browseRows);

        $view = 'voyager::bread.browse';

        if (view()->exists("voyager::$slug.browse")) {
            $view = "voyager::$slug.browse";
        }

        return Voyager::view($view, compact(
            'actions',
            'dataType',
            'dataTypeContent',
            'isModelTranslatable',
            'search',
            'orderBy',
            'orderColumn',
            'sortableColumns',
            'sortOrder',
            'searchNames',
            'isServerSide',
            'defaultSearchKey',
            'usesSoftDeletes',
            'showSoftDeleted',
            'showCheckboxColumn'
        ));
    }

    protected function getWithdrawalDetails($id)
    {
        $withdrawal = ProductWithdrawalHistory::findOrFail($id);

        $this->withdrawalReadColumns = [
            'client'              => 'Client',
            'client_id'           => 'Client ID',
            'agreement_file_name' => 'Fund Agreement',
            'fund_status'         => 'Fund Status',
            'product_name'        => 'Product Code',
            'withdrawal_method'   => 'Type',
            'withdrawal_amount'   => 'Amount (RM)',
            'penalty_amount'      => 'Penalty Amount (RM)',
            'penalty_percentage'  => 'Penalty Percentage',
            'status_checker'      => 'Checker Status',
            'status_approver'     => 'Status Approver',
            'created_at'          => 'Created At',
        ];

        $this->withdrawalReadData = (object) [
            'id'                  => $withdrawal->id,
            'client'              => $withdrawal->productOrder->getClientNameAttribute(),
            'client_id'           => $withdrawal->productOrder->getPurchaserIDAttribute(),
            'agreement_file_name' => $withdrawal->productOrder->agreement_file_name,
            'fund_status'         => $withdrawal->productOrder->status,
            'product_name'        => $withdrawal->productOrder->product->code,
            'withdrawal_method'   => str_replace('_', ' ', $withdrawal->withdrawal_method),
            'withdrawal_amount'   => number_format($withdrawal->withdrawal_amount,2,'.',','),
            'penalty_amount'      => number_format($withdrawal->penalty_amount,2,'.',','),
            'penalty_percentage'  => $withdrawal->penalty_percentage,
            'status_checker'      => str_replace('_', ' ', $withdrawal->status_checker),
            'status_approver'     => str_replace('_', ' ', $withdrawal->status_approver),
            'created_at'          => $withdrawal->created_at->format('Y-m-d H:i:s'),
        ];

        // Return only the columns and data objects
        return [
            'columns' => $this->withdrawalReadColumns,
            'data'    => $this->withdrawalReadData,
        ];

    }

    //--------------------Checker Start--------------------
    public function showWithdrawalChecker(Request $request)
    {

        $showableStatuses  = ['PENDING_CHECKER', 'REJECT_CHECKER'];
        $productWithdrawal = ProductWithdrawalHistory::whereIn('status_checker', $showableStatuses)
            ->orderBy('created_at', 'asc')
            ->get();

        $columns = [
            'client'              => 'Client',
            'agreement_file_name' => 'Fund Agreement',
            'withdrawal_method'   => 'Type',
            'withdrawal_amount'   => 'Amount (RM)',
            'penalty_amount'      => 'Penalty Amount (RM)',
            'penalty_percentage'  => 'Penalty Percentage',
            'status_checker'      => 'Status Checker',
            'created_at'          => 'Created At',
        ];

        $data = [];

        foreach ($productWithdrawal as $withdrawal) {
            $data[] = (object) [
                'id'                  => $withdrawal->id,
                'client'              => $withdrawal->productOrder->getClientNameAttribute(),
                'agreement_file_name' => $withdrawal->productOrder->agreement_file_name,
                'withdrawal_method'   => str_replace('_', ' ', $withdrawal->withdrawal_method),
                'withdrawal_amount'   => number_format($withdrawal->withdrawal_amount,2,'.',','),
                'penalty_amount'      => number_format($withdrawal->penalty_amount,2,'.',','),
                'penalty_percentage'  => $withdrawal->penalty_percentage,
                'status_checker'      => $withdrawal->status_checker,
                'created_at'          => $withdrawal->created_at,
            ];
        }

        $pageTitle   = "Product Early Redemption Management - Checker";
        $icon        = 'voyager-dollar';
        $returnRoute = route('voyager.product-order.index');
        $modelSlug   = 'withdrawal-checker';
        $parentId    = null;
        $baseRoute   = 'admin';
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'delete', 'add'));
    }

    public function readWithdrawalChecker(Request $request, $id)
    {
        $details = $this->getWithdrawalDetails($id);
        $columns = $details['columns'];
        $data    = $details['data'];

        $pageTitle   = "Withdrawal";
        $icon        = 'voyager-check';
        $returnRoute = route('withdrawal_checker.show');
        $modelSlug   = 'withdrawal-checker';
        $parentId    = null;
        $baseRoute   = 'admin';
        $edit        = true;
        $delete      = false;

        return view('voyager::custom-bread.read', compact('edit', 'delete', 'pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute'));

    }

    public function editWithdrawalChecker($id)
    {
        $productWithdrawal = ProductWithdrawalHistory::findOrFail($id);

        // Define the editable columns and their labels
        $columns = [
            'status_checker' => 'Status',
            'remark_checker' => 'Remark',
        ];

        // Define data types for form inputs
        $dataTypes = [
            'status_checker' => 'dropdown', // Dropdown for status_checker
            'remark_checker' => 'text',     // Text input for remark_checker
        ];

        // Dropdown options for status_checker
        $dropdownOptions = [
            'status_checker' => [
                'APPROVE_CHECKER' => 'Approve',
                'REJECT_CHECKER'  => 'Reject',
            ],
        ];

        // Prepare the data for the form (fields that will be editable)
        $data = $productWithdrawal->only(['id', 'status_checker', 'remark_checker']);

        // Page details
        $pageTitle      = "Edit Product Early Redemption - Checker";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'withdrawal-checker';
        $view           = false;
        $returnRoute    = route('withdrawal_checker.show', ['id' => $productWithdrawal->id]);
        $hideViewButton = true;

        // Return the edit view with the necessary data and configuration
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

    public function updateWithdrawalChecker(Request $request, $id)
    {
        $productWithdrawal = ProductWithdrawalHistory::findOrFail($id);

        $validated = $request->validate([
            'status_checker' => 'required|in:PENDING_CHECKER,APPROVE_CHECKER,REJECT_CHECKER', // Valid statuses for the checker
            'remark_checker' => 'nullable|string|max:255',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        // Update the status_checker and remark_checker columns with validated data
        $productWithdrawal->status_checker     = $validated['status_checker'];
        $productWithdrawal->remark_checker     = $validated['remark_checker'] ?? null;
        $productWithdrawal->checker_updated_at = now();
        $productWithdrawal->checked_by         = $user->email;
        // Save the updated withdrawal record
        $productWithdrawal->save();

        // If the status_checker is REJECT_CHECKER, also update the status field to REJECTED
        if ($productWithdrawal->status_checker === 'REJECT_CHECKER') {
            $productWithdrawal->withdrawal_status = 'REJECTED';
        } else if ($productWithdrawal->status_checker === 'APPROVE_CHECKER') {
            $productWithdrawal->withdrawal_status = 'IN_REVIEW';
        }
        $productWithdrawal->save();

        // Redirect with a success message
        return redirect()->route('withdrawal_checker.show', ['id' => $productWithdrawal->id])->with([
            'message'    => 'Product Withdrawal Checker updated successfully.',
            'alert-type' => 'success',
        ]);
    }
    //--------------------Checker End--------------------

    //--------------------Approver Start--------------------
    public function showWithdrawalApprover(Request $request)
    {
        // Get product orders with necessary relationships (replace this with your actual query)
        $showableStatuses  = ['PENDING_APPROVER', 'REJECT_APPROVER'];
        $productWithdrawal = ProductWithdrawalHistory::whereIn('status_approver', $showableStatuses)
            ->where('status_checker', 'APPROVE_CHECKER')
            ->orderBy('created_at', 'asc')
            ->get();

        $columns = [
            'client'              => 'Client',
            'agreement_file_name' => 'Fund Agreement',
            'withdrawal_method'   => 'Type',
            'withdrawal_amount'   => 'Amount (RM)',
            'penalty_amount'      => 'Penalty Amount (RM)',
            'penalty_percentage'  => 'Penalty Percentage',
            'status_approver'     => 'Status Approver',
            'created_at'          => 'Created At',
        ];

        $data = [];

        foreach ($productWithdrawal as $withdrawal) {
            $data[] = (object) [
                'id'                  => $withdrawal->id,
                'client'              => $withdrawal->productOrder->getClientNameAttribute(),
                'agreement_file_name' => $withdrawal->productOrder->agreement_file_name,
                'withdrawal_method'   => str_replace('_', ' ', $withdrawal->withdrawal_method),
                'withdrawal_amount'   => number_format($withdrawal->withdrawal_amount,2,'.',','),
                'penalty_amount'      => number_format($withdrawal->penalty_amount,2,'.',','),
                'penalty_percentage'  => $withdrawal->penalty_percentage,
                'status_approver'     => $withdrawal->status_approver,
                'created_at'          => $withdrawal->created_at,
            ];
        }

        $pageTitle   = "Product Early Redemption Management - Approver";
        $icon        = 'voyager-dollar';
        $returnRoute = route('voyager.product-order.index');
        $modelSlug   = 'withdrawal-approver';
        $parentId    = null;
        $baseRoute   = 'admin';
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'delete', 'add'));
    }

    public function readWithdrawalApprover(Request $request, $id)
    {
        $details = $this->getWithdrawalDetails($id);
        $columns = $details['columns'];
        $data    = $details['data'];

        $pageTitle   = "Withdrawal";
        $icon        = 'voyager-check';
        $returnRoute = route('withdrawal_approver.show');
        $modelSlug   = 'withdrawal-approver';
        $parentId    = null;
        $baseRoute   = 'admin';
        $edit        = true;
        $delete      = false;

        return view('voyager::custom-bread.read', compact('edit', 'delete', 'pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute'));

    }

    public function editWithdrawalApprover($id)
    {
        // Fetch the specific product order record
        $productWithdrawal = ProductWithdrawalHistory::findOrFail($id);
        if ($productWithdrawal->status_checker !== 'APPROVE_CHECKER') {
            return redirect()->route('product_order_approver.show')->with([
                'message'    => 'Only records with status approved by checker can be edited.',
                'alert-type' => 'error',
            ]);
        }

        // Define columns and their labels (only status and remark are editable)
        $columns = [
            'status_approver' => 'Status',
            'remark_approver' => 'Remark',
        ];

        // Define data types for form inputs
        $dataTypes = [
            'status_approver' => 'dropdown',
            'remark_approver' => 'text',
        ];

        // Dropdown options for status_approver
        $dropdownOptions = [
            'status_approver' => [
                'APPROVE_APPROVER' => 'Approve',
                'REJECT_APPROVER'  => 'Reject',
            ],
        ];

        // Prepare the data for the form (fields that will be editable)
        $data = $productWithdrawal->only(['id', 'status_approver', 'remark_approver']);

        // Page details
        $pageTitle      = "Edit Product Early Redemption - Approver";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'withdrawal-approver';
        $returnRoute    = route('withdrawal_approver.show');
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

    public function updateWithdrawalApprover(Request $request, $id)
    {
        // Fetch the specific product order record
        $productWithdrawal = ProductWithdrawalHistory::findOrFail($id);

        // Validate input
        $validated = $request->validate([
            'status_approver' => 'required|in:PENDING_APPROVER,APPROVE_APPROVER,REJECT_APPROVER',
            'remark_approver' => 'nullable|string|max:255',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        // Update fields
        $productWithdrawal->status_approver     = $validated['status_approver'];
        $productWithdrawal->remark_approver     = $validated['remark_approver'] ?? null;
        $productWithdrawal->approved_by         = $user->email;
        $productWithdrawal->approver_updated_at = now();
        // Save the updated withdrawal record
        $productWithdrawal->save();

        if ($productWithdrawal->status_approver === 'APPROVE_APPROVER') {
            $productWithdrawal->withdrawal_status = 'APPROVED';
        } else if ($productWithdrawal->status_approver === 'REJECT_APPROVER') {
            $productWithdrawal->withdrawal_status = 'REJECTED';
        }
        $productWithdrawal->save();

        return redirect()->route('withdrawal_approver.show')->with([
            'message'    => 'Product Withdrawal Approver updated successfully.',
            'alert-type' => 'success',
        ]);
    }
    //--------------------Approver End--------------------

    public function generateBankFile(Request $request, $id)
    {
        try {
            $productWithdrawal = ProductWithdrawalHistory::findOrFail($id);

            // Prepare a list to capture missing approvals
            $notApproved = [];

            // Check if the checker has approved
            if ($productWithdrawal->status_checker !== 'APPROVE_CHECKER') {
                $notApproved[] = 'Checker';
            }

            // Check if the approver has approved
            if ($productWithdrawal->status_approver !== 'APPROVE_APPROVER') {
                $notApproved[] = 'Approver';
            }

            // If any approval is missing, return with an error message listing them
            if (! empty($notApproved)) {
                $errorMessage = 'Redemption has not been approved by: ' . implode(', ', $notApproved);
                return redirect()->back()->with([
                    'message'    => $errorMessage,
                    'alert-type' => 'error',
                ]);
            }

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/product-early-redemption/generate-bank-file?id=' . $productWithdrawal->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);

            return redirect()->route('voyager.product-early-redemption-history.index')->with([
                'message'    => 'Redemption Bank File generation in process, check your email for the bank file shortly',
                'alert-type' => 'success',
            ]);

        } catch (\Exception $e) {
            // Handle exceptions and return to the browse view with an error message
            return redirect()->route('voyager.product-early-redemption-history.index')->with([
                'message'    => 'An error occurred: ' . $e->getMessage(),
                'alert-type' => 'error',
            ]);
        }
    }

    public function updateWithdrawalPayment(Request $request, $id)
    {
        try {
            $productWithdrawal = ProductWithdrawalHistory::findOrFail($id);

            // Check if the checker has approved
            if (is_null($productWithdrawal->bank_result_csv)) {
                return redirect()->back()->with([
                    'message'    => 'Need to upload a Excel file',
                    'alert-type' => 'error',
                ]);
            }
            // Prepare a list to capture missing approvals
            $notApproved = [];

            // Check if the checker has approved
            if ($productWithdrawal->status_checker !== 'APPROVE_CHECKER') {
                $notApproved[] = 'Checker';
            }

            // Check if the approver has approved
            if ($productWithdrawal->status_approver !== 'APPROVE_APPROVER') {
                $notApproved[] = 'Approver';
            }

            // If any approval is missing, return with an error message listing them
            if (! empty($notApproved)) {
                $errorMessage = 'Redemption has not been approved by: ' . implode(', ', $notApproved);
                return redirect()->back()->with([
                    'message'    => $errorMessage,
                    'alert-type' => 'error',
                ]);
            }

            if (is_null($productWithdrawal->bank_result_csv)) {
                return redirect()->back()->with([
                    'message'    => 'Need to upload a Excel file',
                    'alert-type' => 'error',
                ]);
            }

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/product-early-redemption/update-early-redemption-payment?id=' . $productWithdrawal->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);

            return redirect()->route('voyager.product-early-redemption-history.index')->with([
                'message'    => 'Redemption Bank File generation in process, check your email for the bank file shortly',
                'alert-type' => 'success',
            ]);

        } catch (\Exception $e) {
            // Handle exceptions and return to the browse view with an error message
            return redirect()->route('voyager.product-early-redemption-history.index')->with([
                'message'    => 'An error occurred: ' . $e->getMessage(),
                'alert-type' => 'error',
            ]);
        }
    }

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
        $setting      = Setting::where('key', 'admin.early.redemption.bank.result.update.sample.file')->first();
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
                    $fileUrl = config('app.aws_url') . '/' . $downloadLink;
                }
            }
        }

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable', 'fileUrl'));
    }
}
