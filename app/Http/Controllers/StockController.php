<?php

namespace App\Http\Controllers;

use App\Models\AlmacenMovimiento;
use Illuminate\Http\Request;

class StockController extends Controller
{
    public function __constructor(){
        $this->middleware('auth:sanctum');
    }
    
    public function index(Request $request){
        $authUser = auth('sanctum')->user();
        $datos = AlmacenMovimiento::with('tipo_movimiento')
        ->where([
            ["id_sucursal", $authUser->id_sucursal]
        ]);

        if(isset($request->fecha_inicio) && isset($request->fecha_fin)){
            $datos->whereBetween('created_at', [$request->fecha_inicio, $request->fecha_fin]);
        }
        if(isset($request->producto)){
            $datos->where("id_producto", $request->producto);
        }
        if(isset($request->estado)){
            $datos->where("id_tipo_movimiento", $request->estado);
        }
        
        $datos->orderByDesc('created_at');

        return $datos->paginate($request->perpage);
    }
}
