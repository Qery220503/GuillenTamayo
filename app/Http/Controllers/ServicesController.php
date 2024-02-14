<?php

namespace App\Http\Controllers;

use App\Models\TipoDocumento;
use App\Models\AfectacionIgv;
use App\Models\Anamnesis;
use App\Models\Departamento;
use App\Models\Provincia;
use App\Models\Distrito;
use App\Models\Ocupacion;
use App\Models\Productos;
use App\Models\OrigenDinero;
use App\Models\Proveedores;
use App\Models\Clinicas;
use App\Models\Doctores;
use App\Models\EmpresaConvenio;
use Illuminate\Http\Request;
use App\Models\TipoComprobante;
use App\Models\MedioPago;
use App\Models\PreciosLentes;
use App\Models\Sucursales;
use App\Models\CajaTurno;
use App\Models\Clientes;
use App\Models\OrdenLaboratorioEstados;
use App\Models\User;
use App\Models\ComprobanteEstado;
use App\Models\CalendarioFeriados;
use App\Models\Servicio;
use App\Models\StockProductoSucursal;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;

class ServicesController extends Controller
{

    public function tipos_documentos(){
        try{
            $data = TipoDocumento::all();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function codigo_afectacion_igv(){
        try{
            $data = AfectacionIgv::all();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function departamentos(){
        try{
            $data = Departamento::all();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function provincias($id_departamento){
        try{
            $data = Provincia::where('id_departamento', $id_departamento)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function distritos($id_provincia){
        try{
            $data = Distrito::where('id_provincia', $id_provincia)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function sucursales(){
        try{
            $data = Sucursales::where('status', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }


    public function ocupacion(){
        try{
            $data = Ocupacion::where('estado', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }


    public function buscarDniRuc(Request $request)
    {
        $urlDni = "https://apiperu.dev/api/dni/";
        $urlRuc = "https://apiperu.dev/api/ruc/";
        $token = "7c0d548772a5b9c006251f7a404bbaa955c5b201101c4fb1d3c021b02bf0ae5f";
        $url = "";
        if ($request->tipoDoc == 2) {
            $url = $urlRuc.$request->numDoc."?api_token=".$token;
            $json = file_get_contents($url);
            $datos = json_decode($json,true);

            if($datos["success"] == true){

                $retorno = array("success" => $datos["success"],
                                    "nombre_o_razon_social" => $datos["data"]["nombre_o_razon_social"],
                                    "direccion_completa" => $datos["data"]["direccion_completa"],
                                    "condicion" => $datos["data"]["condicion"],
                                    "estado" => $datos["data"]["estado"]
                                );
            }else{
                $retorno = array("success" => $datos["success"]);
            }

            return response()->json($retorno, 200);

        } elseif ($request->tipoDoc == 1) {
            //$url = $urlDni.$request->numDoc;
            $url = $urlDni.$request->numDoc."?api_token=".$token;
            $json = file_get_contents($url);
            $datos = json_decode($json,true);

            if($datos["success"] == true){
                $retorno = array(
                    "original_response" => $datos,
                    "success" => $datos["success"],
                    "result" => array(
                        "Nombres" => $datos["data"]["nombres"],
                        "Apellidos" => $datos["data"]["apellido_paterno"]." ".$datos["data"]["apellido_materno"],
                        "direccion_completa" => null /*$datos["data"]["direccion_completa"]*/));
            }else{
                $retorno = array("success" => $datos["success"]);
            }

            //$retorno = $datos;
            return response()->json($retorno, 200);

        } else {
            echo "Error";
        }
    }

    public function productos(){
        try{
            $data = Productos::select(
                'id_producto','codigo_producto','nombre_producto', 'codigo_varilla', 'precio_compra', 'precio_venta', 'cod_afectacion_igv', 'stock'
            )
            ->with('stock_sucursal')
            ->where('estado', 1)->get();

            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function servicios(){
        try{
            $data = Servicio::select('id_servicio','nombre_servicio','cod_afectacion_igv','precio_compra', 'precio_venta')->where('estado', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function origen_dinero(){
        try{
            $authUser = auth('sanctum')->user();
            $data = OrigenDinero::where('id_sucursal', $authUser->id_sucursal)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function searchProvider(Request $request){
        try{
            $user = Auth::user();
            $searchTerm = $request->keywords;
            $data = Proveedores::where([
                ["estado", 1],
            ]);

            $data = $data->where(function ($query) use ($searchTerm) {
                $query->where('nombre', 'like', "%{$searchTerm}%")
                    ->orWhere('nro_doc', 'like', "%{$searchTerm}%");
            })->get();
            return response()->json($data);

        }catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }


    public function clinicas(){
        try{
            $data = Clinicas::where('estado', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function doctores(){
        try{
            $data = Doctores::where('estado', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function empresas_convenio(){
        try{
            $data = EmpresaConvenio::where('estado', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function tipo_comprobante(){
        try{
            $data = TipoComprobante::where('id_tipo_comprobantes', '<>', 3)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
    public function tipo_comprobante_venta(){
        try{
            $data = TipoComprobante::whereIn('id_tipo_comprobantes',[1, 2])->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function medio_pago(){
        try{
            $data = MedioPago::all();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function caja_turnos(){
        try{
            $data = CajaTurno::all();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function buscarPaciente(Request $request){
        try{
            $data = Clientes::where('nro_documento', $request->nro_nro_documento)
                    ->where('cod_tipo_doc',$request->cod_tipo_doc )
                    ->first();

            return response()->json([
                'data' => $data,
                'success' => isset($data)
            ]);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function orden_lab_estados(){
        try{
            $data = OrdenLaboratorioEstados::all();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function usuarios(){
        try{
            $auth = auth('sanctum')->user();
            $data = User::where('id_sucursal', $auth->id_sucursal)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function comprobante_estados(){
        try{
            $data = ComprobanteEstado::all();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function dias_no_laborales(){
        try{
            $data = CalendarioFeriados::all()->pluck('fecha');
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }


}
