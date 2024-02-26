<?php

namespace App\Http\Controllers;

use App\Mail\CouponMail;
use App\Mail\MultiFocalMail;
use App\Models\Clientes;
use App\Models\Anamnesis;
use App\Models\OrdenLaboratorio;
use App\Models\Comprobante;
use App\Models\ComprobanteDetalle;
use App\Models\Caja;
use App\Models\ComprobanteSerie;
use App\Models\AlmacenMovimiento;
use App\Models\AnamnesisEstadosHistorico;
use App\Models\ComprobanteDeuda;
use App\Models\ConformidadMontura;
use App\Models\Cupon;
use App\Services\ComprobanteService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Eps;
use App\Models\EpsDescuento;
use App\Models\OrdenLaboratorioHistorial;
use App\Services\EpsService;
use Exception;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Mpdf\Mpdf;

class AnamnesisController extends Controller
{
  public function __constructor()
  {
    $this->middleware('auth:sanctum');
  }

  public function paso1(Request $request)
  {
    $auth = auth('sanctum')->user();
    try {


      $data = $request->anamnesis;
      if (!array_key_exists('id_cliente', $request->cliente) || $request->cliente["id_cliente"] == "") {
        $_cliente = $request->cliente;
        $cliente = Clientes::create($_cliente);
        $_head["id_cliente"] = $cliente->id_cliente;
      } else {
        $cliente = $request->cliente;
        $cliente = Clientes::findOrFail($cliente['id_cliente']);
      }

      $data['estado'] = 1;
      $data['id_sucursal'] = $auth->id_sucursal;
      $data['id_cliente'] = $cliente->id_cliente;
      $anamnesis = Anamnesis::create(collect($data)->all());


      AnamnesisEstadosHistorico::create([
        'user_id'=>$auth->id,
        'anamnesis_id'=>$anamnesis->id_anamnesis,
        'fecha'=>date('Y-m-d H:i:s'),
        'estado'=>'anamnesis_creada'
      ]);

      AnamnesisEstadosHistorico::create([
        'user_id'=>$auth->id,
        'anamnesis_id'=>$anamnesis->id_anamnesis,
        'fecha'=>date('Y-m-d H:i:s'),
        'estado'=>'anamnesis_paso_1'
      ]);

      return response()->json([
        'cliente' => $cliente,
        'anamnesis' => $anamnesis
      ], 200);
    } catch (Exception $e) {
      return response()->json([$e->getMessage(), $e->getLine()], 500);
    }
  }

  public function paso2(Request $request)
  {
    $auth = auth('sanctum')->user();
    try {
      $request->merge(['id_sucursal' => $auth->id_sucursal]);
      $request->merge(['id_usuario' => $auth->id]);
      $request->merge(['estado' => 1]);
      $orden_lab = OrdenLaboratorio::create($request->all());


      OrdenLaboratorioHistorial::create([
        'id_orden' => $orden_lab->id_orden_laboratorio,
        'id_estado' => 1,
        'id_usuario' => $auth->id,
      ]);

      AnamnesisEstadosHistorico::create([
        'user_id'=>$auth->id,
        'anamnesis_id'=>$orden_lab->id_anamnesis,
        'fecha'=>date('Y-m-d H:i:s'),
        'estado'=>'anamnesis_paso_2'
      ]);


      return response()->json([
        'orden_laboratorio' => $orden_lab,
      ], 200);
    } catch (Exception $e) {
      return response()->json([$e->getMessage(), $e->getLine(), $e->getFile()], 500);
    }
  }

