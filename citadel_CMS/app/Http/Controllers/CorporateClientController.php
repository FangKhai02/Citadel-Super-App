<?php

namespace App\Http\Controllers;

use App\Models\ProductOrder;
use Exception;
use Carbon\Carbon;
use App\Models\Agent;
use App\Models\Client;
use App\Models\PepInfo;
use App\Models\BankDetails;
use App\Models\UserDetails;
use Illuminate\Http\Request;
use App\Models\CorporateClient;
use TCG\Voyager\Facades\Voyager;
use App\Models\CorporateGuardian;
use App\Models\CorporateDocuments;
use Illuminate\Support\Facades\DB;
use App\Models\CorporateBankDetails;
use Illuminate\Support\Facades\Auth;
use App\Models\CorporateShareholders;
use App\Models\CorporateBeneficiaries;
use App\Models\IndividualBeneficiaries;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Storage;
use App\Models\CorporateShareholdersPivot;
use Illuminate\Database\Eloquent\SoftDeletes;
use TCG\Voyager\Http\Controllers\VoyagerBaseController;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Http\Controllers\Custom\CustomVoyagerBaseController;

class CorporateClientController extends CustomVoyagerBaseController
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
                $searchField = $dataType->name.'.'.$search->key;
                if ($row = $this->findSearchableRelationshipRow($dataType->rows->where('type', 'relationship'), $search->key)) {
                        $query->whereRelation($row->relation, $row->field, $search_filter, $search_value);
                } else {
                     if ($searchField === "corporate_client.corporate_client_hasone_corporate_client_relationship") {
                        $query->where('corporate_client_id', 'LIKE', "%{$search_value}%");
                    }
                    else if ($searchField === "corporate_client.corporate_client_hasone_corporate_client_relationship_1") {
                        $query->whereHas('corporateDetail', function ($query) use ($search_value) {
                            $query->where('entity_name', 'LIKE', "%{$search_value}%");
                        });
                    }else if ($searchField === "corporate_client.corporate_client_hasone_corporate_client_relationship_2") {
                        $query->whereHas('corporateDetail', function ($query) use ($search_value) {
                            $query->where('registration_number', 'LIKE', "%{$search_value}%");
                        });
                    }else if ($searchField === "corporate_client.corporate_client_hasone_corporate_client_relationship_4") {
                        $query->whereHas('client.agent.agency', function ($query) use ($search_value) {
                            $query->where('agency_name', 'LIKE', "%{$search_value}%");
                        });
                    }else if ($searchField === "corporate_client.corporate_client_hasone_corporate_client_relationship_3") {
                        $query->whereHas('client.agent.userDetails', function ($query) use ($search_value) {
                            $query->where('name', 'LIKE', "%{$search_value}%");
                        });
                    }
                    else if ($dataType->browseRows->pluck('field')->contains($search->key)) {
                        $query->where($searchField, $search_filter, $search_value);
                    }
                }
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

        }

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($model);

        // Eagerload Relations
        $this->eagerLoadRelations($dataTypeContent, $dataType, 'browse', $isModelTranslatable);

        // Check if server side pagination is enabled
        $isServerSide = isset($dataType->server_side) && $dataType->server_side;

        // Check if a default search key is set
        $defaultSearchKey = 'corporate_client_hasone_corporate_client_relationship_1';

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

        $corporate = CorporateClient::with(['client', 'corporateDetail', 'userDetails'])->findOrFail($id);
        // Retrieve the CorporateClient with its related corporate details
        $corporateDetail = $corporate->corporateDetail; // Assuming "corporateDetail" is the relationship defined in the CorporateClient model

        // Fetch the CorporateDocuments related to this corporate detail
        $corporateDocs = CorporateDocuments::where('corporate_details_id', $corporateDetail->id)->where('is_deleted',false)->get();

        $agentUserDetail = null;

        if ($corporate->client && $corporate->client->agent_id) {
            $agent = Agent::find($corporate->client->agent_id);

            if ($agent) {
                $agentUserDetail = UserDetails::find($agent->app_user_id);
            }
        }

        // Resolve the view path, checking for a custom read view
        $view = view()->exists("voyager::$slug.read")
            ? "voyager::$slug.read"
            : 'voyager::bread.read';

        return Voyager::view($view, compact('corporate', 'agentUserDetail','corporateDocs'));
    }

    public function deactivateCorporateClient($id)
    {
        $corporateClient = CorporateClient::with([
            'corporateDetail',
            'corporateShareholders' => fn($query) => 
                $query->where('corporate_shareholders.is_deleted', false)
        ])
        ->findOrFail($client->corporateClient()->first()->id);
        // Set corporate client status to deleted
        $corporateClient->is_deleted = 1;

        // Set corporate client shareholders and corporateDetail to deleted 
        foreach ($corporateClient->corporateShareholders as $shareholder) {
            $shareholder->is_deleted = 1;
            $shareholder->save();
        }

        $corporateClient->corporateDetail->is_deleted = 1;

        // Save the changes
        $corporateClient->save();

        return redirect()->route('voyager.corporate-client.index')->with($this->alertSuccess(__('Corporate client deactivated successfully.')));
    }

    //viewWealthIncome
    public function viewWealthIncome($id)
    {
        $corporate = CorporateClient::with('corporateDetail')->findOrFail($id);
        return view('voyager::corporate-client.read-client-wealth-income', compact('corporate'));
    }

    public function viewPEPInfo($id)
    {
        $corporate = CorporateClient::with('corporateDetail')->findOrFail($id);
        $userDetails = UserDetails::where('id', $corporate->user_detail_id)->first();
        $pepInfo = PepInfo::where('id', $corporate->client->pep_info_id)->first();
        return view('voyager::corporate-client.read-client-pep-info', compact('corporate', 'pepInfo', 'userDetails'));
    }

    public function browseCorporateShareholders($id)
    {
        $corporateClient = CorporateClient::with(
            ['corporateDetail',
                'corporateShareholders' => function ($query) {
                    $query->where('corporate_shareholders.is_deleted', false);  // Ensure that shareholders are not deleted
                }
            ])
            ->findOrFail($id);

        return view('voyager::corporate-client.browse-corporate-shareholders', [
            'corporate' => $corporateClient, // Pass the corporate client
            'shareholders' => $corporateClient->corporateShareholders, // Shareholders relationship
        ]);
    }

    public function viewCorporateShareholder($corporateClientId, $shareholderId)
    {
        $corporateClient = CorporateClient::findOrFail($corporateClientId);

        $corporateShareholder = $corporateClient->corporateShareholders()
            ->where('corporate_shareholders.is_deleted', false)
            ->findOrFail($shareholderId);

        $corporateShareholder->load('pepInfo');

        return view('voyager::corporate-client.read-corporate-shareholder', [
            'corporate' => $corporateClient,
            'corporate_shareholder' => $corporateShareholder,
        ]);
    }

    public function browseCorporateBankingDetails($id)
    {
        $corporateClient = CorporateClient::with(['corporateBankDetails', 'corporateDetail'])->findOrFail($id);
        $userDetails = UserDetails::find($corporateClient->user_detail_id);

        return view('voyager::corporate-client.browse-corporate-banking-details', [
            'corporateClient' => $corporateClient,
            'corporateBankDetails' => $corporateClient->corporateBankDetails->where('is_deleted', false),
            'userDetails' => $userDetails,
        ]);
    }

    public function viewCorporateBankingDetails($corporateClientId, $id)
    {

        $corporateClient = CorporateClient::findOrFail($corporateClientId);
        $corporateBankDetails = CorporateBankDetails::where('is_deleted', false)->where('id', $id)->firstOrFail();

        return view('voyager::corporate-client.read-corporate-banking-details', compact('corporateClient', 'corporateBankDetails'));
    }

    public function browseCorporateBeneficiaries($corporateClientId)
    {
        // Find the corporate client by ID, with its corporate detail
        $corporateClient = CorporateClient::with('corporateDetail')->findOrFail($corporateClientId);

        // Get the beneficiaries, including their guardians (if any)
        $beneficiaries = CorporateBeneficiaries::with('corporateGuardians') // Eager load guardians
        ->where('corporate_client_id', $corporateClientId)
            ->get();

        // Pass the data to the view
        return view('voyager::corporate-client.browse-corporate-beneficiaries', compact('corporateClient', 'beneficiaries'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'approval_status' => 'required|string|max:255',
            'approval_status_remark' => 'nullable|string|max:255'
        ]);
        $corporateClient = CorporateClient::findOrFail($id);
        $corporateDetail = $corporateClient->corporateDetail;
        $newApprovalStatus = $request->input('approval_status');
        $newApprovalStatusRemark = $request->input('approval_status_remark');

        // Update the fields based on the dropdown value
        $corporateClient->approver_id = Auth::user()->id;
        $corporateClient->updated_at = Carbon::now();

        if ($newApprovalStatus === 'APPROVED') {
            $corporateClient->approval_status = 'APPROVED';
            $corporateClient->approval_status_remark = $newApprovalStatusRemark;
            $corporateDetail->status = 'APPROVED';
        } elseif ($newApprovalStatus === 'REJECTED') {
            $corporateClient->approval_status = 'REJECTED';
            $corporateClient->approval_status_remark = $newApprovalStatusRemark;
            $corporateDetail->status = 'REJECTED';
        } else {
            $corporateClient->approval_status = 'IN_REVIEW';
            $corporateClient->approval_status_remark = $newApprovalStatusRemark;
            $corporateDetail->status = 'IN_REVIEW';
        }
        $corporateDetail->save();
        $corporateClient->save();

        return redirect()->route('voyager.corporate-client.index')
            ->with($this->alertSuccess(__('Corporate Client updated successfully.')));
    }


    public function deleteCorporateShareholder($shareholderId)
    {
        // Find the corporate shareholder by ID
        $corporate_shareholder = CorporateShareholders::where('is_deleted', false)->findOrFail($shareholderId);

        $corporate_shareholder->is_deleted = 1;
        $corporate_shareholder->updated_at = Carbon::now();
        $corporate_shareholder->save();
        return redirect()->route('voyager.corporate-client.index')->with($this->alertSuccess(__('Corporate Client deleted successfully.')));
    }

    public function deleteCorporateBankingDetails($corporateClientId, $id)
    {
        $corporateBankDetails = CorporateBankDetails::where('is_deleted', false)
            ->where('corporate_client_id', $corporateClientId)
            ->where('id', $id)
            ->firstOrFail();

        $corporateBankDetails->is_deleted = 1;
        $corporateBankDetails->updated_at = Carbon::now();
        $corporateBankDetails->save();

        return redirect()->route('browse.corporate.banking.details', ['corporate_client_id' => $corporateClientId])
            ->with($this->alertSuccess(__('Corporate banking details deleted successfully.')));
    }


    public function viewCorporateDirector($id)
    {
        $corporate = CorporateClient::with(['client', 'corporateDetail', 'userDetails'])->findOrFail($id);
        return view('voyager::corporate-client.read-corporate-user-details',compact('corporate'));
    }

    public function editCorporateDirector($id)
    {
        $corporate = CorporateClient::with(['client', 'corporateDetail', 'userDetails'])->findOrFail($id);
        $client =  $corporate->client;
        $userDetails = $corporate->userDetails;
        $corporateDocs = CorporateDocuments::where('corporate_details_id', $corporate->corporateDetail->id)->where('is_deleted',false)->get();

        return view('voyager::corporate-client.edit-corporate-user-details',compact('client','corporate','userDetails','corporateDocs'));
    }

    public function removeCorporateDirector($id, $fileId)
    {
        // Find the corporate client
        $corporateClient = CorporateClient::findOrFail($id);

        // Find the corporate document to update
        $document = CorporateDocuments::where('corporate_details_id', $corporateClient->corporateDetail->id)
                                      ->where('id', $fileId)
                                      ->where('is_deleted',false)
                                      ->firstOrFail();

        // Update the 'is_deleted' field to true (soft delete)
        $document->is_deleted = true;
        $document->save();

        // Redirect back with a success message
        return redirect()->route('edit.corporate.user.details', $id)
                         ->with('success', 'Document marked as deleted successfully.');
    }

    public function updateCorporateDirector(Request $request, $id)
    {
        try {
            // Validate the incoming request data
            $validatedData = $request->validate([
                'existing_acc' => 'required|string|max:255',
                'new_acc' => 'required|string|max:255',
                'remarks' => 'required|string|max:1000',
                'supporting_documents.*' => 'required|file|mimes:pdf,doc,docx,jpg,png,jpeg|max:2048',
            ]);

            // Find the corporate client
            $corporate = CorporateClient::findOrFail($id);

            // Check if a new director ID is provided
            if (!empty($validatedData['new_acc'])) {
                // Find the new client (director) by ID
                $client = Client::where('client_id', $validatedData['new_acc'])->first();
                if (!$client) {
                    return back()->with($this->alertError(__('New director not found.')));
                }

                // Update the client_id in the related corporate client
                $corporate->client_id = $client->id;
                $corporate->user_detail_id= $client->user_detail_id;
            }

            $corporate->save();

            // Update remarks in the user details table
            $userDetails = $corporate->userDetails;
            $userDetails->remarks = $validatedData['remarks'] ?? null;
            $userDetails->save();

            // Handle supporting documents (store with corporate details ID in company documents table)
            if ($request->hasFile('supporting_documents')) {
                foreach ($request->file('supporting_documents') as $file) {
                    // Store the file in S3 (you can specify a directory for organization)
                    $path = $file->store('company_documents/supporting_files', 's3');

                    // Save the document in the company_documents table
                    CorporateDocuments::create([
                        'corporate_details_id' => $id, // Reference corporate details ID
                        'company_document_key' => $path,
                    ]);
                }
            }

            // Redirect back with success message
            return redirect()->route('voyager.corporate-client.index')->with($this->alertSuccess(__('Corporate client director updated successfully.')));

        } catch (\Exception $e) {
            // Fix: Convert exception to string for concatenation
            return back()->with($this->alertError(__('Failed to update director. Please try again later.') . ' ' . $e->getMessage()));
        }
    }

    public function viewCorporateBeneficiary($corporateId, $beneficiaryid)
    {
        // Find the corporate client details with related models
        $corporate = CorporateClient::with(['client', 'corporateDetail', 'userDetails'])->findOrFail($corporateId);

        // Find the specific beneficiary
        $beneficiary = CorporateBeneficiaries::where('id', $beneficiaryid)
            ->where('is_deleted', false)
            ->firstOrFail();

        // Retrieve the corporate guardian linked to the beneficiary
        $corporateGuardian = $beneficiary->corporateGuardians;

        // Return the view with all necessary data
        return view('voyager::corporate-client.read-corporate-beneficiary', compact(
            'corporate', 'beneficiary', 'corporateGuardian'
        ));
    }

    public function browseCorporateGuardians($client_id)
    {

        $corporate = CorporateClient::findOrFail($client_id);

        $beneficiaryGuardians = CorporateGuardian::where('is_deleted', false)
            ->where('corporate_client_id', $client_id)
            ->get();

        return view('voyager::corporate-client.browse-corporate-beneficiary-guardian',
            compact('corporate', 'beneficiaryGuardians'));
    }


    public function viewCorporateGuardian($client_id, $guardian_id)
    {
        // Find the guardian by ID and validate against the client ID
        $corporateGuardian = CorporateGuardian::where('id', $guardian_id)
            ->where('is_deleted', false)
            ->where('corporate_client_id', $client_id)
            ->first();

        if (!$corporateGuardian) {
            return redirect()->route('browse.corporate.beneficiaries.guardian', ['client_id' => $client_id])
                ->with(['message' => 'Guardian not found or does not belong to this client!', 'alert-type' => 'error']);
        }

        // Retrieve the beneficiaries linked to this guardian
        $beneficiaries = CorporateBeneficiaries::where('company_guardian_id', $guardian_id)
            ->where('corporate_client_id', $client_id)
            ->where('is_deleted', false)
            ->get();

        // Find the corporate client details
        $corporate = CorporateClient::findOrFail($client_id);

        // Retrieve user details for display purposes
        $userDetails = UserDetails::where('id', $corporate->user_detail_id)->first();

        // Return view with data
        return view('voyager::corporate-client.read-corporate-beneficiary-guardian', compact('corporateGuardian', 'beneficiaries', 'corporate', 'userDetails'));
    }

    public function deleteCorporate($id)
    {
        $corporateClient = CorporateClient::findOrFail($id);

        //Verify if the corporate has any active product orders, if found block delete process
        $productOrders = ProductOrder::where('corporate_client_id', $corporateClient->id)
            ->whereIn('status', ['ACTIVE', 'FLOAT', 'IN_REVIEW', 'PENDING_PAYMENT'])
            ->get();

        if ($productOrders->isNotEmpty()) {
            return redirect()->back()->with([
                'message' => 'Corporate client trust funds are active and require action.',
                'alert-type' => 'error',
            ]);
        }

        $corporateClient->is_deleted = 1;
        $corporateClient->save();
        return redirect()->route('voyager.corporate-client.index')->with($this->alertSuccess(__('Corporate client deleted successfully.')));
    }
}
