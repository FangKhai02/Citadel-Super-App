<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\UserDetails;
use App\Models\BankDetails;

class AgentRoleSettings extends Model
{
    use HasFactory;

    protected $table = 'agent_role_settings';

}