  public function paso3(Request $request)
  {
    DB::beginTransaction();
    try {
      $auth = auth('sanctum')->user();
      $caja = Caja::where('estado', 1)
        ->where('id_sucursal', $auth->id_sucursal)
        ->latest()
        ->first();
      $serie = ComprobanteSerie::where('estado', 1)
        ->where('id_sucursal', $auth->id_sucursal)
        ->where('id_tipo_comprobante', $request->header['id_tipo_comprobante'])
        ->first();
      $_head =  $request->header;
      $_head['id_sucursal'] = $auth->id_sucursal;
      $_head['id_usuario'] = $auth->id;
      $_head['id_caja'] = $caja->id_caja;
      if($_head['condicion_pago'] == 1){
        $_head['adelanto'] = 0.00;
        $_head['saldo'] = 0.00;
      }
      if($_head['condicion_pago'] == 2 || $_head['condicion_pago'] ==  3){
        $_head['saldo'] = $_head['total'] - $_head['adelanto'];
        if($_head['id_eps_discount'] != null){
          $_head['saldo'] -= $_head['eps_discount'];
        }
      }
      $_head['dscto_fijo'] = 0.00;
      $_head['dscto_porcentaje'] = 0.00;
      $_head['id_estado_comprobante'] = 4;
      $correlativo = Comprobante::where('id_tipo_comprobante', $request->header['id_tipo_comprobante'])
        ->where('id_sucursal', $auth->id_sucursal)
        ->where('id_serie', $serie->id_serie)
        ->count();


      /*
        Solo si es una venta con EPS.
      */
      if (isset($_head['id_eps_discount']) &&  $_head['id_eps_discount'] != null) {
        $orden = OrdenLaboratorio::with(['lente'])->where('id_anamnesis', $request->id_anamnesis)->first();
        $epsHead = EpsService::prepareEpsHeader($_head);
        $total = $_head['total'];
        if($total < $_head['eps_discount']){
          $epsMoney = $total;
        }else{
          $epsMoney = $_head['eps_discount'];
        }
        $epsDetails = EpsService::prepareEpsDetail($request->detail, $epsMoney);
        $epsHead['id_orden_lab'] = $orden->id_orden_laboratorio;
        $epsInvoice = Comprobante::create(collect($epsHead)->all());
        foreach ($epsDetails as $detalle) {
          $detalle["id_comprobante"] = $epsInvoice->id_comprobante;
          ComprobanteDetalle::create(collect($detalle)->all());
        }
        if ($total > $epsInvoice->total) {
          $clientReceipt = $total - $epsInvoice->total;
          $_head['total'] = $clientReceipt;
          $_head['subtotal'] = $clientReceipt / (1 + 0.18);
          $_head['igv'] = $clientReceipt - $_head['subtotal'];
          $_head['id_eps_discount'] = null;
          $_head['eps_discount'] = 0.00;
          $clientDocument = Comprobante::create(collect($_head)->all());
          $clientDocument['id_orden_lab'] = $orden->id_orden_laboratorio;
          $clientDocument->correlativo = ++$correlativo;
          $clientDocument->save();
          $scaleFactor = $clientReceipt / $total;
          foreach ($request->detail as $value) {
            $value['id_comprobante'] = $clientDocument->id_comprobante;
            $value['precio_total'] = $value['precio_total'] * $scaleFactor;
            $value['precio_unitario'] = $value['precio_unitario'] * $scaleFactor;
            $detalle = ComprobanteDetalle::create(collect($value)->all());
          }
          $epsInvoice->id_comprobante_eps = $clientDocument->id_comprobante;
          $epsInvoice->save();
        }
        foreach ($request->detail as $value) {
          if ($value['item_type'] == 1) {
            AlmacenMovimiento::egresoStock([
              "id_producto" => $value['id_producto'],
              "cantidad" => $value['cantidad'],
              "precio_total" => $value['precio_total']
            ], $auth->id_sucursal, 2);
          }
        }
        $facturacion_eps = ComprobanteService::facturar($epsInvoice->id_comprobante);
        $facturacion_client = null;
        if (isset($clientDocument)) $facturacion_client = ComprobanteService::facturar($clientDocument->id_comprobante);
        $anamnesis = Anamnesis::where('id_anamnesis', $request->id_anamnesis)->first();
        $anamnesis->estado = 0;
        $anamnesis->save();
        if ($orden->lente['modelo'] == 'MULTIFOCAL') {
          $client = Clientes::where('id_cliente', $clientDocument->id_cliente)->first();
          if($client != null){
            Mail::to($client->email)->queue(new MultiFocalMail($client));
          }
        }

        AnamnesisEstadosHistorico::create([
          'user_id'=>$auth->id,
          'anamnesis_id'=>$request->id_anamnesis,
          'fecha'=>date('Y-m-d H:i:s'),
          'estado'=>'anamnesis_paso_3'
        ]);

        AnamnesisEstadosHistorico::create([
          'user_id'=>$auth->id,
          'anamnesis_id'=>$request->id_anamnesis,
          'fecha'=>date('Y-m-d H:i:s'),
          'estado'=>'anamnesis_cerrada'
        ]);
        $cuponDate = Carbon::now()->addMonths(12);

        $cupon = Cupon::create([
          'id_usuario' => $auth->id,
          'id_sucursal' => $auth->id_sucursal,
          'codigo_cupon' => $this->generateCouponCode(8),
          'tipo_descuento' => 2,
          'descuento' => 20,
          'fecha_vencimiento' => $cuponDate->toDateString(),
          'id_comprobante_origen' => ($clientDocument == null) ? $epsInvoice->id_comprobante : $clientDocument->id_comprobante,
        ]);

        $cliente = Clientes::find( $_head['id_cliente']);
        Mail::to($cliente->email)->queue(new CouponMail($cupon, $cliente));

        DB::commit();


        return response()->json([
          'success' => true,
          'comprobante' => isset($clientDocument) ? $clientDocument : null,
          'cupon' => $cupon,
          'extra' => [
            'eps' => $facturacion_eps,
            'client' => $facturacion_client
          ]
        ], 200);
      } else {
        /*
          Solo si no es una venta por EPS
        */
        $comprobante = Comprobante::create(collect($_head)->all());
        $comprobante->correlativo = ++$correlativo;
        $orden = OrdenLaboratorio::with(['lente'])->where('id_anamnesis', $request->id_anamnesis)->first();
        $comprobante->id_orden_lab = $orden->id_orden_laboratorio;
        $comprobante->save();
        foreach ($request->detail as $value) {
          $value['id_comprobante'] = $comprobante->id_comprobante;
          $detalle = ComprobanteDetalle::create(collect($value)->all());
          if ($detalle->item_type == 1) {
            $data = AlmacenMovimiento::egresoStock([
              "id_producto" => $detalle->id_producto,
              "cantidad" => $detalle->cantidad,
              "precio_total" => $detalle->precio_total
            ], $auth->id_sucursal, 2);
          }
        }
        if ($_head['condicion_pago'] == 3 && isset($request->cuotas)) {
          $index = 1;
          foreach ($request->cuotas as $cuota) {
            $comprobanteCredito = [
              "id_comprobante" => $comprobante->id_comprobante,
              "monto" => $cuota["monto"],
              "fecha" => $cuota["fecha"],
            ];
            ComprobanteDeuda::create($comprobanteCredito);
            $index++;
          }
        }
        $anamnesis = Anamnesis::where('id_anamnesis', $request->id_anamnesis)->first();
        $anamnesis->estado = 0;
        $anamnesis->save();

        AnamnesisEstadosHistorico::create([
          'user_id'=>$auth->id,
          'anamnesis_id'=>$request->id_anamnesis,
          'fecha'=>date('Y-m-d H:i:s'),
          'estado'=>'anamnesis_paso_3'
        ]);
        AnamnesisEstadosHistorico::create([
          'user_id'=>$auth->id,
          'anamnesis_id'=>$request->id_anamnesis,
          'fecha'=>date('Y-m-d H:i:s'),
          'estado'=>'anamnesis_cerrada'
        ]);

        $cuponDate = Carbon::now()->addMonths(12);
        $cupon = Cupon::create([
          'id_usuario' => $auth->id,
          'id_sucursal' => $auth->id_sucursal,
          'codigo_cupon' => $this->generateCouponCode(8),
          'tipo_descuento' => 2,
          'descuento' => 20,
          'fecha_vencimiento' => $cuponDate->toDateString(),
          'id_comprobante_origen' => $comprobante->id_comprobante,
        ]);

        $cliente = Clientes::find( $_head['id_cliente']);
        Mail::to($cliente->email)->queue(new CouponMail($cupon, $cliente));

        /*
          Nota de venta
          Pendiente a implementación si se requiere
        */
        if ($comprobante->id_tipo_comprobante != 1 && $comprobante->id_tipo_comprobante != 2) {
          DB::commit();
          return response()->json([
            "success" => true,
            "comprobante" => $comprobante,
            'extra' => []
          ]);
        }
        $facturacion_data = ComprobanteService::facturar($comprobante->id_comprobante);
        DB::commit();
        if ($orden->lente['modelo'] == 'MULTIFOCAL') {
          $client = Clientes::where('id_cliente', $comprobante->id_cliente)->first();
          if($client != null){
            Mail::to($client->email)->send(new MultiFocalMail($client));
          }
        }


        return response()->json([
          "success" => true,
          "comprobante" => $comprobante,
          'cupon' => $cupon,
          "extra" => [
            "client" => $facturacion_data
          ]
        ], 200);
      }
    } catch (Exception $e) {
      return response()->json([
        'success' => false,
        'message' => $e->getMessage(),
        'line' => $e->getLine(),
        'file' => $e->getFile()
      ], 500);
    }
  }
  private function generateCouponCode($length) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $code = '';
    $max = strlen($characters) - 1;
    for ($i = 0; $i < $length; $i++) {
      $code .= $characters[random_int(0, $max)];
    }
    return $code;
  }

  public function searchAnamnesis($id)
  {
    $anamnesis = Anamnesis::with([
      'cliente',
      'clinica',
      'doctor',
      'empresa',
      'sucursal',
      'orden.montura',
      'orden.lente',
      'historial.user'
      ])
      ->where('id_anamnesis', $id)
      ->first();
    if ($anamnesis) {
      return response()->json($anamnesis, 200);
    }
    return response()->json(null, 404);
  }

  public function searchAnamnesisPaciente($id)
  {
    try {
      $date = Carbon::now()->subDays(30);

    $anamnesis = Anamnesis::whereHas('cliente', function ($q) use ($id) {
      $q->where('nro_documento', $id)->orWhere('id_cliente',$id);
    })->with(['cliente', 'doctor', 'clinica', 'empresa', 'orden.montura', 'orden.lente'])
      ->whereBetween('created_at', [$date, Carbon::now()])
      ->where('estado', 1)
      ->orderBy('id_anamnesis', 'DESC')
      ->get();

    return response()->json($anamnesis, 200);
    } catch (Exception $e) {
      return response()->json($e,500);
    }
  }

  public function descartarAnamnesis($id)
  {
    $anamnesis = Anamnesis::where('id_anamnesis', $id)->first();
    $auth = auth()->user();
    $anamnesis->update([
      'estado' => 0
    ]);

    AnamnesisEstadosHistorico::create([
      'user_id'=>$auth->id,
      'anamnesis_id'=>$anamnesis->id_anamnesis,
      'fecha'=>date('Y-m-d H:i:s'),
      'estado'=>'anamnesis_archivada_usuario'
    ]);


    return response()->json([
      'msg' => "Anamnesis desactivada"
    ], 200);
  }

  public function obtenerAnamnesis(Request $request)
  {
    $user = auth()->user();

    $data = Anamnesis::with(['cliente', 'orden.montura', 'orden.lente'])
      ->where('id_sucursal', $user->id_sucursal);

    $itemsPerPage = ($request->itemsPerPage == null) ? 10 : $request->itemsPerPage;
    $sortBy = ($request->sortBy == null) ? 'id_anamnesis' : $request->sortBy;
    $sortDesc = $request->sortDesc == true ? 'desc' : 'asc';

    if (isset($request->searchTerm)) {
      $data->where(function ($query) use ($request) {
        $query->where('nombre_material', 'like', '%' . $request->searchTerm . '%');
      });
    }
    if (isset($sortBy)) {
      $data->orderBy($sortBy, $sortDesc);
    }
    return $data->paginate($itemsPerPage);
  }

  public function conformidadMontura(Request $request){
    try {
      $conformidad_montura = $request;
      $saved=ConformidadMontura::create($conformidad_montura->all());
      return response()->json($saved, 200);
    } catch (Exception $e) {
      return response()->json($e,500);
    }
  }

  public function vistaConformidadMontura($id){
    $orden_lab=OrdenLaboratorio::with('anamnesis','cliente','sucursal')->where('id_orden_laboratorio',$id)->get();
    $conformidad_montura=ConformidadMontura::with('anamnesis')->where('id_anamnesis',$orden_lab[0]->id_anamnesis)->get();

    $orden_lab = $orden_lab[0];
    $conformidad_montura =$conformidad_montura[0];

    return view("conformidad_montura",compact('orden_lab','conformidad_montura'));
  }

  public function conformidadMonturaPDF($id)
    {
        $html = $this->vistaConformidadMontura($id)->render();
        $file = 'pdf_' . 'pdf';
        $mpdf = new Mpdf(
            [
                'mode' => 'utf-8',
                'format' => [80, 360],
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
