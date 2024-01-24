<?php

namespace App\Http\Controllers;

use App\Models\Compras;
use App\Models\ComprasDetalle;
use App\Models\ComprobanteSerie;
use App\Models\DeudaCompraCuota;
use App\Models\Egresos;
use App\Models\DeudaCompraPago;
use App\Models\Productos;
use App\Models\AlmacenMovimiento;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Exception;
use Illuminate\Support\Facades\Auth;
use Mpdf\Mpdf;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ComprasController extends Controller
{
    public function __constructor()
    {
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request)
    {
        $authUser = auth('sanctum')->user();

        $idProveedor = $request->id_proveedor;
        $searchTerm = $request->searchTerm;
        $fechaInicio = $request->fechaInicio;
        $fechaFin = $request->fechaFin;
        $condicionPago = $request->condicionPago;
        $saldoPendiente = $request->saldoPendiente;
        $estado = $request->estado;
        $datos = Compras::where([
            ["id_sucursal", $authUser->id_sucursal],
        ]);

        if (isset($idProveedor)) {
            $datos = $datos->where('id_proveedor', $idProveedor);
        }
        if (isset($searchTerm)) {
            $datos = $datos->where(function ($query) use ($searchTerm) {
                $query->where('nombre_proveedor', 'like', "%{$searchTerm}%")
                    ->orWhere('nro_documento', 'like', "%{$searchTerm}%");
            });
        }
        if (isset($fechaInicio)) {
            if (isset($fechaFin)) {
                $datos = $datos->whereBetween('fecha', [$fechaInicio, $fechaFin]);
            } else {
                $datos = $datos->where('fecha', '>=', $fechaInicio);
            }
        }
        if (isset($condicionPago)) {
            $datos = $datos->where('condicion_pago', $condicionPago);
        }
        if (isset($saldoPendiente)) {
            if ($saldoPendiente == 1) {
                $datos = $datos->where('deuda_saldo', ">", 0);
            } else {
                $datos = $datos->where('deuda_saldo', 0);
            }
        }
        if (isset($estado)) {
            $datos = $datos->where('estado', $estado);
        }

        return $datos->latest()->paginate($request->itemsPerPage);
    }

    public function show($id)
    {
        try {
            $data = Compras::with(
                'sucursal',
                'origen_dinero',
                'medio_pago',
                'detalle',
                'usuario',
                'pagos_deuda',
                'cuotas'
            )->findOrFail($id);
            return response()->json($data, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function store(Request $request)
    {
        try {
            $authUser = auth('sanctum')->user();
            $_merge = $request->header;
            $_merge['user_id'] = $authUser->id;
            $_merge['id_sucursal'] = $authUser->id_sucursal;
            $_merge['estado'] = 1;
            $_merge['correlativo'] = Compras::where([
                ['id_serie', $_merge['id_serie']],
                ['id_sucursal', $authUser->id_sucursal]
            ])->count() + 1;
            if($request->header["condicion_pago"] == 1){
                $_merge['deuda_saldo'] = 0;
            }
            $compra = Compras::create(collect($_merge)->all());

            foreach ($request->detail as $value) {
                $value['id_compra'] = $compra->id_compra;
                ComprasDetalle::create(collect($value)->all());
                if (isset($value['id_producto'])) {
                    AlmacenMovimiento::ingresoStock($value, $authUser->id_sucursal, 1);
                }
            }

            //--- Sale de caja chica ---
            if ($compra->id_origen_dinero == 1) {
                Egresos::create([
                    'descripcion' => 'COMPRA ' . $_merge['correlativo'] . ' ' . str_pad($compra->id_compra, 6, "0", STR_PAD_LEFT),
                    'monto' => $compra->total,
                    'origen' => 1,
                    'fecha_egreso' => Carbon::now()->toDateString(),
                    'id_compra' => $compra->id_compra
                ]);
            }
            //--- End ---

            //--- Gestion de Deuda ---
            if ($request->header['deuda_tipo'] == 'saldo') {
                DeudaCompraPago::create([
                    'id_compra' => $compra->id_compra,
                    'monto_abonado' => $compra->deuda_total_abonado,
                    'saldo' => $compra->deuda_saldo,
                    'fecha' => $compra->fecha,
                    'descripcion' => 'PRIMER ADELANTO',
                    'nro_operacion' => '-',
                    'id_origen_dinero' => $compra->id_origen_dinero,
                    'user_id' => $authUser->id,
                ]);
            }
            else if ($request->header['deuda_tipo'] == 'cuotas') {
                foreach ($request->cuotas as $value) {
                    DeudaCompraCuota::create([
                        'id_compra' => $compra->id_compra,
                        'fecha' => $value["fecha"],
                        'monto' => $value["monto"]
                    ]);
                }
            }
            //--- Fin ---

            return response()->json($compra, 200);
        } catch (\Exception $e) {
            return response()->json($e->getLine(), 500);
        }
    }

    public function pagos(Request $request)
    {
        try {
            //return response()->json($request->all());
            $compra = Compras::findOrFail($request->id_compra);
            $authUser = auth('sanctum')->user();
            $request->merge(['id_sucursal' => $authUser->id_sucursal]);
            $request->merge(['user_id' => $authUser->id]);
            $request->merge(['saldo' => $compra->deuda_saldo - $request->monto_abonado]);
            $data = DeudaCompraPago::create($request->all());
            $compra->update([
                'deuda_total_abonado' => $compra->deuda_total_abonado + $request->monto_abonado,
                'deuda_saldo' => $compra->deuda_saldo - $request->monto_abonado
            ]);
            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function pagoMultiple($compras, Request $request)
    {
        $compraIds = explode(',', $compras);

        $validator = Validator::make(['compraIds' => $compraIds], [
            'compraIds.*' => [
                'required',
                'integer',
                Rule::exists('compras', 'id_compra')
            ],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Los Ids de compras no son correctos',
                'errores' => $validator->errors()
            ], 422);
        }
        $user = Auth::user();
        $pagos = array();
        foreach ($compraIds as $compraId) {
            $compra = Compras::where('id_compra', $compraId)->first();
            $data = $request->all();
            $data['id_compra'] = $compraId;
            $data['monto_abonado'] = $compra->deuda_saldo;
            $data['saldo'] = 0;
            $data['id_sucursal'] = $user->id_sucursal;
            $data['user_id'] = $user->id;


            $compra->update([
                'deuda_total_abonado' => $compra->deuda_total_abonado + $compra->deuda_saldo,
                'deuda_saldo' => 0,
            ]);
            $pago = DeudaCompraPago::create($data);
            array_push($pagos, $pago);
        }

        return response()->json([
            'success' => true,
            'msg' => 'Pagos creados',
            'pagos' => $pagos
        ], Response::HTTP_CREATED);
    }


    public function destroy($id)
    {
        DB::beginTransaction();
        try {
            $user = Auth::user();
            $compra = Compras::findOrFail($id);
            $detalle = ComprasDetalle::where('id_compra', $compra->id_compra)->get();
            foreach ($detalle as $det) {
                $producto = Productos::where('codigo_producto', $det->codigo_producto)->first();
                if ($producto != null) {
                    $value = [
                        'id_producto' => $producto->id_producto,
                        'cantidad' => $det->cantidad,
                        'precio_total' => $det->precio_total
                    ];
                    AlmacenMovimiento::egresoStock($value, $user->id_sucursal, 1);//!!!!
                }
            }
            //Eliminamos egreso
            if ($compra->id_origen_dinero == 1) {
                Egresos::where('id_compra', $compra->id_compra)->update([
                    'estado' => 0
                ]);
            }
            //Eliminamos la compra
            $upd_data = array(
                'estado'  =>  0,
                'user_id_update' => $user->id,
            );
            $compra->update($upd_data);

            DB::commit();
            return response()->json($compra, 200);

        } catch (Exception $e) {
            DB::rollBack();
            return response()->json($e->getMessage(), 500);
        }
    }



    public function vista($id)
    {
        $compra = Compras::with(
            'sucursal',
            'sucursal',
            'origen_dinero',
            'medio_pago',
            'detalle',
            'usuario',
            'pagos_deuda',
            'cuotas'
        )->findOrFail($id);

        return view('compra', compact('compra')); //, compact('orden'));
    }

    public function generarPDF($id)
    {
        $html = $this->vista($id)->render();
        $file = 'pdf_' . 'pdf';
        $mpdf = new Mpdf(
            [
                'mode' => 'utf-8',
                'format' => 'A4',
                'margin_top' => 0,
                'margin_right' => 0,
                'margin_bottom' => 0,
                'margin_left' => 0
            ]
        );
        $mpdf->WriteHTML($html);
        $mpdf->Output($file, 'I');
    }


    public function getComprasSeries()
    {
        $user = Auth::user();

        $data = ComprobanteSerie::where([
            ['id_tipo_comprobante', 8],
            ['id_sucursal', $user->id_sucursal]
        ])
            ->get();

        return response()->json($data, 200);
    }
}
