<?php

namespace App\Http\Controllers;

use App\Models\ComprobanteCredito;
use App\Models\Caja;
use App\Models\ComprobantePagoDeuda;
use App\Models\Comprobante;
use App\Models\ComprobantePago;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ComprobanteCreditoController extends Controller
{
    public function pagar(Request $request)
    {
        DB::beginTransaction();

        try {
            $ultimaCaja = Caja::where('estado', 1)
                ->whereDate('created_at', DB::raw('CURDATE()'))
                ->orderBy('id_caja', 'DESC')
                ->first();
            if ($ultimaCaja === null) {
                return response()->json([
                    'success' => false,
                    'msg' => 'La Caja no ha sido abierta aún hoy!'
                ]);
            }

            $auth = Auth::user();
            $payment = $request->all();
            $payment['id_caja'] = $ultimaCaja->id_caja;
            $payment['id_user'] = $auth->id;

            $comprobante = Comprobante::findOrFail($request->id_comprobante);
            $payment['saldo'] = $comprobante->saldo - $payment['monto'];
            $paymentStored = ComprobantePago::create($payment);
            $comprobante->decrement('saldo', $paymentStored->monto);
            $comprobante->increment('total_abonado', $paymentStored->monto);
            $comprobante->save();


            DB::commit();
            return response()->json([
                'success' => true,
                'pago' => $paymentStored
            ]);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }
    public function pagos($comprobante)
    {

        try {

            $paymentsStored = ComprobantePago::with(['medio_pago', 'usuario'])->where('id_comprobante', $comprobante)->get();
            return response()->json([
                'success' => true,
                'pagos' => $paymentsStored
            ]);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }
    public function cuentas_pagar($debtsData, Request $request)
    {
        try {
            $authUser = Auth::user();
            $debtsIds = explode(',', $debtsData);

            $ultimaCaja = Caja::where('estado', 1)
                ->whereDate('created_at', DB::raw('CURDATE()'))
                ->orderBy('id_caja', 'DESC')
                ->first();
            if ($ultimaCaja === null) {
                return response()->json([
                    'success' => false,
                    'message' => 'La Caja no ha sido abierta aún hoy!'
                ], 422);
            }

            $validator = Validator::make(['comprobantesIds' => $debtsIds], [
                'comprobantesIds.*' => [
                    'required',
                    'integer',
                    Rule::exists('comprobantes', 'id_comprobante')
                ],
            ]);
            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Los Ids de los comprobantes no son correctos',
                    'errors' => $validator->errors()
                ], 422);
            }

            foreach ($debtsIds as $debtId) {
                $comprob = Comprobante::find($debtId);
                ComprobantePago::create([
                    'id_compra' => $debtId,
                    'id_user' => $authUser->id,
                    'monto' => $request->montoAbonado,
                    'saldo' => $comprob->saldo,
                    'fecha' => $request->fechaPago,
                    'id_comprobante' => $comprob->id_comprobante,
                    'id_caja' => $ultimaCaja->id_caja,
                    'id_metodo_pago' => $request->id_metodo_pago,
                    'observacion' => $request->descripcion
                ]);

                $comprob->update([
                    'total_abonado' => $comprob->total_abonado + $comprob->saldo,
                    'saldo' => 0,
                ]);
            }

            return response()->json([
                'success' => true,
                'message' => 'Pagos registrados correctamente',
            ], 200);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
