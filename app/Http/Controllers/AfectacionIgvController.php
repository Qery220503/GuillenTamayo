<?php

namespace App\Http\Controllers;

use App\Models\AfectacionIgv;
use Illuminate\Http\Request;

class AfectacionIgvController extends Controller
{
    public function combo(){
        try{
            $data = AfectacionIgv::all();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
}
