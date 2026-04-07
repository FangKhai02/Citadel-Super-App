<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use TCG\Voyager\Http\Controllers\VoyagerBaseController;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Events\BreadDataAdded;
use TCG\Voyager\Events\BreadDataUpdated;
use App\Models\Checker;
use App\Models\BankFileUpload;
use App\Models\Approver;
use DB;

class CheckerController extends VoyagerBaseController
{
    public function update(Request $request, $id)
    {
        // Validate the request
        $this->validateRequest($request);

        // Start transaction to ensure data consistency
        DB::beginTransaction();

        try {
            // Find the Checker record and update status
            $checker = $this->updateChecker($id, $request->input('status'), $request->input('remarks'));

            // If the status is 'REJECTED', update the associated BankFileUpload to 'REJECTED'
            if ($checker->status === 'REJECTED') {
                $this->updateBankFileUploadStatus($checker->bank_file_upload_id, 'REJECTED');
            }

            // If the status is 'APPROVED', create a new Approver record
            if ($checker->status === 'APPROVED') {
                $this->createApprover($checker->bank_file_upload_id, $request->input('remark', ''));
            }

            // Commit the transaction
            DB::commit();

            $slug = $this->getSlug($request);
            $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();
            $data = $checker; // Data for redirect
             // Handle redirect logic
             if (!$request->has('_tagging')) {
                if (auth()->user()->can('browse', $data)) {
                    $redirect = redirect()->route("voyager.{$dataType->slug}.index");
                } else {
                    $redirect = redirect()->back();
                }

                return $redirect->with([
                    'message'    => __('voyager::generic.successfully_updated') . " {$dataType->getTranslatedAttribute('display_name_singular')}",
                    'alert-type' => 'success',
                ]);
            } else {
                return response()->json(['success' => true, 'data' => $data]);
            }

        } catch (\Exception $e) {
            // Rollback the transaction if something goes wrong
            DB::rollBack();

            // Redirect back with error message
            return redirect()->back()->with([
                'message'    => 'An error occurred: ' . $e->getMessage(),
                'alert-type' => 'error',
            ]);
        }
    }

    /**
     * Validate the incoming request.
     */
    private function validateRequest(Request $request)
    {
        $request->validate([
            'status' => 'required|in:APPROVED,REJECTED',
            'remarks' => 'nullable|string|max:255',
        ]);
    }

    /**
     * Update Checker status and remarks.
     */
    private function updateChecker($id, $status, $remarks = null)
    {
        $checker = Checker::findOrFail($id);
        $checker->status = $status;
        $checker->updated_by = auth()->id(); // Assuming user authentication
        $checker->remarks = $remarks ?? $checker->remarks; // Preserve old remarks if not provided
        $checker->save();

        return $checker;
    }

    /**
     * Update the BankFileUpload status.
     */
    private function updateBankFileUploadStatus($bankFileUploadId, $status)
    {
        $bankFileUpload = BankFileUpload::findOrFail($bankFileUploadId);
        $bankFileUpload->status = $status;
        $bankFileUpload->save();
    }

    /**
     * Create a new Approver entry when Checker is successful.
     */
    private function createApprover($bankFileUploadId, $remark = '')
    {
        $approver = new Approver();
        $approver->bank_file_upload_id = $bankFileUploadId;
        $approver->status = 'PENDING'; // Initial status for new Approver
        $approver->remark = $remark;
        $approver->save();
    }
}
