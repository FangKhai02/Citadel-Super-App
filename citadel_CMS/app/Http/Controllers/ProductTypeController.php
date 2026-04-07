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

class ProductTypeController extends VoyagerBaseController
{
}
