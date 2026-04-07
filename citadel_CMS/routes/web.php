<?php

use App\Http\Controllers\AgencyController;
use App\Http\Controllers\AgentController;
use App\Http\Controllers\Auth\ForgotPasswordController;
use App\Http\Controllers\Auth\ResetPasswordController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\CorporateClientController;
use App\Http\Controllers\DeleteRequestController;
use App\Http\Controllers\ProductAgreementDateController;
use App\Http\Controllers\ProductAgreementScheduleController;
use App\Http\Controllers\ProductCommissionHistoryController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ProductDividendHistoryController;
use App\Http\Controllers\ProductDividendScheduleController;
use App\Http\Controllers\ProductEarlyRedemptionHistoryController;
use App\Http\Controllers\ProductOrderController;
use App\Http\Controllers\ProductReallocationController;
use App\Http\Controllers\ProductRedemptionController;
use App\Http\Controllers\ProductRolloverHistoryController;
use App\Http\Controllers\ProductTargetReturnController;
use Illuminate\Support\Facades\Route;
use TCG\Voyager\Facades\Voyager;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
 */

Route::get('/', function () {
    return redirect('/admin');
});

Route::get('/account-delete-request', [DeleteRequestController::class, 'showForm'])->name('account-delete-request.form');
Route::post('/account-delete-request', [DeleteRequestController::class, 'handleRequest'])->name('account-delete-request.submit');

