<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ClientDeactivatedMail extends Mailable
{
    use Queueable, SerializesModels;
    public $client;

    public function __construct($client)
    {
        $this->client = $client;
    }

    public function build()
    {
        return $this->subject('Citadel First App Delete Account Request')
            ->view('emails.client-deactivated');
    }
}
