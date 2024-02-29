<?php

namespace App\Http\Controllers;

use App\Models\AlmacenMovimiento;
use App\Models\Caja;
use App\Models\Campaign;
use App\Models\Clientes;
use App\Models\Comprobante;
use App\Models\ComprobanteDetalle;
use App\Models\ComprobanteDeuda;
use App\Models\ComprobanteSerie;
use App\Models\OrdenLaboratorio;
use App\Models\PreciosLentes;
use App\Models\Productos;
use App\Services\ComprobanteService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class CampaignController extends Controller
{
  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */
  public function index(Request $request)
  {
    $perpage = isset($request->perpage) ? $request->perpage : 10;
    $data = Campaign::where([
      ['status', 1],
    ]);

    if (isset($request->searchTerm)) {
      $data->where("name", "LIKE", "%" . $request->searchTerm . "%");
    }
    $data->withCount(['orders']);

    return $data->paginate($request->perpage);
  }

  /**
   * Store a newly created resource in storage.
   *
   * @param  \Illuminate\Http\Request  $request
   * @return \Illuminate\Http\Response
   */
  public function store(Request $request)
  {
    $validated = $request->validate([
      "name"=> "required|string|max:255",
    ]);
    $user = auth()->user();
    $campaign = Campaign::create([
      ...$validated,
      "id_sucursal" => $user->id_sucursal,
      "id_user" => $user->id,
    ]);

    return response()->json([
      "success" => true,
      "campaign" => $campaign
    ], 201);
  }

  /**
     * Display the specified resource.
   *
   * @param  int  $id
   * @return \Illuminate\Http\Response
   */
  public function show($id)
  {
    $campaign = Campaign::with(["orders"])->findOrFail($id);
    $orders = $campaign->orders;
    $details = [];
    $lentes = [];
    $monturas = [];

    foreach ($orders as $order) {
      $lente = PreciosLentes::find($order['id_precio_lentes']);
      $monturaId = $order['id_montura'];
      $montura = $monturaId ? Productos::find($monturaId) : null;

      if (!isset($lentes[$lente->id_precio_lente])) {
        $lentes[$lente->id_precio_lente] = [
          "lente" => $lente,
          "count" => 1
        ];
      } else {
        $lentes[$lente->id_precio_lente]["count"]++;
      }
      if ($montura) {
        if (!isset($monturas[$montura->id_producto])) {
          $monturas[$montura->id_producto] = [
            "montura" => $montura,
            "count" => 1
          ];
        } else {
          $monturas[$montura->id_producto]["count"]++;
        }
      }
    }
    foreach ($lentes as $lente) {
        $details[] = $lente;
    }

    foreach ($monturas as $montura) {
        $details[] = $montura;
    }

    return response()->json($details);
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
    //
  }

  /**
   * Remove the specified resource from storage.
   *
   * @param  int  $id
   * @return \Illuminate\Http\Response
   */
  public function destroy($id)
  {
    //
  }

  public function loadCampaigns(){
    $user = auth()->user();
    $campaigns = Campaign::where('id_sucursal', $user->id_sucursal)
                        ->where('active', 1)
                        ->where('status', 1)
                        ->get();
    return response()->json($campaigns);
  }

  public function facturar(Request $request)
  {
    $campaign = Campaign::findOrFail($request->id_campana);

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
      $comprobante->id_campana = $campaign->id;
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
          $producto = Productos::findOrFail($detalle->id_producto);
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


      /*
        NOTA DE PEDIDO
        No entra aca por que se solicito que no hayan notas de venta
        queda pendiente a implementarse si se requiere.
      */

      /*
      if ($comprobante->id_tipo_comprobante != 1 && $comprobante->id_tipo_comprobante != 2) {
        DB::commit();
        return response()->json([
          "success" => true,
          "comprobante" => $comprobante,
        ]);
      }*/


      $facturacion_data = ComprobanteService::facturar($comprobante->id_comprobante);

      // Asignación de ordenes a comprobante global
      $idsOrdenes = OrdenLaboratorio::where('id_campana', $campaign->id)
                    ->pluck('id_orden_laboratorio')
                    ->toArray();



      DB::table('orden_laboratorio')
          ->whereIn('id_orden_laboratorio', $idsOrdenes)
          ->update(['id_comprobante' => $comprobante->id_comprobante]);

      $campaign->active = 0;
      $campaign->save();
      DB::commit();

      return response()->json([
        ...$facturacion_data,
        "comprobante" => $comprobante,
      ], 200);

    } catch (\Exception $e) {
      DB::rollBack();
      return response()->json($e->getMessage(), 500);
    }

  }
}
