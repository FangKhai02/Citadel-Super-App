<?php

namespace App\Actions;

use TCG\Voyager\Actions\AbstractAction;
use App\Models\BankDetails;

class CustomAction extends AbstractAction
{
    public function getTitle()
    {
        return '';
    }

    public function getIcon()
    {
        return 'voyager-list';
    }

    public function getPolicy()
    {
        return 'edit';
    }

    public function shouldActionDisplayOnDataType()
    {
        // Show or hide the action button; in this case, will show for agent model and client model
        return
        $this->dataType->slug == 'agent' ||
        $this->dataType->slug == 'client' ||
        $this->dataType->slug == 'product-order' ||
        $this->dataType->slug == 'corporate-client' ||
        $this->dataType->slug == 'agency' ||
        $this->dataType->slug == 'product';
    }

    public function getAttributes()
    {
        return [
            'class' => 'btn btn-sm btn-primary dropdown-toggle pull-left',
            'data-toggle' => 'dropdown', // Enable dropdown
            'style' => 'margin-right: 5px;', // Add margin-right via inline style
            'aria-haspopup' => 'true',
            'aria-expanded' => 'false',
        ];
    }

    public function getDefaultRoute()
    {
        return '#'; // Placeholder route since this is a dropdown
    }

    public function shouldActionDisplayOnRow($row)
    {
        // Optionally control visibility based on row data if needed
        return true; // Show on all rows for now
    }

