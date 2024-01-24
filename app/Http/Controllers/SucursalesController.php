<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Sucursales;
use App\Models\ComprobanteSerie;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx\Rels;

class SucursalesController extends Controller
{
    public function __constructor(){
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request){
        $authUser = auth('sanctum')->user();
        $datos = Sucursales::where([
            ["status", 1],
        ]);
        if(isset($request->searchTerm)){
            $datos = $datos->where("nombre_sucursal", "LIKE", "%".$request->searchTerm."%")->where("estado", 1);
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
        try{
            $sucursal = Sucursales::create($request->all());
            return response()->json($sucursal, 200);

        }catch(\Exception $e){
            return response()->json($e->getMessage(),500);
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
            $sucursal = Sucursales::findOrFail($id);
            return response()->json($sucursal, 200);
        }catch(\Exception $e){
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
            $sucursal = Sucursales::findOrFail($id);
            $sucursal->update($request->all());
            return response()->json($sucursal, 200);

        }catch(\Exception $e){
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
        try{
            $sucursal = Sucursales::findOrFail($id);
            $upd_data = array(
                'status'  =>  0
            );
            $sucursal->update($upd_data);
            return response()->json($sucursal, 200);

        }catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function combo(){
        try{
            $data = Sucursales::where('status', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
    
    public function series($id){
        try{
            $data = ComprobanteSerie::where('estado', 1)
                        ->where('id_sucursal', $id)
                        ->with(['documento'])
                        ->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function getMantenimiento(){
        try{
            $authUser = auth('sanctum')->user();
            $datos = Sucursales::select('mantenimiento_lentes', 'mantenimiento_productos')->findOrFail($authUser->id_sucursal);
            return response()->json($datos);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function updateMantenimiento(Request $request){
        try{
            $authUser = auth('sanctum')->user();
            $datos = Sucursales::findOrFail($authUser->id_sucursal);
            $datos->update([
                $request->field => $request->status
            ]);
            return response()->json($datos);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
}
