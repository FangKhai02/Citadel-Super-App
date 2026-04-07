<?php

namespace App\Http\Controllers;

use App\Mail\ClientDeactivatedMail;
use App\Models\AppUser;
use App\Models\AppUserSession;
use App\Models\BankDetails;
use App\Models\Client;
use App\Models\CorporateClient;
use App\Models\EmploymentDetails;
use App\Models\IndividualBeneficiaries;
use App\Models\IndividualGuardian;
use App\Models\PepInfo;
use App\Models\ProductOrder;
use App\Models\UserDetails;
use App\Models\WealthIncome;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use TCG\Voyager\Facades\Voyager;

class ClientController extends VoyagerBaseController
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

            $query = $model::select($dataType->name . '.*');

            if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope' . ucfirst($dataType->scope))) {
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
                $searchField = $dataType->name . '.' . $search->key;
                if ($row = $this->findSearchableRelationshipRow($dataType->rows->where('type', 'relationship'), $search->key)) {
                    $query->whereRelation($row->relation, $row->field, $search_filter, $search_value);
                } else {
                    if ($searchField === "client.client_belongsto_user_detail_relationship_2") {
                        $query->whereHas('userDetails', function ($query) use ($search_value) {
                            $query->where(function ($query) use ($search_value) {
                                $query->where('mobile_country_code', 'LIKE', "%{$search_value}%")
                                    ->orWhere('mobile_number', 'LIKE', "%{$search_value}%")
                                    ->orWhereRaw("CONCAT(mobile_country_code, ' ', mobile_number) LIKE ?", ["%{$search_value}%"]);
                            });
                        });
                    } else if ($searchField === "client.client_hasone_client_relationship") {
                        $query->whereHas('agent.agency', function ($query) use ($search_value) {
                            $query->where('agency_name', 'LIKE', "%{$search_value}%");
                        });
                    } else if ($searchField === "client.client_belongsto_agent_relationship") {
                        $query->whereHas('agent.userDetails', function ($query) use ($search_value) {
                            $query->where('name', 'LIKE', "%{$search_value}%");
                        });
                    } else if ($dataType->browseRows->pluck('field')->contains($search->key)) {
                        $query->where($searchField, $search_filter, $search_value);
                    }
                }
            }

            $row = $dataType->rows->where('field', $orderBy)->firstWhere('type', 'relationship');
            if ($orderBy && (in_array($orderBy, $dataType->fields()) || !empty($row))) {
                $querySortOrder = (!empty($sortOrder)) ? $sortOrder : 'desc';
                if (!empty($row)) {
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
            $model = false;
        }

        $searchNames = [];
        if ($dataType->server_side) {
            $searchNames = $dataType->browseRows->mapWithKeys(function ($row) {
                return [$row['field'] => $row->getTranslatedAttribute('display_name')];
            })->toArray();

        }

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($model);

        // Eagerload Relations
        $this->eagerLoadRelations($dataTypeContent, $dataType, 'browse', $isModelTranslatable);

        // Check if server side pagination is enabled
        $isServerSide = isset($dataType->server_side) && $dataType->server_side;

        // Check if a default search key is set
        $defaultSearchKey = 'client_belongsto_user_detail_relationship';

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

    public function show(Request $request, $id)
    {
        $slug = $this->getSlug($request);
        // Find the client by ID
        $client = Client::findOrFail($id);
        if ($client->status === 0) {
            abort(404, 'NOT FOUND');
        }

        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();

        $view = 'voyager::bread.read';

        if (view()->exists("voyager::$slug.read")) {
            $view = "voyager::$slug.read";
        }

        return Voyager::view($view, compact('client', 'userDetails'));

    }

    public function deactivateClient($id)
    {
        $client = Client::findOrFail($id);

        //Verify if the client has any active product orders, if found block delete process
        $productOrders = ProductOrder::where('client_id', $client->id)
            ->whereIn('status', ['ACTIVE', 'FLOAT', 'IN_REVIEW', 'PENDING_PAYMENT'])
            ->get();

        if ($productOrders->isNotEmpty()) {
            return redirect()->back()->with([
                'message' => 'Client trust funds are active and require action.',
                'alert-type' => 'error',
            ]);
        }

        // Deactivate the corporate client & details where status not rejected
        $corporateClient = $client->corporateClient()->with([
            'corporateDetail',
            'corporateShareholders' => fn($query) =>
                $query->where('corporate_shareholders.is_deleted', false)
        ])->first();
        
        if ($corporateClient) {
            if ($corporateClient->approval_status !== 'REJECTED') {
                return redirect()->back()->with([
                    'message' => 'Client is still an active director of a corporate.',
                    'alert-type' => 'error',
                ]);
            }
        
            // Set corporate client status to deleted
            $corporateClient->is_deleted = 1;
        
            // Set corporate client shareholders and corporateDetail to deleted
            foreach ($corporateClient->corporateShareholders as $shareholder) {
                $shareholder->is_deleted = 1;
                $shareholder->save();
            }
        
            if ($corporateClient->corporateDetail) {
                $corporateClient->corporateDetail->is_deleted = 1;
                $corporateClient->corporateDetail->save();
            }
        
            $corporateClient->save();
        }
        
        // Continue processing the client and app user
        $client->status = 0;
        
        // Set app user as deleted
        $appUser = AppUser::findOrFail($client->app_user_id);
        $appUser->is_deleted = 1;
        $appUser->save();
        
        // Delete all user sessions
        AppUserSession::where('app_user_id', $client->app_user_id)->delete();
        
        // Save client changes
        $client->save();

        // Send email notification
        Mail::to($appUser->email_address)->send(new ClientDeactivatedMail($client));

        return redirect()->route('voyager.client.index')->with($this->alertSuccess(__('Client deleted successfully.')));
    }

    public function activateClient($id)
    {
        $client = Client::findOrFail($id);
        $client->status = 1;
        $client->save();
        return redirect()->route('voyager.client.index')->with($this->alertSuccess(__('Client activated successfully.')));
    }

    public function viewClientIdentity($id)
    {
        // Find the client by ID
        $client = Client::findOrFail($id);
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();
        return view('voyager::client.read-client-identity', compact('userDetails', 'client'));
    }

    public function editClientIdentity($id)
    {
        $client = Client::find($id);
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();
        return view('voyager::client.edit-client-identity', compact('userDetails', 'client'));
    }

    public function updateClientIdentity(Request $request, $id)
    {
        try {
            // Find the client by ID
            $client = Client::findOrFail($id);

            // Find the user details associated with the client
            $userDetails = UserDetails::where('id', $client->user_detail_id)->firstOrFail();

            // Update user details with request data
            $userDetails->fill($request->except(['_token', '_method'])); // Exclude token and method fields

            // Handle file uploads to S3
            if ($request->hasFile('ic_document')) {
                $userDetails->ic_document = $request->file('ic_document')->store('client', 's3');
            }

            if ($request->hasFile('selfie_image_key')) {
                $userDetails->selfie_image_key = $request->file('selfie_image_key')->store('client', 's3');
            }

            if ($request->hasFile('proof_of_address_file_key')) {
                $userDetails->proof_of_address_file_key = $request->file('proof_of_address_file_key')->store('client', 's3');
            }

            if ($request->hasFile('onboarding_agreement_key')) {
                $userDetails->onboarding_agreement_key = $request->file('onboarding_agreement_key')->store('client', 's3');
            }

            // Save user details to update the database
            $userDetails->updated_by = Auth::user()->email;
            $userDetails->save();

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client identity updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to update client identity.')));
        }
    }

    public function viewPEPInfo($id)
    {
        // Find the client by ID
        $client = Client::findOrFail($id);
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();
        $pepInfo = PepInfo::where('id', $client->pep_info_id)->first();
        if (!$pepInfo || !$pepInfo->pep_status === false) {
            // Create a new instance of PepInfo with null values for the properties
            $pepInfo = new PepInfo([
                'pep_type' => null,
                'pep_immediate_family_name' => null,
                'pep_position' => null,
                'pep_organisation' => null,
                'pep_supporting_documents_key' => null,
            ]);
        }

        return view('voyager::client.read-client-pep-info', compact('client', 'pepInfo', 'userDetails'));
    }

    public function editPEPInfo($id)
    {
        // Find the client by ID
        $client = Client::findOrFail($id);
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();
        $pepInfo = PepInfo::where('client_id', $client->id)->first();
        return view('voyager::client.edit-client-pep-info', compact('client', 'pepInfo', 'userDetails'));

    }

    public function updatePEPInfo(Request $request, $id)
    {
        try {
            // Find the client by ID
            $client = Client::findOrFail($id);

            // Find the PEP info associated with the client
            $pepInfo = PepInfo::where('client_id', $client->id)->firstOrFail();

            // Update PEP info with request data
            $pepInfo->update($request->except(['_token', '_method'])); // Exclude token and method fields

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client PEP info updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to update client PEP info.')));
        }
    }

    public function viewEmploymentDetails($id)
    {
        // Find the client by ID
        $client = Client::findOrFail($id);
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();
        $clientEmploymentDetails = EmploymentDetails::where('client_id', $client->id)->first();
        return view('voyager::client.read-client-employment-details', compact('client', 'clientEmploymentDetails', 'userDetails'));
    }

    public function editEmploymentDetails($id)
    {
        // Find the client by ID
        $client = Client::findOrFail($id);
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();
        $clientEmploymentDetails = EmploymentDetails::where('client_id', $client->id)->first();
        return view('voyager::client.edit-client-employment-details', compact('client', 'clientEmploymentDetails', 'userDetails'));
    }

    public function updateEmploymentDetails(Request $request, $id)
    {
        try {
            // Find the client by ID
            $client = Client::findOrFail($id);

            // Find the employment details associated with the client
            $employmentDetails = EmploymentDetails::where('client_id', $client->id)->firstOrFail();

            // Update employment details with request data
            $employmentDetails->update($request->except(['_token', '_method'])); // Exclude token and method fields

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client employment details updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to update client employment details.')));
        }
    }

    public function viewWealthIncome($id)
    {
        // Find the client by ID
        $client = Client::findOrFail($id);
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();
        $clientWealthIncome = WealthIncome::where('id', $client->wealth_income_id)->first();
        return view('voyager::client.read-client-wealth-income', compact('client', 'clientWealthIncome', 'userDetails'));
    }

    public function editWealthIncome($id)
    {
        // Find the client by ID
        $client = Client::findOrFail($id);
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();
        $clientIndividualWealthIncome = IndividualWealthIncome::where('client_id', $client->id)->first();
        return view('voyager::client.edit-client-wealth-income', compact('client', 'clientIndividualWealthIncome', 'userDetails'));
    }

    public function updateIndividualWealthIncome(Request $request, $id)
    {
        try {
            // Find the client by ID
            $client = Client::findOrFail($id);

            // Find the individual wealth and income details associated with the client
            $individualWealthIncome = IndividualWealthIncome::where('client_id', $client->id)->firstOrFail();

            // Update individual wealth and income details with request data
            $individualWealthIncome->update($request->except(['_token', '_method'])); // Exclude token and method fields

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client individual wealth and income details updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to update client individual wealth and income details.')));
        }
    }

    public function browseBankingDetails($id)
    {
        // Find the client by ID
        $client = Client::findOrFail($id);
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();
        $bankDetails = $client->bankDetails()->where('is_deleted', false)->get();
        return view('voyager::client.browse-client-banking-details', compact('client', 'bankDetails', 'userDetails'));
    }

    public function viewBankingDetails($client_id, $id)
    {

        $client = Client::findOrFail($client_id);
        // Find the specific bank detail by ID and ensure it is not marked as deleted
        $bankDetails = BankDetails::where('id', $id)
            ->where('is_deleted', false)
            ->firstOrFail();

        return view('voyager::client.read-client-banking-details', compact('client', 'bankDetails'));
    }

    public function editBankingDetails($client_id, $id)
    {
        // Find the client by ID to ensure the client exists
        $client = Client::findOrFail($client_id);

        // Find the specific bank detail by ID
        $bankDetails = BankDetails::where('id', $id)
            ->where('app_user_id', $client->app_user_id) // Ensure it's associated with the client
            ->firstOrFail();

        // Return a view with the bank detail information for editing
        return view('voyager::client.edit-add-client-banking-details', compact('client', 'bankDetails'));
    }

    public function updateBankingDetails(Request $request, $client_id, $id)
    {
        try {
            // Find the client by ID to ensure the client exists
            $client = Client::findOrFail($client_id);

            // Find the specific bank detail by ID
            $bankDetails = BankDetails::where('id', $id)
                ->where('app_user_id', $client->app_user_id) // Ensure it's associated with the client
                ->firstOrFail();

            // Update bank details with request data
            $bankDetails->update($request->except(['_token', '_method'])); // Exclude token and method fields

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client banking details updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to update client banking details.')));
        }
    }

    public function createBankingDetails($client_id)
    {
        // Find the client by ID to ensure the client exists
        $client = Client::findOrFail($client_id);

        // Return a view to create a new bank detail for the client
        return view('voyager::client.edit-add-client-banking-details', compact('client'));
    }

    public function storeBankingDetails(Request $request, $client_id)
    {
        try {
            // Find the client by ID to ensure the client exists
            $client = Client::findOrFail($client_id);

            // Create a new bank detail with request data
            $bankDetails = new BankDetails($request->except(['_token', '_method'])); // Exclude token and method fields

            // Associate the bank detail with the client
            $bankDetails->app_user_id = $client->app_user_id;

            // Save the bank detail
            $bankDetails->save();

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client banking details created successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to create client banking details.')));
        }
    }

    public function deleteBankingDetails($client_id, $id)
    {
        try {
            // Find the client by ID to ensure the client exists
            $client = Client::findOrFail($client_id);

            // Find the specific bank detail by ID
            $bankDetails = BankDetails::where('id', $id)
                ->where('app_user_id', $client->app_user_id) // Ensure it's associated with the client
                ->firstOrFail();

            // Delete the bank detail
            $bankDetails->delete();

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client banking details deleted successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to delete client banking details.')));
        }
    }

    public function browseBeneficiaries($client_id)
    {
        // Find the client by ID
        $client = Client::findOrFail($client_id);

        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();

        // Get the client's beneficiaries
        $beneficiaries = $client->beneficiaries()->where('is_deleted', false)->get();

        // Return a view with the client's beneficiaries
        return view('voyager::client.browse-client-beneficiary', compact('client', 'beneficiaries', 'userDetails'));
    }

    public function viewBeneficiary($client_id, $id)
    {
        // Find the client by ID
        $client = Client::findOrFail($client_id);

        // Find the specific beneficiary by ID
        $beneficiary = IndividualBeneficiaries::where('id', $id)->where('is_deleted', false)->findOrFail($id);

        $individualBeneficiaryGuardian = $beneficiary->guardians;

        // Return a view with the beneficiary information
        return view('voyager::client.read-client-beneficiary', compact('client', 'beneficiary', 'individualBeneficiaryGuardian'));
    }

    public function editBeneficiary($client_id, $id)
    {
        // Find the client by ID to ensure the client exists
        $client = Client::findOrFail($client_id);

        // Find the specific beneficiary by ID
        $beneficiary = Beneficiary::where('id', $id)
            ->where('client_id', $client->id) // Ensure it's associated with the client
            ->firstOrFail();

        // Return a view with the beneficiary information for editing
        return view('voyager::client.edit-add-client-beneficiary', compact('client', 'beneficiary'));
    }

    public function updateBeneficiary(Request $request, $client_id, $id)
    {
        try {
            // Find the client by ID to ensure the client exists
            $client = Client::findOrFail($client_id);

            // Find the specific beneficiary by ID
            $beneficiary = Beneficiary::where('id', $id)
                ->where('client_id', $client->id) // Ensure it's associated with the client
                ->firstOrFail();

            // Update beneficiary with request data
            $beneficiary->update($request->except(['_token', '_method'])); // Exclude token and method fields

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client beneficiary updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to update client beneficiary.')));
        }
    }

    public function createBeneficiary($client_id)
    {
        // Find the client by ID to ensure the client exists
        $client = Client::findOrFail($client_id);

        // Return a view to create a new beneficiary for the client
        return view('voyager::client.edit-add-client-beneficiary', compact('client'));
    }

    public function storeBeneficiary(Request $request, $client_id)
    {
        try {
            // Find the client by ID to ensure the client exists
            $client = Client::findOrFail($client_id);

            // Create a new beneficiary with request data
            $beneficiary = new Beneficiary($request->except(['_token', '_method'])); // Exclude token and method fields

            // Associate the beneficiary with the client
            $beneficiary->client_id = $client->id;

            // Save the beneficiary
            $beneficiary->save();

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client beneficiary created successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to create client beneficiary.')));
        }
    }

    public function deleteBeneficiary($client_id, $id)
    {
        try {
            // Find the client by ID to ensure the client exists
            $client = Client::findOrFail($client_id);

            // Find the specific beneficiary by ID
            $beneficiary = Beneficiary::where('id', $id)
                ->where('client_id', $client->id) // Ensure it's associated with the client
                ->firstOrFail();

            // Delete the beneficiary
            $beneficiary->touch();
            $beneficiary->delete();

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client beneficiary deleted successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to delete client beneficiary.')));
        }
    }

    public function browseBeneficiaryGuardians($client_id)
    {
        // Find the client by ID
        $client = Client::findOrFail($client_id);

        // Get user details
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();

        // Get the client's beneficiary guardians
        $beneficiaryGuardian = $client->beneficiaryGuardians()->where('is_deleted', false)->get();

        // Return a view with the client's beneficiary guardians
        return view('voyager::client.browse-client-beneficiary-guardian', compact('client', 'beneficiaryGuardian', 'userDetails'));
    }

    public function viewBeneficiaryGuardians($client_id, $id)
    {
        // Find individualGuardian by ID
        $individualGuardian = IndividualGuardian::where('id', $id)->where('is_deleted', false)->first();

        if (!$individualGuardian) {
            //        return redirect()->back()->with('error', 'Guardian not found or deleted');
            return redirect()->route('browse.client.beneficiaries.guardian', ['client_id' => $client_id])->with(['message' => 'Something went wrong!', 'alert-type' => 'error']);

        }

        // Find client by client_id
        $client = Client::findOrFail($client_id);

        // Get list individualBeneficiaryGuardian by $id
        $individualBeneficiaryGuardian = $individualGuardian->beneficiaries;

        // Get user details
        $userDetails = UserDetails::where('id', $client->user_detail_id)->first();

        // Return a view with the client's beneficiary guardians
        return view('voyager::client.read-client-beneficiary-guardian', compact('individualGuardian', 'individualBeneficiaryGuardian', 'userDetails', 'client'));
    }

    public function editBeneficiaryGuardian($client_id, $id)
    {
        // Find the client by ID to ensure the client exists
        $client = Client::findOrFail($client_id);

        $beneficiaries = $client->beneficiaries;

        // Find the specific beneficiary guardian by ID
        $beneficiaryGuardian = IndividualGuardian::where('id', $id)
            ->where('client_id', $client->id) // Ensure it's associated with the client
            ->firstOrFail();

        // Return a view with the beneficiary guardian information for editing
        return view('voyager::client.edit-add-client-beneficiary-guardian', compact('client', 'beneficiaryGuardian', 'beneficiaries'));
    }

    public function updateBeneficiaryGuardian(Request $request, $client_id, $id)
    {
        try {
            // Find the client by ID to ensure the client exists
            $client = Client::findOrFail($client_id);

            // Find the specific beneficiary guardian by ID
            $beneficiaryGuardian = IndividualGuardian::where('id', $id)
                ->where('client_id', $client->id) // Ensure it's associated with the client
                ->firstOrFail();

            // Update beneficiary guardian with request data
            $beneficiaryGuardian->update($request->except(['_token', '_method'])); // Exclude token and method fields

            // Update client updated_at field
            $client->updated_by = Auth::user()->email;
            $client->touch();
            $client->save();

            // Prepare success message
            $data = $this->alertSuccess(__('Client beneficiary guardian updated successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to update client beneficiary guardian.')));
        }
    }

    public function createBeneficiaryGuardian($client_id)
    {
        // Find the client by ID to ensure the client exists
        $client = Client::findOrFail($client_id);
        $beneficiaries = $client->beneficiaries;

        // Return a view to create a new beneficiary guardian for the client
        return view('voyager::client.edit-add-client-beneficiary-guardian', compact('client', 'beneficiaries'));
    }

    public function storeBeneficiaryGuardian(Request $request, $client_id)
    {
        try {
            // Find the client by ID to ensure the client exists
            $client = Client::findOrFail($client_id);

            // Create a new beneficiary guardian with request data
            $beneficiaryGuardian = new IndividualGuardian($request->except(['_token', '_method'])); // Exclude token and method fields

            // Associate the beneficiary guardian with the client
            $beneficiaryGuardian->client_id = $client->id;

            // Save the beneficiary guardian
            $beneficiaryGuardian->save();

            // Update client updated_at field
            $client->touch();

            // Prepare success message
            $data = $this->alertSuccess(__('Client beneficiary guardian created successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to create client beneficiary guardian.')));
        }
    }

    public function deleteBeneficiaryGuardian($client_id, $id)
    {
        try {
            // Find the client by ID to ensure the client exists
            $client = Client::findOrFail($client_id);

            // Find the specific beneficiary guardian by ID
            $beneficiaryGuardian = BeneficiaryGuardian::where('id', $id)
                ->where('client_id', $client->id) // Ensure it's associated with the client
                ->firstOrFail();

            // Delete the beneficiary guardian
            $beneficiaryGuardian->delete();

            // Update client updated_at field
            $client->touch();

            // Prepare success message
            $data = $this->alertSuccess(__('Client beneficiary guardian deleted successfully.'));

            // Redirect with success message
            return redirect()->route('voyager.client.index')->with($data);
        } catch (Exception $e) {
            // Prepare error message in case of exception
            return back()->with($this->alertError(__('Failed to delete client beneficiary guardian.')));
        }
    }

}
