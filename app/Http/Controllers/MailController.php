<?php

namespace App\Http\Controllers;
use Mpdf\Mpdf;
use Illuminate\Http\Request;

class MailController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __invoke(Request $request)
    {
        return view('mails.multifocal');
        $html = view('Comanda');
        $file = 'pdf_' . 'pdf';
        $mpdf = new Mpdf(
            [
                'mode' => 'utf-8',
                'format' => [80, 220],
                'margin_top' => 2,
                'margin_right' => 5,
                'margin_bottom' => 0,
                'margin_left' => 5
            ]
        );
        $mpdf->WriteHTML($html);
        $mpdf->Output($file, 'I');
    }
}