Route::group(['prefix' => 'admin'], function () {

    //Agent Downline management
    Route::get('/agent/downline/', [AgentController::class, 'downlineManagement'])
        ->middleware('can:browse_agentdownline')
        ->name('agent.downline');

    Voyager::routes();

    Route::get('forget', [ForgotPasswordController::class, 'showLinkRequestForm'])->name('password.request');
    Route::post('forget', [ForgotPasswordController::class, 'sendResetLinkEmail'])->name('password.email');
    Route::get('reset/{token}', [ResetPasswordController::class, 'showResetForm'])->name('password.reset');
    Route::post('reset', [ResetPasswordController::class, 'reset'])->name('password.reset.submit');

    Route::group(['middleware' => 'admin.user'], function () {
        /********************* AGENT  ***********************/

        // // Route to edit the agent identity details
        Route::get('/agent/{id}/edit-agent-identity', [AgentController::class, 'editAgentIdentity'])->name('edit.agent.identity');

        // // Route to handle the update of agent identity details
        Route::put('/agent/{id}/update-agent-identity', [AgentController::class, 'updateAgentIdentity'])->name('update.agent.identity');

        // Route to edit the agency details
        Route::get('/agent/{id}/edit-agency-details', [AgentController::class, 'editAgencyDetails'])->name('edit.agency.details');

        // Route to handle the update of agency details
        Route::put('/agent/{id}/update-agency-details', [AgentController::class, 'updateAgencyDetails'])->name('update.agency.details');

        // Route to read the agent banking details
        Route::get('/agent/{id}/view-agent-banking-details', [AgentController::class, 'viewBankingDetails'])->name('view.agent.banking.details');

        // // Route to edit the agent banking details
        Route::get('/agent/{id}/edit-agent-banking-details', [AgentController::class, 'editBankingDetails'])->name('edit.agent.banking.details');

        // // Route to handle the update of agent banking details
        Route::put('/agent/{id}/update-agent-banking-details', [AgentController::class, 'updateBankingDetails'])->name('update.agent.banking.details');

        /********************* CLIENT  ***********************/
        // Route to deactivate the client
        Route::get('/client/{id}/deactivate-client', [ClientController::class, 'deactivateClient'])->name('deactivate.client');

        // Route to activate the client
        Route::get('/client/{id}/activate-client', [ClientController::class, 'activateClient'])->name('activate.client');

        /********************* CLIENT IDENTITY ***********************/

        // Route to view the client identity details
        Route::get('/client/{id}/view-client-identity', [ClientController::class, 'viewClientIdentity'])->name('view.client.identity');

        // Route to edit the client identity details
        Route::get('/client/{id}/edit-client-identity', [ClientController::class, 'editClientIdentity'])->name('edit.client.identity');

        // Route to handle the update of client identity details
        Route::put('/client/{id}/update-client-identity', [ClientController::class, 'updateClientIdentity'])->name('update.client.identity');

        /********************* CLIENT  PEP INFO ***********************/

        // Route to view the client PEP info
        Route::get('/client/{id}/view-client-pep-info', [ClientController::class, 'viewPEPInfo'])->name('view.client.pep.info');

        // Route to edit the client PEP info
        Route::get('/client/{id}/edit-client-pep-info', [ClientController::class, 'editPEPInfo'])->name('edit.client.pep.info');

        // Route to handle the update of client PEP info
        Route::put('/client/{id}/update-client-pep-info', [ClientController::class, 'updatePEPInfo'])->name('update.client.pep.info');

        /********************* CLIENT EMPLOYMENT DETAILS ***********************/

        // Route to view the client employment details
        Route::get('/client/{id}/view-client-employment-details', [ClientController::class, 'viewEmploymentDetails'])->name('view.client.employment.details');

        // Route to edit the client employment details
        Route::get('/client/{id}/edit-client-employment-details', [ClientController::class, 'editEmploymentDetails'])->name('edit.client.employment.details');

        // Route to handle the update of client employment details
        Route::put('/client/{id}/update-client-employment-details', [ClientController::class, 'updateEmploymentDetails'])->name('update.client.employment.details');

        /********************* CLIENT INDIVIDUAL WEALTH AND INCOME ***********************/

        // Route to view the client individual wealth and income details
        Route::get('/client/{id}/view-client-wealth-income', [ClientController::class, 'viewWealthIncome'])->name('view.client.wealth.income');

        // Route to edit the client individual wealth and income details
        Route::get('/client/{id}/edit-client-wealth-income', [ClientController::class, 'editIndividualWealthIncome'])->name('edit.client.wealth.income');

        // Route to handle the update of client individual wealth and income details
        Route::put('/client/{id}/update-client-individual-wealth-income', [ClientController::class, 'updateIndividualWealthIncome'])->name('update.client.individual.wealth.income');

        /********************* CLIENT BANKING DETAILS ***********************/

        // Route to browse the client banking details
        Route::get('/client/{client_id}/banking-details', [ClientController::class, 'browseBankingDetails'])
            ->name('browse.client.banking.details');

        // Route to view the client banking details
        Route::get('/client/{client_id}/banking-details/{id}', [ClientController::class, 'viewBankingDetails'])
            ->name('view.client.banking.details');

        // Route to edit the client banking details
        Route::get('/client/{client_id}/banking-details/edit/{id}', [ClientController::class, 'editBankingDetails'])
            ->name('edit.client.banking.details');

        // Route to update the update of client banking details
        Route::put('/client/{client_id}/banking-details/update/{id}', [ClientController::class, 'updateBankingDetails'])
            ->name('update.client.banking.details');

        // Route to create new client banking details
        Route::get('/client/{id}/banking-details/create', [ClientController::class, 'createBankingDetails'])
            ->name('create.client.banking.details');

        // Route to store new client banking details
        Route::post('/client/{id}/banking-details/store', [ClientController::class, 'storeBankingDetails'])
            ->name('store.client.banking.details');

        // Route to delete client banking details
        Route::delete('/client/{client_id}/banking-details/delete/{id}', [ClientController::class, 'deleteBankingDetails'])
            ->name('delete.client.banking.details');

        /********************* CLIENT BENEFICIARIES ***********************/

        // Route to browse client beneficiaries
        Route::get('/client/{client_id}/beneficiary', [ClientController::class, 'browseBeneficiaries'])
            ->name('browse.client.beneficiaries');

        // Route to view client beneficiary
        Route::get('/client/{client_id}/beneficiary/{id}', [ClientController::class, 'viewBeneficiary'])
            ->name('view.client.beneficiary');

        // Route to edit client beneficiaries
        Route::get('/client/{client_id}/beneficiary/edit/{id}', [ClientController::class, 'editBeneficiary'])
            ->name('edit.client.beneficiaries');

        // Route to update client beneficiaries
        Route::put('/client/{client_id}/beneficiary/update/{id}', [ClientController::class, 'updateBeneficiary'])
            ->name('update.client.beneficiaries');

        // Route to create new client beneficiaries
        Route::get('/client/{id}/beneficiary/create', [ClientController::class, 'createBeneficiary'])
            ->name('create.client.beneficiaries');

        // Route to store new client beneficiaries
        Route::post('/client/{id}/beneficiary/store', [ClientController::class, 'storeBeneficiary'])
            ->name('store.client.beneficiaries');

        /********************* CLIENT BENEFICIARIES GUARDIAN ***********************/

        // Route to browse client beneficiaries guardians
        Route::get('/client/{client_id}/beneficiary-guardians', [ClientController::class, 'browseBeneficiaryGuardians'])
            ->name('browse.client.beneficiaries.guardian');

        // Route to view client beneficiaries guardians
        Route::get('/client/{client_id}/beneficiary-guardians/{id}', [ClientController::class, 'viewBeneficiaryGuardians'])
            ->name('view.client.beneficiary.guardian');

        // Route to edit client beneficiaries guardians
        Route::get('/client/{client_id}/beneficiary-guardians/edit/{id}', [ClientController::class, 'editBeneficiaryGuardian'])
            ->name('edit.client.beneficiaries.guardian');

        // Route to update client beneficiaries guardians
        Route::put('/client/{client_id}/beneficiary-guardians/update/{id}', [ClientController::class, 'updateBeneficiaryGuardian'])
            ->name('update.client.beneficiaries.guardian');

        // Route to create new client beneficiaries guardians
        Route::get('/client/{id}/beneficiary-guardians/create', [ClientController::class, 'createBeneficiaryGuardian'])
            ->name('create.client.beneficiaries.guardian');

        // Route to store new client beneficiaries guardians
        Route::post('/client/{id}/beneficiary-guardians/store', [ClientController::class, 'storeBeneficiaryGuardian'])
            ->name('store.client.beneficiaries.guardian');

        /********************* Corporate Client***********************/
        //Route to view corporate director
        Route::get('/corporate-client/{id}/corporate-user-details', [CorporateClientController::class, 'viewCorporateDirector'])
            ->name('view.corporate.user.details');

        //Route to edit corporate director
        Route::get('/corporate-client/{id}/edit-corporate-user-details', [CorporateClientController::class, 'editCorporateDirector'])
            ->name('edit.corporate.user.details');

        //Route to remove corporate documents
        Route::get('/corporate-client/{id}/remove-corporate-user-details/{file}', [CorporateClientController::class, 'removeCorporateDirector'])
            ->name('remove.corporate.file');

        // Route to handle the update of Corporate wealth and income
        Route::put('/corporate-client/{id}/update-corporate-user-details', [CorporateClientController::class, 'updateCorporateDirector'])
            ->name('update.corporate.user.details');

        //Route to view corporate client wealth and income
        Route::get('/corporate-client/{id}/corporate-client-wealth-income', [CorporateClientController::class, 'viewWealthIncome'])
            ->name('view.corporate.wealth.income');

        // Route to edit Corporate wealth and income
//    Route::get('/corporate-client/{corporate_client_id}/edit-corporate-wealth-income', [CorporateClientController::class, 'editCorporateWealthIncome'])
//        ->name('edit.corporate.wealth.income');

        // Route to handle the update of Corporate wealth and income
//    Route::put('/corporate-client/{corporate_client_id}/update-corporate-wealth-income', [CorporateClientController::class, 'updateCorporateWealthIncome'])
//        ->name('update.corporate.wealth.income');

        // Route to view Corporate Pep Info
        Route::get('/corporate-client/{corporate_client_id}/corporate-pep-info', [CorporateClientController::class, 'viewPEPInfo'])
            ->name('view.corporate.pep.info');

        // Route to edit Corporate Pep Info
//    Route::get('/corporate-client/{corporate_client_id}/edit-corporate-pep-info', [CorporateClientController::class, 'editCorporatePEPInfo'])
//        ->name('edit.corporate.pep.info');

        // Route to handle the update of Corporate Pep Info
//    Route::put('/corporate-client/{id}/update-corporate-pep-info', [CorporateClientController::class, 'updateCorporatePEPInfo'])
//        ->name('update.corporate.pep.info');

        //Route to edit Corporate Client
//    Route::get('/corporate-client/{corporate_client_id}/edit-corporate', [CorporateClientController::class, 'editCorporateClient'])
//        ->name('edit.corporate');

        // Route to handle the update of Corporate Client Shareholder
//    Route::put('/corporate-client/{id}/update-corporate-client', [CorporateClientController::class, 'updateCorporateClient'])->name('update.corporate.client');

        //Route to browse Corporate Client Shareholder
        Route::get('/corporate-client/{corporate_client_id}/corporate-client-shareholders', [CorporateClientController::class, 'browseCorporateShareholders'])
            ->name('browse.corporate.shareholders');

        //Route to view Corporate Client Shareholder
        Route::get('/corporate-client/{corporate_client_id}/corporate-client-shareholder/{shareholder_id}', [CorporateClientController::class, 'viewCorporateShareholder'])
            ->name('read.corporate.shareholder');

        //Route to edit Corporate Client Shareholder
//    Route::get('/corporate-client/{corporate_client_id}/edit-corporate-client-shareholder/{shareholder_id}', [CorporateClientController::class, 'editCorporateShareholder'])
//        ->name('edit.corporate.shareholder');

        // Route to handle the update of Corporate Client Shareholder
//    Route::put('/corporate-client/{corporate_client_id}/update-corporate-shareholder/{shareholder_id}', [CorporateClientController::class, 'updateCorporateShareholder'])->name('update.corporate.shareholder');

        //Route to delete Corporate Client Shareholder
        Route::get('/corporate-client/{corporate_client_id}/delete-corporate-client-shareholder/{shareholder_id}', [CorporateClientController::class, 'deleteCorporateShareholder'])
            ->name('delete.corporate.shareholder');

        //Route to browse Corporate Banking Details
        Route::get('/corporate-client/{corporate_client_id}/browse-corporate-banking-details', [CorporateClientController::class, 'browseCorporateBankingDetails'])
            ->name('browse.corporate.banking.details');

        //Route to view Corporate Banking Details
        Route::get('/corporate-client/{corporate_client_id}/view-corporate-banking-details/{bankDetails_id}', [CorporateClientController::class, 'viewCorporateBankingDetails'])
            ->name('read.corporate.banking.details');

        Route::get('/phpinfo', function () {
            return phpinfo();
        })->name('phpinfo');

        Route::get('/test-aws-config', function () {
            return response()->json([
                'AWS_ACCESS_KEY_ID'     => env('AWS_ACCESS_KEY_ID'),
                'AWS_SECRET_ACCESS_KEY' => env('AWS_SECRET_ACCESS_KEY'),
                'AWS_DEFAULT_REGION'    => env('AWS_DEFAULT_REGION'),
                'AWS_BUCKET'            => env('AWS_BUCKET'),
                'AWS_URL'               => env('AWS_URL'),
                'AWS_ENDPOINT'          => env('AWS_ENDPOINT'),
            ]);
        });

        Route::get('/env-path', function () {
            dd(app()->environmentFilePath());
        });

        // Route to edit Corporate Pep Info
//    Route::get('/corporate-client/{corporate_client_id}/edit-corporate-pep-info', [CorporateClientController::class, 'editCorporatePEPInfo'])
//        ->name('edit.corporate.pep.info');

        // Route to handle the update of Corporate Pep Info
//    Route::put('/corporate-client/{id}/update-corporate-pep-info', [CorporateClientController::class, 'updateCorporatePEPInfo'])
//        ->name('update.corporate.pep.info');

        //Route to edit Corporate Client
//    Route::get('/corporate-client/{corporate_client_id}/edit-corporate', [CorporateClientController::class, 'editCorporateClient'])
//        ->name('edit.corporate');

        // Route to handle the update of Corporate Client Shareholder
//    Route::put('/corporate-client/{id}/update-corporate-client', [CorporateClientController::class, 'updateCorporateClient'])->name('update.corporate.client');

        //Route to browse Corporate Client Shareholder
        Route::get('/corporate-client/{corporate_client_id}/corporate-client-shareholders', [CorporateClientController::class, 'browseCorporateShareholders'])
            ->name('browse.corporate.shareholders');

        //Route to edit Corporate Banking Details
//    Route::get('/corporate-client/{corporate_client_id}/edit-corporate-banking-details/{bankDetails_id}', [CorporateClientController::class, 'editCorporateBankingDetails'])
//        ->name('edit.corporate.banking.details');

        // Route to handle the update of Corporate Banking Details
//    Route::put('/corporate-client/{corporate_client_id}/update-corporate-banking-details', [CorporateClientController::class, 'updateCorporateBankingDetails'])->name('update.corporate.banking.details');

        //Route to delete Corporate Client Corporate Banking Details
        Route::get('/corporate-client/{corporate_client_id}/corporate-banking-details/{bankDetails_id}', [CorporateClientController::class, 'deleteCorporateBankingDetails'])
            ->name('delete.corporate.banking.details');

        //Route to browse Corporate Beneficiaries
        Route::get('/corporate-client/{corporate_client_id}/corporate-beneficiaries', [CorporateClientController::class, 'browseCorporateBeneficiaries'])
            ->name('browse.corporate.beneficiaries');

        //Route to view Corporate Beneficiary
        Route::get('/corporate-client/{corporate_client_id}/corporate-beneficiaries/{beneficiary_id}', [CorporateClientController::class, 'viewCorporateBeneficiary'])
            ->name('read.corporate.beneficiary');

        //Route to browse Corporate Beneficiaries Guardians
        Route::get('/corporate-client/{corporate_client_id}/corporate-guardian', [CorporateClientController::class, 'browseCorporateGuardians'])
            ->name('browse.corporate.guardians');

        //Route to view Corporate Beneficiary Guardian
        Route::get('/corporate-client/{corporate_client_id}/corporate-guardian/{guardian_id}', [CorporateClientController::class, 'viewCorporateGuardian'])
            ->name('read.corporate.guardian');

        // Route to approve corporate profile
        Route::get('/corporate-client/{id}/approve', [CorporateClientController::class, 'approveCorporateClient'])->name('corporate-client.approve');

        // Route to reject corporate profile
        Route::get('/corporate-client/{id}/reject', [CorporateClientController::class, 'rejectCorporateClient'])->name('corporate-client.reject');

        /********************* PRODUCT ****************************/

        // Route to browse Early Redemption
        Route::get('/product/{id}/early-redemption', [ProductController::class, 'browseProductEarlyRedemption'])
            ->middleware('can:browse_early_redemption')
            ->name('browse.product.early.redemption');

        // Route to create Early Redemption
        Route::get('/product/{id}/early-redemption/create', [ProductController::class, 'createProductEarlyRedemption'])
            ->middleware('can:add_early_redemption')
            ->name('create.product.early.redemption');

        // Route to store new Early Redemption
        Route::post('/product/{id}/early-redemption/store', [ProductController::class, 'storeProductEarlyRedemption'])
            ->middleware('can:add_early_redemption')
            ->name('store.product.early.redemption');

        // Route to view Early Redemption
        Route::get('/product/{id}/early-redemption/{early_redemption_id}', [ProductController::class, 'viewProductEarlyRedemption'])
            ->middleware('can:read_early_redemption')
            ->name('view.product.early.redemption');

        // Route to edit Early Redemption
        Route::get('/product/{id}/early-redemption/{early_redemption_id}/edit', [ProductController::class, 'editProductEarlyRedemption'])
            ->middleware('can:edit_early_redemption')
            ->name('edit.product.early.redemption');

        Route::put('/product/{id}/early-redemption/{early_redemption_id}/update', [ProductController::class, 'updateProductEarlyRedemption'])
            ->middleware('can:edit_early_redemption')
            ->name('update.product.early.redemption');

        // Route to delete Early Redemption
        Route::delete('/product/{id}/early-redemption/{early_redemption_id}/delete', [ProductController::class, 'deleteProductEarlyRedemption'])
            ->middleware('can:delete_early_redemption')
            ->name('delete.product.early-redemption');

        // Route to browse Commission Configuration
        Route::get('/product/{id}/commission-config', [ProductController::class, 'browseProductCommission'])
            ->name('browse.product.commission.config');

        // Route to create Commission Configuration
        Route::get('/product/{id}/commission-config/create', [ProductController::class, 'createProductCommission'])
            ->name('create.product.commission.config');

        // Route to store new Commission Configuration
        Route::post('/product/{id}/commission-config/store', [ProductController::class, 'storeProductCommission'])
            ->name('store.product.commission.config');

        // Route to view Commission Configuration
        Route::get('/product/{id}/commission-config/{commission_id}', [ProductController::class, 'viewProductCommission'])
            ->name('view.product.commission.config');

        // Route to edit Commission Configuration
        Route::get('/product/{id}/commission-config/{commission_id}/edit', [ProductController::class, 'editProductCommission'])
            ->name('edit.product.commission.config');

        // Route to update Commission Configuration
        Route::put('/product/{id}/commission-config/{commission_id}/update', [ProductController::class, 'updateProductCommission'])
            ->name('update.product.commission.config');

        // Route to browse Commission Agent Configuration
        Route::get('/product/{id}/commission-agent-config', [ProductController::class, 'browseProductCommissionAgent'])
            ->name('browse.product.commission.agent.config');

        // Route to create Commission Agent Configuration
        Route::get('/product/{id}/commission-agent-config/create', [ProductController::class, 'createProductCommissionAgent'])
            ->name('create.product.commission.agent.config');

        // Route to store Commission Agent Configuration
        Route::post('/product/{id}/commission-agent-config/store', [ProductController::class, 'storeProductCommissionAgent'])
            ->name('store.product.commission.agent.config');

        // Route to view Commission Agent Configuration
        Route::get('/product/{id}/commission-agent-config/{commission_agent_id}', [ProductController::class, 'viewProductCommissionAgent'])
            ->name('view.product.commission.agent.config');

        // Route to edit Commission Agent Configuration
        Route::get('/product/{id}/commission-agent-config/{commission_agent_id}/edit', [ProductController::class, 'editProductCommissionAgent'])
            ->name('edit.product.commission.agent.config');

        // Route to update Commission Agent Configuration
        Route::put('/product/{id}/commission-agent-config/{commission_agent_id}/update', [ProductController::class, 'updateProductCommissionAgent'])
            ->name('update.product.commission.agent.config');

        /********************* PRODUCT ORDER***********************/

        // Route to view the product order client details
        Route::get('/product-order/{id}/client-details', [ProductOrderController::class, 'viewClientDetails'])
            ->name('product-order.client-details');

        // Route to view the product order corporate client details
        Route::get('/product-order/{id}/corporate-details', [ProductOrderController::class, 'viewCorporateClientDetails'])
            ->name('product-order.corporate-details');

        // Route to browse product order shareholder details
        Route::get('/product-order/{id}/shareholders', [ProductOrderController::class, 'browseShareholders'])
            ->name('product-order.shareholders');

        // Route to view the product order shareholder details
        Route::get('/product-order/{id}/shareholders/{shareholder_id}', [ProductOrderController::class, 'viewShareholder'])
            ->name('product-order.shareholder');

        // Route to view the product order banking details
        Route::get('/product-order/{id}/banking-details', [ProductOrderController::class, 'viewBankingDetails'])
            ->name('product-order.banking-details');

        // Route to edit the product order banking details
        Route::get('/product-order/{id}/banking-details/{banking_id}/edit', [ProductOrderController::class, 'editBankingDetails'])
            ->name('product-order.edit-banking-details');

        // Route to update the product order banking details
        Route::put('/product-order/{id}/banking-details/{banking_id}/update', [ProductOrderController::class, 'updateBankingDetails'])
            ->name('product-order.update-banking-details');

        // Route to browse product order beneficiaries details
        Route::get('/product-order/{id}/beneficiaries', [ProductOrderController::class, 'browseBeneficiaries'])
            ->name('product-order.beneficiaries');

        // Route to view the product order beneficiary details
        Route::get('/product-order/{id}/beneficiaries/{beneficiary_id}', [ProductOrderController::class, 'viewBeneficiary'])
            ->name('product-order.beneficiary');

        // Route to view product order beneficiaries guardians details
        Route::get('/product-order/{id}/beneficiary/{beneficiary_id}/guardians', [ProductOrderController::class, 'viewBeneficiaryGuardians'])
            ->name('product-order.beneficiary.guardians');

        // Route to view the product order document
        Route::get('/product-order/{id}/view-product-order-document', [ProductOrderController::class, 'viewDocument'])
            ->name('product-order.document');

        // Browse routes for product order checker and product order approver
        Route::get('product-order-finance', [ProductOrderController::class, 'showProductOrderFinance'])
            ->middleware('can:browse_product_order_finance')
            ->name('product_order_finance.show');

        Route::get('product-order-checker', [ProductOrderController::class, 'showProductOrderChecker'])
            ->middleware('can:browse_product_order_checker')
            ->name('product_order_checker.show');

        Route::get('product-order-approver', [ProductOrderController::class, 'showProductOrderApprover'])
            ->middleware('can:browse_product_order_approver')
            ->name('product_order_approver.show');

        // Edit and update routes for product order finance
        Route::get('product-order-finance/{id}', [ProductOrderController::class, 'redirectToEditProductOrderFinance']);

        Route::get('product-order-finance/{id}/edit', [ProductOrderController::class, 'editProductOrderFinance'])
            ->middleware('can:edit_product_order_finance')
            ->name('product_order_finance.edit');

        Route::put('product-order-finance/{id}/update', [ProductOrderController::class, 'updateProductOrderFinance'])
            ->middleware('can:edit_product_order_finance')
            ->name('product_order_finance.update');

        // Edit and update routes for product order checker
        Route::get('product-order-checker/{id}', [ProductOrderController::class, 'redirectEditProductOrderChecker']);

        Route::get('product-order-checker/{id}/edit', [ProductOrderController::class, 'editProductOrderChecker'])
            ->middleware('can:edit_product_order_checker')
            ->name('product_order_checker.edit');

        Route::put('product-order-checker/{id}/update', [ProductOrderController::class, 'updateProductOrderChecker'])
            ->middleware('can:edit_product_order_checker')
            ->name('product_order_checker.update');

        // Edit and update routes for product order approver
        Route::get('product-order-approver/{id}', [ProductOrderController::class, 'redirectEditProductOrderApprover']);

        Route::get('product-order-approver/{id}/edit', [ProductOrderController::class, 'editProductOrderApprover'])
            ->middleware('can:edit_product_order_approver')
            ->name('product_order_approver.edit');

        Route::put('product-order-approver/{id}/update', [ProductOrderController::class, 'updateProductOrderApprover'])
            ->middleware('can:edit_product_order_approver')
            ->name('product_order_approver.update');

        /********************* Agency***********************/
        // Route to add the agency banking details
        Route::get('/agency/{agency_id}/banking-details/create', [AgencyController::class, 'createBankingDetails'])
            ->name('create.agency.banking.details');

        // Route to edit the agency banking details
        Route::get('/agency/{agency_id}/banking-details/edit/{id}', [AgencyController::class, 'editBankingDetails'])
            ->name('edit.agency.banking.details');

        // Route to update the update of agency banking details
        Route::put('/agency/{agency_id}/banking-details/update/{id}', [AgencyController::class, 'updateBankingDetails'])
            ->name('update.agency.banking.details');

        // Route to create new agency banking details
//        Route::get('/agency/{id}/banking-details/create', [AgencyController::class, 'createBankingDetails'])
//            ->name('create.agency.banking.details');

        // Route to store new agency banking details
        Route::post('/agency/{id}/banking-details/store', [AgencyController::class, 'storeBankingDetails'])
            ->name('store.agency.banking.details');

        // Route to view the agency banking details
        Route::get('/agency/{agency_id}/banking-details', [AgencyController::class, 'viewBankingDetails'])
            ->name('view.agency.banking.details');

        // Route to delete agency banking details
        Route::delete('/agency/{agency_id}/banking-details/delete/{id}', [AgencyController::class, 'deleteBankingDetails'])
            ->name('delete.agency.banking.details');

        /********************* Redemption Details***********************/
        // Route to browse all redemption details
        //Route::get('/redemption_details', [RedemptionDetailController::class, 'show'])->name('redemption_details.show');

        // Route to show the form to create a new redemption detail
//                Route::get('/redemption_details/create', [RedemptionDetailController::class, 'create'])->name('redemption_details.create');

        // Route to store a newly created redemption detail
//                Route::post('/redemption_details', [RedemptionDetailController::class, 'store'])->name('redemption_details.store');

        // Route to view a specific redemption detail by ID
//        Route::get('/redemption_details/{id}', [RedemptionDetailController::class, 'show'])->name('redemption_details.show');

        // Route to show the form to edit a specific redemption detail
        //Route::get('/redemption_details/{id}/edit', [RedemptionDetailController::class, 'edit'])->name('redemption_details.edit');

        // Route to update a specific redemption detail
        //Route::put('/redemption_details/{id}', [RedemptionDetailController::class, 'update'])->name('redemption_details.update');

        // Route to delete a specific redemption detail
        //Route::delete('/redemption_details/{id}', [RedemptionDetailController::class, 'destroy'])->name('redemption_details.destroy');

        /********************* Dividend History***********************/
        // Browse routes for dividend_checker and dividend_approval
        Route::post('dividend-history/{id}/generate-bank-file', [ProductDividendHistoryController::class, 'generateBankFile'])->name('dividend-history.generate-bank-file');
        Route::post('dividend-history/{id}/update-dividend-payment', [ProductDividendHistoryController::class, 'updateDividendPayment'])->name('dividend-history.update-dividend-payment');

        Route::get('dividend_checker', [ProductController::class, 'showDividendChecker'])
            ->middleware('can:browse_dividend_checker')
            ->name('dividend_checker.show');

        Route::get('dividend_approval', [ProductController::class, 'showDividendApprover'])
            ->middleware('can:browse_dividend_approval')
            ->name('dividend_approval.show');

        Route::get('dividend-report', [ProductController::class, 'getProductDividendCalculationHistoryQuestion'])
            ->middleware('can:browse_dividend_report')
            ->name('dividend-report.index');

        // Edit and update routes for dividend_checker
        Route::get('dividend_checker/{id}', [ProductController::class, 'redirectEditDividendChecker']);

        Route::get('dividend_checker/{id}/edit', [ProductController::class, 'editDividendChecker'])
            ->middleware('can:edit_dividend_checker')
            ->name('dividend_checker.edit');

        Route::put('dividend_checker/{id}/update', [ProductController::class, 'updateDividendChecker'])
            ->middleware('can:edit_dividend_checker')
            ->name('dividend_checker.update');

        // Edit and update routes for dividend_approval
        Route::get('dividend_approval/{id}', [ProductController::class, 'redirectEditDividendApprover']);

        Route::get('dividend_approval/{id}/edit', [ProductController::class, 'editDividendApprover'])
            ->middleware('can:edit_dividend_approval')
            ->name('dividend_approval.edit');

        Route::put('dividend_approval/{id}/update', [ProductController::class, 'updateDividendApprover'])
            ->middleware('can:edit_dividend_approval')
            ->name('dividend_approval.update');

        /********************* Withdrawal History***********************/
        // Browse routes for withdrawal_checker and withdrawal_approval

        Route::get('withdrawal-checker', [ProductEarlyRedemptionHistoryController::class, 'showWithdrawalChecker'])
            ->middleware('can:browse_withdrawal_checker')
            ->name('withdrawal_checker.show');

        Route::get('withdrawal-approver', [ProductEarlyRedemptionHistoryController::class, 'showWithdrawalApprover'])
            ->middleware('can:browse_withdrawal_approver')
            ->name('withdrawal_approver.show');

        // Edit and update routes for withdrawal_checker
        Route::get('withdrawal-checker/{id}/edit', [ProductEarlyRedemptionHistoryController::class, 'editWithdrawalChecker'])
            ->middleware('can:edit_withdrawal_checker')
            ->name('withdrawal_checker.edit');

        Route::put('withdrawal-checker/{id}/update', [ProductEarlyRedemptionHistoryController::class, 'updateWithdrawalChecker'])
            ->middleware('can:edit_withdrawal_checker')
            ->name('withdrawal_checker.update');

        // Edit and update routes for withdrawal_approval
        Route::get('withdrawal-approver/{id}/edit', [ProductEarlyRedemptionHistoryController::class, 'editWithdrawalApprover'])
            ->middleware('can:edit_withdrawal_approver')
            ->name('withdrawal_approver.edit');

        Route::put('withdrawal-approver/{id}/update', [ProductEarlyRedemptionHistoryController::class, 'updateWithdrawalApprover'])
            ->middleware('can:edit_withdrawal_approver')
            ->name('withdrawal_approver.update');

        Route::get('withdrawal-checker/{id}', [ProductEarlyRedemptionHistoryController::class, 'readWithdrawalChecker'])
            ->middleware('can:read_withdrawal_checker');

        Route::get('withdrawal-approver/{id}', [ProductEarlyRedemptionHistoryController::class, 'readWithdrawalApprover'])
            ->middleware('can:read_withdrawal_approver');

        Route::post('withdrawal-history/{id}/generate-bank-file', [ProductEarlyRedemptionHistoryController::class, 'generateBankFile'])->name('withdrawal-history.generate-bank-file');
        Route::post('withdrawal-history/{id}/update-withdrawal-payment', [ProductEarlyRedemptionHistoryController::class, 'updateWithdrawalPayment'])->name('withdrawal-history.update-withdrawal-payment');

        /********************* PRODUCT COMMISSION HISTORY ***********************/

        // Route to browse Agent Commission Dashboard
        Route::get('/agent-commission-dashboard', [ProductCommissionHistoryController::class, 'browseProductCommissionAgentDashboard'])
            ->middleware('can:browse_agent_commission_dashboard')
            ->name('browse.product.agent.commission.dashboard');

        // Route to browse Agent Commission Dashboard
        Route::get('/agency-commission-dashboard', [ProductCommissionHistoryController::class, 'browseProductCommissionAgencyDashboard'])
            ->middleware('can:browse_agency_commission_dashboard')
            ->name('browse.product.agency.commission.dashboard');

        // Checker browse, edit and update routes
        Route::get('commission_checker', [ProductCommissionHistoryController::class, 'showCommissionChecker'])
            ->middleware('can:browse_commission_checker')
            ->name('commission_checker.show');

        Route::get('commission_checker/{id}/edit', [ProductCommissionHistoryController::class, 'editCommissionChecker'])
            ->middleware('can:edit_commission_checker')
            ->name('commission_checker.edit');

        Route::put('commission_checker/{id}/update', [ProductCommissionHistoryController::class, 'updateCommissionChecker'])
            ->middleware('can:edit_commission_checker')
            ->name('commission_checker.update');

        Route::get('commission_checker/{id}', [ProductCommissionHistoryController::class, 'redirectEditCommissionChecker']);

        // Approver browse, edit and update routes
        Route::get('commission_approval', [ProductCommissionHistoryController::class, 'showCommissionApproval'])
            ->middleware('can:browse_commission_approval')
            ->name('commission_approval.show');

        Route::get('commission_approval/{id}/edit', [ProductCommissionHistoryController::class, 'editCommissionApprover'])
            ->middleware('can:edit_commission_approval')
            ->name('commission_approver.edit');

        Route::put('commission_approval/{id}/update', [ProductCommissionHistoryController::class, 'updateCommissionApprover'])
            ->middleware('can:edit_commission_approval')
            ->name('commission_approver.update');

        Route::get('commission_approval/{id}', [ProductCommissionHistoryController::class, 'redirectEditCommissionApprover']);

        Route::post('product-commission-history/{id}/generate-bank-file', [ProductCommissionHistoryController::class, 'generateBankFile'])->name('product-commission-history.generate-bank-file');
        Route::post('product-commission-history/{id}/update-commission-payment', [ProductCommissionHistoryController::class, 'updateCommissionPayment'])->name('product-commission-history.update-commission-payment');
    });

    /********************* PRODUCT TARGET RETURN***********************/
    //Used to reroute from Product BROSWE
    Route::get('product-target-return', [ProductTargetReturnController::class, 'index'])->name('voyager.product-target-return.index');

    /********************* PRODUCT AGREEMENT SCHEDULE***********************/
    //Used to reroute from Product BROSWE
    Route::get('product-agreement-schedule', [ProductAgreementScheduleController::class, 'index'])->name('voyager.product-agreement-schedule.index');

    /********************* PRODUCT DIVIDEND SCHEDULE***********************/
    //Used to reroute from Product BROSWE
    Route::get('product-dividend-schedule', [ProductDividendScheduleController::class, 'index'])->name('voyager.product-dividend-schedule.index');

    /********************* PRODUCT AGREEMENT DATE***********************/
    //Used to reroute from Product BROSWE
    Route::get('product-agreement-date', [ProductAgreementDateController::class, 'index'])->name('voyager.product-agreement-date.index');

    /****************************** Redemption Management *************************/
    // Browse routes for redemption_checker and redemption_approval
    Route::get('redemption-checker', [ProductRedemptionController::class, 'showRedemptionChecker'])
        ->middleware('can:browse_redemption_checker')
        ->name('redemption_checker.show');

    Route::get('redemption-approver', [ProductRedemptionController::class, 'showRedemptionApproval'])
        ->middleware('can:browse_redemption_approver')
        ->name('redemption_approver.show');

    // Edit and update routes for redemption_checker
    Route::get('redemption-checker/{id}', [ProductRedemptionController::class, 'readRedemptionChecker']);

    Route::get('redemption-checker/{id}/edit', [ProductRedemptionController::class, 'editRedemptionChecker'])
        ->middleware('can:edit_redemption_checker')
        ->name('redemption_checker.edit');

    Route::put('redemption-checker/{id}/update', [ProductRedemptionController::class, 'updateRedemptionChecker'])->name('redemption_checker.update');

    // Edit and update routes for redemption_approval
    Route::get('redemption-approver/{id}', [ProductRedemptionController::class, 'readRedemptionApprover']);

    Route::get('redemption-approver/{id}/edit', [ProductRedemptionController::class, 'editRedemptionApprover'])
        ->middleware('can:edit_redemption_approver')
        ->name('redemption_approver.edit');

    Route::put('redemption-approver/{id}/update', [ProductRedemptionController::class, 'updateRedemptionApprover'])
        ->middleware('can:edit_redemption_approver')
        ->name('redemption_approver.update');

    Route::post('product-redemption/{id}/generate-bank-file', [ProductRedemptionController::class, 'generateBankFile'])->name('product-redemption.generate-bank-file');
    Route::post('product-redemption/{id}/update-redemption-payment', [ProductRedemptionController::class, 'updateRedemptionPayment'])->name('product-redemption.update-redemption-payment');


    /****************************** Reallocation Management *************************/
    // Browse routes for redemption_checker and redemption_approval
    Route::get('product-reallocation-checker', [ProductReallocationController::class, 'showReallocationChecker'])->name('product_reallocation_checker.show');
    Route::get('product-reallocation-approver', [ProductReallocationController::class, 'showReallocationApproval'])->name('product_reallocation_approver.show');

    // Edit and update routes for redemption_checker
    Route::get('product-reallocation-checker/{id}', [ProductReallocationController::class, 'redirectEditReallocationChecker']);
    Route::get('product-reallocation-checker/{id}/edit', [ProductReallocationController::class, 'editReallocationChecker'])->name('product_reallocation_checker.edit');
    Route::put('product-reallocation-checker/{id}/update', [ProductReallocationController::class, 'updateReallocationChecker'])->name('product_reallocation_checker.update');

    // Edit and update routes for redemption_approval
    Route::get('product-reallocation-approver/{id}', [ProductReallocationController::class, 'redirectEditReallocationApprover']);
    Route::get('product-reallocation-approver/{id}/edit', [ProductReallocationController::class, 'editReallocationApprover'])->name('product_reallocation_approver.edit');
    Route::put('product-reallocation-approver/{id}/update', [ProductReallocationController::class, 'updateReallocationApprover'])->name('product_reallocation_approver.update');

    /****************************** Rollover Management *************************/
    // Browse routes for redemption_checker and redemption_approval
    Route::get('product-rollover-history-checker', [ProductRolloverHistoryController::class, 'showRolloverChecker'])->name('product_rollover_history_checker.show');
    Route::get('product-rollover-history-approver', [ProductRolloverHistoryController::class, 'showRolloverApproval'])->name('product_rollover_history_approver.show');

    // Edit and update routes for redemption_checker
    Route::get('product-rollover-history-checker/{id}', [ProductRolloverHistoryController::class, 'redirectEditRolloverChecker']);
    Route::get('product-rollover-history-checker/{id}/edit', [ProductRolloverHistoryController::class, 'editRolloverChecker'])->name('product_rollover_history_checker.edit');
    Route::put('product-rollover-history-checker/{id}/update', [ProductRolloverHistoryController::class, 'updateRolloverChecker'])->name('product_rollover_history_checker.update');

    // Edit and update routes for redemption_approval
    Route::get('product-rollover-history-approver/{id}', [ProductRolloverHistoryController::class, 'redirectEditRolloverApprover']);
    Route::get('product-rollover-history-approver/{id}/edit', [ProductRolloverHistoryController::class, 'editRolloverApprover'])->name('product_rollover_history_approver.edit');
    Route::put('product-rollover-history-approver/{id}/update', [ProductRolloverHistoryController::class, 'updateRolloverApprover'])->name('product_rollover_history_approver.update');

    Route::get('/agent-personal-details/{id}/edit', [AgentController::class, 'editAgentPersonalDetails'])->name('edit.agent.personal.details');
    Route::put('/agent-personal-details/{id}', [AgentController::class, 'updateAgentPersonalDetails'])->name('update.agent.personal.details');
});
