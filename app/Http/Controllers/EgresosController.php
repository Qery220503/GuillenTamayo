<?php

namespace App\Http\Controllers;

use App\Models\Egresos;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Exception;
use Illuminate\Support\Facades\Auth;
use App\Models\Caja;

class EgresosController extends Controller
{
    public function __constructor(){
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request){
        $authUser = auth('sanctum')->user();
        $datos = Egresos::with(['mediopago','proveedor','usuario'])->where([
            ["estado", 1]
        ]);
        
        if(!empty($request->data)){
            $datos = $datos->where("nombre", "LIKE", "%".$request->data."%")->where("estado", 1);
        }
        return $datos->paginate($request->perpage);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            $auth = auth('sanctum')->user();
            $caja = Caja::whereDate('created_at', Carbon::now()->toDateString())
                ->where('estado', 1)
                ->first();
            if(!isset($caja)){
                return response()->json([
                    "success" => false,
                    "msg" => "No existe una caja abierta el dia de hoy"
                ]);
            }
            $egreso = Egresos::create([
                'descripcion' => $request->descripcion,
                'monto' => $request->monto,
                'id_caja' => ($request->origen == 1) ? $caja->id_caja : null,
                'origen' => $request->origen,
                'id_medio_pago' => $request->id_medio_pago,
                'id_proveedor' => $request->id_proveedor,
                'observaciones' => $request->observaciones,
                'id_user' => $auth->id,
                'fecha_egreso' => Carbon::now()->toDateString()
            ]);

            return response()->json($egreso, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try{
            //obtiene la sucursal con sus zonas
            $egreso = Egresos::findOrFail($id);
            return response()->json($egreso, 200);
        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try{
            $egreso = Egresos::findOrFail($id);
            $egreso->update($request->all());
            return response()->json($egreso, 200);

        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {
            $data = Egresos::findOrFail($id);
            $upd_data = array(
                'estado'  =>  0
            );
            $data->update($upd_data);
            return response()->json($data, 200);
            
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }
}
