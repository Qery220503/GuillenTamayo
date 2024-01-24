<?php

namespace App\Http\Controllers;

use App\Models\Clinicas;
use Illuminate\Http\Request;
use Exception;

class ClinicasController extends Controller
{
    public function __constructor(){
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request){
        $authUser = auth('sanctum')->user();
        $datos = Clinicas::where([
            ["estado", 1],
            //["id_sucursal", $authUser->id_sucursal],
        ]);

        if(isset($request->nombre_clinica)){
            $datos->where("nombre_clinica", "LIKE", "%".$request->nombre_clinica."%");
        }
        if(isset($request->telefono_clinica)){
            $datos->where("telefono_clinica", "LIKE", "%".$request->telefono_clinica."%");
        }
        if(isset($request->email_clinica)){
            $datos->where("email_clinica", "LIKE", "%".$request->email_clinica."%");
        }
        if (isset($request->descuento)) {
            $datos->where("descuento", $request->descuento);
        }
        if(isset($request->afiliacion)){
            $datos->where("afiliacion", "LIKE", "%".$request->afiliacion."%");
        }
        if(isset($request->enviar_correos)){
            $datos->where("enviar_correos", "LIKE", "%".$request->enviar_correos."%");
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
            $marca_data = Clinicas::create($request->all());
            return response()->json($marca_data, 200);
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
            $producto = Clinicas::findOrFail($id);
            return response()->json($producto, 200);
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
            $producto = Clinicas::findOrFail($id);
            $producto->update($request->all());
            return response()->json($producto, 200);

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
    }

}
