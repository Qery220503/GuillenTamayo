<?php

namespace App\Http\Controllers;

use App\Models\Doctores;
use Illuminate\Http\Request;
use Exception;

class DoctoresController extends Controller
{
    public function __constructor(){
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request){
        $authUser = auth('sanctum')->user();
        $datos = Doctores::where([
            ["estado", 1],
        ]);

        if(isset($request->nombres)){
            $datos->where("nombres", "LIKE", "%".$request->nombres."%")
                  ->orWhere("apellidos", "LIKE", "%".$request->nombres."%");
        }
        if(isset($request->nro_documento)){
            $datos->where("nro_documento", "LIKE", "%".$request->nro_documento."%");
        }
        if(isset($request->email)){
            $datos->where("email", "LIKE", "%".$request->email."%");
        }
        if(isset($request->nro_telefono)){
            $datos->where("nro_telefono", "LIKE", "%".$request->nro_telefono."%");
        }
        if(isset($request->porcentaje_comision)){
            $datos->where("porcentaje_comision", "LIKE", "%".$request->porcentaje_comision."%");
        }
        if(isset($request->enviar_correos)){
            $datos->where("enviar_correos", $request->enviar_correos);
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
            $doctor = Doctores::create([
                'nombres' => $request->nombres,
                'nro_documento' => $request->nombres,
                'fecha_nacimiento' => $request->fecha_nacimiento,
                'email' => $request->email,
                'enviar_correos' => $request->enviar_correos,
                'convenio' => $request->convenio,
                'nro_documento' => $request->nro_documento,
                'estado' => 1,
                'nro_telefono'=> $request->nro_telefono,
                'porcentaje_comision' => $request->porcentaje_comision
            ]);
            return response()->json($doctor, 200);
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
            $doctor = Doctores::findOrFail($id);
            return response()->json($doctor, 200);
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
            $doctor = Doctores::findOrFail($id);
            $doctor->update($request->all());
            return response()->json($doctor, 200);

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
            $data = Doctores::findOrFail($id);
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