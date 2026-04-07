<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Custom\CustomVoyagerBaseController;
use App\Models\BankDetails;
use App\Models\Client;
use App\Models\CorporateBeneficiaries;
use App\Models\CorporateClient;
use App\Models\CorporateGuardian;
use App\Models\IndividualBeneficiaryGuardian;
use App\Models\ProductAgreement;
use App\Models\ProductAgreementPivot;
use App\Models\ProductBeneficiaries;
use App\Models\ProductOrder;
use App\Models\UserDetails;
use App\Models\PepInfo;
use App\Util\Util;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\ProductWithdrawalHistory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use TCG\Voyager\Events\BreadDataUpdated;
use TCG\Voyager\Facades\Voyager;

class ProductOrderController extends CustomVoyagerBaseController
{
    //use BreadRelationshipParser;

    //***************************************
    //               ____
    //              |  _ \
    //              | |_) |
    //              |  _ <
    //              | |_) |
    //              |____/
    //
    //      Browse our Data Type (B)READ
    //
    //****************************************

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

        $searchNames = [];
        if ($dataType->server_side) {
            $searchNames = $dataType->readRows->mapWithKeys(function ($row) {
                return [$row['field'] => $row->getTranslatedAttribute('display_name')];
            });
//            $tableRow = array_keys(CustomSchemaManager::describeTable(app($dataType->model_name)->getTable())->toArray());
//            $browseRow = $dataType->browseRows->where('type', 'relationship')->pluck('field')->toArray();
//            $searchable = array_merge ($tableRow, $browseRow);
//            $dataRow = Voyager::model('DataRow')->whereDataTypeId($dataType->id)->get();
//            foreach ($searchable as $key => $value) {
//                $field = $dataRow->where('field', $value)->first();
//                $displayName = ucwords(str_replace('_', ' ', $value));
//                if ($field !== null) {
//                    $displayName = $field->getAttribute('display_name');
//                }
//                $searchNames[$value] = $displayName;
//            }
        }

        $orderBy         = $request->get('order_by', $dataType->order_column);
        $sortOrder       = $request->get('sort_order', $dataType->order_direction);
        $usesSoftDeletes = false;
        $showSoftDeleted = false;

