<?php

namespace App\Http\Controllers;

use App\Models\Caja;
use App\Models\Comprobante;
use App\Models\User;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx\Rels;
use Illuminate\Support\Facades\DB;

class CajaController extends Controller
{
    public function __constructor()
    {
        $this->middleware('auth:sanctum');
    }
    public function index(){

    }

    public function store(Request $request)
    {
        $auth = auth('sanctum')->user();
        $user = User::findOrFail(auth('sanctum')->user()->id);
        try {
            $ultimaCaja = Caja::where('estado', 1)
                                ->whereDate('created_at', DB::raw('CURDATE()'))
                                ->where('id_sucursal', $auth->id_sucursal)
                                ->orderBy('id_caja', 'DESC')
                                ->first();
            if(isset($ultimaCaja)){
                return response()->json([
                    'msg' => 'Existen cajas sin cerrar',
                    'success' => false,
                    'caja' => $ultimaCaja
                ], 500);
            }


            $request->merge(['id_usuario' => $auth->id]);
            $request->merge(['id_sucursal' => $user->id_sucursal]);
            $caja = Caja::create($request->all());
            return response()->json($caja, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }
    public function show(Request $request){
    }
    public function cajasPendientes()
    {
        $ultimaCaja = Caja::where('estado', 1)
            ->whereDate('created_at', DB::raw('CURDATE()'))
            ->orderBy('id_caja', 'DESC')
            ->first();
        if (isset($ultimaCaja)) {
            $cajas = Caja::where('estado', 1)
                ->where('id_caja', '<>', $ultimaCaja->id_caja)
                ->get();
        } else {
            $cajas = Caja::where('estado', 1)
                ->get();
        }
        return response()->json($cajas);
    }
    public function open(Request $request)
    {
        $auth = auth('sanctum')->user();
        try {
            $auth = auth('sanctum')->user();
            $caja = Caja::where('estado', 1)
                ->where('id_sucursal', $auth->id_sucursal)
                ->whereDate('created_at', DB::raw('CURDATE()'))
                ->orderBy('id_caja', 'DESC')
                ->first();
            if (isset($caja)) {
                return response()->json([
                    'data' => $caja,
                    'success' => isset($caja)
                ]);
            } else {
                $caja = Caja::where('id_sucursal', $auth->id_sucursal)
                    ->latest()
                    ->first();
                return response()->json([
                    'data' => $caja,
                    'success' => false
                ]);
            }
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function close(Request $request)
    {
        try {
            $caja = Caja::where('id_caja', $request->id_caja)
                ->first();
            $caja->estado = 0;
            $caja->save();
            return response()->json([
                'success' => true,
                'caja' => $caja
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage()
            ], 500);
        }
    }
    public function cajaDetalles(Request $request)
    {
        $caja  = Caja::where('id_caja', $request->id_caja)
            ->first();

        $ventas = DB::table('medio_pago as mp')
            ->select('mp.id_medio_pago', 'mp.medio_pago as medio', DB::raw('IFNULL(SUM(c.total), "0.00") as total'))
            ->leftJoin(
                'comprobantes as c',
                function ($leftJoin) use ($caja) {
                    $leftJoin->on('c.id_medio_pago', '=', 'mp.id_medio_pago')
                        ->where('c.id_caja', '=', $caja->id_caja)
                        ->where('c.fecha_anulacion', '=', null);
                }
            )
            ->groupBy('medio')
            ->get();
        $deudasPagos = DB::table('medio_pago as mp')
            ->select('mp.id_medio_pago', 'mp.medio_pago as medio',  DB::raw('IFNULL(SUM(c.monto), "0.00") as total'))
            ->leftJoin(
                'comprobantes_pago_deuda as c',
                function ($leftJoin) use ($caja) {
                    $leftJoin->on('c.id_medio_pago', '=', 'mp.id_medio_pago')
                        ->where('c.id_caja', '=', $caja->id_caja);
                }
            )
            ->groupBy('medio')
            ->get();

        $egresos = DB::table('egresos')
            ->where('id_caja', $caja->id_caja)
            ->where('origen', 1)
            ->where('estado', 1)
            ->sum('monto');

        $cancelaciones = DB::table('comprobantes')
            ->where('id_caja', $caja->id_caja)
            ->where('fecha_anulacion', '<>', null)
            ->sum('total');


        return response()->json([
            "success" => true,
            "data" => [
                "ingresos" => [
                    "ventas" => $ventas,
                    "deudas_clientes" => $deudasPagos
                ],
                "egresos" => [
                    "egresos" => $egresos,
                    "cancelaciones" => $cancelaciones
                ]
            ],
        ], 200);
    }
    public function ultimaCaja(){
        $caja = Caja::orderBy("id_caja", "DESC")->first();
        return response()->json($caja, 200);
    }
    public function cajasPorFechas(Request $request){
        $datetime = new Carbon($request->date);
        $cajas = Caja::whereDate('created_at',"=",$datetime)->get();
        return response()->json($cajas);
    }
}
