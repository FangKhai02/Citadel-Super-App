<?php

namespace App\Http\Controllers;

use App\Models\Agency;
use App\Models\CorporateDocuments;
use App\Models\Product;
use Firebase\JWT\JWT;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use TCG\Voyager\Facades\Voyager;
use App\Models\ProductCommission;
use Illuminate\Support\Facades\Auth;
use App\Models\ProductCommissionAgent;
use App\Models\ProductDividendHistory;
use App\Models\ProductEarlyRedemption;
use App\Models\ProductCommissionHistory;
use TCG\Voyager\Events\BreadDataUpdated;
use TCG\Voyager\Http\Controllers\VoyagerBaseController;
use App\Http\Controllers\Custom\CustomVoyagerBaseController;
use function Symfony\Component\String\s;

class ProductController extends CustomVoyagerBaseController
{
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

        $orderBy         = $request->get('order_by', $dataType->order_column);
        $sortOrder       = $request->get('sort_order', $dataType->order_direction);
        $usesSoftDeletes = false;
        $showSoftDeleted = false;

        // Next Get or Paginate the actual content from the MODEL that corresponds to the slug DataType
        if (strlen($dataType->model_name) != 0) {
            $model = app($dataType->model_name);

            $query = $model::select($dataType->name . '.*');

            if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope' . ucfirst($dataType->scope))) {
                $query->{$dataType->scope}();
            }

            // Use withTrashed() if model uses SoftDeletes and if toggle is selected
            if ($model && in_array(SoftDeletes::class, class_uses_recursive($model)) && Auth::user()->can('delete', app($dataType->model_name))) {
                $usesSoftDeletes = true;

                if ($request->get('showSoftDeleted')) {
                    $showSoftDeleted = true;
                    $query           = $query->withTrashed();
                }
            }

            $this->removeRelationshipField($dataType, 'browse');

            if (!empty($search->value) && $search->key && $search->filter) {
                $search_filter = $search->filter === 'equals' ? '=' : 'LIKE';
                $search_value  = $search->filter === 'equals' ? $search->value : '%' . $search->value . '%';
                $searchField   = $dataType->name . '.' . $search->key;

                if ($search->key === 'category') {
                    $query->whereHas('productType', function ($q) use ($search_filter, $search_value) {
                        $q->where('name', $search_filter, $search_value);
                    });
                } elseif ($search->key === 'agency') {
                    $query->whereHas('agencies', function ($q) use ($search_filter, $search_value) {
                        $q->where('agency_code', $search_filter, $search_value);
                    });
                } elseif ($search->key === 'reallocation') {
                    $query->whereHas('productReallocationConfiguration', function ($q) use ($search_filter, $search_value) {
                        $q->where('code', $search_filter, $search_value);
                    });
                } elseif ($search->key === 'agreement') {
                    $query->whereHas('productAgreement', function ($q) use ($search_filter, $search_value) {
                        $q->where('name', $search_filter, $search_value);
                    });
                } elseif ($dataType->browseRows->pluck('field')->contains($search->key)) {
                    $query->where($searchField, $search_filter, $search_value);
                } else {
                    $query->where($searchField, $search_filter, $search_value);
                }
            }

