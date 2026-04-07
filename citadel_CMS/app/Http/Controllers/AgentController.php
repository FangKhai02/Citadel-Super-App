<?php
namespace App\Http\Controllers;

use App\Models\Agency;
use App\Models\Agent;
use App\Models\AgentRoleSettings;
use App\Models\UserDetails;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use TCG\Voyager\Facades\Voyager;

class AgentController extends VoyagerBaseController
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

            // If a column has a relationship associated with it, we do not want to show that field
            $this->removeRelationshipField($dataType, 'browse');

            if ($search->value != '' && $search->key && $search->filter) {
                $search_filter = ($search->filter == 'equals') ? '=' : 'LIKE';
                $search_value  = ($search->filter == 'equals') ? $search->value : '%' . $search->value . '%';
                $searchField   = $dataType->name . '.' . $search->key;
                if ($row = $this->findSearchableRelationshipRow($dataType->rows->where('type', 'relationship'), $search->key)) {
                    if (isset($row->custom) && $row->custom && $row->field === 'full_mobile_number') {
                        $query->whereHas('userDetails', function ($query) use ($search_value) {
                            $query->where(function ($query) use ($search_value) {
                                $query->where('mobile_country_code', 'LIKE', "%{$search_value}%")
                                    ->orWhere('mobile_number', 'LIKE', "%{$search_value}%")
                                    ->orWhereRaw("CONCAT(mobile_country_code, ' ', mobile_number) LIKE ?", ["%{$search_value}%"]);
                            });
                        });
                    } elseif ($row->field === 'recruiter_name') {
                        $query->whereHas('recruitManager.userDetails', function ($query) use ($search_value) {
                            $query->where('name', 'LIKE', "%{$search_value}%");
                        });
                    } elseif ($row->field === 'role_display_name') {
                        $query->whereHas('role', function ($query) use ($search_value) {
                            $query->where('role_code', 'LIKE', "%{$search_value}%");
                        });
                    } elseif ($row->field === 'identity_card_number') {
                        $query->whereHas('userDetails', function ($query) use ($search_value) {
                            $query->where('identity_card_number', 'LIKE', "%{$search_value}%");
                        });
                    } else {
                        $query->whereRelation($row->relation, $row->field, $search_filter, $search_value);
                    }
                } else {
                    if ($dataType->browseRows->pluck('field')->contains($search->key)) {
                        $query->where($searchField, $search_filter, $search_value);
                    }
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
            $searchNames = $dataType->browseRows->mapWithKeys(function ($row) {
                return [$row['field'] => $row->getTranslatedAttribute('display_name')];
            })->toArray();

            // Add "id_number" at the beginning of the array
            $searchNames = ['agent_belongsto_user_detail_relationship_3' => 'ID Number'] + $searchNames;
        }

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($model);

        // Eagerload Relations
        $this->eagerLoadRelations($dataTypeContent, $dataType, 'browse', $isModelTranslatable);

        // Check if server side pagination is enabled
        $isServerSide = isset($dataType->server_side) && $dataType->server_side;

        // Check if a default search key is set
        $defaultSearchKey = 'agent_belongsto_user_detail_relationship';

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

    protected function findSearchableRelationshipRow($relationshipRows, $searchKey)
    {
        if ($searchKey === 'agent_belongsto_user_detail_relationship_3') {
            return (object) [
                'relation' => null,
                'field'    => 'identity_card_number',
                'custom'   => true,
            ];
        }

        // Check if the search key is 'full_mobile_number'
        if ($searchKey === 'agent_belongsto_user_detail_relationship_2') {
            return (object) [
                'relation' => null,
                'field'    => 'full_mobile_number',
                'custom'   => true,
            ];
        }
        if ($searchKey === 'agent_belongsto_user_detail_relationship_9') {
            return (object) [
                'relation' => null,
                'field'    => 'recruiter_name',
                'custom'   => true,
            ];
        }
        if ($searchKey === 'agent_belongsto_agent_role_setting_relationship_1') {
            return (object) [
                'relation' => null,
                'field'    => 'role_display_name',
                'custom'   => true,
            ];
        }

        $row = $relationshipRows->filter(function ($item) use ($searchKey) {
            if ($item->field != $searchKey) {
                return false;
            }
            if ($item->details->type != 'belongsTo') {
                return false;
            }

            return ! $this->relationIsUsingAccessorAsLabel($item->details);
        })->first();

        if (! $row) {
            return null;
        }

        $relation = $row->details->relation ?? \Str::camel(class_basename(app($row->details->model)));

        return (object) ['relation' => $relation, 'field' => $row->details->label];
    }

    public function show(Request $request, $id)
    {
        $slug = $this->getSlug($request);
        // Find the agent by ID
        $agent = Agent::with(['recruitManager.userDetails', 'agency', 'bankDetails', 'role'])->find($id);

        // Find the user details associated with the agent
        $userDetails = UserDetails::where('id', $agent->user_detail_id)->first();

        // Find the agency details associated with the agent
        $agency = Agency::where('id', $agent->agency_id)->first();

        // Find the recruit manager associated with the agent
        $recruitManager = $agent->recruitManager ? $agent->recruitManager->userDetails : null;

        // Find the bank details associated with the agent
        $bankDetails = $agent->bankDetails;

        $view = 'voyager::bread.read';

        if (view()->exists("voyager::$slug.read")) {
            $view = "voyager::$slug.read";
        }

        // Return return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable', 'isSoftDeleted'));
        return Voyager::view($view, compact('agent', 'userDetails', 'agency', 'recruitManager', 'bankDetails'));
    }

    public function editAgentIdentity($id)
    {
        $agent       = Agent::find($id);
        $roles       = AgentRoleSettings::all();
        $userDetails = UserDetails::where('id', $agent->user_detail_id)->first();
        return view('voyager::agent.edit-agent-identity', compact('userDetails', 'agent', 'roles'));
    }

    public function updateAgentIdentity(Request $request, $id)
    {
        try {
            // Find the agent by ID
            $agent = Agent::findOrFail($id);

            // Validate the incoming role data
            $request->validate([
                'agent_role_id' => 'required|exists:agent_role_settings,id', // Ensure the selected role exists in the DB
            ]);

            // Update the agent's role
            $agent->agent_role_id = $request->input('agent_role_id');

            //Update agent status
            $agent->status = $request->input('status');

            // Find the user details associated with the agent
            $userDetails = UserDetails::findOrFail($agent->user_detail_id);

                                                                         // Update user details with request data
            $userDetails->fill($request->except(['_token', '_method'])); // Exclude token and method fields

            if ($request->hasFile('selfie_image_key')) {
                $userDetails->selfie_image_key = $request->file('selfie_image_key')->store('documents', 's3');
            }

            if ($request->hasFile('proof_of_address_file_key')) {
                $userDetails->proof_of_address_file_key = $request->file('proof_of_address_file_key')->store('documents', 's3');
            }

            // Save user details to update the database
            $userDetails->updated_by = Auth::user()->email;
            $userDetails->save();

            // Update agent updated_at field
            $agent->updated_by = Auth::user()->email;
            $agent->touch();
            $agent->save();

            // Prepare success message
            return redirect()->route('voyager.agent.index')->with(
                $this->alertSuccess(__('Agent identity updated successfully.'))
            );
        } catch (ModelNotFoundException $e) {
            return back()->with($this->alertError(__('Agent or user details not found.')));
        } catch (QueryException $e) {
            return back()->with($this->alertError(__('Failed to update agent identity due to a database error.')));
        } catch (Exception $e) {
            return back()->with($this->alertError(__('Failed to update agent identity.')));
        }
    }

    public function editAgencyDetails($id)
    {
        // Find the agent by ID
        $agent = Agent::findOrFail($id);

        $userDetails = UserDetails::where('app_user_id', $agent->user_detail_id)->first();

                                   // Fetch agencies for the dropdown
        $agencies = Agency::all(); // Get all agencies

                                                              // Fetch agents for the Recruit Manager dropdown
        $recruitManagers = Agent::with('userDetails')->get(); // Get all agents with user details

        // Define the roles for the dropdown
        $roles = [
            'mgr'        => 'Manager',
            'p2p'        => 'Peer to Peer',
            'sm'         => 'Sales Manager',
            'avp'        => 'Assistant Vice President',
            'vp'         => 'Vice President',
            'svp'        => 'Senior Vice President',
            'direct_svp' => 'Director Senior Vice President',
            'hos'        => 'Head of Service',
            'ceo'        => 'Chief Executive Officer',
            'ccsb'       => 'Chief Customer Service Boss',
            'cwp'        => 'Chief Workforce Planner',
        ];

        return view('voyager::agent.edit-agency-details', compact('agent', 'userDetails', 'agencies', 'recruitManagers', 'roles'));
    }

    public function updateAgencyDetails(Request $request, $id)
    {
        try {
            // Find the agent by ID
            $agent = Agent::findOrFail($id);

                                                       // Prepare the status value based on the checkbox state
            $status = $request->has('status') ? 1 : 0; // Set to 1 if checked, 0 if not

            // Update the agent's status
            $agent->update(['status' => $status]);

            // Update agent updated_at field
            $agent->updated_by = Auth::user()->email;
            $agent->touch();
            $agent->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Agent agency details updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.agent.index')->with($data);
        } catch (Exception $e) {
                                           // Prepare error message in case of exception
            \Log::error($e->getMessage()); // Log the error for debugging
            return back()->with($this->alertError(__('Failed to update agent agency details.')));
        }
    }

    public function viewBankingDetails($id)
    {
        // Find the agent by ID
        $agent = Agent::findOrFail($id);

                                            // Retrieve banking details (assuming there is a relation defined)
        $bankDetails = $agent->bankDetails; // Adjust this based on your relationships

        return view('voyager::agent.view-banking-details', compact('agent', 'bankDetails'));
    }

    public function editBankingDetails($id)
    {
        // Find the agent by ID
        $agent = Agent::findOrFail($id);

                                               // Retrieve banking details (assuming there is a relation defined)
        $bankingDetails = $agent->bankDetails; // Adjust this based on your relationships

        return view('voyager::agent.edit-banking-details', compact('agent', 'bankingDetails'));
    }

    public function updateBankingDetails(Request $request, $id)
    {
        try {
            // Find the agent by ID
            $agent = Agent::findOrFail($id);
            // Validate the incoming request
            $request->validate([
                'bank_name'           => 'required|string',
                'account_number'      => 'required|string',
                'account_holder_name' => 'required|string',
                'permanent_address'   => 'nullable|string',
                'postcode'            => 'nullable|string',
                'city'                => 'nullable|string',
                'state'               => 'nullable|string',
                'country'             => 'nullable|string',
                'swift_code'          => 'nullable|string',

            ]);

            if ($request->hasFile('bank_account_proof_key')) {
                $agent->bankDetails->bank_account_proof_key = $request->file('bank_account_proof_key')->store('documents', 's3');
                $agent->bankDetails->save(); // Save the file path to the database explicitly
            }

            // Update the agent's banking details
            $agent->bankDetails()->update($request->only([
                'bank_name',
                'account_number',
                'account_holder_name',
                'permanent_address',
                'postcode',
                'city',
                'state',
                'country',
                'swift_code',
            ]));

            // Update agent updated_at field
            $agent->updated_by = Auth::user()->email;
            $agent->touch();
            $agent->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Banking details updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.agent.index')->with($data);
        } catch (\Exception $e) {
            // Log the error (optional)
            \Log::error($e->getMessage());

            // Prepare error message
            $data = $this->alertError(__('Failed to update banking details. Please try again.'));

            // Redirect back with error message
            return redirect()->back()->with($data);
        }
    }

    /*********Agent Downline Management********/
    public function buildAgentDownline($agent)
    {
        $row = [
            'agent'           => $agent->userDetails->name,
            'role'            => $agent->role->role_code,
            'recruit_manager' => null,
            'manager'         => null,
            'sm'              => null,
            'avp'             => null,
            'vp'              => null,
            'svp'             => null,
        ];

        $currentAgent = $agent;
        //if Agent have recruit manager
        while ($currentAgent->recruitManager) {
            $currentAgent       = $currentAgent->recruitManager;
            $recruitManagerName = $currentAgent->userDetails->name;
            // Fill up recruit manager name only if it's not already set
            if (is_null($row['recruit_manager'])) {
                $row['recruit_manager'] = $recruitManagerName;
            }
            //Fill up hierarchy row based on recruit manager role
            switch ($currentAgent->role->role_code) {
                case 'MGR':
                    $row['manager'] = $recruitManagerName;
                    break;
                case 'SM':
                    $row['sm'] = $recruitManagerName;
                    break;
                case 'AVP':
                    $row['avp'] = $recruitManagerName;
                    break;
                case 'VP':
                    $row['vp'] = $recruitManagerName;
                    break;
                case 'SVP':
                    $row['svp'] = $recruitManagerName;
                    break;
            }
        }
        return $row;
    }

    public function downlineManagement()
    {
        // Enable server-side features
        $isServerSide     = true;
        $searchNames      = ['user_details.name' => 'Agent Name', 'agent_role_settings.role_code' => 'Role'];
        $defaultSearchKey = 'user_details.name';

        // Handle the search and sorting functionality
        $searchKey   = request()->input('key', $defaultSearchKey);
        $searchValue = request()->input('s');
        $filter      = request()->input('filter', 'contains');
        $sortOrder   = request()->input('sort_order', 'asc');
        $orderBy     = request()->input('order_by', 'id');

        // Create a search object to pass to the view
        $search = (object) [
            'key'    => $searchKey,
            'value'  => $searchValue,
            'filter' => $filter,
        ];

        // Query for agents with optional search functionality
        $query = Agent::where('status', 'ACTIVE')
            ->leftJoin('user_details', 'agent.user_detail_id', '=', 'user_details.id')
            ->leftJoin('agent_role_settings', 'agent.agent_role_id', '=', 'agent_role_settings.id')
            ->select('agent.*', 'user_details.name as agent_name', 'agent_role_settings.role_code as agent_role');

        if ($searchValue) {
            switch ($filter) {
                case 'contains':
                    $query->where($searchKey, 'like', '%' . $searchValue . '%');
                    break;
                case 'equals':
                    $query->where($searchKey, $searchValue);
                    break;
            }
        }

        // Sorting
        if (in_array($orderBy, ['agent_name', 'agent_role'])) {
            $query->orderBy($orderBy, $sortOrder);
        }

        // Pagination
        $agents = $query->paginate(10);

        // Prepare the hierarchies while keeping pagination metadata
        $hierarchies = $agents->map(function ($agent) {
            return $this->buildAgentDownline($agent);
        });

        return view('vendor.voyager.agent.browse-agent-downline', compact(
            'hierarchies',
            'isServerSide',
            'searchNames',
            'defaultSearchKey',
            'search',
            'sortOrder',
            'orderBy',
            'agents'));
    }

    public function editAgentPersonalDetails($id)
    {
        // Retrieve the agent. Adjust the relationship name as needed.
        $agent       = Agent::findOrFail($id);
        $userDetails = $agent->userDetails;

        // Define columns and their labels (only status and remark are editable)
        $columns = [
            'name' => 'Name',
        ];

        // Define data types for form inputs
        $dataTypes = [
            'name' => 'text',
        ];

        // Prepare data for the form
        $data = $userDetails->only(['id', 'name']);

        // Page details
        $pageTitle      = "Edit Agent Personal Details";
        $parentId       = $userDetails->id;
        $baseRoute      = 'admin/agent-personal-details';
        $modelSlug      = null;
        $view           = false;
        $returnRoute    = route('voyager.agent.index');
        $hideViewButton = true;

        return view('voyager::custom-bread.edit-add', compact(
            'pageTitle',
            'view',
            'columns',
            'dataTypes',
            'data',
            'parentId',
            'baseRoute',
            'modelSlug',
            'returnRoute',
            'hideViewButton'
        ));
    }

    public function updateAgentPersonalDetails(Request $request, $id)
    {
        $userDetails = UserDetails::findOrFail($id);

        $validated = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        $userDetails->name = $validated['name'];
        $userDetails->save();

        return redirect()->route('voyager.agent.index')->with([
            'message' => 'Agent Details updated successfully.',
            'alert-type' => 'success',
        ]);
    }

}
