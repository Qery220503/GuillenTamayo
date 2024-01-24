<?php

namespace App\Http\Controllers;

use App\Models\Comprobante;
use App\Models\ComprobanteDetalle;
use App\Models\Caja;
use App\Models\ComprobanteSerie;
use Illuminate\Http\Request;
use App\Models\Clientes;
use App\Models\AlmacenMovimiento;
use App\Models\ComprobanteDeuda;
use App\Services\ComprobanteService;
use Carbon\Carbon;
use Mpdf\Mpdf;
use Illuminate\Support\Facades\DB;

class ComprobanteController extends Controller
{
  public function index(Request $request)
  {
    try {
      $data = Comprobante::listAll($request);
      return response()->json($data, 200);
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
    try {
      $data = Comprobante::with(
        'detalle.unidad',
        'sucursal',
        'orden_laboratorio',
        'usuario',
        'estado_comprobante',
        'detalle',
        'cliente',
        'medio_pago',
        'serie',
        'caja',
        'tipo_documento',
        'deuda'
      )->findOrFail($id);
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function store(Request $request)
  {
    DB::beginTransaction();
    try {
      $auth = auth('sanctum')->user();
      $_head =  $request->header;
      if ($request->header["id_cliente"] == "") {
        $_cliente = $request->header;
        $_cliente['cod_tipo_doc'] = $_cliente["id_tipo_documento"];
        $_cliente['nombre_razon_social'] = $_cliente["nombre_cliente"];
        $cliente = Clientes::create($_cliente);

        $_head["id_cliente"] = $cliente->id_cliente;
      }
      $caja = Caja::where('estado', 1)
        ->where('id_sucursal', $auth->id_sucursal)
        ->latest()
        ->first();
      $serie = ComprobanteSerie::where('estado', 1)
        ->where('id_sucursal', $auth->id_sucursal)
        ->where('id_tipo_comprobante', $request->header['id_tipo_comprobante'])
        ->first();
      $_head['id_sucursal'] = $auth->id_sucursal;
      $_head['id_usuario'] = $auth->id;
      $_head['id_caja'] = $caja->id_caja;
      $_head['id_estado_comprobante'] = 4;
      $_head['id_serie'] = $_head['id_serie'];
      $_head['saldo'] = 0.00;
      if ($_head['condicion_pago'] == 2 || $_head['condicion_pago'] == 3) {
        $_head['saldo'] = $_head['total'] - $_head['adelanto'];
      }
      if($_head['factura_gratuita']){
        $_head['saldo'] = 0.00;
        $_head['total'] = 0.00;
        $_head['adelanto'] = 0.00;
        $_head['igv'] = 0.00;
        $_head['subtotal'] = 0.00;
        //$_head['fecha_emision'] = $_head['fecha_emision'];
      }
      $comprobante = Comprobante::create(collect($_head)->all());
      $correlativo = Comprobante::where('id_tipo_comprobante', $request->header['id_tipo_comprobante'])
        ->where('id_sucursal', $auth->id_sucursal)
        ->where('id_serie', $serie->id_serie)
        ->count();
      $comprobante->correlativo = ++$correlativo;
      $comprobante->save();
      foreach ($request->detail as $value) {
        $value['id_comprobante'] = $comprobante->id_comprobante;
        $detalle = ComprobanteDetalle::create(collect($value)->all());
        if ($detalle->item_type == 1) {
          AlmacenMovimiento::egresoStock([
            "id_producto" => $detalle->id_producto,
            "cantidad" => $detalle->cantidad,
            "precio_total" => $detalle->precio_total
          ], $auth->id_sucursal, 2);
        }
      }

      /* CREACIÓN DE CUOTAS */

      if ($_head['condicion_pago'] == 3 && isset($request->cuotas) && sizeof($request->cuotas) > 0) {
        foreach ($request->cuotas as $cuota) {
          $comprobanteCredito = [
            "id_comprobante" => $comprobante->id_comprobante,
            "monto" => $cuota["monto"],
            "fecha" => $cuota["fecha"],
          ];
          ComprobanteDeuda::create($comprobanteCredito);
        }
      }

      /* Si es Nota de Pedido */
      if ($comprobante->id_tipo_comprobante != 1 && $comprobante->id_tipo_comprobante != 2) {
        DB::commit();
        return response()->json([
          "success" => true,
          "comprobante" => $comprobante
        ]);
      }


      $facturacion_data = ComprobanteService::facturar($comprobante->id_comprobante);
      DB::commit();
      return response()->json($facturacion_data, 200);
    } catch (\Exception $e) {
      DB::rollBack();
      return response()->json($e->getMessage(), 500);
    }
  }

  public function vista($id)
  {

    $comprobante = Comprobante::with([
      'sucursal',
      'usuario',
      'estado_comprobante',
      'detalle.unidad',
      'cliente',
      'medio_pago',
      'serie',
      'tipo_documento',
    ])->findOrFail($id);
    return view('notapedido', compact('comprobante'));
  }

  public function generarNotaVentaPDF($id)
  {
    $html = $this->vista($id);
    $file = 'pdf_' . 'pdf';
    $mpdf = new Mpdf(
      [
        'mode' => 'utf-8',
        'format' => [80, 220],
        'margin_top' => 2,
        'margin_right' => 5,
        'margin_bottom' => 0,
        'margin_left' => 5
      ]
    );
    $mpdf->WriteHTML($html);
    $mpdf->Output($file, 'I');
  }

  public function generarComanda(Request $request)
  {
    $comprobante = Comprobante::with([
      'sucursal',
      'usuario',
      'estado_comprobante',
      'orden_laboratorio',
      'detalle.unidad',
      'cliente',
      'medio_pago',
      'serie',
      'tipo_documento',
    ])->findOrFail($request->id);
    $html = view('Comanda', compact('comprobante'));
    $file = 'pdf_' . 'pdf';
    $mpdf = new Mpdf(
      [
        'mode' => 'utf-8',
        'format' => [80, 220],
        'margin_top' => 2,
        'margin_right' => 5,
        'margin_bottom' => 0,
        'margin_left' => 5
      ]
    );
    $mpdf->WriteHTML($html);
    $mpdf->Output($file, 'I');
  }
}
