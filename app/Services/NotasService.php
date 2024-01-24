<?php

namespace App\Services;

use App\Models\Clientes;
use App\Models\Comprobante;
use App\Models\NotaDetalle;
use App\Models\Nota;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class NotasService
{
    public static function enviar($id)
    {
        $nota = Nota::with(['serie', 'cliente', 'tipo_comprobante', 'comprobante'])->findOrFail($id);
        $comprobante = Comprobante::with('sucursal')->where('id_comprobante', $nota->id_comprobante)->first();
        $nota_detalle = NotaDetalle::with('unidad_medida')->where('id_nota', $id)->get();
        $cliente = Clientes::with('tipo_documento')->where('id_cliente', $nota->id_cliente)->first();
        $timestamp = $nota->fecha_emision;
        $date = Carbon::createFromFormat('Y-m-d H:i:s', $timestamp, 'America/Lima');
        $data = [
            "serie_documento" => $nota->serie['serie'],
            "numero_documento" => "#",
            "fecha_de_emision" =>  $date->format("Y-m-d"),
            "hora_de_emision" => $date->format("H:i"),
            "codigo_tipo_documento" => $nota->tipo_comprobante["codigo_sunat"],
            "codigo_tipo_nota" => "01",
            "motivo_o_sustento_de_nota" => $nota->descripcion,
            "codigo_tipo_moneda" => "PEN",
            "numero_orden_de_compra" => "",
            "documento_afectado" => [
                "external_id" => $nota->comprobante['external_id'],
            ],
            "datos_del_cliente_o_receptor" => [
                "codigo_tipo_documento_identidad" => $cliente->tipo_documento['codigo_sunat'],
                "numero_documento" => $cliente->nro_documento,
                "apellidos_y_nombres_o_razon_social" => $cliente->nombre_razon_social,
                "codigo_pais" => "PE",
                "ubigeo" => "", //$cliente->id_distrito
                "direccion" => $cliente->direccion,
                "correo_electronico" => $cliente->email,
                "telefono" => $cliente->telefono,
            ],
            "totales" => [
                "total_exportacion" => 0,
                "total_operaciones_gravadas" => $nota->subtotal,
                "total_operaciones_inafectas" => 0,
                "total_operaciones_exoneradas" => 0,
                "total_operaciones_gratuitas" => 0,
                "total_igv" => $nota->igv,
                "total_impuestos" => $nota->igv,
                "total_valor" => $nota->subtotal,
                "total_venta" => $nota->total,
            ],
            "items" => []
        ];
        $items = $nota_detalle->map(function ($detalle) {
            if($detalle->item_type == 1){
                $codigo_interno = $detalle->id_producto;
            }
            if($detalle->item_type == 2){
                $codigo_interno = $detalle->id_precio_lente;
            }
            if($detalle->item_type == 3){
                $codigo_interno = $detalle->id_servicio;
            }
            return [
                "codigo_interno" => $codigo_interno,
                "descripcion" => $detalle->descripcion,
                "codigo_producto_sunat" => "",
                "unidad_de_medida" => $detalle->unidad_medida->codigo_sunat,
                "cantidad" => $detalle->cantidad,
                "valor_unitario" =>  50,
                "codigo_tipo_precio" => "01",
                "precio_unitario" => $detalle->precio_unitario,
                "codigo_tipo_afectacion_igv" => "10",
                "total_base_igv" => number_format($detalle->total/1.18, 2, '.',''),
                "porcentaje_igv" => 18,
                "total_igv" => number_format($detalle->total - ($detalle->total/1.18), 2,'.',''),
                "total_impuestos" => 18,
                "total_valor_item" => $detalle->total,
                "total_item" => $detalle->total,
            ];
        });
        $data["items"] = $items;

        //Envio de nota
        $comp_sunat = json_encode($data);
        $token = $comprobante->sucursal['token_api'];
        $ruta = $comprobante->sucursal['url_api'];
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $ruta . "/api/documents");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: application/json',
            'Authorization: Bearer ' . $token
        ));
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $comp_sunat);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $respuesta  = curl_exec($ch);
        curl_close($ch);
        $res_decode = json_decode($respuesta, true);

        if ($res_decode['success'] == true) {
            $external_id   = $res_decode['data']['external_id'];
            $correlativo   = explode("-", $res_decode['data']['number'])[1];
            $pdf_document  = $res_decode['links']['pdf'];
            $pdf_cpe_embed = $ruta . "print/document/" . $external_id . "/ticket";
            $pdf_cpe_embed = $ruta . "print/document/" . $external_id . "/ticket";
            $nota->external_id = $external_id;
            $nota->id_estado_comprobante  = 1;
            $nota->correlativo = $correlativo;
            $nota->save();
            return ['success' => true, 'pdf' => $pdf_cpe_embed, 'message' => 'Comprobante creado y validado.', 'external_id' => $external_id, 'facturador' => $ruta];
        } else {
            $nota->id_estado_comprobante  = 4;
            $nota->save();
            return ['success' => false, 'message' => 'Error en la comprobancion con la SUNAT', 'id_comprobante' => $comprobante->id_comprobante, 'error' => $respuesta];
        }

        return $res_decode;
    }
}