    public function getDropdownActions($row) // Accept the row parameter
    {
        $dataSlug = $this->dataType->slug;
        if ($dataSlug == 'agent') {
            // Get the user_detail_id, bank_details_id, and agency_details_id from the provided row instance
            $userDetailId = $row->user_detail_id ?? null;
            $bankDetailsId = $row->bankDetails ?? null;
            $agencyDetailsId = $row->id ?? null;

            $actions = [];

            if ($userDetailId) {
                $actions[] = [
                    'title' => 'Edit Agent Identity',
                    'route' => route('voyager.agent.edit', $row->id),
                    'icon' => 'voyager-edit',
                    'attributes' => ['class' => 'dropdown-item'],
                ];
                $actions[] = [
                    'title' => 'Edit Agent Personal Details',
                    'route' => route('edit.agent.personal.details', $row->id),
                    'icon' => 'voyager-edit',
                    'attributes' => ['class' => 'dropdown-item'],
                ];
                // View Agent identity, route laravel voyager /admin/agent
                $actions[] = [
                    'title' => 'View Agent Identity',
                    'route' => route('voyager.agent.show', $row->id),
                    'icon' => 'voyager-eye',
                    'attributes' => ['class' => 'dropdown-item'],
                ];
//                $actions[] = [
//                    'title' => 'Browse Agent Banking Details',
//                    'route' => route('browse.agent.banking.details', $row->id),
//                    'icon' => 'voyager-list',
//                    'attributes' => ['class' => 'dropdown-item'],
//                ];

                }
                //Removed edit agency from agent page. Edit agency is done in Agency page
                // if ($agencyDetailsId) {
                //     $actions[] = [
                //         'title' => 'Edit Agency Details',
                //         'route' => route('edit.agency.details', $row->id),
                //         'icon' => 'voyager-edit',
                //         'attributes' => ['class' => 'dropdown-item'],
                //     ];
                // }
                if ($bankDetailsId) {
                    $actions[] = [
                        'title' => 'Edit Agent Banking Details',
                        'route' => route('edit.agent.banking.details',  $row->id),
                        'icon' => 'voyager-edit',
                        'attributes' => ['class' => 'dropdown-item'],
                    ];
                    $actions[] = [
                        'title' => 'View Agent Banking Details',
                        'route' => route('view.agent.banking.details', $row->id),
                        'icon' => 'voyager-eye',
                        'attributes' => ['class' => 'dropdown-item'],
                    ];
                }
                $actions[] = [
                    'title' => 'Delete Agent',
                    'route' => 'javascript:void(0);',
                    'icon' => 'voyager-trash',
                    'attributes' => [
                        'class' => 'dropdown-item delete',
                        'data-id' => $row->id,
                    ],
                ];
        } else if ($dataSlug == 'client') {
            // Get the user_detail_id, bank_details_id, and agency_details_id from the provided row instance
            $userDetailId = $row->user_detail_id ?? null;
            $bankDetailsId = $row->bank_details_id ?? null;
            $employeeDetailsId = $row->employment_details_id ?? null;
            $wealthIncome = $row->wealth_income_id ?? null;

            $actions = [];

            if ($userDetailId) {
                //View client
                $actions[] = [
                    'title' => 'Client Details',
                    'route' => route('voyager.client.show', $row->id),
                    'icon' => 'voyager-eye',
                    'attributes' => ['class' => 'dropdown-item'],
                ];

                //Edit Client
               $actions[] = [
                   'title' => 'Edit Client Identity',
                   'route' => route('voyager.client.edit', $row->id),
                   'icon' => 'voyager-edit',
                   'attributes' => ['class' => 'dropdown-item'],
               ];
                $actions[] = [
                    'title' => 'PEP Info',
                    'route' => route('view.client.pep.info', $row->id),
                    'icon' => 'voyager-eye',
                    'attributes' => ['class' => 'dropdown-item'],
                ];

                $actions[] = [
                    'title' => 'Banking Details',
                    'route' => route('browse.client.banking.details', $row->id),
                    'icon' => 'voyager-list',
                    'attributes' => ['class' => 'dropdown-item'],
                ];

                $actions[] = [
                    'title' => 'Beneficiary',
                    'route' => route('browse.client.beneficiaries', $row->id),
                    'icon' => 'voyager-list',
                    'attributes' => ['class' => 'dropdown-item'],
                ];

                $actions[] = [
                    'title' => 'Guardian',
                    'route' => route('browse.client.beneficiaries.guardian', $row->id),
                    'icon' => 'voyager-list',
                    'attributes' => ['class' => 'dropdown-item'],
                ];
                //When Deactivate, activate button will show.
//                $actions[] = [
//                    'title' => $row->status ? 'Deactivate Client' : 'Activate Client',
//                    'route' => $row->status ? route('deactivate.client', $row->id) : route('activate.client', $row->id),
//                    'icon' => $row->status ? 'voyager-x' : 'voyager-check',
//                    'attributes' => ['class' => 'dropdown-item'],
//                ];

                //When deleted, hide this button
                if ($row->status !== 0) {
                    $actions[] = [
                        'title' => 'Delete Client',
                        'route' => 'javascript:void(0);',
                        'icon' => 'voyager-trash',
                        'attributes' => [
                            'class' => 'dropdown-item delete',
                            'data-id' => $row->id,
                        ],
                    ];
                }

                if ($employeeDetailsId) {
                    $actions[] = [
                        'title' => 'Client Employment Details',
                        'route' => route('view.client.employment.details', $row->id),
                        'icon' => 'voyager-eye',
                        'attributes' => ['class' => 'dropdown-item'],
                    ];
                }

                if ($wealthIncome) {
                    $actions[] = [
                        'title' => 'Client Wealth & Income',
                        'route' => route('view.client.wealth.income', $row->id),
                        'icon' => 'voyager-eye',
                        'attributes' => ['class' => 'dropdown-item'],
                    ];
                }

                //Delete Client
//                $actions[] = [
//                    'title' => 'Delete Client',
//                    'route' => 'javascript:void(0);',
//                    'icon' => 'voyager-trash',
//                    'attributes' => [
//                        'class' => 'dropdown-item delete',
//                        'data-id' => $row->id,
//                    ],
//                ];

            }

        } else if ($dataSlug == 'product') {
            $actions = [];
            $actions[] = [
                'title' => 'Product Config',
                'route' => route('voyager.product.show', $row->id),
                'icon' => 'voyager-eye',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            $actions[] = [
                'title' => 'Target Return',
                'route' => route('voyager.product-target-return.index', ['key' => 'product_id',
                    'filter' => 'contains',
                    's' => $row->id])
                ,
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            $actions[] = [
                'title' => 'Agreement Date',
                'route' =>  route('voyager.product-agreement-date.index', [
                    'key' => 'product_type_id',
                    'filter' => 'contains',
                    's' => $row->product_type_id
                ]),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            $actions[] = [
                'title' => 'Agreement Schedule',
                'route' => route('voyager.product-agreement-schedule.index', ['key' => 'product_agreement_schedule_belongstomany_product_relationship',
                    'filter' => 'contains',
                    's' => $row->productType()->first()->name]),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            $actions[] = [
                'title' => 'Dividend Schedule',
                'route' => route('voyager.product-dividend-schedule.index', ['key' => 'product_id',
                    'filter' => 'contains',
                    's' => $row->id]),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            if ($row->investment_tenure_month != ($row->lock_in_period_value * ($row->lock_in_period_option == 'YEAR' ? 12 : 1)))
            {
                $actions[] = [
                    'title' => 'Early Redemption',
                    'route' => route('browse.product.early.redemption', $row->id),
                    'icon' => 'voyager-list',
                    'attributes' => ['class' => 'dropdown-item'],
                ];
            }
            $actions[] = [
                'title' => 'Agency Commission Configuration',
                'route' => route('voyager.agency-commission-configuration.index', [
                    'key' => 'agency_commission_configuration_belongsto_product_relationship',
                    'filter' => 'contains',
                    's' => $row->code
                ]),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            $actions[] = [
                'title' => 'In-House Commission Configuration',
                'route' =>  route('voyager.agent-commission-configuration.index', [
                    'key' => 'agent_commission_configuration_belongsto_product_relationship',
                    'filter' => 'contains',
                    's' => $row->code
                ]),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];
        } else if ($dataSlug == 'product-order') {
            $actions = [];
            $actions[] = [
                'title' => 'View Product Order Details',
                'route' => route('voyager.product-order.show', $row->id),
                'icon' => 'voyager-eye',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            $actions[] = [
                'title' => 'View Client Details',
                'route' => route('product-order.client-details', $row->id),
                'icon' => 'voyager-eye',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            if($row->corporate_client_id){
                $actions[] = [
                    'title' => 'View Corporate Details',
                    'route' => route('product-order.corporate-details', $row->id),
                    'icon' => 'voyager-eye',
                    'attributes' => ['class' => 'dropdown-item'],
                ];
                $actions[] = [
                    'title' => 'Browse Shareholders',
                    'route' => route('product-order.shareholders', $row->id),
                    'icon' => 'voyager-list',
                    'attributes' => ['class' => 'dropdown-item'],
                ];
            }
            $actions[] = [
                'title' => 'View Banking Details',
                'route' => route('product-order.banking-details', $row->id),
                'icon' => 'voyager-eye',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            $actions[] = [
                'title' => 'Browse Beneficiaries',
                'route' => route('product-order.beneficiaries', $row->id),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];
//            $actions[] = [
//                'title' => 'View Document',
//                'route' => route('product-order.document', $row->id),
//                'icon' => 'voyager-eye',
//                'attributes' => [
//                    'class' => 'dropdown-item view-document', // Add a class for JavaScript handling
//                    'data-id' => $row->id, // Pass the ID for the AJAX request
//                ],
//            ];

        } else if ($dataSlug == 'corporate-client') {
            $actions = [];
            $actions[] = [
                'title' => 'Corporate Details',
                'route' => route('voyager.corporate-client.show', $row->id),
                'icon' => 'voyager-eye',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            $actions[] = [
                'title' => 'Corporate Director Details',
                'route' => route('view.corporate.user.details', $row->id),
                'icon' => 'voyager-eye',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            // View Corporate Pep Info
            $actions[] = [
                'title' => 'PEP Status',
                'route' => route('view.corporate.pep.info', $row->id),
                'icon' => 'voyager-eye',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            // View Corporate Wealth & Income
            $actions[] = [
                'title' => 'Corporate Wealth & Income',
                'route' => route('view.corporate.wealth.income', $row->id),
                'icon' => 'voyager-eye',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            // Browse Corporate Shareholder
            $actions[] = [
                'title' => 'Shareholders',
                'route' => route('browse.corporate.shareholders',  $row->id),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];

            // Browse Corporate Bank Details
            $actions[] = [
                'title' => 'Bank Details',
                'route' => route('browse.corporate.banking.details',  $row->id),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];

            // Browse Corporate Beneficiaries
            $actions[] = [
                'title' => 'Beneficiaries',
                'route' => route('browse.corporate.beneficiaries',  $row->id),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];

            // Browse Corporate Guardians
            $actions[] = [
                'title' => 'Guardians',
                'route' => route('browse.corporate.guardians',  $row->id),
                'icon' => 'voyager-list',
                'attributes' => ['class' => 'dropdown-item'],
            ];

            //Edit approval status
            $actions[] = [
                'title' => 'Edit Approval Status',
                'route' => route('voyager.corporate-client.edit', $row->id),
                'icon' => 'voyager-check',
                'attributes' => ['class' => 'dropdown-item'],
            ];

            // Soft Delete Corporate Client
            $actions[] = [
                    'title' => 'Delete Corporate',
                    'route' => 'javascript:void(0);',
                    'icon' => 'voyager-trash',
                    'attributes' => [
                        'class' => 'dropdown-item delete',
                        'data-id' => $row->id,
                    ],
                ];

//                // Approve Corporate Client
//                $actions[] = [
//                    'title' => 'Approve Corporate Profile',
//                    'route' => route('corporate-client.approve', $row->id),
//                    'icon' => 'voyager-check',
//                    'attributes' => ['class' => 'dropdown-item'],
//                ];
//
//                // Reject Corporate Client
//                $actions[] = [
//                    'title' => 'Reject Corporate Profile',
//                    'route' => route('corporate-client.reject', $row->id),
//                    'icon' => 'voyager-x',
//                    'attributes' => ['class' => 'dropdown-item'],
//                ];

        } else if ($dataSlug == 'agency') {
            $actions = [];
            //View Agency Details
            $actions[] = [
                'title' => 'View Agency Details',
                'route' => route('voyager.agency.show', $row->id),
                'icon' => 'voyager-eye',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            //Add Agency Banking details
            //get BankDetails::where agency_id = agency_id
            $bank = BankDetails::where('agency_id', $row->id)->first();
            if ($bank) {
                //View Agency Banking details
                $actions[] = [
                    'title' => 'View Agency Banking Details',
                    'route' => route('view.agency.banking.details', $row->id),
                    'icon' => 'voyager-eye',
                    'attributes' => ['class' => 'dropdown-item'],
                ];
            } else {
            $actions[] = [
                'title' => 'Add Agency Banking Details',
                'route' => route('create.agency.banking.details', $row->id),
                'icon' => 'voyager-data',
                'attributes' => ['class' => 'dropdown-item'],
            ];
            }
//            $actions[] = [
//                'title' => 'Delete Agency',
//                'route' => 'javascript:void(0);',
//                'icon' => 'voyager-trash',
//                'attributes' => [
//                    'class' => 'dropdown-item delete',
//                    'data-id' => $row->id,
//                ],
//            ];
        }

        return $actions; // Return the list of actions for rendering in the Blade template
    }

}
