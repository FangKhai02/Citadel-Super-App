<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Custom\CustomVoyagerBaseController;
use App\Models\ProductRedemption;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Models\Setting;

class ProductRedemptionController extends CustomVoyagerBaseController
{
    protected $redemptionColumns;
    protected $redemptionData;

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

                if ($search->key === 'product_redemption_hasone_product_redemption_relationship') {
                    // Searching by client name
                    $query->where(function ($query) use ($search_filter, $search_value) {
                        $query->whereHas('productOrder.client.userDetails', function ($query) use ($search_filter, $search_value) {
                            $query->where('name', $search_filter, $search_value);
                        })
                            ->orWhereHas('productOrder.corporateClient.corporateDetail', function ($query) use ($search_filter, $search_value) {
                                $query->where('entity_name', $search_filter, $search_value);
                            });
                    });
                }elseif ($search->key === 'product_redemption_belongsto_product_order_relationship') {
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

    protected function getRedemptionDetails($id)
    {
        $redemption = ProductRedemption::findOrFail($id);

        // Define your columns
        $this->redemptionColumns = [
            'client'              => 'Client',
            'client_id'           => 'Client ID',
            'agreement_file_name' => 'Fund Agreement',
            'fund_status'         => 'Fund Status',
            'type'                => 'Redemption Type',
            'product_name'        => 'Product Name',
            'amount'              => 'Amount',
            'status_checker'      => 'Status Checker',
            'status_approver'     => 'Status Approver',
            'created_at'          => 'Created At',
        ];

        // Build your data object
        $this->redemptionData = (object) [
            'id'                  => $redemption->id,
            'client'              => $redemption->productOrder->getClientNameAttribute(),
            'client_id'           => $redemption->productOrder->getPurchaserIDAttribute(),
            'agreement_file_name' => $redemption->productOrder->agreement_file_name,
            'fund_status'         => $redemption->productOrder->status,
            'type'                => $redemption->type,
            'product_name'        => $redemption->productOrder->product->code,
            'amount'              => $redemption->amount,
            'status_checker'      => str_replace('_', ' ', $redemption->status_checker),
            'status_approver'     => str_replace('_', ' ', $redemption->status_approver),
            'created_at'          => $redemption->created_at->format('Y-m-d H:i:s'),
        ];

        // Return only the columns and data objects
        return [
            'columns' => $this->redemptionColumns,
            'data'    => $this->redemptionData,
        ];
    }

    //--------------------Checker Start--------------------
    public function showRedemptionChecker(Request $request)
    {
        $redemption = ProductRedemption::whereIn('status_checker', ['REJECT_CHECKER', 'PENDING_CHECKER'])->get();

        $columns = [
            'client'              => 'Client',
            'agreement_file_name' => 'Fund Agreement',
            'fund_status'         => 'Fund Status',
            'type'                => 'Redemption Type',
            'status_checker'      => 'Status Checker',
            'created_at'          => 'Created At',
        ];

        $data = $redemption->map(function ($redemptionChecker) {
            return [
                'id'                  => $redemptionChecker->id,
                'client'              => $redemptionChecker->productOrder->getClientNameAttribute(),
                'agreement_file_name' => $redemptionChecker->productOrder->agreement_file_name,
                'fund_status'         => $redemptionChecker->productOrder->status,
                'type'                => $redemptionChecker->type,
                'status_checker'      => str_replace('_', ' ', $redemptionChecker->status_checker),
                'created_at'          => $redemptionChecker->created_at->format('Y-m-d H:i:s')];
        });

        $pageTitle   = "Redemptions Management- Checker";
        $icon        = 'voyager-check';
        $returnRoute = route('voyager.redemption-details.index');
        $modelSlug   = 'redemption-checker';
        $parentId    = null;
        $baseRoute   = 'admin';
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'delete', 'add'));
    }

    public function readRedemptionChecker(Request $request, $id)
    {
        $details = $this->getRedemptionDetails($id);
        $columns = $details['columns'];
        $data    = $details['data'];

        $pageTitle   = "Redemption";
        $icon        = 'voyager-check';
        $returnRoute = route('redemption_checker.edit', ['id' => $id]);
        $modelSlug   = 'redemption-checker';
        $parentId    = null;
        $baseRoute   = 'admin';
        $edit        = true;
        $delete      = false;

        return view('voyager::custom-bread.read', compact('edit', 'delete', 'pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute'));

    }

    public function editRedemptionChecker($id)
    {
        $redemption = ProductRedemption::findOrFail($id);

        // Define the editable columns and their labels
        $columns = [
            'status_checker' => 'Checker Status',
            'remark_checker' => 'Remark Checker',
        ];

        $dataTypes = [
            'status_checker' => 'dropdown', // Dropdown for status_checker
            'remark_checker' => 'text',     // Text input for remark_checker
        ];

        // Dropdown options for status_checker
        $dropdownOptions = [
            'status_checker' => [
                'APPROVE_CHECKER' => 'Approved Checker',
                'REJECT_CHECKER'  => 'Rejected Checker',
            ],
        ];

        // Prepare data for the form (fields that will be editable)
        $data = $redemption->only(['id', 'status_checker', 'remark_checker']);

        // Page details
        $pageTitle      = "Edit Redemption Checker";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'redemption-checker';
        $view           = false;
        $returnRoute    = route('redemption_checker.show');
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

    public function updateRedemptionChecker(Request $request, $id)
    {
        $redemption = ProductRedemption::findOrFail($id);

        $validated = $request->validate([
            'status_checker' => 'required|in:PENDING_CHECKER,APPROVE_CHECKER,REJECT_CHECKER',
            'remark_checker' => 'nullable|string|max:255',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        // Update the status_checker and remark_checker columns with validated data
        $redemption->status_checker     = $validated['status_checker'];
        $redemption->remark_checker     = $validated['remark_checker'] ?? null;
        $redemption->checker_updated_at = now();
        $redemption->checked_by         = $user->email;
        // Save the updated redemtion record
        $redemption->save();

        if ($redemption->status_checker === 'REJECT_CHECKER') {
            $redemption->status = 'REJECTED';
        } else if ($redemption->status_checker === 'APPROVE_CHECKER') {
            $redemption->status = 'IN_REVIEW';
        }
        $redemption->save();

        // Redirect with a success message
        return redirect()->route('redemption_checker.show')->with([
            'message'    => 'Redemption Checker updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectEditRedemptionChecker($id)
    {
        return redirect()->route('redemption_checker.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }
    //--------------------Checker End--------------------

    //--------------------Approver Start--------------------
    public function showRedemptionApproval(Request $request)
    {
        $redemption = ProductRedemption::whereIn('status_approver', ['REJECT_APPROVER', 'PENDING_APPROVER'])
            ->where('status_checker', 'APPROVE_CHECKER')
            ->get();

        $columns = [
            'client'              => 'Client',
            'agreement_file_name' => 'Fund Agreement',
            'fund_status'         => 'Fund Status',
            'type'                => 'Redemption Type',
            'status_checker'      => 'Status Checker',
            'created_at'          => 'Created At',
        ];

        $data = $redemption->map(function ($redemptionApproval) {
            return [
                'id'                  => $redemptionApproval->id,
                'client'              => $redemptionApproval->productOrder->getClientNameAttribute(),
                'agreement_file_name' => $redemptionApproval->productOrder->agreement_file_name,
                'fund_status'         => $redemptionApproval->productOrder->status,
                'type'                => $redemptionApproval->type,
                'status_checker'      => str_replace('_', ' ', $redemptionApproval->status_approver),
                'created_at'          => $redemptionApproval->created_at->format('Y-m-d H:i:s'),
            ];
        });

        $pageTitle   = "Redemptions Management - Approval";
        $icon        = 'voyager-star';
        $returnRoute = route('voyager.redemption-details.index');
        $modelSlug   = 'redemption-approver';
        $parentId    = null;
        $baseRoute   = 'admin';
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'delete', 'add'));
    }

    public function readRedemptionApprover(Request $request, $id)
    {
        $details = $this->getRedemptionDetails($id);
        $columns = $details['columns'];
        $data    = $details['data'];

        $pageTitle   = "Redemption";
        $icon        = 'voyager-check';
        $returnRoute = route('redemption_approver.edit', ['id' => $id]);
        $modelSlug   = 'redemption-approver';
        $parentId    = null;
        $baseRoute   = 'admin';
        $edit        = true;
        $delete      = false;

        return view('voyager::custom-bread.read', compact('edit', 'delete', 'pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute'));

    }

    public function editRedemptionApprover($id)
    {

        $redemption = ProductRedemption::findOrFail($id);

        // Restrict access if status_checker is not APPROVED
        if ($redemption->status_checker !== 'APPROVE_CHECKER') {
            return redirect()->route('redemption_approver.show')->with([
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
        $data = $redemption->only(['id', 'status_approver', 'remark_approver']); // Fetch only required fields

        // Page details
        $pageTitle      = "Edit Redemption Approver";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'redemption-approver';
        $returnRoute    = route('redemption_approver.show');
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

    public function updateRedemptionApprover(Request $request, $id)
    {
        $redemption = ProductRedemption::findOrFail($id);

        $validated = $request->validate([
            'status_approver' => 'required|in:PENDING_APPROVER,APPROVE_APPROVER,REJECT_APPROVER',
            'remark_approver' => 'nullable|string|max:255',
        ]);

        $user = Auth::user();

        $redemption->status_approver     = $validated['status_approver'];
        $redemption->remark_approver     = $validated['remark_approver'] ?? null;
        $redemption->approved_by         = $user->email;
        $redemption->approver_updated_at = now();
        $redemption->save();

        if ($redemption->status_approver === 'APPROVE_APPROVER') {
            $redemption->status = 'APPROVED';
        } else if ($redemption->status_approver === 'REJECT_APPROVER') {
            $redemption->status = 'REJECTED';
        }
        $redemption->save();

        return redirect()->route('redemption_approver.show')->with([
            'message'    => 'Redemption Approver updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectEditRedemptionApprover($id)
    {
        return redirect()->route('redemption_approver.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }
    //--------------------Approver End--------------------

    public function generateBankFile(Request $request, $id)
    {
        try {
            $productRedemption = ProductRedemption::findOrFail($id);

            // Prepare a list to capture missing approvals
            $notApproved = [];

            // Check if the checker has approved
            if ($productRedemption->status_checker !== 'APPROVE_CHECKER') {
                $notApproved[] = 'Checker';
            }

            // Check if the approver has approved
            if ($productRedemption->status_approver !== 'APPROVE_APPROVER') {
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
            $fullUrl        = $citadelBackend . 'api/backend/cms/product-redemption/generate-bank-file?id=' . $productRedemption->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);

            return redirect()->route('voyager.product-redemption.index')->with([
                'message'    => 'Redemption Bank File generation in process, check your email for the bank file shortly',
                'alert-type' => 'success',
            ]);

        } catch (\Exception $e) {
            // Handle exceptions and return to the browse view with an error message
            return redirect()->route('voyager.product-redemption.index')->with([
                'message'    => 'An error occurred: ' . $e->getMessage(),
                'alert-type' => 'error',
            ]);
        }
    }

    public function updateRedemptionPayment(Request $request, $id)
    {
        try {
            $productRedemption = ProductRedemption::findOrFail($id);

            // Prepare a list to capture missing approvals
            $notApproved = [];

            // Check if the checker has approved
            if ($productRedemption->status_checker !== 'APPROVE_CHECKER') {
                $notApproved[] = 'Checker';
            }

            // Check if the approver has approved
            if ($productRedemption->status_approver !== 'APPROVE_APPROVER') {
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

            if (is_null($productRedemption->bank_result_csv)) {
                return redirect()->back()->with([
                    'message'    => 'Need to upload a Excel file',
                    'alert-type' => 'error',
                ]);
            }

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/product-redemption/update-redemption-payment?id=' . $productRedemption->id;
            Http::get($fullUrl);

            // Add a 5-second delay (non-blocking)
            sleep(5);

            return redirect()->route('voyager.product-redemption.index')->with([
                'message'    => 'Redemption Payment Update is in process, check your email for the results shortly',
                'alert-type' => 'success',
            ]);
        } catch (\Exception $e) {
            // Handle exceptions and return to the browse view with an error message
            return redirect()->route('voyager.product-redemption.index')->with([
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
        $setting      = Setting::where('key', 'admin.redemption.bank.result.update.sample.file')->first();
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
