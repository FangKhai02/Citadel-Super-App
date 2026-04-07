<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use TCG\Voyager\Http\Controllers\VoyagerBaseController;
use TCG\Voyager\Facades\Voyager;
use App\Models\Approver;
use App\Models\BankFileUpload;
use DB;

class ApproverController extends VoyagerBaseController
{
    public function update(Request $request, $id)
    {
        // Validate the incoming request
        $this->validateRequest($request);

        // Start transaction to ensure atomicity
        DB::beginTransaction();

        try {
            // Find the approver record and update status
            $approver = $this->updateApprover($id, $request->input('status'), $request->input('remark'));

            // Handle status update logic
            if ($approver->status === 'REJECTED') {
                // Update Bank File Upload status to REJECTED
                $this->updateBankFileUploadStatus($approver->bank_file_upload_id, 'REJECTED');
            } elseif ($approver->status === 'APPROVED') {
                // Update Bank File Upload status to APPROVED
                // $this->updateBankFileUploadStatus($approver->bank_file_upload_id, 'APPROVED');
            }

            // Commit the transaction
            DB::commit();

            $slug = $this->getSlug($request);
            $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();
            $data = $approver; // Data for redirect
            // Redirect back with success message
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
            // Rollback the transaction on failure
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
        ]);
    }

    /**
     * Update the Approver's status.
     */
    private function updateApprover($id, $status, $remarks) 
    {
        $approver = Approver::findOrFail($id);
        $approver->status = $status;
        $approver->remark = $approver->remark = $remarks ?? $approver->remarks; // Preserve old remarks if not provided
        $approver->save();

        return $approver;
    }

    /**
     * Update the Bank File Upload status.
     */
    private function updateBankFileUploadStatus($bankFileUploadId, $status)
    {
        $bankFileUpload = BankFileUpload::findOrFail($bankFileUploadId);
        $bankFileUpload->status = $status;
        $bankFileUpload->save();
    }
}
