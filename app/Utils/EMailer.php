<?php

namespace App\Utils;

use App\Mail\RecoverEmail;
use App\Mail\BillingEmail;

use App\Mail\OrderConfirmEmail;
use App\Mail\OrderPendingEmail;
use App\Mail\OrderRejectEmail;
use App\Mail\PaymentRejectEmail;
use App\Mail\PaymentPaymeRejectEmail;
use App\Mail\InscriptionMail;
use App\Mail\InscriptionMailAccess;
use App\Mail\RegisterAccountEmail;
use Illuminate\Support\Facades\Mail;

class EMailer
{

    private static function getMailInstance($type, $data, $subject = null)
    {
        switch ($type) {
            case 'welcome_mail':
                return new InscriptionMail();
                break;
            default:
                return null;
        }
    }

    public static function send($type, $to, $data, $subject = null)
    {

        try {

            $instance = self::getMailInstance($type, $data, $subject);
            //echo "Send mail to ".$to; 
            $result = Mail::to($to)->send($instance);

            return $result;
        } catch (\Exception $e) {
            throw $e;
        }
    }
}
