<?php

namespace App\Mail;

use App\Models\Clientes;
use App\Models\Cupon;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class CouponMail extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */

     public function __construct(
        public Cupon $coupon,
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
        return $this->view('mails.coupon')
                    ->with('coupon', $this->coupon)
                    ->subject('¡Hey, tenemos un regalo para tí, Guillen Tamayo!');
    
    }
}
