<?php

namespace App\Mail;

use App\Models\Clientes;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class MultiFocalMail extends Mailable implements ShouldQueue
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(
      public Clientes $client
    )
    {}

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $image = env('APP_URL')."/images/illustrations/logo.png";
        return $this->view('mails.multifocal')
                    ->subject('¡Descubre cómo mejorar tu experiencia con tus nuevos lentes multifocales!')
                    ->with([
                        'image' => $image,
                        'message' => $this,
                    ]);
    }
}
