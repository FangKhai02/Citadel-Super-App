<?php

namespace App\Http\Controllers;

use App\Models\Agency;
use App\Models\BankDetails;
use App\Util\Util;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use TCG\Voyager\Events\BreadDataAdded;
use TCG\Voyager\Facades\Voyager;
use App\Http\Controllers\Custom\CustomVoyagerBaseController;
use Illuminate\Support\Facades\Redis;

class AgencyController extends CustomVoyagerBaseController
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
                $search_value = ($search->filter == 'equals') ? $search->value : '%'.$search->value.'%';
                $relationField = Util::findRelationFieldForControllerQuery($dataType, $search->key, $model);

                if (is_array($relationField)) {
                    // Since there are only two elements (0: relation name, 1: filter column)
                    $query->whereHas($relationField[0], function ($query) use ($relationField, $search_filter, $search_value) {
                        $query->where($relationField[1], $search_filter, $search_value);
                    });
                } else {
                    // If it's not an array, fall back to a basic where query
                    $query->where($search->key, $search_filter, $search_value);
                }


//                if ($search->key === 'status') {
//
//                    if (stripos($search->value, 'active') !== false) {
//
//                        // Map "active" to 1
//                        $search_value = 1;
//                    } elseif (stripos($search->value, 'inactive') !== false) {
//
//                        // Map "inactive" to 0
//                        $search_value = 0;
//                    }
//                }