        // Next Get or Paginate the actual content from the MODEL that corresponds to the slug DataType
        if (strlen($dataType->model_name) != 0) {
            $model = app($dataType->model_name);
            $query = $model::select('*');

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

            // If a column has a relationship associated with it, we do not want to show that field
            $this->removeRelationshipField($dataType, 'browse');

            if ($search->value != '' && $search->key && $search->filter) {
                $search_filter = ($search->filter == 'equals') ? '=' : 'LIKE';
                $search_value  = ($search->filter == 'equals') ? $search->value : '%' . $search->value . '%';
                $relationField = Util::findRelationFieldForControllerQuery($dataType, $search->key, $model);
                if (is_array($relationField)) {
                    if (isset($relationField[2]) && isset($relationField[3])) {
                        $subQuery = $relationField[3]::select('*')->where($relationField[1], $search_filter, $search_value)->pluck('id')->toArray();
                        $query->whereHas($relationField[2], function ($query) use ($relationField, $search_filter, $subQuery) {
                            $query->whereIn($relationField[4], $subQuery);
                        });
                    } else {
                        // Custom search field for custom dynamic field
                        // $relationField[0] : model
                        // $relationField[1] : field
                        $field = $relationField[1];

                        if ($field == 'client_type') {
                            if ($search->value == 'Individual') {
                                $query->whereNotNull('client_id');
                            } elseif ($search->value == 'Corporate') {
                                $query->whereNotNull('corporate_client_id');
                            }
                        }
                        else if ($field == 'purchaser_id') {
                            if (str_ends_with($search->value, '-I')) {
                                $query->whereHas('client', function ($query) use ($search_value) {
                                    $query->where('client_id', '=', $search_value);
                                });
                            } elseif (str_ends_with($search->value, '-C')) {
                                $query->whereHas('corporateClient', function ($query) use ($search_value) {
                                    $query->where('corporate_client_id', '=', $search_value);
                                });
                            }
                        } else if ($field == 'order_type') {
                            $searchValue = $search->value;
                            $isExactMatch = ($search_filter === '=');

                            if (strtoupper($searchValue) === 'NEW') {
                                $query->where('agreement_file_name', 'not like', '%ROLLOVER%')
                                    ->where('agreement_file_name', 'not like', '%REALLOCATE%');
                            } else {
                                if ($isExactMatch) {
                                    $query->where('agreement_file_name', $searchValue);
                                } else {
                                    $query->where('agreement_file_name', 'LIKE', '%' . $searchValue . '%');
                                }
                            }
                        } else if ($field == 'id_number') {
                            // Search for individual client id_number
                            $query->where(function ($q) use ($search_value, $search_filter) {
                                // For Individual Clients
                                $q->where(function ($subQ) use ($search_value, $search_filter) {
                                    $subQ->whereNotNull('client_id')
                                        ->whereHas('client.userDetails', function ($userDetailsQ) use ($search_value, $search_filter) {
                                            $userDetailsQ->where('identity_card_number', $search_filter, $search_value);
                                        });
                                });
                                // For Corporate Clients
                                $q->orWhere(function ($subQ) use ($search_value, $search_filter) {
                                    $subQ->whereNotNull('corporate_client_id')
                                        ->whereHas('corporateClient.corporateDetail', function ($corpDetailQ) use ($search_value, $search_filter) {
                                            $corpDetailQ->where('registration_number', $search_filter, $search_value);
                                        });
                                });
                            });
                        } else {
                            $query->whereHas($relationField[0], function ($query) use ($relationField, $search_filter, $search_value) {
                                $query->where($relationField[1], $search_filter, $search_value);
                            });
                        }
                    }
                } else if ($search->key == 'product_order_hasone_product_order_relationship_3') {
                    // Search for individual client id_number
                    $query->where(function ($q) use ($search_value, $search_filter) {
                        // For Individual Clients
                        $q->where(function ($subQ) use ($search_value, $search_filter) {
                            $subQ->whereNotNull('client_id')
                                ->whereHas('client.userDetails', function ($userDetailsQ) use ($search_value, $search_filter) {
                                    $userDetailsQ->where('identity_card_number', $search_filter, $search_value);
                                });
                        });
                        // For Corporate Clients
                        $q->orWhere(function ($subQ) use ($search_value, $search_filter) {
                            $subQ->whereNotNull('corporate_client_id')
                                ->whereHas('corporateClient.corporateDetail', function ($corpDetailQ) use ($search_value, $search_filter) {
                                    $corpDetailQ->where('registration_number', $search_filter, $search_value);
                                });
                        });
                    });
                }
                else {
                    $query->where($search->key, $search_filter, $search_value);
                }
            }

            if ($orderBy && in_array($orderBy, $dataType->fields())) {
                $querySortOrder  = (! empty($sortOrder)) ? $sortOrder : 'desc';
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

    public function show(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $isSoftDeleted = false;

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
            if ($dataTypeContent->deleted_at) {
                $isSoftDeleted = true;
            }
        } else {
            // If Model doest exist, get data from table name
            $dataTypeContent = DB::table($dataType->name)->where('id', $id)->first();
        }

        // Replace relationships' keys for labels and create READ links if a slug is provided.
        $dataTypeContent = $this->resolveRelations($dataTypeContent, $dataType, true);

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'read');

        // Check permission
        $this->authorize('read', $dataTypeContent);

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        // Eagerload Relations
        $this->eagerLoadRelations($dataTypeContent, $dataType, 'read', $isModelTranslatable);

        $view = 'voyager::bread.read';

        if (view()->exists("voyager::$slug.read")) {
            $view = "voyager::$slug.read";
        }
        if (isset($dataTypeContent->agreement_key) && !isset($dataTypeContent->unsigned_agreement_key)) {
            $citadelBackend = config('app.citadel_backend');
            $fullUrl = $citadelBackend . 'api/backend/cms/unsigned-product-agreement/generate?id=' . $id;
            Http::get($fullUrl);

            // Update the dataTypeContent with the new unsigned_agreement_key
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
                if ($dataTypeContent->deleted_at) {
                    $isSoftDeleted = true;
                }
            } else {
                // If Model doest exist, get data from table name
                $dataTypeContent = DB::table($dataType->name)->where('id', $id)->first();
            }
        }

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable', 'isSoftDeleted'));
    }

    public function update(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Compatibility with Model binding.
        $id = $id instanceof \Illuminate\Database\Eloquent\Model ? $id->{$id->getKeyName()} : $id;

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

        if (!$request->ajax()) {

            // Get fields with images to remove before updating and make a copy of $data
            $to_remove = $dataType->editRows->where('type', 'image')
                ->filter(function ($item, $key) use ($request) {
                    return $request->hasFile($item->field);
                });
            $original_data = clone($data);

            $this->insertUpdateData($request, $slug, $dataType->editRows, $data);

            // Check if physical_signed_agreement_files was changed
            if ($data->physical_signed_agreement_files !== $original_data->physical_signed_agreement_files) {
                $data->physical_signed_agreement_files_updated_at = now();
                $data->physical_signed_agreement_files_updated_by = Auth::user() ? Auth::user()->email : null;
                $data->save();
            }

            // Check if received_physical_signed_agreement_files was changed
            if ($data->received_physical_signed_agreement_files !== $original_data->received_physical_signed_agreement_files) {
                $data->received_physical_signed_agreement_files_updated_at = now();
                $data->received_physical_signed_agreement_files_updated_by = Auth::user() ? Auth::user()->email : null;
                $data->save();
            }

            // Delete Images
            $this->deleteBreadImages($original_data, $to_remove);

            event(new BreadDataUpdated($dataType, $data));

            if (auth()->user()->can('browse', app($dataType->model_name))) {
                // Redirect to show/read view instead of index
                $redirect = redirect()->route("voyager.{$dataType->slug}.show", $id);
            } else {
                $redirect = redirect()->back();
            }

            return $redirect->with([
                'message' => __('voyager::generic.successfully_updated') . " {$dataType->getTranslatedAttribute('display_name_singular')}",
                'alert-type' => 'success',
            ]);
        }
    }

    // View Client Details using custombread.read
    public function viewClientDetails(Request $request, $id)
    {
        // Find the product order by ID
        $productOrder = ProductOrder::findOrFail($id);

        if($productOrder->client_id){
            // Find the client by ID
            $client = Client::findOrFail($productOrder->client_id);
            $userDetails = $client->userDetails ?? null;
        }else{
            $corporateClient = CorporateClient::findOrFail($productOrder->corporate_client_id);
            $client = Client::findOrFail($corporateClient->client_id);
            $userDetails = $client->userDetails ?? null;
        }

        $columns = [
            // Bank Name, Account Number, Account Holder Name, SWIFT Code, Proof of Bank Account
            'client_id'            => 'Client ID',
            'full_name'             => 'Full Name',
            'identity_card_number'        => 'NRIC / Passport No.',
            'dob' => 'Date of Birth',
            'gender' => 'Gender',
            'marital_status' => 'Marital Status',
            'resident_status' => 'Resident Status',
            'nationality' => 'Nationality',
            'address'   => 'Address',
            'email' => 'Email',
            'mobile_number'            => 'Mobile Number',
            'bankruptcy' => 'Bankrupt Status',
            'pep' => 'PEP Status',
            'pep_type' => 'PEP Type',
            'immidiate_family_name' => 'Full Name of Immediate Family',
            'position' => 'Current Position / Designation',
            'organisation' => 'Organisation / Entity',
            'proof_of_address' => 'Proof of Address',
            'pep_document' => 'PEP Supporting Document',
            'document_id' => 'Document ID',
            'selfie' => 'Selfie',
        ];

        // Prepare data for the table
        $pep = PepInfo::where('id', $client->pep_info_id)->first();
        $address = implode(', ', array_filter([
            $userDetails->address, $userDetails->postcode, $userDetails->city, $userDetails->state, $userDetails->country]));
        $mobileNumber = trim(($userDetails->mobile_country_code ?? '') . ($userDetails->mobile_number ?? ''));


        $data = (object) [
            'client_id'            => $client->client_id,
            'full_name'             => $userDetails->name ?? '-',
            'identity_card_number'        => $userDetails->identity_card_number ?? '-',
            'dob' => $userDetails->dob ?? '-',
            'gender' => $userDetails->gender ?? '-',
            'marital_status' => $userDetails->marital_status ?? '-',
            'resident_status' => $userDetails->resident_status ?? '-',
            'nationality' => $userDetails->nationality,
            'address'   => $address ?? '-',
            'email' => $userDetails->email ?? '-',
            'mobile_number' => $mobileNumber ?? '-',
            'bankruptcy' => 'None',
            'pep' => $pep->pep ? 'Yes' : 'No',
            'pep_type' => $pep->pep_type ?? '-',
            'immidiate_family_name' => $pep->pep_immediate_family_name ?? '-',
            'position' => $pep->pep_position ?? '-',
            'organisation' => $pep->pep_organisation ?? '-',
            'proof_of_address' => $userDetails->proof_of_address_file_key ?? '-',
            'pep_document' => $pep->pep_supporting_documents_key ?? '-',
            'document_id' => [
                ['url' => $userDetails->identity_card_front_image_key],
                ['url' => $userDetails->identity_card_back_image_key],
            ],
            'selfie' => $userDetails->selfie_image_key ?? '-',
        ];

        $dataType = [
            'proof_of_address' => 'image',
            'pep_document' => 'image',
            'document_id' => 'list-link',
            'selfie' => 'image',
        ];

        // Page details

        $pageTitle   = "Client Details";
        $icon        = 'voyager-person';
        $returnRoute = route('voyager.product-order.index');
        $modelSlug   = 'product-order';
        $parentId    = $productOrder->id;
        $baseRoute   = 'admin/product-order/';
        $edit        = false;
        $delete      = false;

        return view('voyager::custom-bread.read', compact('columns', 'data', 'pageTitle', 'icon', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'edit', 'delete', 'dataType'));
    }

    // View Corporate Client Details using custombread.read
    public function viewCorporateClientDetails(Request $request, $id)
    {
        // Find the product order by ID
        $productOrder = ProductOrder::findOrFail($id);

        // Find the corporate client by ID
        $corporateClient = CorporateClient::findOrFail($productOrder->corporate_client_id);
        $corporateDetails = $corporateClient->corporateDetail ?? null;
        $userDetails = $corporateClient->userDetails ?? null;

        $columns = [
            'corporate_client_id' => 'Corporate ID',
            'corporate_name' => 'Name',
            'entity_type' => 'Type of Entity',
            'register_number' => 'Registration Number',
            'date_incorporate' => 'Date of Incorporation',
            'place_incorporate' => 'Place of Incorporation',
            'business_type' => 'Business Type',
            'registered_address' =>'Registered Address',
            'business_address' =>'Business Address',
            'contact_name' => 'Contact Name',
            'contact_designation' => 'Contact Designation',
            'mobile_number'=> 'Contact Mobile Number',
            'email' => 'Contact Email',
            'order_id' => 'Order ID',
            'payment_id' => 'Payment ID',
        ];

        // Prepare data for the table
        $data = (object) [
            'corporate_client_id'=> $corporateClient->corporate_client_id ?? '-',
            'corporate_name'=> $corporateDetails->entity_name ?? '-',
            'entity_type'=> ucwords(str_replace('_', ' ', strtolower($corporateDetails->entity_type)))?? '-',
            'register_number'=> $corporateDetails->registration_number ?? '-',
            'date_incorporate'=> \Carbon\Carbon::parse($corporateDetails->date_incorporation)->format('d M Y') ?? '-',
            'place_incorporate'=> $corporateDetails->place_incorporation ?? '-',
            'business_type'=> ucwords(str_replace('_', ' ', strtolower($corporateDetails->business_type))) ?? '-',
            'registered_address'=> $corporateDetails->registered_address.' '.$corporateDetails->postcode.' '.$corporateDetails->city.$corporateDetails->state.' '.$corporateDetails->country ?? '-',
            'business_address'=> $corporateDetails->business_address.' '.$corporateDetails->business_postcode.' '.$corporateDetails->business_city.' '.$corporateDetails->business_state.' '.$corporateDetails->business_country ?? '-',
            'contact_name' => $corporateDetails->contact_name ?? '-',
            'contact_designation' => $corporateDetails->contact_designation ?? '-',
            'mobile_number'=> $corporateDetails->contact_mobile_country_code . $corporateDetails->contact_mobile_number ?? '-',
            'email' => $corporateDetails->contact_email ?? '-',
            'order_id' => $productOrder->order_reference_number ?? '-',
            'payment_id' => $productOrder->payment_id ?? '-',
        ];

        $dataType = [
            'proof_of_bank_account' => 'image',
        ];


        // Page details
        $pageTitle   = "Corporate Details";
        $icon        = 'voyager-person';
        $returnRoute = route('voyager.product-order.index');
        $modelSlug   = 'product-order';
        $parentId    = $productOrder->id;
        $baseRoute   = 'admin/product-order/';
        $edit        = false;
        $delete      = false;

        return view('voyager::custom-bread.read', compact('columns', 'data', 'pageTitle', 'icon', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'edit', 'delete', 'dataType'));


    }

    // Browse Shareholders
    public function browseShareholders(Request $request, $id)
    {
        $productOrder = ProductOrder::findOrFail($id);
        $corporateClient = CorporateClient::with(
            ['corporateDetail',
                'corporateShareholders' => function ($query) {
                    $query->where('corporate_shareholders.is_deleted', false);  // Ensure that shareholders are not deleted
                }
            ])
            ->findOrFail($productOrder->corporate_client_id);

        $data = collect();
        $corporateClient->corporateShareholders->each(function ($shareholder) use (&$data) {
            $pepinfo = $shareholder->pepInfo;
            $isPep = $pepinfo->pep;
            $data->push([
                'id' => $shareholder->id,
                'full_name' => $shareholder->name,
                'pep_info' => $isPep ? 'Yes' : 'No',
                'percentage_of_shares' => $shareholder->percentage_of_shareholdings,
            ]);
        });
        $columns = [
            'full_name' => 'Full Name',
            'pep_info' => 'PEP Info',
            'percentage_of_shares' => 'Percentage of Dist',
        ];

        // Page details
        $pageTitle = "Shareholders";
        $icon = 'voyager-people';
        $returnRoute = route('voyager.product-order.index');
        $modelSlug = 'shareholders';
        $parentId = $productOrder->id;
        $baseRoute = 'admin/product-order/';
        $edit = false;
        $delete = false;
        $add = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'edit', 'delete' , 'add'));
    }

    // View Shareholder
    public function viewShareholder(Request $request, $id, $subId)
    {
        $productOrder = ProductOrder::findOrFail($id);
        $corporateClient = CorporateClient::with(
            ['corporateDetail',
                'corporateShareholders' => function ($query) {
                    $query->where('corporate_shareholders.is_deleted', false);  // Ensure that shareholders are not deleted
                }
            ])
            ->findOrFail($productOrder->corporate_client_id);
        $shareholder = $corporateClient->corporateShareholders->where('id', $subId)->first();
        $pepinfo = $shareholder->pepInfo;
        $isPep = $pepinfo->pep;
        $columns = [
            'full_name' => 'Full Name',
            'nric' => 'NRIC / Passport No.',
            'address' => 'Address',
            'email' => 'Email Address',
            'mobile_number' => 'Mobile Number',
            'pep_status' => 'PEP Status',
            'pep_type' => 'PEP Type',
            'immidiate_family_name' => 'Full Name of Immediate Family',
            'position' => 'Current Position / Designation',
            'organisation' => 'Organisation / Entity',
            'pep_document' => 'PEP Document',
            'document_id' => 'Document ID',
        ];
        $address = implode(', ', array_filter([
            $shareholder->address, $shareholder->postcode, $shareholder->city, $shareholder->state, $shareholder->country]));
        $mobileNumber = trim(($shareholder->mobile_country_code ?? '') . ($shareholder->mobile_number ?? ''));

        $documentLinks = collect([
            $shareholder->identity_card_front_image_key,
            $shareholder->identity_card_back_image_key,
        ])->filter()->map(function ($documentKey) {
            return ['url' => $documentKey];
        })->toArray();

        $data = (object) [
            'full_name' => $shareholder->name,
            'nric' => $shareholder->identity_card_number,
            'address' => $address,
            'email' => $shareholder->email,
            'mobile_number' => $mobileNumber,
            'pep_status' => $isPep ? 'Yes' : 'No',
            'pep_type' => $pepinfo->pep_type ?? '-',
            'immidiate_family_name' => $pepinfo->pep_immediate_family_name ?? '-',
            'position' => $pepinfo->pep_position ?? '-',
            'organisation' => $pepinfo->pep_organisation ?? '-',
            'pep_document' => $pepinfo->pep_supporting_documents_key ?? '-',
            'document_id' => $documentLinks,
        ];
        $dataType = [
            'pep_document' => 'list-link',
            'document_id' => 'list-link',
        ];
        // Page metadata
        $pageTitle = "View Shareholder Details";
        $icon = 'voyager-people';
        $returnRoute = route('product-order.shareholders', ['id' => $productOrder->id]);
        $modelSlug = 'product-order';
        $parentId = $productOrder->id;
        $baseRoute = 'admin/product-order/';
        $edit = false;
        $delete = false;

        return view('voyager::custom-bread.read', compact('columns', 'data', 'pageTitle', 'icon', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'edit', 'delete', 'dataType'));
    }

    public function viewDocument(Request $request, $id)
    {
        // Find the product order by ID
        $productOrder = ProductOrder::with('product')->findOrFail($id);
        $product = $productOrder->product;

        // Step 1: Get product agreement IDs from the pivot table
        $agreementIds = ProductAgreementPivot::where('product_id', $product->id)
            ->pluck('product_agreement_id');

        // Step 2: Determine client type
        $clientType = null;

        if ($productOrder->client_id != null) {
            $clientType = 'INDIVIDUAL';
        } elseif ($productOrder->corporate_client_id != null) {
            $clientType = 'CORPORATE';
        }

        // Step 3: Fetch the correct agreement
        $agreement = null;
        if ($clientType && $agreementIds->isNotEmpty()) {
            $agreement = ProductAgreement::whereIn('id', $agreementIds)
                ->where('client_type', $clientType)
                ->first();
        }

        // Step 4: Handle document editor content
        if ($agreement && $agreement->use_document_editor) {
            return response($agreement->document_editor)
                ->header('Content-Type', 'text/html');
        }

        // Step 5: Handle uploaded document from S3
        $documents = $agreement ? $agreement->upload_document : null;

        if (!empty($documents)) {
            $documents = json_decode($documents, true);

            // Check the structure of $documents
            if (is_array($documents) && isset($documents[0]['download_link'])) {
                $downloadLink = $documents[0]['download_link'];

                // Get the full URL for the file in S3
                $url = Storage::disk('s3')->url($downloadLink);

                // Check if the file exists in S3
                if (Storage::disk('s3')->exists($downloadLink)) {
                    // Read the HTML file from S3
                    try {
                        $htmlContent = file_get_contents($url);
                        return response()->json([
                            'success' => true,
                            'content' => $htmlContent,
                        ]);
                    } catch (\Exception $e) {
                        return response()->json([
                            'success' => false,
                            'message' => 'Error fetching document: ' . $e->getMessage(),
                        ], 500);
                    }
                } else {
                    return response()->json([
                        'success' => false,
                        'message' => 'File does not exist in S3.',
                    ], 404);
                }
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'No valid download link found.',
                ], 404);
            }
        } else {
            return response()->json([
                'success' => false,
                'message' => 'No documents found.',
            ], 404);
        }
    }

    // View Banking Details
    public function viewBankingDetails(Request $request, $id)
    {
        $productOrder = ProductOrder::findOrFail($id);
        $bankDetails  = BankDetails::findOrFail($productOrder->bank_details_id);

        // Define columns
        // $columns = [
        //     // Product Code, Period Type, Period, Condition, Penalty (%)
        //     'product_code' => 'Product Code',
        //     'period_type' => 'Period Type',
        //     'period' => 'Period',
        //     'condition' => 'Condition',
        //     'penalty' => 'Penalty (%)'
        // ];

        // Define columns
        $columns = [
            // Bank Name, Account Number, Account Holder Name, SWIFT Code, Proof of Bank Account
            'bank_name'             => 'Bank Name',
            'account_number'        => 'Account Number',
            'account_holder_name'   => 'Account Holder Name',
            'bank_address'          => 'Address',
            'swift_code'            => 'SWIFT Code',
            'proof_of_bank_account' => 'Proof of Bank Account',
        ];
        // Prepare address by concatenating address fields (bank address, postcode, city, state, country)
        $address = implode(', ', array_filter([
            $bankDetails->bank_address,
            $bankDetails->city,
            $bankDetails->postcode,
            $bankDetails->state,
            $bankDetails->country,
        ]));

        // Prepare data for the table
        $data = (object) [
            'id'                   => $bankDetails->id,
            'bank_name'             => $bankDetails->bank_name,
            'account_number'        => $bankDetails->account_number,
            'account_holder_name'   => $bankDetails->account_holder_name,
            'bank_address'          => $address,
            'swift_code'            => $bankDetails->swift_code,
            'proof_of_bank_account' => $bankDetails->bank_account_proof_key,
        ];

        $dataType = [
            'proof_of_bank_account' => 'image',
        ];


        // Page details
        $pageTitle   = "Banking Details";
        $icon        = 'voyager-dollar';
        $returnRoute = route('voyager.product-order.index');
        $modelSlug   = 'banking-details';
        $parentId    = $productOrder->id;
        $baseRoute   = 'admin/product-order/';
        $edit        = true;
        $delete      = false;

        return view('voyager::custom-bread.read', compact('columns', 'data', 'pageTitle', 'icon', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'edit', 'delete', 'dataType'));
    }

    // Edit Banking Details
    public function editBankingDetails(Request $request, $id)
    {
        $productOrder = ProductOrder::findOrFail($id);
        $bankDetails  = BankDetails::findOrFail($productOrder->bank_details_id);

        // Define columns
        $columns = [
            // Bank Name, Account Number, Account Holder Name, SWIFT Code, Proof of Bank Account
            'bank_name'             => 'Bank Name',
            'account_number'        => 'Account Number',
            'account_holder_name'   => 'Account Holder Name',
            'swift_code'            => 'SWIFT Code',
            'proof_of_bank_account' => 'Proof of Bank Account',
        ];

        // Prepare data for the table
        $data = [
            'id'                    => $bankDetails->id,
            'bank_name'             => $bankDetails->bank_name,
            'account_number'        => $bankDetails->account_number,
            'account_holder_name'   => $bankDetails->account_holder_name,
            'swift_code'            => $bankDetails->swift_code,
            'proof_of_bank_account' => $bankDetails->bank_account_proof_key,
        ];

        $dataTypes = [
            'proof_of_bank_account' => 'file',
        ];

        // Page details
        $pageTitle   = "Banking Details";
        $icon        = 'voyager-dollar';
        $returnRoute = route('voyager.product-order.index', ['id' => $id]);
        $modelSlug   = 'banking-details';
        $parentId    = $productOrder->id;
        $baseRoute   = 'admin/product-order/';
        $edit        = true;
        $delete      = false;
        $hideViewButton = true;

        return view('voyager::custom-bread.edit-add', compact('hideViewButton','columns', 'data', 'pageTitle', 'icon', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'edit', 'delete', 'dataTypes'));
    }

    // Update Banking Details
    public function updateBankingDetails(Request $request, $id)
    {
        $productOrder = ProductOrder::findOrFail($id);
        $bankDetails  = BankDetails::findOrFail($productOrder->bank_details_id);

        // Validate the request
        $request->validate([
            'bank_name'           => 'required|string',
            'account_number'      => 'required|string',
            'account_holder_name' => 'required|string',
            'swift_code'          => 'required|string',
            'proof_of_bank_account' => 'nullable|image',
        ]);

        // Update the bank details
        $bankDetails->update([
            'bank_name'           => $request->bank_name,
            'account_number'      => $request->account_number,
            'account_holder_name' => $request->account_holder_name,
            'swift_code'          => $request->swift_code,
        ]);

        // Update the proof of bank account if provided
        try {
            if ($request->hasFile('proof_of_bank_account')) {
                $bankDetails->bank_account_proof_key = $request->file('proof_of_bank_account')->store('documents', 's3');
                $bankDetails->save();
            }
        } catch (\Exception $e) {
            return back()->with([
                'message'    => 'An error occurred while updating the bank details.',
                'alert-type' => 'error',
            ]);
        }

        // Redirect back to the product order index page
        return redirect()->route('voyager.product-order.index')->with([
            'message'    => 'Product Order Checker updated successfully.',
            'alert-type' => 'success',
        ]);;
    }

    // Browse Beneficiaries

    public function browseBeneficiaries(Request $request)
    {
        // Fetch the product order using the provided ID
        $productOrder = ProductOrder::findOrFail($request->id);

        $productBeneficiaries = ProductBeneficiaries::where('product_order_id', $productOrder->id)->get();
        $data                 = collect();

        $productBeneficiaries->each(function ($productBeneficiary) use (&$data, $productOrder) {
            // Fetch individual beneficiaries if applicable
            if ($productOrder->client_id) {
                $individualBeneficiaries = $productBeneficiary->clientBeneficiary()->get();
                $individualBeneficiaries->each(function ($beneficiary) use (&$data, $productBeneficiary) {
                    $data->push([
                        'id'                      => $beneficiary->id,
                        'full_name'               => $beneficiary->full_name,
                        'guardian_name'           => $beneficiary->guardians->isNotEmpty()
                        ? $beneficiary->guardians->pluck('full_name')->join(', ')
                        : 'None',
                        'relationship_to_settlor' => $beneficiary->relationship_to_settlor,
                        'type'                    => $productBeneficiary->beneficiary_type,
                        'percentage_of_dist'      => $productBeneficiary->percentage,
                    ]);
                });
            } elseif ($productOrder->corporate_client_id) {
                $corporateBeneficiaries = $productBeneficiary->corporateBeneficiary()->get();
                $corporateBeneficiaries->each(function ($beneficiary) use (&$data, $productBeneficiary) {
                    $data->push([
                        'id'                      => $beneficiary->id,
                        'full_name'               => $beneficiary->full_name,
                        'guardian_name'           => $beneficiary->corporateGuardians
                        ? $beneficiary->corporateGuardians->full_name
                        : 'None',
                        'relationship_to_settlor' => $beneficiary->relationship_to_settlor,
                        'type'                    => $productBeneficiary->beneficiary_type,
                        'percentage_of_dist'      => $productBeneficiary->percentage,
                    ]);
                });
            } else {
                $data = [];
            }
        });

        // Define columns for the table
        $columns = [
            'full_name'               => 'Full Name',
            'guardian_name'           => 'Guardian Name',
            'relationship_to_settlor' => 'Relationship to Settlor',
            'type'                    => 'Type',
            'percentage_of_dist'      => 'Percentage of Dist(%)',
        ];

        // Page details
        $pageTitle   = "Beneficiaries";
        $icon        = 'voyager-people';
        $returnRoute = route('voyager.product-order.index', ['id' => $productOrder->id]);
        $modelSlug   = 'beneficiaries';
        $parentId    = $productOrder->id;
        $baseRoute   = 'admin/product-order/';
        $edit        = false;
        $delete      = false;

        // Return the view with the prepared data
        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'edit', 'delete'));
    }

    // View Beneficiary
    public function viewBeneficiary(Request $request, $id, $subId)
    {
        $productOrder       = ProductOrder::findOrFail($id);
        $productBeneficiary = ProductBeneficiaries::where('product_order_id', $productOrder->id)->firstOrFail();

        $beneficiary = null;
        $guardian    = null;
        $pivot       = collect();
        $client      = null;
        $corporate   = null;

        if ($productOrder->client_id) {
            $client      = $productOrder->client;
            $beneficiary = $productBeneficiary->clientBeneficiary()->first();
            $guardian    = $beneficiary->guardians()->first();
            if ($guardian) {
                $pivot = IndividualBeneficiaryGuardian::where([
                    ['individual_beneficiary_id', $beneficiary->id],
                    ['individual_guardian_id', $guardian->id],
                    ['is_deleted', false],
                ])->first() ?? null;
                if (! $pivot) {
                    $guardian = null;
                }
            }
        } elseif ($productOrder->corporate_client_id) {
            $corporate   = CorporateClient::where($productOrder->corproate)->first();
            $beneficiary = CorporateBeneficiaries::findOrFail($subId);
            if ($beneficiary && $beneficiary->company_guardian_id) {
                $guardian = CorporateGuardian::find($beneficiary->company_guardian_id);
            } else {
                $guardian = null;
            }
        }

        $columns = [
            'guardian'                => 'Guardian',
            'relationship_to_settlor' => 'Relationship to Settlor',
            'percentage_of_dist'      => 'Percentage of Distribution',
            'full_name'               => 'Full Name',
            'id_number'               => 'ID Number',
            'dob'                     => 'Date of Birth',
            'gender'                  => 'Gender',
            'marital_status'          => 'Marital Status',
            'residential_status'      => 'Residential Status',
            'nationality'             => 'Nationality',
            'address'                 => 'Address',
            'email'                   => 'Email Address',
            'mobile_number'           => 'Mobile Number',
            'type'                    => 'Type',
            'document_id'             => 'Document ID',
        ];

        $addressBeneficiary = implode(', ', array_filter([
            $beneficiary->address, $beneficiary->postcode, $beneficiary->city, $beneficiary->state, $beneficiary->country]));

        $mobileNumber = trim(($beneficiary->mobile_country_code ?? '') . ' ' . ($beneficiary->mobile_number ?? ''));

        $documentLinks = collect([
            $beneficiary->identity_card_front_image_key,
            $beneficiary->identity_card_back_image_key,
        ])->filter()->map(function ($documentKey) {
            return ['url' => $documentKey];
        })->toArray();

        $data = (object) [
            'guardian'                => $guardian,
            'relationship_to_settlor' => $beneficiary->relationship_to_settlor ?? null,
            'percentage_of_dist'      => $productBeneficiary->percentage ?? null,
            'full_name'               => $beneficiary->full_name ?? null,
            'id_number'               => $beneficiary->identity_card_number ?? null,
            'dob'                     => $beneficiary->dob ?? null,
            'gender'                  => $beneficiary->gender ?? null,
            'marital_status'          => $beneficiary->marital_status ?? null,
            'residential_status'      => $beneficiary->residential_status ?? null,
            'nationality'             => $beneficiary->nationality ?? null,
            'address'                 => $addressBeneficiary,
            'email'                   => $beneficiary->email ?? null,
            'mobile_number'           => $mobileNumber,
            'type'                    => $productBeneficiary->beneficiary_type ?? null,
            'document_id'             => $documentLinks,
            'client'                  => $client,
            'corporate'               => $corporate,
            'beneficiary'             => $beneficiary,
        ];

        $dataType = [
            'document_id' => 'list-link',
        ];

        // Page metadata
        $pageTitle   = "View Beneficiary Details";
        $icon        = 'voyager-people';
        $returnRoute = route('product-order.beneficiaries', ['id' => $productOrder->id]);
        $modelSlug   = 'product-order';
        $parentId    = $productOrder->id;
        $baseRoute   = 'admin/product-order/';
        $edit        = false;
        $delete      = false;

        // Return the view
        return view('voyager::custom-bread.read', compact('columns', 'data', 'pageTitle',
            'icon', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'edit', 'delete', 'guardian', 'client', 'dataType', 'pivot'));
    }

    //******************Checker*********************
    public function showProductOrderChecker(Request $request)
    {
        // Get product orders (replace this with your actual query)
        $showableStatuses = ['PENDING_CHECKER', 'REJECT_CHECKER'];
        $productOrders    = ProductOrder::with(['client', 'product', 'createdBy', 'client.agent'])
            ->whereIn('status_checker', $showableStatuses)
            ->orderBy('created_at', 'asc')
            ->get();

        // Define the columns for the table
        $columns = [
            'order_id'         => 'Order ID',
            'client_id'        => 'Client ID',
            'client_type'      => 'Client Type',
            'client_name'      => 'Client Name',
            'product_name'     => 'Product',
            'purchased_amount' => 'Placement (RM)',
            'agent'            => 'Agent',
            'created_by'       => 'Created By',
            'created_at'       => 'Created Date',
            'status_checker'   => 'Status',
        ];

        // Prepare data with conditional logic
        $data = [];
        foreach ($productOrders as $product) {
            if ($product->client_id || $product->corporate_client_id) {
                // Handle logic for client type
                if ($product->client_id) {
                    $clientType = "Individual";
                    $clientId   = $product->client_id;
                    $clientName = $product->client?->userDetails?->name ?? 'N/A';
                    $agentName = $product->client?->agent?->userDetails?->name ?? 'N/A';
                    // $createdByName = $product->createdBy ? ($product->createdBy->role == 'AGENT' ? $product->client->agent->userDetails->name : $product->client->userDetails->name) : 'N/A';
                    $createdByName = $product->createdBy ? $product->createdBy->user_type : 'N/A';
                } elseif ($product->corporate_client_id) {
                    $clientType = "Corporate";
                    $clientId   = $product->corporateClient->corporate_client_id;
                    $clientName = $product->corporateClient ? $product->corporateClient->userDetails->name : 'N/A';
                    $agentName  = $product->corporateClient->client->agent ? $product->corporateClient->client->agent->userDetails->name : 'N/A';
                    // $createdByName = $product->createdBy ? ($product->createdBy->user_type == 'AGENT' ? $product->corporateClient->agent->userDetails->name : $product->corporateClient->userDetails->name) : 'N/A';
                    $createdByName = $product->createdBy ? $product->createdBy->user_type : 'N/A';
                }

                //filter data when product->client_id || product->corporate_client_id
                $statusChecker = str_replace('_', ' ', $product->status_checker);

                $data[] = (object) [
                    'id'               => $product->id,
                    'order_id'         => $product->order_reference_number,
                    'client_id'        => $clientId,
                    'client_type'      => $clientType,
                    'client_name'      => $clientName,
                    'product_name'     => $product->product->name,
                    'purchased_amount' =>  number_format($product->purchased_amount,2,'.', ','),
                    'agent'            => $agentName,
                    'created_by'       => $createdByName,
                    'status_checker'   => $statusChecker,
                    'created_at'       => $product->created_at,
                ];
            }
        }

        $pageTitle   = "Trust Product Order Management - Checker";
        $icon        = 'voyager-check';
        $returnRoute = route('voyager.product-order.index');
        $modelSlug   = 'product-order-checker';
        $parentId    = null;
        $baseRoute   = 'admin';
        $view        = false;
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editProductOrderChecker($id)
    {
        // Fetch the product order checker record by ID
        $productOrderChecker = ProductOrder::findOrFail($id);

        // if ($productOrderChecker->status_finance !== 'APPROVE_FINANCE') {
        //     return redirect()->route('product_order_checker.show')->with([
        //         'message'    => 'Only records with status approved by finance can be edited.',
        //         'alert-type' => 'error',
        //     ]);
        // }

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
        $data = $productOrderChecker->only(['id', 'status_checker', 'remark_checker']);

        // Page details
        $pageTitle      = "Edit Trust Product Order - Checker";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'product-order-checker';
        $view           = false;
        $returnRoute    = route('product_order_checker.show', ['id' => $productOrderChecker->id]);
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

    public function updateProductOrderChecker(Request $request, $id)
    {
        // Fetch the specific product order checker record by ID
        $productOrder = ProductOrder::findOrFail($id);

        // Validate the incoming data
        $validated = $request->validate([
            'status_checker' => 'required|in:PENDING_CHECKER,APPROVE_CHECKER,REJECT_CHECKER', // Valid statuses for the checker
            'remark_checker' => 'nullable|string|max:255',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        $citadelBackend = config('app.citadel_backend');
        $fullUrl        = $citadelBackend . 'api/backend/cms/product-order/approval?referenceNumber=' . $productOrder->order_reference_number;

        $jsonRequest = [
            "adminEmail"  => $user->email,
            "adminStatus" => $validated['status_checker'],
            "adminRemark" => $validated['remark_checker'],
            "adminType"   => "CHECKER",
        ];
        $response = Http::post($fullUrl, $jsonRequest);

        // Check HTTP response
        if (! $response->successful()) {
            return redirect()->back()->with([
                'message'    => 'Unable to update Product Order Checker Status. Please try again later.',
                'alert-type' => 'error',
            ]);
        }

        // Redirect with a success message
        return redirect()->route('product_order_checker.show', ['id' => $productOrder->id])->with([
            'message'    => 'Product Order Checker updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    //******************Approver*********************
    public function showProductOrderApprover(Request $request)
    {
        // Get product orders with necessary relationships (replace this with your actual query)
        $showableStatuses = ['PENDING_APPROVER', 'REJECT_APPROVER'];
        $productOrders    = ProductOrder::with(['client', 'product', 'createdBy', 'client.agent'])
            ->whereIn('status_approver', $showableStatuses)
            ->where('status_finance', 'APPROVE_FINANCE')
            ->where('status_checker', 'APPROVE_CHECKER')
            ->orderBy('created_at', 'asc')
            ->get();

        // Define the columns for the table
        $columns = [
            'order_id'         => 'Order ID',
            'client_id'        => 'Client ID',
            'client_type'      => 'Client Type',
            'client_name'      => 'Client Name',
            'product_name'     => 'Product',
            'purchased_amount' => 'Placement (RM)',
            'agent'            => 'Agent',
            'created_by'       => 'Created By',
            'created_at'       => 'Created Date',
            'status_approver'  => 'Status',
        ];

        // Prepare data with conditional logic
        $data = [];
        foreach ($productOrders as $product) {
            if ($product->client_id || $product->corporate_client_id) {
                // Handle logic for client type
                if ($product->client_id) {
                    $clientType    = "Individual";
                    $clientId      = $product->client->client_id;
                    $clientName    = $product->client ? $product->client->userDetails->name : 'N/A';
                    $agentName     = $product->client->agent ? $product->client->agent->userDetails->name : 'N/A';
                    $createdByName = $product->createdBy ? $product->createdBy->user_type : 'N/A';
                } elseif ($product->corporate_client_id) {
                    $clientType    = "Corporate";
                    $clientId      = $product->corporateClient->corporate_client_id;
                    $clientName    = $product->corporateClient ? $product->corporateClient->userDetails->name : 'N/A';
                    $agentName     = $product->corporateClient->client->agent ? $product->corporateClient->client->agent->userDetails->name : 'N/A';
                    $createdByName = $product->createdBy ? $product->createdBy->user_type : 'N/A';
                }

                $statusApprover = str_replace('_', ' ', $product->status_approver);
                // Filter data when product->client_id || product->corporate_client_id
                $data[] = (object) [
                    'id'               => $product->id,
                    'order_id'         => $product->order_reference_number,
                    'client_id'        => $clientId,
                    'client_type'      => $clientType,
                    'client_name'      => $clientName,
                    'product_name'     => $product->product->name,
                    'purchased_amount' => number_format($product->purchased_amount,2,'.', ','),
                    'agent'            => $agentName,
                    'created_by'       => $createdByName,
                    'status_approver'  => $statusApprover,
                    'created_at'       => $product->created_at,
                ];

            }
        }

        $pageTitle   = "Trust Product Order Management - Approver ";
        $icon        = 'voyager-check';
        $returnRoute = route('voyager.product-order.index');
        $modelSlug   = 'product-order-approver';
        $parentId    = null;
        $baseRoute   = 'admin';
        $view        = false;
        $delete      = false;
        $add         = false;

        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editProductOrderApprover($id)
    {
        // Fetch the specific product order record
        $productOrder = ProductOrder::findOrFail($id);

        if ($productOrder->status_checker !== 'APPROVE_CHECKER' || $productOrder->status_finance !== 'APPROVE_FINANCE') {
            return redirect()->route('product_order_approver.show')->with([
                'message'    => 'Only records with status approved by checker and finance can be edited.',
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

                                                                                   // Prepare data for the form
        $data = $productOrder->only(['id', 'status_approver', 'remark_approver']); // Fetch only required fields

        // Page details
        $pageTitle      = "Edit Product Order Approver";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'product-order-approver';
        $returnRoute    = route('product_order_approver.show');
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

    public function updateProductOrderApprover(Request $request, $id)
    {
        // Fetch the specific product order record
        $productOrder = ProductOrder::findOrFail($id);

        // Validate input
        $validated = $request->validate([
            'status_approver' => 'required|in:PENDING_APPROVER,APPROVE_APPROVER,REJECT_APPROVER',
            'remark_approver' => 'nullable|string|max:255',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        // Update fields
        //$productOrder->status_approver     = $validated['status_approver'];
        //$productOrder->remark_approver     = $validated['remark_approver'];
        //$productOrder->approved_by         = $user->email;
        //$productOrder->approver_updated_at = now();

        $citadelBackend = config('app.citadel_backend');
        $fullUrl        = $citadelBackend . 'api/backend/cms/product-order/approval?referenceNumber=' . $productOrder->order_reference_number;

        $jsonRequest = [
            "adminEmail"  => $user->email,
            "adminStatus" => $validated['status_approver'],
            "adminRemark" => $validated['remark_approver'],
            "adminType"   => "APPROVER",
        ];
        $response = Http::post($fullUrl, $jsonRequest);

        // Check HTTP response
        if (! $response->successful()) {
            return redirect()->back()->with([
                'message'    => 'Unable to update Product Order Approver Status. Please try again later.',
                'alert-type' => 'error',
            ]);
        }

        return redirect()->route('product_order_approver.show')->with([
            'message'    => 'Product Order Approver updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    //******************Finance*********************
    public function showProductOrderFinance(Request $request)
    {
        // Get product orders with necessary relationships (adjust this query based on your needs)
        $showableStatuses = ['PENDING_FINANCE', 'REJECT_FINANCE'];
        $productOrders    = ProductOrder::with(['client', 'product', 'createdBy', 'client.agent'])
            ->whereIn('status_finance', $showableStatuses)
            ->where('status_checker', 'APPROVE_CHECKER')
            ->orderBy('created_at', 'asc')
            ->get();

        $columns = [
            'order_id'         => 'Order ID',
            'client_id'        => 'Client ID',
            'client_type'      => 'Client Type',
            'client_name'      => 'Client Name',
            'product_name'     => 'Product',
            'purchased_amount' => 'Placement (RM)',
            'agent'            => 'Agent',
            'created_by'       => 'Created By',
            'created_at'       => 'Created Date',
            'status_finance'   => 'Status',
        ];

        // Prepare data with conditional logic
        $data = [];
        foreach ($productOrders as $product) {
            if ($product->client_id || $product->corporate_client_id) {
                // Handle logic for client type
                if ($product->client_id) {
                    $clientType    = "Individual";
                    $clientId = $product->client ? $product->client->client_id : 'N/A';
                    $clientName    = $product->client ? $product->client->userDetails->name : 'N/A';
                    $agentName = $product->client->agent->userDetails->name ?? 'N/A';
                    $createdByName = $product->createdBy ? $product->createdBy->user_type : 'N/A';
                } elseif ($product->corporate_client_id) {
                    $clientType    = "Corporate";
                    $clientId      = $product->corporateClient->corporate_client_id;
                    $clientName    = $product->corporateClient ? $product->corporateClient->userDetails->name : 'N/A';
                    $agentName     = $product->corporateClient->client->agent ? $product->corporateClient->client->agent->userDetails->name : 'N/A';
                    $createdByName = $product->createdBy ? $product->createdBy->user_type : 'N/A';
                }

                $statusFinance = str_replace('_', ' ', $product->status_finance);

                $data[] = (object) [
                    'id'               => $product->id,
                    'order_id'         => $product->order_reference_number,
                    'client_id'        => $clientId,
                    'client_type'      => $clientType,
                    'client_name'      => $clientName,
                    'product_name'     => $product->product->name,
                    'purchased_amount' => number_format($product->purchased_amount,2,'.', ','),
                    'agent'            => $agentName,
                    'created_by'       => $createdByName,
                    'status_finance'   => $statusFinance,
                    'created_at'       => $product->created_at,
                ];
            }
        }

        // Variables for the page
        $pageTitle   = "Trust Product Order Management - Finance ";
        $icon        = 'voyager-dollar';
        $returnRoute = route('voyager.product-order.index');
        $modelSlug   = 'product-order-finance';
        $parentId    = null;
        $baseRoute   = 'admin';
        $view        = false;
        $delete      = false;
        $add         = false;

        // Return the view with the necessary data
        return view('voyager::custom-bread.browse', compact('pageTitle', 'icon', 'columns', 'data', 'returnRoute', 'modelSlug', 'parentId', 'baseRoute', 'view', 'delete', 'add'));
    }

    public function editProductOrderFinance($id)
    {
        // Fetch the specific product order record
        $productOrder = ProductOrder::findOrFail($id);

        if ($productOrder->status_checker !== 'APPROVE_CHECKER') {
             return redirect()->route('product-order-finance.show')->with([
                 'message'    => 'Only records with status approved by checker can be edited.',
                 'alert-type' => 'error',
             ]);
         }
        // Define columns and their labels (only status and remark are editable)
        $columns = [
            'status_finance' => 'Status',
            'remark_finance' => 'Remark',
        ];

        // Define data types for form inputs
        $dataTypes = [
            'status_finance' => 'dropdown',
            'remark_finance' => 'text',
        ];

        // Dropdown options for status_approver
        $dropdownOptions = [
            'status_finance' => [
                'APPROVE_FINANCE' => 'Approve',
                'REJECT_FINANCE'  => 'Reject',
            ],
        ];

        // Prepare data for the form
        $data = $productOrder->only(['id', 'status_finance', 'remark_finance']); // Fetch only required fields

        // Page details
        $pageTitle      = "Edit Product Order Finance";
        $parentId       = null;
        $baseRoute      = 'admin';
        $modelSlug      = 'product-order-finance';
        $returnRoute    = route('product_order_finance.show');
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

    public function updateProductOrderFinance(Request $request, $id)
    {
        // Fetch the specific product order record
        $productOrder = ProductOrder::findOrFail($id);

        // Validate input
        $validated = $request->validate([
            'status_finance' => 'required|in:PENDING_FINANCE,APPROVE_FINANCE,REJECT_FINANCE',
            'remark_finance' => 'nullable|string|max:255',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        // Update fields
        //$productOrder->status_finance     = $validated['status_finance'];
        //$productOrder->remark_finance     = $validated['remark_finance'];
        //$productOrder->financed_by        = $user->email;
        //$productOrder->finance_updated_at = now();

        $citadelBackend = config('app.citadel_backend');
        $fullUrl        = $citadelBackend . 'api/backend/cms/product-order/approval?referenceNumber=' . $productOrder->order_reference_number;

        //$productOrder->save();

        $jsonRequest = [
            "adminEmail"  => $user->email,
            "adminStatus" => $validated['status_finance'],
            "adminRemark" => $validated['remark_finance'],
            "adminType"   => "FINANCE",
        ];
        $response = Http::post($fullUrl, $jsonRequest);

        // Check HTTP response
        if (! $response->successful()) {
            return redirect()->back()->with([
                'message'    => 'Unable to update Product Order Finace status. Please try again later.',
                'alert-type' => 'error',
            ]);
        }

        return redirect()->route('product_order_finance.show')->with([
            'message'    => 'Product Order Finance Status updated successfully.',
            'alert-type' => 'success',
        ]);
    }

    public function redirectToEditProductOrderFinance($id)
    {
        return redirect()->route('product_order_finance.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }

    public function redirectEditProductOrderChecker($id)
    {
        return redirect()->route('product_order_checker.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }

    public function redirectEditProductOrderApprover($id)
    {
        return redirect()->route('product_order_approver.edit', ['id' => $id])->with([
            'message'    => 'Access denied. You do not have the required permissions to view this page.',
            'alert-type' => 'error',
        ]);
    }
}
