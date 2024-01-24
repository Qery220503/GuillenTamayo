<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\EmpresaConvenio;
use Exception;

class EmpresaConvenioController extends Controller
{
    public function __constructor(){
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request){
        $authUser = auth('sanctum')->user();
        $datos = EmpresaConvenio::where([
            ["estado", 1],
        ]);

        if(isset($request->nombre_empresa)){
            $datos->where("nombre_empresa", "LIKE", "%".$request->nombre_empresa."%");
        }
        if(isset($request->email_empresa)){
            $datos->where("email_empresa", "LIKE", "%".$request->email_empresa."%");
        }
        if(isset($request->telefono_empresa)){
            $datos->where("telefono_empresa", "LIKE", "%".$request->telefono_empresa."%");
        }
        if(isset($request->enviar_correos)){
            $datos->where("enviar_correos", "LIKE", "%".$request->enviar_correos."%");
        }
        if(isset($request->cobertura)){
            $datos->where("cobertura", "LIKE", "%".$request->cobertura."%");
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
            EmpresaConvenio::allowedToSave($request->ruc_empresa);
            $data = $request->all();
            if(!isset($data['descuento_cobertura']) || $data['descuento_cobertura'] == null){
                $data['descuento_cobertura'] = 0;
            }
            $empresa = EmpresaConvenio::create($data);
            return response()->json($empresa, 200);

        }catch(Exception $e){
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
            $empresa = EmpresaConvenio::findOrFail($id);
            return response()->json($empresa, 200);
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
            $empresa = EmpresaConvenio::findOrFail($id);
            $data = $request->all();
            if(!isset($data['descuento_cobertura']) || $data['descuento_cobertura'] == null){
                $data['descuento_cobertura'] = 0;
            }
            $empresa->update($data);
            return response()->json($empresa, 200);

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
        try{
            $empresa = EmpresaConvenio::findOrFail($id);
            $upd_data = array(
                'status'  =>  0
            );
            $empresa->update($upd_data);
            return response()->json($empresa, 200);

        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function combo(){
        try{
            $data = EmpresaConvenio::where('status', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
}
