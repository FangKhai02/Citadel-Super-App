<?php

namespace App\Actions;

use TCG\Voyager\Actions\EditAction as VoyagerEditAction;

class CustomEditAction extends VoyagerEditAction
{
    // Override methods as needed
    public function shouldActionDisplayOnRow($row)
    {
        // Define slugs where the condition applies
        $restrictedSlugs = ['approver', 'checker', 'bank-file-upload'];

        // Check if the data type's slug is in the restricted list
        if (in_array($this->dataType->slug, $restrictedSlugs)) {
            // Check if the status is 'Approved'
            return $row->status === 'PENDING';
        }

        // If not in the restricted list, show the edit button
        return true;
    }
}
