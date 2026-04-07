<?php

// app/Policies/AgentPolicy.php
namespace App\Policies;

use App\Models\User;
use App\Models\Agent;
use Illuminate\Auth\Access\HandlesAuthorization;

class AgentPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can update the agent.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Agent  $agent
     * @return mixed
     */
    public function update(User $user, Agent $agent)
    {
        // Add custom authorization logic, for example:
        // Allow admins or authorized roles to update
        return $user->hasRole('admin') || $user->hasPermission('edit-agent-identity');
    }
}
