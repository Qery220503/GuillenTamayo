<?php

namespace App\Http\Controllers;

use App\Models\Anamnesis;
use App\Models\Comprobante;
use App\Models\Encuesta;
use App\Models\OrdenLaboratorio;
use App\Models\Productos;
use App\Models\Servicio;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx\Rels;

use Maatwebsite\Excel\Facades\Excel;
use App\Exports\Reports\CuadroGeneralExport;
use App\Exports\Reports\DeudasPendientesExport;

class ReportesController extends Controller
{
    /**
     *
     *
     * @return \Illuminate\Http\Response
     */
    private function getMedidaOrden($id_orden){
        $orden_lab = OrdenLaboratorio::findOrFail($id_orden);      
        $refraccion_lejos = $orden_lab->refraccion_lejos;        
        $refraccion_cerca = $orden_lab->refraccion_cerca; 
        $refraccion_intermedia = $orden_lab->refraccion_intermedia; 
        $receta = "";
        if($refraccion_lejos != null){
            $refraccion = $refraccion_lejos;
            $receta .= 'LEJOS: OD: ESF: ' . $refraccion['od']['esfera'] . ' CIL: ' . $refraccion['od']['cilindro'] . ' EJE: ' . $refraccion['od']['eje'] . ' ADD:' . $orden_lab->adiciones['od'] . ' DNP:' . $refraccion['od']['dnp'] . ' ALT: ' . $refraccion['od']['alt'] . ' PRISM: ' . $refraccion['od']['prismas'] . ' A.V.C.C: ' . $refraccion['od']['avcc'].
                'OI: ESF: ' . $refraccion['oi']['esfera'] . ' CIL: ' . $refraccion['oi']['cilindro'] . ' EJE: ' . $refraccion['oi']['eje'] . ' ADD:' . $orden_lab->adiciones['oi'] . ' DNP:' . $refraccion['oi']['dnp'] . ' ALT: ' . $refraccion['oi']['alt'] . ' PRISM: ' . $refraccion['oi']['prismas'] . ' A.V.C.C: ' . $refraccion['od']['avcc'];
        }
       
        if($refraccion_cerca != null){
            $refraccion = $refraccion_cerca;
            $receta .= 'CERCA: OD: ESF: ' . $refraccion['od']['esfera'] . ' CIL: ' . $refraccion['od']['cilindro'] . ' EJE: ' . $refraccion['od']['eje'] . ' ADD:' . $orden_lab->adiciones['od'] . ' DNP:' . $refraccion['od']['dnp'] . ' ALT: ' . $refraccion['od']['alt'] . ' PRISM: ' . $refraccion['od']['prismas'] . ' A.V.C.C: ' . $refraccion['od']['avcc'].
                'OI: ESF: ' . $refraccion['oi']['esfera'] . ' CIL: ' . $refraccion['oi']['cilindro'] . ' EJE: ' . $refraccion['oi']['eje'] . ' ADD:' . $orden_lab->adiciones['oi'] . ' DNP:' . $refraccion['oi']['dnp'] . ' ALT: ' . $refraccion['oi']['alt'] . ' PRISM: ' . $refraccion['oi']['prismas'] . ' A.V.C.C: ' . $refraccion['od']['avcc'];
        }

        if($refraccion_intermedia != null){
            $refraccion = $refraccion_intermedia;
            $receta .= 'INTERMEDIA: OD: ESF: ' . $refraccion['od']['esfera'] . ' CIL: ' . $refraccion['od']['cilindro'] . ' EJE: ' . $refraccion['od']['eje'] . ' ADD:' . $orden_lab->adiciones['od'] . ' DNP:' . $refraccion['od']['dnp'] . ' ALT: ' . $refraccion['od']['alt'] . ' PRISM: ' . $refraccion['od']['prismas'] . ' A.V.C.C: ' . $refraccion['od']['avcc'].
                'OI: ESF: ' . $refraccion['oi']['esfera'] . ' CIL: ' . $refraccion['oi']['cilindro'] . ' EJE: ' . $refraccion['oi']['eje'] . ' ADD:' . $orden_lab->adiciones['oi'] . ' DNP:' . $refraccion['oi']['dnp'] . ' ALT: ' . $refraccion['oi']['alt'] . ' PRISM: ' . $refraccion['oi']['prismas'] . ' A.V.C.C: ' . $refraccion['od']['avcc'];
        }

        return $receta;
    }
    public function cuadroGeneral(Request $request)
    {
        $start = new Carbon($request->begin);
        $end = new Carbon($request->end);

        $comprobantes = Comprobante::whereBetween('fecha_emision',[$start, $end])
                            ->with(['serie', 'cliente', 'estado_comprobante', 'usuario'])
                            ->orderBy('id_comprobante', 'DESC')
                            ->get();
        //return response()->json($comprobantes, 500);
        $data = [];

        foreach($comprobantes as $comp){
            $detalle_comp = DB::table('comprobantes_detalles')
                            ->where('id_comprobante', $comp->id_comprobante)
                            ->get();
            $flag_orden = 0;
            $monturas_consideradas = [];
            foreach($detalle_comp as $dcomp){
                $fecha_orden = "";
                $fecha_cpe = $comp->fecha_emision;
                $estado_comprobante = $comp->estado_comprobante->nombre_estado;
                $cpe = "";
                $nombre = "SIN CLIENTE";
                $doc = "11111111";
                $telefono = "N/A";
                $correo = "N/A";
                $montura = "PROPIA"; //DEL CLIENTE
                $color_montura = "N/A";
                $precio_montura = "0.00";
                $material_lentes = "N/A";
                $disenio_lentes = "N/A";
                $tratamiento_lentes = "N/A";
                $fotocroma_lentes = "N/A";
                $fabricacion_lentes = "N/A";
                $medida = "N/A";
                $cantidad_lentes = 0;
                $ganancia_bruta = 0;
                $precio_lentes = 0;
                $proveedor_lentes = "N/A";
                $fecha_entrega = $comp->fecha_emision;
                $fecha_entregado = $comp->fecha_emision;
                $monto_total_venta = $comp->total;
                $porcen_dscto = $comp->dscto_porcentaje;
                $estado_trabajo = "N/A";
                $compra_laboratorio = 0;
                $compra_montura = 0;
                $nombre_clinica = "N/A";
                $nombre_doctor = "N/A";
                $nombre_convenio = "N/A";
                $nombre_vendedor = "N/A";
                $tipo_montura = "N/A";
                $nombre_servicio = "";
                $satisfaccion = "N/A";
                

                //Flag que determina si se añade el item al arreglo
                $flag_add = 0;

                //Serie y Correlativo de comprobante
                $serie = !empty($comp->serie) ? $comp->serie['serie']."-" : "NP01-";
                $cpe = $serie.$comp->correlativo;

                if($comp->id_cliente){
                    //$cliente = $this->db->select("Nombre, Telefono1, Correo, Dni, Ruc")->where("id", $comp->Cliente_id)->get("cliente")->row();

                    $nombre = $comp->cliente['nombre_razon_social'];
                    $telefono = !empty($comp->cliente['telefono']) ? $comp->cliente['telefono'] : "N/A";
                    $correo = !empty($comp->cliente['email']) ? $comp->cliente['email'] : "N/A";
                    $doc = !empty($comp->cliente['nro_documento']) ? $comp->cliente['nro_documento']: "SIN DOCUMENTO";
                }

                //Buscamos encuesta asociada
                if($comp->id_orden_lab != null){
                    //$encuesta = $this->db->select("nivel_satisfac")->where("id_anamnesis", $comp->id_anamnesis)->where("estado", 1)->get("encuestas")->row();
                    $encuesta = Encuesta::where('id_comprobante', $comp->id_comprobante)->first();

                    if(isset($encuesta->nivel_satisfaccion)){
                        if($encuesta->nivel_satisfaccion == 1){
                            $satisfaccion = "Muy Mala";
                        }else if($encuesta->nivel_satisfaccion == 2){
                            $satisfaccion = "Mala";
                        }else if($encuesta->nivel_satisfaccion == 3){
                            $satisfaccion = "Regular";
                        }else if($encuesta->nivel_satisfaccion == 4){
                            $satisfaccion = "Buena";
                        }else if($encuesta->nivel_satisfaccion == 5){
                            $satisfaccion = "Muy Buena";
                        }
                    }
                }else{
                    $satisfaccion = "N/A";
                }

                if($comp->id_orden_lab != null && $flag_orden == 0){
                    $flag_orden = 1;
                    $flag_add = 1;
                    // Obtenemos orden de laboratorio
                    $orden = OrdenLaboratorio::with(['montura', 'lente', 'estadoComprobante', 'usuario'])->where('id_orden_laboratorio', $comp->id_orden_lab)->first();
                    $id_material_lente = $orden->id_precio_lentes;
                    //Fecha de orden
                    $fecha_orden = $orden->created_at;
                    //Fecha de entrega
                    $fecha_entrega = $orden->fecha_entrega;
                    //FALTA FECHA EN LA QUE FUE ENTREGADO
                    $fecha_entregado = $orden->fecha_entrega;
                    $pv_montura_db = $orden->id_montura;

                    if($pv_montura_db != null){
                        //$montura_get = $this->db->select("id, Precio, PrecioCompra, Nombre, categoria")->where("id", $pv_montura_db->meta_value)->get("producto")->row();
                        // obtenemos precio de montura
                        //$precio_montura = isset($montura_get->Precio) ? $montura_get->Precio:"0.00";
                        $precio_montura = $orden->montura['precio_venta'];
                        //Obtenemos Precio Compra
                        //$compra_montura = isset($montura_get->PrecioCompra) ? $montura_get->PrecioCompra:"0.00";
                        $compra_montura = $orden->montura['precio_compra'];
                        $montura = $orden->montura['nombre_producto'];

                        $tipo_montura = $orden->tipo_montura;

                        //Agregamos id de montura a nuestro arreglo
                        $monturas_consideradas[] = $orden->montura['id_producto'];
                    }
                    
                    //Obtenemos material de lente
                    $material_lentes = $orden->lente['material'];
                    //Obtenemos diseño de lente
                    $disenio_lentes =  $orden->lente['modelo'];
                    //Obtenemos tratamineto
                    $tratamiento_lentes = $orden->lente['tratamiento'];
                    //Obtenemos fotocromatico
                    $fotocroma_lentes = $orden->lente['fotocromatico'];
                    //Obtenemos fabricacion de lente
                    $fabricacion_lentes = $orden->lente['fabricacion'];
                    //Obtenemos Medida
                    $medida = $this->getMedidaOrden($comp->id_orden_lab);
                    //Cantidad lentes
                    $cantidad_lentes = 2;
                    //Obtenemos precio de lentes
                    $precio_lentes =  $orden->lente['precio_lente'];
                    //Obtenemos proveedor de lentes
                    $proveedor_lentes = $orden->lente['nombre_laboratorio'];
                    //Obtenemos Estado
                    $estado_trabajo = $orden->estadoComprobante['nombre_estados'];
                    //Total compra laboratorio
                    $compra_laboratorio = $orden->monto_compra_proyectado;
                    //Obtenemos factura de los lentes (si fuera el caso)
                    $factura_compra = "N/A";
                    if($orden->id_anamnesis != null){
                        //Obtener id de convenio, clinica y doctor
                        $anam_datos = Anamnesis::where('id_anamnesis', $orden->id_anamnesis)
                                        ->with(['clinica', 'doctor', 'empresa'])
                                        ->first();
                        //Obtener clinica
                        $nombre_clinica = ($anam_datos->id_clinica == 0 || $anam_datos->id_clinica == null) ? "Ninguna" : $anam_datos->clinica['nombre_clinica'];
                        //Obtener doctor
                        $nombre_doctor = ($anam_datos->id_doctor == 0 || $anam_datos->id_doctor == null) ? "Ninguno" : $anam_datos->doctor['nombres'];
                        //Obtener convenio
                        $nombre_convenio = ($anam_datos->id_empresa_convenio == 0 || $anam_datos->id_empresa_convenio == null) ? "Ninguno" : "";//$anam_datos->empresa['nombre_empresa'];
                        //Vendedor
                        $nombre_vendedor = $orden->usuario['name'];
                    }

                }
                
                //Excluimos monturas solares y oftalmicas de los productos adicionales

                //Buscamos productos adicionales
                //Aplicamos producto diferente de 0 para no mostrar productos fuera de inventario
                if(($dcomp->item_type == 1 && $flag_orden==0 && $comp->id_orden_lab == null && $dcomp->id_producto != null) || ($dcomp->item_type == 1 && $flag_orden==1 && $comp->id_orden_lab != null && $dcomp->id_producto != null && !in_array($dcomp->id_producto, $monturas_consideradas))){
                    $flag_add = 1;
                    $montura_get = Productos::where('id_producto', $dcomp->id_producto)->with(['categoria'])->first();
                    // obtenemos precio de montura
                    $precio_montura = isset($montura_get->precio_venta) ? $montura_get->precio_venta:"0.00";
                    //Obtenemos Precio Compra
                    $compra_montura = isset($montura_get->precio_compra) ? $montura_get->precio_compra:"0.00";
                    $montura = $montura_get->nombre_producto;
                    $tipo_montura = $montura_get->categoria['nombre_categoria'];
                    $nombre_vendedor = $comp->usuario['name'];
                }

                //Buscamos servicios adicionales
                if(($dcomp->item_type == 3 && $flag_orden==0 && $comp->id_orden_lab == null) || ($dcomp->item_type == 3 && $flag_orden==1 && $comp->id_orden_lab != null)){
                    $flag_add = 1;

                    $servicio = Servicio::where('id_servicio', $dcomp->id_servicio)->first();

                    //$servicio = $this->db->where("id", $dcomp->Producto_id)->get("servicio")->row();

                    $nombre_servicio = $servicio->nombre_servicio;
                    $montura = "N/A";

                    $nombre_vendedor =  $comp->usuario['name'];
                }

                $ganancia_bruta = $monto_total_venta - ($compra_montura + $compra_laboratorio);

                if($flag_add == 1){
                    $data[] = array(
                        "fecha_orden" => $fecha_orden,
                        "fecha_cpe" => $fecha_cpe,
                        "cpe" => $cpe,
                        "nombre" => $nombre,
                        "doc" => $doc,
                        "telefono" => $telefono,
                        "correo" => $correo,
                        "montura" => $montura,
                        "precio_montura" => $precio_montura,
                        "material_lentes" => $material_lentes,
                        "disenio_lentes" => $disenio_lentes,
                        "tratamiento_lentes" => $tratamiento_lentes,
                        "fabricacion_lentes" => $fabricacion_lentes,
                        "fotocroma_lentes" 	=> $fotocroma_lentes,
                        "medida" 			=> $medida,
                        "cantidad_lentes" 	=> $cantidad_lentes,
                        "precio_lentes" 	=> $precio_lentes,
                        "proveedor_lentes" 	=> $proveedor_lentes,
                        "fecha_entrega" 	=> $fecha_entrega,
                        "monto_total_venta" => $monto_total_venta,
                        "porcen_dscto" 		=> $porcen_dscto,
                        "ganancia_bruta" 	=> number_format($ganancia_bruta, 2),
                        "estado_trabajo"	=> $estado_trabajo,
                        "compra_laboratorio"=> $compra_laboratorio,
                        "compra_montura" 	=> $compra_montura,
                        "nombre_clinica" 	=> $nombre_clinica,
                        "nombre_doctor" 	=> $nombre_doctor,
                        "nombre_convenio" 	=> $nombre_convenio,
                        "nombre_vendedor" 	=> $nombre_vendedor,
                        "comprobante_compra"=> (isset($factura_compra)) ? $factura_compra : "N/A",
                        "fecha_entregado" 	=> $fecha_entregado,
                        "tipo_montura"  	=> $tipo_montura,
                        "nombre_servicio"	=> $nombre_servicio,
                        "satisfaccion"		=> $satisfaccion,
                        "estado_comprobante"=> $estado_comprobante
                    );
                }
            }
        }

        return response()->json($data);
    }


    public function cuadroGeneralExcel(Request $request)
    {
        $fileName = 'cuadro_general.xlsx';
        return Excel::download( new CuadroGeneralExport($request->begin, $request->end), $fileName);
    }

    public function deudasPendientes(Request $request){
        $data = Comprobante::where("saldo",">",0)->with(['cliente', 'serie', 'tipo_comprobante'])->paginate($request->perpage);
        return response()->json($data);
    }

    public function deudasPendientesExcel(Request $request){
        $fileName = 'deudas-comprobantes.xlsx';
        return Excel::download( new DeudasPendientesExport(), $fileName);
    }

}