            $row = $dataType->rows->where('field', $orderBy)->firstWhere('type', 'relationship');
            if ($orderBy && (in_array($orderBy, $dataType->fields()) || ! empty($row))) {
                $querySortOrder = (! empty($sortOrder)) ? $sortOrder : 'desc';
                if (! empty($row)) {
                    $query->select([
                        $dataType->name . '.*',
                        'joined.' . $row->details->label . ' as ' . $orderBy,
                    ])->leftJoin(
                        $row->details->table . ' as joined',
                        $dataType->name . '.' . $row->details->column,
                        'joined.' . $row->details->key
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
            $model           = false;
        }
        $searchNames = [];

        if ($dataType->server_side) {
            $customSearchNames = [
                'category'     => 'Category',
                'agency'       => 'Agency',
                'reallocation' => 'Reallocation Upon Maturity (Fund Name)',
                'agreement'    => 'Agreement'
            ];

            $excludedRelationships = [
                'product_hasmany_product_reallocation_relationship',
                'product_hasone_product_relationship_1',
                'product_belongsto_product_agreement_relationship',
                'product_belongsto_product_type_relationship',
                'product_catalogue_url',
                'image_of_product_url'
            ];

            $browseFields = $dataType->browseRows->pluck('field');

            $readRows = $dataType->readRows->reject(function ($row) use ($browseFields, $customSearchNames, $excludedRelationships) {
                return
                    $browseFields->contains($row->field) ||
                    array_key_exists($row->field, $customSearchNames) ||
                    in_array($row->field, $excludedRelationships);
            });

            $allSearchable = $dataType->browseRows->concat($readRows);

            $searchNames = $allSearchable->mapWithKeys(function ($row) {
                return [$row['field'] => $row->getTranslatedAttribute('display_name')];
            })->toArray();

            $searchNames = $customSearchNames + $searchNames;
        }

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($model);

        // Eagerload Relations
        $this->eagerLoadRelations($dataTypeContent, $dataType, 'browse', $isModelTranslatable);

        // Check if server side pagination is enabled
        $isServerSide = isset($dataType->server_side) && $dataType->server_side;

        // Check if a default search key is set
        $defaultSearchKey = '';

        // Actions
        $actions = [];
        if (! empty($dataTypeContent->first())) {
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
            $index       = $dataType->browseRows->where('field', $orderBy)->keys()->first() + ($showCheckboxColumn ? 1 : 0);
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

    public function update(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Compatibility with Model binding.
        $id = $id instanceof \Illuminate\Database\Eloquent\Model  ? $id->{$id->getKeyName()} : $id;

        $model = app($dataType->model_name);
        $query = $model->query();
        if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope' . ucfirst($dataType->scope))) {
            $query = $query->{$dataType->scope}();
        }
        if ($model && in_array(SoftDeletes::class, class_uses_recursive($model))) {
            $query = $query->withTrashed();
        }

        $data = $query->findOrFail($id);

        // Check permission
        $this->authorize('edit', $data);

        // Validate fields with ajax
        $val = $this->validateBread($request->all(), $dataType->editRows, $dataType->name, $id)->validate();

        // Get fields with images to remove before updating and make a copy of $data
        $to_remove = $dataType->editRows->where('type', 'image')
            ->filter(function ($item, $key) use ($request) {
                return $request->hasFile($item->field);
            });
        $original_data = clone ($data);

        $this->insertUpdateData($request, $slug, $dataType->editRows, $data);

        // Sync agencies if not selected
        if (empty($request->product_hasone_product_relationship_1)) {
            // No agencies selected, add all existing agencies to product
            $data->agencies()->sync(Agency::all()->pluck('id')->toArray());
        }

        // Delete Images
        $this->deleteBreadImages($original_data, $to_remove);

        event(new BreadDataUpdated($dataType, $data));

        if (auth()->user()->can('browse', app($dataType->model_name))) {
            $redirect = redirect()->route("voyager.{$dataType->slug}.index");
        } else {
            $redirect = redirect()->back();
        }

        return $redirect->with([
            'message' => __('voyager::generic.successfully_updated') . " {$dataType->getTranslatedAttribute('display_name_singular')}",
            'alert-type' => 'success',
        ]);
    }

    //****************** START PRODUCT EARLY REDEMPTION FUNCTION **********************//

    public function browseProductEarlyRedemption(Request $request)
    {
        $product = Product::findOrFail($request->id);
        $productEarlyRedemption = $product->productEarlyRedemption;

        // Define columns
        $columns = [
            // Product Code, Period Type, Period, Condition, Penalty (%)
            'product_code' => 'Product Code',
            'period_type' => 'Period Type',
            'period' => 'Period',
            'condition' => 'Condition',
            'penalty' => 'Penalty (%)',
        ];

        // Prepare data for the table
        $data = $productEarlyRedemption->map(function ($redemption) use ($product) {
            return [
                'id' => $redemption->id,
                'product_code' => $product->code,
                'period_type' => "Year", //TODO change column
                'period' => $redemption->period,
                'condition' => $redemption->condition,
                'penalty' => $redemption->penalty_percentage,
            ];
        });

        // Page details
        $pageTitle = "Early Redemption";
        $icon = 'voyager-calendar';
        $returnRoute = route('voyager.product.index');
        $modelSlug = 'early-redemption';
        $parentId = $product->id;
        $baseRoute = 'admin/product/';

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute'));
    }

    public function createProductEarlyRedemption(Request $request)
    {
        $product = Product::findOrFail($request->id);

        // Define columns
        $columns = [
            // Product Code, Period Type, Period, Condition, Penalty (%)
            'product_id' => 'Product Code',
            'period_type' => 'Period Type',
            'period' => 'Period',
            'condition' => 'Condition',
            'penalty' => 'Penalty (%)',
        ];

        $dataTypes = [
            'product_id' => 'parent-disable',
            'period_type' => 'dropdown',
            'period' => 'number',
            'condition' => 'dropdown',
            'penalty' => 'number',
        ];

        $dropdownOptions = [
            'condition' => ['PENALTY' => 'Penalty', 'NOT_ALLOWED' => 'Not Allowed'],
            'period_type' => ['YEAR' => 'Year', 'MONTH' => 'Month'],
        ];

        // Define required fields
        $requiredFields = [
            'product_id' => true,
            'period_type' => true,
            'period' => true,
            'condition' => false,
            'penalty' => true,
        ];

        // Page details
        $pageTitle = "Early Redemption";
        $icon = 'voyager-calendar';
        $returnRoute = route('browse.product.early.redemption', ['id' => $product->id]);
        $modelSlug = 'early-redemption';
        $parentId = $product->id;
        $parentValue = $product->code;
        $baseRoute = 'admin/product/';
        $hideViewButton = true;

        return view('voyager::custom-bread.edit-add', compact(
            'parentValue', 'dataTypes', 'dropdownOptions', 'pageTitle',
            'icon', 'columns', 'returnRoute', 'modelSlug', 'parentId',
            'baseRoute', 'hideViewButton', 'requiredFields'
        ));
    }

    public function storeProductEarlyRedemption(Request $request)
    {

        // Create the new product early redemption record
        $productEarlyRedemption = new ProductEarlyRedemption();
        $productEarlyRedemption->product_id = $request->product_id;
        $productEarlyRedemption->period = $request->period;
        $productEarlyRedemption->condition = $request->condition;
        $productEarlyRedemption->penalty_percentage = $request->penalty;
        $productEarlyRedemption->save();

        // Redirect back with a success message
        return redirect()->route('browse.product.early.redemption', ['id' => $request->product_id])
            ->with('success', 'Early Redemption created successfully');
    }

    public function viewProductEarlyRedemption(Request $request, $id, $sub_id)
    {
        $product = Product::findOrFail($request->id);
        $productEarlyRedemption = $product->productEarlyRedemption->where('id', $sub_id)->firstOrFail();

        // Define columns
        $columns = [
            // Product Code, Period Type, Period, Condition, Penalty (%)
            'product_code' => 'Product Code',
            'period_type' => 'Period Type',
            'period' => 'Period',
            'condition' => 'Condition',
            'penalty' => 'Penalty (%)',
        ];

        // Prepare data for the table
        $data = (object) [
            'id' => $productEarlyRedemption->id,
            'product_code' => $product->code,
            'period_type' => "Year", //TODO change column
            'period' => $productEarlyRedemption->period,
            'condition' => $productEarlyRedemption->condition,
            'penalty' => $productEarlyRedemption->penalty_percentage,
        ];

        // Page details
        $pageTitle = "Early Redemption";
        $icon = 'voyager-calendar';
        $returnRoute = route('browse.product.early.redemption', ['id' => $id]);
        $modelSlug = 'early-redemption';
        $parentId = $product->id;
        $baseRoute = 'admin/product/';
        $edit = true;
        $delete = false;

        return view('voyager::custom-bread.read', compact('edit', 'delete', 'pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute'));
    }

    public function editProductEarlyRedemption(Request $request, $id, $sub_id)
    {
        $product = Product::findOrFail($id);
        $productEarlyRedemption = $product->productEarlyRedemption->where('id', $sub_id)->firstOrFail();

        // Define columns
        $columns = [
            // Product Code, Period Type, Period, Condition, Penalty (%)
            'product_id' => 'Product Code',
            'period_type' => 'Period Type',
            'period' => 'Period',
            'condition' => 'Condition',
            'penalty' => 'Penalty (%)',
        ];

        // Prepare data for the table
        $data = [
            'id' => $productEarlyRedemption->id,
            'product_id' => $product->id,
            'period_type' => "Year", //TODO change column
            'period' => $productEarlyRedemption->period,
            'condition' => $productEarlyRedemption->condition,
            'penalty' => $productEarlyRedemption->penalty_percentage,
        ];

        $dataTypes = [
            'product_id' => 'parent-disable',
            'period_type' => 'dropdown',
            'period' => 'number',
            'condition' => 'dropdown',
            'penalty' => 'number',
        ];

        $dropdownOptions = [
            'condition' => ['PENALTY' => 'Penalty', 'NOT_ALLOWED' => 'Not Allowed'],
            'period_type' => ['YEAR' => 'Year', 'MONTH' => 'Month'],
        ];

        // Page details
        $pageTitle = "Early Redemption";
        $icon = 'voyager-calendar';
        $returnRoute = route('browse.product.early.redemption', ['id' => $id]);
        $modelSlug = 'early-redemption';
        $parentId = $product->id;
        $parentValue = $product->code;
        $baseRoute = 'admin/product/';
        $hideViewButton = true;

        return view('voyager::custom-bread.edit-add', compact('parentValue', 'dataTypes', 'dropdownOptions', 'pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute','hideViewButton'));
    }

    public function updateProductEarlyRedemption(Request $request, $id, $sub_id)
    {
        $product = Product::findOrFail($id);
        $productEarlyRedemption = $product->productEarlyRedemption->where('id', $sub_id)->firstOrFail();

        // Update the record with the new data
        $productEarlyRedemption->period = $request->period;
        $productEarlyRedemption->condition = $request->condition;
        $productEarlyRedemption->penalty_percentage = $request->penalty;
        $productEarlyRedemption->save();

        // Redirect back with a success message
        return redirect()->route('browse.product.early.redemption', ['id' => $id])
            ->with('success', 'Early Redemption updated successfully');
    }

    public function deleteProductEarlyRedemption(Request $request, $id, $sub_id)
    {
        $product = Product::findOrFail($id);
        $productEarlyRedemption = $product->productEarlyRedemption->where('id', $sub_id)->firstOrFail();

        // Delete the record
        $productEarlyRedemption->delete();

        // Redirect back with a success message
        return redirect()->route('browse.product.early.redemption', ['id' => $id])
            ->with('success', 'Early Redemption deleted successfully');
    }

    //****************** START PRODUCT COMMISSION FUNCTION **********************//
    public function browseProductCommission(Request $request)
    {
        $product = Product::findOrFail($request->id);
        $productCommission = ProductCommission::where('product_id', $product->id)->get();

        // Define columns
        $columns = [
            'product_code' => 'Product Code',
            'agency_type' => 'Agency Type',
            'condition' => 'Condition',
            'threshold' => 'Threshold',
        ];

        // Prepare data for the table
        $data = $productCommission->map(function ($commission) use ($product) {
            $condition = '-';
            switch ($commission->condition ?? null) {
                case 0:
                    $condition = 'New';
                    break;
                case 1:
                    $condition = 'New Above';
                    break;
                case 2:
                    $condition = 'Tier 2';
                    break;
                default:
                    $condition = '-';
            }

            return [
                'id' => $commission->id,
                'product_code' => $product->code ?? '-',
                'agency_type' => $commission->agency->agency_type ?? '-',
                'condition' => $condition,
                'threshold' => number_format($commission->threshold,2,'.',',') ?? '-',
            ];
        });

        // Page details
        $pageTitle = "Product Commission";
        $icon = 'voyager-briefcase';
        $returnRoute = route('voyager.product.index');
        $modelSlug = 'commission-config';
        $parentId = $product->id;
        $baseRoute = 'admin/product/';

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute'));
    }

    public function createProductCommission(Request $request)
    {
        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($request->id);

        // Page details
        $pageTitle = "Add Product Commission";
        $icon = 'voyager-briefcase';
        $returnRoute = route('browse.product.commission.config', ['id' => $product->id]);
        $modelSlug = 'commission-config';
        $parentId = $product->id;
        $parentValue = $product->code;
        $baseRoute = 'admin/product/';
        $hideViewButton = true;

        // Define columns (if you need custom column names for display)
        $columns = [
            'product_id' => 'Product Code',
            'agency_id' => 'Agency Type',
            'condition' => 'Condition',
            'threshold' => 'Threshold',
        ];

        $dataTypes = [
            'product_id' => 'parent-disable',
            'agency_id' => 'dropdown',
            'condition' => 'dropdown',
            'threshold' => 'number',
        ];

        // Define dropdown options for specific fields
        $dropdownOptions = [
            'agency_id' => Agency::pluck('agency_name', 'id')->toArray(),
            'condition' => [0 => 'New', 1 => 'New Above', 2 => 'Tier 2'],
        ];

        // Pass the data to the view
        return view('voyager::custom-bread.edit-add', compact(
            'dataTypes',
            'dropdownOptions',
            'pageTitle',
            'columns',
            'icon',
            'returnRoute',
            'modelSlug',
            'parentId',
            'parentValue',
            'baseRoute',
            'hideViewButton'
        ));
    }

    public function storeProductCommission(Request $request)
    {

        // Create the new product commission record
        $productCommission = new ProductCommission();
        $productCommission->product_id = $request->product_id;
        $productCommission->agency_id = $request->agency_id;
        $productCommission->condition = $request->condition;
        $productCommission->threshold = $request->threshold;
        $productCommission->save();

        // Redirect back with a success message
        return redirect()->route('browse.product.commission.config', ['id' => $request->product_id])
            ->with('success', 'Product Commission created successfully');
    }

    public function viewProductCommission(Request $request, $id, $sub_id)
    {
        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($id);
        // Fetch the expected profit sharing record using the sub_id
        $productCommission = ProductCommission::where('product_id', $product->id)->where('id', $sub_id)->firstOrFail();

        // Page details
        $pageTitle = "Product Commission Details";
        $icon = 'voyager-briefcase';
        $returnRoute = route('browse.product.commission.config', ['id' => $id]);
        $modelSlug = 'commission-config';
        $parentId = $product->id;
        $baseRoute = 'admin/product/';

        $columns = [
            'product_code' => 'Product Code',
            'agency_type' => 'Agency Type',
            'condition' => 'Condition',
            'threshold' => 'Threshold',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];

        // Prepare data to be passed to the view

        $condition = '-';
        switch ($productCommission->condition ?? null) {
            case 0:
                $condition = 'New';
                break;
            case 1:
                $condition = 'New Above';
                break;
            case 2:
                $condition = 'Tier 2';
                break;
            default:
                $condition = '-';
        }

        $data = [
            'id' => $productCommission->id,
            'product_code' => $product->code ?? '-',
            'agency_type' => $productCommission->agency->agency_type ?? '-',
            'condition' => $condition,
            'threshold' =>  number_format($productCommission->threshold,2,'.',',') ?? '-',
            'created_at' => $productCommission->created_at->format('Y-m-d'),
            'updated_at' => $productCommission->updated_at->format('Y-m-d'),
        ];
        $edit = true;
        $delete = false;

        // Return the read view with the necessary data
        return view('voyager::custom-bread.read', compact(
            'edit',
            'delete',
            'pageTitle',
            'icon',
            'columns',
            'data',
            'returnRoute',
            'modelSlug',
            'parentId',
            'baseRoute'
        ));
    }

    public function editProductCommission(Request $request, $id, $sub_id)
    {
        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($id);

        // Fetch the specific profit sharing record using sub_id
        $productCommission = ProductCommission::where('product_id', $product->id)->where('id', $sub_id)->firstOrFail();

        // Page details
        $pageTitle = "Edit Product Commission";
        $icon = 'voyager-briefcase';
        $returnRoute = route('browse.product.commission.config', ['id' => $id]);
        $modelSlug = 'commission-config';
        $parentId = $product->id;
        $parentValue = $product->code;
        $hideViewButton = true;
        $baseRoute = 'admin/product/';

        // Define columns (if you need custom column names for display)
        $columns = [
            'product_code' => 'Product Code',
            'agency_id' => 'Agency Type',
            'condition' => 'Condition',
            'threshold' => 'Threshold',
        ];

        // Prepare data to be passed to the view

        $data = [
            'id' => $productCommission->id,
            'product_code' => $product->code,
            'agency_id' => $productCommission->agency_id,
            'condition' => $productCommission->condition,
            'threshold' => number_format($productCommission->threshold,2,'.',','),
        ];

        $dataTypes = [
            'product_code' => 'parent-disable',
            'agency_id' => 'dropdown',
            'condition' => 'dropdown',
            'threshold' => 'number',
            'created_at' => 'date',
        ];

        // Define dropdown options for specific fields
        $dropdownOptions = [
            'agency_id' => Agency::pluck('agency_type', 'id')->toArray(),
            'condition' => [0 => 'New', 1 => 'New Above', 2 => 'Tier 2'],
        ];

        // Pass the data and columns to the view
        return view('voyager::custom-bread.edit-add', compact(
            'dataTypes',
            'dropdownOptions',
            'pageTitle',
            'icon',
            'returnRoute',
            'modelSlug',
            'parentId',
            'parentValue',
            'baseRoute',
            'productCommission', // Pass the record to the view
            'columns', // Pass the columns to the view
            'data', // Pass the data (record) to the view
            'hideViewButton'
        ));
    }

    public function updateProductCommission(Request $request, $id, $sub_id)
    {

        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($id);

        // Fetch the specific profit sharing record using sub_id
        $productCommission = ProductCommission::where('product_id', $product->id)->where('id', $sub_id)->firstOrFail();

        // Update the record with the new data
        $productCommission->product_id = $product->id;
        $productCommission->agency_id = $request->agency_id;
        $productCommission->condition = $request->condition;
        $productCommission->threshold = $request->threshold;
        // Update other fields as necessary
        $productCommission->save();

        // Redirect back with a success message
        return redirect()->route('browse.product.commission.config', ['id' => $id])
            ->with('success', 'Product Commission updated successfully');
    }

    public function deleteProductCommission(Request $request, $id, $sub_id)
    {
        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($id);

        // Fetch the specific profit sharing record using sub_id
        $productCommission = ProductCommission::where('product_id', $product->id)->where('id', $sub_id)->firstOrFail();

        // Delete the record
        $productCommission->delete();

        // Redirect back with a success message
        return redirect()->route('browse.product.commission.config', ['id' => $id])
            ->with('success', 'Product Commission deleted successfully');
    }

    //****************** END PRODUCT COMMISSION FUNCTION **********************//

    //****************** START PRODUCT COMMISSION AGENT FUNCTION **********************//
    public function browseProductCommissionAgent(Request $request)
    {
        $product = Product::findOrFail($request->id);
        $productCommissionAgent = $product->productCommissionAgent;

        // Define columns
        $columns = [
            "product_code" => "Product Code",
            "agent_role" => "Agent Role",
            "commission" => "Commission (%)",
        ];

        // Prepare data for the table
        $data = $productCommissionAgent->map(function ($agent) use ($product) {

            $agentRole = '-';
            switch ($agent->agent_role ?? null) {
                case 'MGR':
                    $agentRole = 'Manager';
                    break;
                case 'P2P':
                    $agentRole = 'P2P';
                    break;
                case 'SM':
                    $agentRole = 'Senior Manager';
                    break;
                case 'AVP':
                    $agentRole = 'AVP';
                    break;
                case 'VP':
                    $agentRole = 'VP';
                    break;
                case 'SVP':
                    $agentRole = 'SVP';
                    break;
                case 'DIRECT_SVP':
                    $agentRole = 'Direct SVP';
                    break;
                case 'HOS':
                    $agentRole = 'HOS';
                    break;
                case 'CEO':
                    $agentRole = 'CEO';
                    break;
                case 'CCSB':
                    $agentRole = 'CCSB';
                    break;
                case 'CWP':
                    $agentRole = 'CWP';
                    break;
                default:
                    $agentRole = '-';
            }

            return [
                'id' => $agent->id,
                'product_code' => $product->code ?? '-',
                'agent_role' => $agentRole,
                'commission' => $agent->commission ?? '-',
            ];
        });

        // Page details
        $pageTitle = "Agent Commission";
        $icon = 'voyager-person';
        $returnRoute = route('voyager.product.index');
        $modelSlug = 'commission-agent-config';
        $parentId = $product->id;
        $baseRoute = 'admin/product/';

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute'));
    }

    public function createProductCommissionAgent(Request $request)
    {
        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($request->id);

        // Page details
        $pageTitle = "Add Agent Commission";
        $icon = 'voyager-person';
        $returnRoute = route('browse.product.commission.agent.config', ['id' => $product->id]);
        $modelSlug = 'commission-agent-config';
        $parentId = $product->id;
        $parentValue = $product->code;
        $baseRoute = 'admin/product/';
        $hideViewButton = true;

        // Define columns (if you need custom column names for display)
        $columns = [
            'product_id' => 'Product Code',
            'agent_role' => 'Agent Role',
            'commission' => 'Commission (%)',
        ];

        $dataTypes = [
            'product_id' => 'parent-disable',
            'agent_role' => 'dropdown',
            'commission' => 'number',
        ];

        // Define dropdown options for specific fields
        $dropdownOptions = [
            //'MGR', 'P2P', 'SM', 'AVP', 'VP', 'SVP', 'DIRECT_SVP', 'HOS', 'CEO', 'CCSB', 'CWP'
            // make id and display agent role different
            'agent_role' => ['MGR' => 'Manager', 'P2P' => 'P2P', 'SM' => 'Senior Manager', 'AVP' => 'AVP', 'VP' => 'VP', 'SVP' => 'SVP', 'DIRECT_SVP' => 'Direct SVP', 'HOS' => 'HOS', 'CEO' => 'CEO', 'CCSB' => 'CCSB', 'CWP' => 'CWP'],
        ];

        // Pass the data to
        return view('voyager::custom-bread.edit-add', compact(
            'dataTypes',
            'dropdownOptions',
            'pageTitle',
            'columns',
            'icon',
            'returnRoute',
            'modelSlug',
            'parentId',
            'parentValue',
            'baseRoute',
            'hideViewButton'
        ));
    }

    public function storeProductCommissionAgent(Request $request)
    {
        // check agent should be unique for a product

        // Create the new product commission agent record
        $productCommissionAgent = new ProductCommissionAgent();
        $productCommissionAgent->product_id = $request->product_id;
        $productCommissionAgent->agent_role = $request->agent_role;
        $productCommissionAgent->commission = $request->commission;
        $productCommissionAgent->save();

        // Redirect back with a success message
        return redirect()->route('browse.product.commission.agent.config', ['id' => $request->product_id])
            ->with('success', 'Agent Commission created successfully');
    }

    public function viewProductCommissionAgent(Request $request, $id, $sub_id)
    {
        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($id);
        // Fetch the specific commission agent record using sub_id
        $productCommissionAgent = $product->productCommissionAgent->where('id', $sub_id)->firstOrFail();

        // Page details
        $pageTitle = "Agent Commission Details";
        $icon = 'voyager-person';
        $returnRoute = route('browse.product.commission.agent.config', ['id' => $id]);
        $modelSlug = 'commission-agent-config';
        $parentId = $product->id;
        $baseRoute = 'admin/product/';

        $columns = [
            'product_code' => 'Product Code',
            'agent_role' => 'Agent Role',
            'commission' => 'Commission (%)',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];

        $agentRole = '-';
        switch ($productCommissionAgent->agent_role ?? null) {
            case 'MGR':
                $agentRole = 'Manager';
                break;
            case 'P2P':
                $agentRole = 'P2P';
                break;
            case 'SM':
                $agentRole = 'Senior Manager';
                break;
            case 'AVP':
                $agentRole = 'AVP';
                break;
            case 'VP':
                $agentRole = 'VP';
                break;
            case 'SVP':
                $agentRole = 'SVP';
                break;
            case 'DIRECT_SVP':
                $agentRole = 'Direct SVP';
                break;
            case 'HOS':
                $agentRole = 'HOS';
                break;
            case 'CEO':
                $agentRole = 'CEO';
                break;
            case 'CCSB':
                $agentRole = 'CCSB';
                break;
            case 'CWP':
                $agentRole = 'CWP';
                break;
            default:
                $agentRole = '-';
        }

        // Prepare data to be passed to the view
        $data = [
            'id' => $productCommissionAgent->id,
            'product_code' => $product->code ?? '-',
            'agent_role' => $agentRole,
            'commission' => $productCommissionAgent->commission ?? '-',
            'created_at' => $productCommissionAgent->created_at->format('Y-m-d'),
            'updated_at' => $productCommissionAgent->updated_at->format('Y-m-d'),
        ];
        $edit = true;
        $delete = false;

        // Return the read view with the necessary data
        return view('voyager::custom-bread.read', compact(
            'edit',
            'delete',
            'pageTitle',
            'icon',
            'columns',
            'data',
            'returnRoute',
            'modelSlug',
            'parentId',
            'baseRoute'
        ));
    }

    public function editProductCommissionAgent(Request $request, $id, $sub_id)
    {
        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($id);

        // Fetch the specific commission agent record using sub_id
        $productCommissionAgent = $product->productCommissionAgent->where('id', $sub_id)->firstOrFail();

        // Page details
        $pageTitle = "Edit Agent Commission";
        $icon = 'voyager-person';
        $returnRoute = route('browse.product.commission.agent.config', ['id' => $id]);
        $modelSlug = 'commission-agent-config';
        $parentId = $product->id;
        $parentValue = $product->code;
        $baseRoute = 'admin/product/';
        $hideViewButton = true;

        // Define columns (if you need custom column names for display)
        $columns = [
            'product_id' => 'Product Code',
            'agent_role' => 'Agent Role',
            'commission' => 'Commission (%)',
        ];

        // Prepare data to be passed to the view
        $data = [
            'id' => $productCommissionAgent->id,
            'product_id' => $product->code,
            'agent_role' => $productCommissionAgent->agent_role,
            'commission' => $productCommissionAgent->commission,
        ];

        $dataTypes = [
            'product_id' => 'parent-disable',
            'agent_role' => 'dropdown',
            'commission' => 'number',
            'created_at' => 'date',
        ];

        // Define dropdown options for specific fields
        $dropdownOptions = [
            'agent_role' => ['MGR' => 'Manager', 'P2P' => 'P2P', 'SM' => 'Senior Manager', 'AVP' => 'AVP', 'VP' => 'VP', 'SVP' => 'SVP', 'DIRECT_SVP' => 'Direct SVP', 'HOS' => 'HOS', 'CEO' => 'CEO', 'CCSB' => 'CCSB', 'CWP' => 'CWP'],
        ];

        // Pass the data and columns to the view
        return view('voyager::custom-bread.edit-add', compact(
            'dropdownOptions',
            'dataTypes',
            'pageTitle',
            'icon',
            'returnRoute',
            'modelSlug',
            'parentId',
            'parentValue',
            'baseRoute',
            'productCommissionAgent', // Pass the record to the view
            'columns', // Pass the columns to the view
            'data', // Pass the data (record) to the view
            'hideViewButton'
        ));
    }

    public function updateProductCommissionAgent(Request $request, $id, $sub_id)
    {
        // Validate input
        $request->validate([
            'agent_role' => 'required|string',
            'commission' => 'required|numeric',
            // Add other validation rules as necessary
        ]);

        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($id);

        // Fetch the specific commission agent record using sub_id
        $productCommissionAgent = $product->productCommissionAgent->where('id', $sub_id)->firstOrFail();

        // Update the record with the new data
        $productCommissionAgent->agent_role = $request->agent_role;
        $productCommissionAgent->commission = $request->commission;
        // Update other fields as necessary
        $productCommissionAgent->save();

        // Redirect back with a success message
        return redirect()->route('browse.product.commission.agent.config', ['id' => $id])
            ->with('success', 'Agent Commission updated successfully');
    }

    public function deleteProductCommissionAgent(Request $request, $id, $sub_id)
    {
        // Fetch the product based on the provided product ID
        $product = Product::findOrFail($id);

        // Fetch the specific commission agent record using sub_id
        $productCommissionAgent = $product->productCommissionAgent->where('id', $sub_id)->firstOrFail();

        // Delete the record
        $productCommissionAgent->delete();

        // Redirect back with a success message
        return redirect()->route('browse.product.commission.agent.config', ['id' => $id])
            ->with('success', 'Agent Commission deleted successfully');
    }

    //****************** END PRODUCT COMMISSION AGENT FUNCTION **********************//

    //****************** START PRODUCT DIVIDEND HISTORY FUNCTION **********************//
    public function getProductDividendCalculationHistoryQuestion()
    {
        // Get the Metabase site URL from the environment
        $METABASE_SITE_URL = config('app.METABASE_SITE_URL');
        $METABASE_SECRET_KEY = config('app.METABASE_SECRET_KEY');
        $ENV = config('app.env');

        if (strcasecmp($ENV, 'production') === 0) {
            $questionNumber = 107; // Production question number
        } else {
            $questionNumber = 1; // Development question number
        }

        $payload = [
            "resource" => [
                "question" => $questionNumber,
            ],
            "params" => (object) [
            ],
            "exp" => time() + 10 * 60, // 10 minute expiration
        ];
        $token = JWT::encode($payload, $METABASE_SECRET_KEY, 'HS256');
        $iframeUrl = $METABASE_SITE_URL . "/embed/question/" . $token . "#bordered=true&titled=true";
        //return the view metabase-dashboard.blade.php with the iframeUrl value
        $user = auth()->user();
        if ($user && $user->hasPermission('browse_product_dividend_history')) {
            return view('metabase-dashboard', compact('iframeUrl'));
        } else {
            return redirect()->route('welcome');
        }
    }

    public function showDividendChecker(Request $request)
    {
        $showableStatuses = ['PENDING_CHECKER', 'REJECT_CHECKER'];
        $dividendCheckers = ProductDividendHistory::select('csv_file_name', 'dividend_csv_key', 'status_checker', 'created_at','id')
            ->whereIn('status_checker', $showableStatuses)
            ->get();

        $columns = [
            'csv_file_name' => 'Profit Sharing File Name',
            'dividend_csv_key' => 'Profit Sharing File',
            'status_checker' => 'Status',
            'created_at' => 'Created At',
        ];

        $data = $dividendCheckers->map(function ($dividendChecker) {
            return [
                'id' => $dividendChecker->id,
                'csv_file_name' => $dividendChecker->csv_file_name,
                'dividend_csv_key' => $dividendChecker->dividend_csv_key,
                'status_checker' => str_replace('_', ' ', $dividendChecker->status_checker),
                'created_at' => $dividendChecker->created_at->toDateString(), // Format the date if needed
            ];
        });

        $pageTitle = "Profit Sharing Management - Checker";
        $icon = 'voyager-check';
        $returnRoute = route('voyager.dividend-history.index');
        $modelSlug = 'dividend_checker';
        $parentId = null;
        $baseRoute = 'admin';
        $view = false;
        $delete = false;
        $add = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function showDividendApprover(Request $request)
    {
        $showableStatuses = ['PENDING_APPROVER', 'REJECT_APPROVER'];
        $dividendApprovals = ProductDividendHistory::select('csv_file_name','dividend_csv_key', 'status_approver', 'remarks_approver', 'created_at', 'id')
            ->whereIn('status_approver', $showableStatuses)
            ->where('status_checker', 'APPROVE_CHECKER')
            ->get(); // Ensure 'id' is selected

        $columns = [
            'csv_file_name' => 'Profit Sharing File Name',
            'dividend_csv_key' => 'Profit Sharing File',
            'status_approver' => 'Status Approver',
            'created_at' => 'Created At',
        ];

        $data = $dividendApprovals->map(function ($dividendApproval) {
            return [
                'id' => $dividendApproval->id, // Add 'id' to each record
                'csv_file_name' => $dividendApproval->csv_file_name,
                'dividend_csv_key' => $dividendApproval->dividend_csv_key,
                'status_approver' => str_replace('_', ' ', $dividendApproval->status_approver),
                'created_at' => $dividendApproval->created_at->toDateString(), // Format date
            ];
        });

        $pageTitle = "Profit Sharing Management - Approver";
        $icon = 'voyager-star';
        $returnRoute = route('voyager.dividend-history.index');
        $modelSlug = 'dividend_approval';
        $parentId = null; // Adjust if necessary
        $baseRoute = 'admin';
        $view = false;
        $delete = false;
        $add = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editDividendChecker($id)
    {
        // Fetch the dividend checker record by ID
        $dividendChecker = ProductDividendHistory::findOrFail($id);
        $rejectChecker = $dividendChecker->status_checker == 'REJECT_CHECKER';

        // Define the editable columns and their labels
        $columns = [
            'status_checker' => 'Checker Status',
            'remarks_checker' => 'Remark Checker',
        ];

        // Define data types for form inputs
        $dataTypes = [
            'status_checker' => 'dropdown', // Dropdown for status_checker
            'remarks_checker' => 'text', // Text input for remarks_checker
        ];

        // Dropdown options for status_checker
        $dropdownOptions = [
            'status_checker' => [
                //'PENDING_CHECKER' => 'Pending Checker',
                'APPROVE_CHECKER' => 'Approve Checker',
                'REJECT_CHECKER' => 'Reject Checker',
            ],
        ];

        // Prepare the data for the form (fields that will be editable)
        $data = $dividendChecker->only(['id', 'status_checker', 'remarks_checker']);
        if ($rejectChecker) {
            $columns['dividend_csv_key'] = 'Profit Sharing File';
            $dataTypes['dividend_csv_key'] = 'file'; // File input for dividend_csv_key
            $data['dividend_csv_key'] = $dividendChecker->dividend_csv_key;
        }

        // Page details
        $pageTitle = "Edit Profit Sharing Checker";
        $parentId = null;
        $baseRoute = 'admin';
        $modelSlug = 'dividend_checker';
        $view = false;
        $returnRoute = route('dividend_checker.show', ['id' => $dividendChecker->id]);
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

    public function updateDividendChecker(Request $request, $id)
    {
        // Fetch the specific dividend checker record by ID
        $dividendChecker = ProductDividendHistory::findOrFail($id);

        // Create a validator instance
        $validator = \Illuminate\Support\Facades\Validator::make($request->all(), [
            'status_checker' => 'required|in:PENDING_CHECKER,APPROVE_CHECKER,REJECT_CHECKER', // Assuming these are the valid statuses for the checker
            'remarks_checker' => 'nullable|string|max:255',
            'dividend_csv_key' => 'nullable|file|mimes:xlsx', // Assuming the file is an Excel file
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
            $dividendChecker->checked_at = now();

            // Check if the user is authenticated and has an email
            if ($user && isset($user->email)) {
                // Save the authenticated user's email in the checked_by column
                $dividendChecker->checked_by = $user->email;
            }
        }
        // Update the status_checker and remarks_checker columns with validated data
        $dividendChecker->status_checker = $validated['status_checker'];
        $dividendChecker->remarks_checker = $validated['remarks_checker'];

        $dividendChecker->save();

        if ($request->hasFile('dividend_csv_key')) {
            $folderPath = 'dividend-csv/' . now()->format('Y/m/d');
            $dividendChecker->updated_dividend_csv_key = $request->file('dividend_csv_key')->store($folderPath, 's3');;
//            $dividendChecker->csv_file_name = $request->file('dividend_csv_key')->getClientOriginalName();

            // Save the updated dividend checker
            $dividendChecker->save();

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/dividend/update-dividend-excel?id=' . $dividendChecker->id;
            Http::get($fullUrl);
            // Add a 5-second delay (non-blocking)
            sleep(5);
        }

        // Redirect with a success message
        return redirect()->route('dividend_checker.show', ['id' => $dividendChecker->id])->with([
            'message' => 'Profit Sharing Checker updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function editDividendApprover($id)
    {
        // Fetch the dividend approval record by ID
        $dividendApproval = ProductDividendHistory::findOrFail($id);
        $rejectApprover = $dividendApproval->status_approver == 'REJECT_APPROVER';

        // Restrict access if status_checker is not APPROVED
        if ($dividendApproval->status_checker !== 'APPROVE_CHECKER') {
            return redirect()->route('dividend_approval.show')->with([
                'message' => 'Only records with status approved by checker can be edited.',
                'alert-type' => 'error',
            ]);
        }

        // Define the editable columns and their labels (only status_approver and remarks_approver)
        $columns = [
            'status_approver' => 'Approver Status',
            'remarks_approver' => 'Remark Approver',
        ];

        // Define data types for form inputs
        $dataTypes = [
            'status_approver' => 'dropdown', // Dropdown for status_approver
            'remarks_approver' => 'text', // Text input for remarks_approver
        ];

        // Dropdown options for status_approver
        $dropdownOptions = [
            'status_approver' => [
                //'PENDING_APPROVER' => 'Pending Approver',
                'APPROVE_APPROVER' => 'Approve Approver',
                'REJECT_APPROVER' => 'Reject Approver',
            ],
        ];

        // Prepare the data for the form (fields that will be editable)
        $data = $dividendApproval->only(['id', 'status_approver', 'remarks_approver']);
        if ($rejectApprover) {
            $columns['dividend_csv_key'] = 'Profit Sharing File';
            $dataTypes['dividend_csv_key'] = 'file'; // File input for dividend_csv_key
            $data['dividend_csv_key'] = $dividendApproval->dividend_csv_key;
        }

        // Page details
        $pageTitle = "Edit Profit Sharing Approver";
        $parentId = null;
        $baseRoute = 'admin';
        $modelSlug = 'dividend_approval';
        $view = false;
        $returnRoute = route('dividend_approval.show', ['id' => $dividendApproval->id]);
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

    public function updateDividendApprover(Request $request, $id)
    {
        // Fetch the specific dividend approval record by ID
        $dividendApproval = ProductDividendHistory::findOrFail($id);

        // Validate the incoming data
        $validated = $request->validate([
            'status_approver' => 'required|in:PENDING_APPROVER,APPROVE_APPROVER,REJECT_APPROVER', // Assuming these are the valid statuses for approver
            'remarks_approver' => 'nullable|string|max:255',
            'dividend_csv_key' => 'nullable|file|mimes:xlsx', // Assuming the file is an Excel file
        ]);

        // Get the authenticated user
        $user = Auth::user();

        // Check if the status_approver is APPROVE_APPROVER
        if ($validated['status_approver'] == 'APPROVE_APPROVER') {
            // Save the current timestamp in the approved_at column
            $dividendApproval->approved_at = now();

            // Check if the user is authenticated and has an email
            if ($user && isset($user->email)) {
                // Save the authenticated user's email in the approved_by column
                $dividendApproval->approved_by = $user->email;
            }
        }

        // Update the status_approver and remarks_approver columns with validated data
        $dividendApproval->status_approver = $validated['status_approver'];
        $dividendApproval->remarks_approver = $validated['remarks_approver'];

        $dividendApproval->save();

        if ($request->hasFile('dividend_csv_key')) {
            $folderPath = 'dividend-csv/' . now()->format('Y/m/d');
            $dividendApproval->updated_dividend_csv_key = $request->file('dividend_csv_key')->store($folderPath, 's3');;
//            $dividendApproval->csv_file_name = $request->file('dividend_csv_key')->getClientOriginalName();

            // Save the updated dividend approval
            $dividendApproval->save();

            $citadelBackend = config('app.citadel_backend');
            $fullUrl        = $citadelBackend . 'api/backend/cms/dividend/update-dividend-excel?id=' . $dividendApproval->id;
            Http::get($fullUrl);
            // Add a 5-second delay (non-blocking)
            sleep(5);
        }

        // Redirect with a success message
        return redirect()->route('dividend_approval.show', ['id' => $dividendApproval->id])->with([
            'message' => 'Profit Sharing Approver updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectEditDividendChecker($id)
    {
        return redirect()->route('dividend_checker.edit', ['id' => $id])->with([
            'message' => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }

    public function redirectEditDividendApprover($id)
    {
        return redirect()->route('dividend_approval.edit', ['id' => $id])->with([
            'message' => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }
    //****************** END PRODUCT DIVIDEND HISTORY FUNCTION **********************//
}