//                if ($row = $this->findSearchableRelationshipRow($dataType->rows->where('type', 'relationship'), $search->key)) {
//                    $query->whereRelation($row->relation, $row->field, $search_filter, $search_value);
//                } else {
//                    if ($searchField === "agency.agency_hasone_agency_relationship") {
//                        $query->withCount('agents')
//                            ->having('agents_count', '=', $search_value);
//                    }
//                    else if ($searchField === "client.client_belongsto_agent_relationship") {
//                        $query->whereHas('agent.userDetails', function ($query) use ($search_value) {
//                            $query->where('name', 'LIKE', "%{$search_value}%");
//                        });
//                    }
//                    else if ($dataType->browseRows->pluck('field')->contains($search->key)) {
//                        $query->where($searchField, $search_filter, $search_value);
//                    }
//                }
            }

            $row = $dataType->rows->where('field', $orderBy)->firstWhere('type', 'relationship');
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
            $searchNames = collect($searchNames)->filter(function ($value, $key) {
                // Exclude 'agency_hasone_agency_relationship' (No. of Agents) and 'status'
                return !in_array($key, ['agency_hasone_agency_relationship', 'status']);
            })->toArray();
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

    public function store(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('add', app($dataType->model_name));

        // Validate fields with ajax
        $val = $this->validateBread($request->all(), $dataType->addRows)->validate();

        // Generate the Agency Digital ID
        $agencyCode = trim($request->input('agency_code'));
        $companyRegistrationNumber = $request->input('agency_reg_number');

        // Extract the last 6 digits of the company registration number
        $regNum = preg_replace('/[^0-9]/', '', $companyRegistrationNumber); // Remove all non-numeric characters
        $regNum = str_pad(substr($regNum, -6), 6, '0', STR_PAD_LEFT); // Ensure at least 6 digits

        // Generate the running number
        $runningNumber = $this->generateRunningNumber();

        // Combine into the final agency code
        $newAgencyId = $agencyCode . $regNum . $runningNumber;

        $request->merge(['agency_id' => $newAgencyId]); // Add the generated code to the request data

        $data = $this->insertUpdateData($request, $slug, $dataType->addRows, new Agency());
        // Manually update the agency_code
        $data->agency_id = $newAgencyId;
        $data->save();

        event(new BreadDataAdded($dataType, $data));

        if (!$request->has('_tagging')) {
            if (auth()->user()->can('browse', $data)) {
                $redirect = redirect()->route("voyager.{$dataType->slug}.index");
            } else {
                $redirect = redirect()->back();
            }

            return $redirect->with([
                'message' => __('voyager::generic.successfully_added_new') . " {$dataType->getTranslatedAttribute('display_name_singular')}",
                'alert-type' => 'success',
            ]);
        } else {
            return response()->json(['success' => true, 'data' => $data]);
        }
    }

    function generateRunningNumber()
    {

        // Redis key to store the running number
        $redisKey = 'citadel/digital-id/running-number/agency';

        // Check if the key exists, if not, initialize it with 0
        if (!Redis::exists($redisKey)) {
            Redis::set($redisKey, 0);
        }

        // Increment the running number
        $runningNumber = Redis::incr($redisKey);

        // If running number exceeds 9999, reset it back to 0
        if ($runningNumber > 9999) {
            Redis::set($redisKey, 0);
            $runningNumber = Redis::incr($redisKey); // Increment to make it 1 again
        }

        // Pad the running number to 4 characters with leading zeros
        return str_pad($runningNumber, 4, '0', STR_PAD_LEFT);
    }


    /********************* View/Browse Banking Details ***********************/
    public function viewBankingDetails($agency_id)
    {
        // Find the agency by ID to ensure the agency exists
        $agency = Agency::findOrFail($agency_id);

        // Find the specific bank detail by ID
        $bankDetails = BankDetails::where('agency_id', $agency_id)
            ->where('is_deleted', 0) // Add this condition to filter out deleted records
            ->first();

        $error = is_null($bankDetails) ? 'Bank details not found for the specified agency.' : null;

        // Return a view with the bank detail information
        return view('voyager::agency.read-agency-banking-details', compact('agency', 'bankDetails', 'error'));
    }

    /********************* Create Banking Details ***********************/
    public function createBankingDetails($agency_id)
    {
        // Find the agency by ID to ensure the agency exists
        $agency = Agency::findOrFail($agency_id);

        // Return a view to create a new bank detail for the agency
        return view('voyager::agency.edit-add-agency-banking-details', compact('agency'));
    }

    public function storeBankingDetails(Request $request, $agency_id)
    {
        try {
            // Find the Agency by ID to ensure the agency exists
            $agency = Agency::findOrFail($agency_id);

            // Create a new bank detail with request data
            $bankDetails = new BankDetails($request->except(['_token', '_method'])); // Exclude token and method fields

            // Associate the bank detail with the Agency
            $bankDetails->agency_id = $agency->id;

            if ($request->hasFile('bank_account_proof_key')) {
                $bankDetails->bank_account_proof_key = $request->file('bank_account_proof_key')->store('documents', 's3');
            }

            // Save the bank detail
            $bankDetails->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Agency banking details created successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.agency.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to create Agency banking details.')));
        }
    }

    /********************* Edit Banking Details ***********************/
    public function editBankingDetails($agency_id, $id)
    {
        // Find the agency by ID to ensure the agency exists
        $agency = Agency::findOrFail($agency_id);

        // Find the specific bank detail by ID
        $bankDetails = BankDetails::where('id', $id)
            ->where('agency_id', $agency->id)
            ->firstOrFail();

        // Return a view with the bank detail information for editing
        return view('voyager::agency.edit-add-agency-banking-details', compact('agency', 'bankDetails'));
    }

    public function updateBankingDetails(Request $request, $agency_id, $id)
    {
        try {
            // Find the agency by ID to ensure the agency exists
            $agency = Agency::findOrFail($agency_id);

            // Find the specific bank detail by ID
            $bankDetails = BankDetails::where('id', $id)
                ->where('agency_id', $agency->id)
                ->firstOrFail();

            // Update bank details with request data
            $bankDetails->update($request->except(['_token', '_method'])); // Exclude token and method fields
            // add s3 upload for bank_account_proof_key
            if ($request->hasFile('bank_account_proof_key')) {
                $bankDetails->bank_account_proof_key = $request->file('bank_account_proof_key')->store('documents', 's3');
                $bankDetails->save(); // Save the file path to the database explicitly
            }
            // Prepare success message
            $data = $this->alertSuccess(__('Agency banking details updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.agency.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to update agency banking details.')));
        }
    }

    /********************* Delete Banking Details ***********************/
    public function deleteBankingDetails($agency_id, $id)
    {
        try {
            // Find the agency by ID to ensure the agency exists
            $agency = Agency::findOrFail($agency_id);

            // Find the specific bank detail by ID
            $bankDetails = BankDetails::where('id', $id)
                ->where('agency_id', $agency->id)
                ->firstOrFail();

            // Delete the bank detail
            $bankDetails->delete();

            // Prepare success message
            $data = $this->alertSuccess(__('Agency banking details deleted successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.agency.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to delete agency banking details.')));
        }
    }

}
