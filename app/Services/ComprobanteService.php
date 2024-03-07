<?php

namespace App\Services;

use App\Models\Comprobante;
use App\Models\ComprobanteDetalle;
use Exception;
use Illuminate\Support\Facades\DB;
use App\Models\ComprobanteSerie;
use App\Models\PreciosLentes;
use App\Models\TipoComprobante;
use Illuminate\Support\Facades\Log;

class ComprobanteService
{
  public static function facturar($id)
  {
    $comprobante_n = Comprobante::findOrFail($id);
    $comprobante = Comprobante::findOrFail($id);
    $comprobante_detalle = ComprobanteDetalle::where("id_comprobante", $id)->with('unidad')->get();
    $items = array();
    $nueva_serie = ComprobanteSerie::find($comprobante->id_serie);

    $total_items = 0.00;
    foreach ($comprobante_detalle as $cmp_d) {
      $valor_unitario = $cmp_d->precio_unitario / 1.18;
      $total_base_igv = $cmp_d->precio_total / 1.18; //subtotal
      $total_igv      = $cmp_d->precio_total - $total_base_igv;
      $total_items    += $cmp_d->precio_total;
      $total_gratuita = 0;

      switch ($cmp_d->item_type) {
        case 1:
          $codigoInterno = $cmp_d->id_producto;
          break;
        case 2:
          $codigoInterno = $cmp_d->id_precio_lente;
          break;
        case 3:
          $codigoInterno = $cmp_d->id_servicio;
          break;
        default:
          $codigoInterno = null;
          break;
      }

      if ($comprobante_n->factura_gratuita == 1) {
        /*
        $items[] = array(
          "unidad_de_medida"          =>  $cmp_d->unidad->codigo_sunat,
          "codigo_interno"            => $codigoInterno,
          "codigo_producto_sunat"    => "",
          "codigo_producto_gsl"        => "",
          "descripcion"        => $cmp_d->detalle_item,
          "cantidad"          => $cmp_d->cantidad,
          "valor_unitario"      => 0,
          "codigo_tipo_precio"     => "02",
          "precio_unitario"      => 0,
          "codigo_tipo_afectacion_igv" => "21",
          "total_base_igv"        => 0,
          "porcentaje_igv"       => 0,
          "total_igv"          => 0,
          "total_impuestos"      => 0,
          "total_valor_item"       => 0,
          "total_item"          => 0,
        );
        */
        $total_gratuita += number_format(($cmp_d->precio_total - $total_igv), 2, '.', '');
        $items[] = array(
          "unidad_de_medida"          =>  $cmp_d->unidad->codigo_sunat,
          "codigo_interno"            => $codigoInterno,
          "codigo_producto_sunat"    => "",
          "codigo_producto_gsl"        => "",
          "descripcion"        => $cmp_d->detalle_item,
          "cantidad"          => $cmp_d->cantidad,
          "valor_unitario"      => 0,
          "codigo_tipo_precio"     => "02",
          "precio_unitario"      => $total_gratuita,
          "codigo_tipo_afectacion_igv" => "21",
          "total_base_igv"        => 0,
          "porcentaje_igv"       => 0,
          "total_igv"          => 0,
          "total_impuestos"      => 0,
          "total_valor_item"       => 0,
          "total_item"          => $total_gratuita,
        );

      } else {
        $items[] = array(
          "codigo_interno"             => $codigoInterno,
          "descripcion"                => $cmp_d->detalle_item,
          "codigo_producto_sunat"      => "",
          "codigo_producto_gsl"        => "",
          "unidad_de_medida"           => $cmp_d->unidad->codigo_sunat,
          "cantidad"                   => $cmp_d->cantidad,
          "valor_unitario"             => number_format($valor_unitario, 2, '.', ''),
          "codigo_tipo_precio"         => "01",
          "precio_unitario"            => number_format($cmp_d->precio_unitario, 2, '.', ''),
          "codigo_tipo_afectacion_igv" => "10",
          "total_base_igv"             => number_format($total_base_igv, 2, '.', ''),
          "porcentaje_igv"             => 18,
          "total_igv"                  => number_format($total_igv, 2, '.', ''),
          "total_impuestos"            => number_format($total_igv, 2, '.', ''),
          "total_valor_item"           => number_format($total_base_igv, 2, '.', ''),
          "total_item"                 => $cmp_d->precio_total,
        );
      }


    }
    $tipo_comprobante = TipoComprobante::where('id_tipo_comprobantes', $comprobante_n->id_tipo_comprobante)->first();
    $codigo_tipo_documento           = $tipo_comprobante->codigo_sunat; //Factura : Boleta
    $codigo_tipo_documento_identidad = strlen($comprobante_n->nro_documento) == 8 ? "1" : "6"; //DNI : RUC
    $hora_de_emision = date("h:i:s");

    //Descuentos
    $descuento = 0.00;
    if($comprobante->dscto_porcentaje > 0){
      $descuento = $comprobante->dscto_porcentaje;
    }
    if($comprobante->dscto_fijo > 0){
      $descuento = $comprobante->dscto_fijo;
    }
    if($comprobante->id_eps_discount != null && $comprobante->eps_discount > 0){
      $descuento = $comprobante->eps_discount;
    }

    $comp_arr = array(
      "serie_documento"        => $nueva_serie->serie,
      "numero_documento"       => "#",
      "fecha_de_emision"       => $comprobante_n->fecha_emision,
      "hora_de_emision"        => $hora_de_emision,
      "codigo_tipo_operacion"  => "0101", //Operacion Sunat
      "codigo_tipo_documento"  => $codigo_tipo_documento,
      "codigo_tipo_moneda"     => "PEN",
      "fecha_de_vencimiento"   => $comprobante_n->fecha_emision, //la misma fecha de emision
      "numero_orden_de_compra" => "", //Opcional
      "formato_pdf"            => (isset($comprobante_n->formato_impresion)) ? $comprobante_n->formato_impresion : "ticketguillen",
      "datos_del_emisor" => array(
        "codigo_pais"                      => "PE",
        "ubigeo"                           => "040101",
        "direccion"                        => $comprobante->sucursal['direccion_fiscal'],
        "correo_electronico"               => $comprobante->sucursal['email'],
        "telefono"                         => $comprobante->sucursal['telefono'],
        "codigo_del_domicilio_fiscal"      => $comprobante->sucursal['cod_domicilio_fiscal'],
      ),
      "datos_del_cliente_o_receptor" => array(
        "codigo_tipo_documento_identidad"    => $codigo_tipo_documento_identidad,
        "numero_documento"                   => $comprobante_n->nro_documento,
        "apellidos_y_nombres_o_razon_social" => $comprobante_n->nombre_cliente,
        "codigo_pais"                        => "PE",
        "ubigeo"                             => "",
        "direccion"                          => $comprobante_n->direccion_cliente,
        "correo_electronico"                 => "",
        "telefono"                           => ""
      ),
      "totales" => array(
        "total_descuentos" => $descuento,
        "total_exportacion"            => 0.00,
        "total_operaciones_gravadas"   => number_format($comprobante->subtotal, 2, '.', ''),
        "total_operaciones_inafectas"  => 0.00,
        "total_operaciones_exoneradas" => 0.00,
        "total_operaciones_gratuita"   => ($comprobante_n->factura_gratuita == 1) ? $total_items : 0.00,
        "total_igv"                    => number_format($comprobante->igv, 2, '.', ''),
        "total_impuestos"              => number_format($comprobante->igv, 2, '.', ''), //Total de Impuestos?
        "total_valor"                  => number_format($comprobante->subtotal, 2, '.', ''),
        "total_venta"                  => $comprobante->total,
      ),
      "items" => $items,
      "acciones" => array("enviar_xml_firmado" => false, "enviar_email" => false, "formato_pdf" => "ticket"),
      "informacion_adicional" => 'Forma de Pago: ' . $comprobante->medio_pago["medio_pago"],
    );

    if($comprobante_n->factura_gratuita == 1){
			$comp_arr["totales"]["total_descuentos"] = 0;
			$comp_arr["totales"]["total_operaciones_gravadas"] = 0;
			$comp_arr["totales"]["total_igv"] = 0;
			$comp_arr["totales"]["total_impuestos"] = 0;
			$comp_arr["totales"]["total_valor"] = 0;
			$comp_arr["totales"]["total_venta"] = 0;
			$comp_arr["totales"]["total_operaciones_gratuitas"] = $total_gratuita;

			$comp_arr["leyendas"] = array(array("codigo" => 1002, "valor" => "TRANSFERENCIA GRATUITA"));
		}



    //Envio de Json a la API - Boleta Gravada
    $comp_sunat = json_encode($comp_arr);
    Log::info("Receipt JSON: " . $comp_sunat);
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
      $comprobante->external_id = $external_id;
      $comprobante->id_estado_comprobante  = 4;
      $comprobante->correlativo = $correlativo;
      //Actualizamos detalles si es gratuita
      if($comprobante->factura_gratuita == 1){
        ComprobanteDetalle::where('id_comprobante', $comprobante->id_comprobante)
                          ->update([
                            'precio_unitario' => 0,
                            'precio_total' => 0,
                          ]);
      }
      $comprobante->save();
      return ['success' => true, 'pdf' => $pdf_cpe_embed, 'message' => 'Comprobante creado y validado.', 'external_id' => $external_id, 'facturador' => $ruta];
    } else {
      $comprobante->id_estado_comprobante  = 3;
      $comprobante->save();
      return ['success' => false, 'message' => 'Error en la comprobancion con la SUNAT', 'id_comprobante' => $comprobante->id_comprobante, 'error' => $respuesta];
    }
  }



  public static function anular()
  {
  }
}
