<?php

namespace App\Http\Controllers;

use App\Models\Eps;
use Illuminate\Http\Request;

class EpsController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __invoke(Request $request)
    {
        return response()->json(Eps::with(['discounts'])->get());
    }
}
