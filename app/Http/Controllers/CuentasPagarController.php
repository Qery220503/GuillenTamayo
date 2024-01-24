<?php

namespace App\Http\Controllers;

use App\Models\Compras;
use App\Models\DeudaCompraPago;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;

class CuentasPagarController extends Controller
{
    public function index(Request $request){
        $authUser = auth('sanctum')->user();

        $searchTerm = $request->searchTerm;
        $fechaInicio = $request->fechaInicio;
        $fechaFin    = $request->fechaFin;
        
        $data = Compras::where([
                ['id_sucursal', '=', $authUser->id_sucursal],
                ['condicion_pago', '!=', 1], // 1 = al contado
                ['estado', 1]
            ]);

        if(isset($searchTerm)){
            $data = $data->whereHas('proveedores', function ($query) use ($searchTerm) {
                $query->where('nombre', 'like', "%{$searchTerm}%")
                    ->orWhere('nro_doc', 'like', "%{$searchTerm}%");
            });
        }
        if(isset($fechaInicio)){
            if(isset($fechaFin)){
                $data = $data->whereBetween('fecha', [$fechaInicio, $fechaFin]);
            }else{
                $data = $data->where('fecha', '>=', $fechaInicio);
            }
        }

        return $data->orderBy('fecha_vencimiento', 'asc')->paginate($request->perPage);
    }

    public function store(Request $request){
        $authUser = auth('sanctum')->user();

        $deuda = Compras::findOrFail($request->id_compra);
        if($request->montoAbonado > $deuda->deuda_saldo){
            return response()->json(['message' => 'El monto introducido excede el total pentiende de la deuda'], 500);
        }
        
        $deuda->deuda_saldo = (float)$deuda->deuda_saldo - (float)$request->montoAbonado;
        $deuda->deuda_total_abonado = (float)$deuda->deuda_total_abonado + (float)$request->montoAbonado;
        $deuda->save();

        DeudaCompraPago::create([
            'id_compra' => $request->id_compra,
            'user_id' => $authUser->id,
            'banco' => $request->banco,
            'monto_abonado' => $request->montoAbonado,
            'fecha' => $request->fechaPago,
            'descripcion' => $request->descripcion,
            'nro_operacion' => $request->nroOperacion,
            'id_origen_dinero' => $request->idOrigenDinero,
        ]);
        
        return response()->json(['message' => 'Pago registrado correctamente'], 200);
    }

    public function show($id){
        try{
            $data = Compras::with(
              'pagos_deuda',
            )->findOrFail($id);
            return response()->json($data, 200);

        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function pagoGrupal($debtsData, Request $request){
        $authUser = Auth::user();
        $debtsIds = explode(',', $debtsData);

        //--- Validacion de IDs compras ---
        $validator = Validator::make(['compraIds' => $debtsIds], [
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
                'errors' => $validator->errors()
            ], 422);
        }
        //--- Fin ---

       foreach ($debtsIds as $debtId) {
            $compra = Compras::find($debtId);
            DeudaCompraPago::create([
                'id_compra' => $debtId,
                'user_id' => $authUser->id,
                'banco' => $request->banco,
                'monto_abonado' => $compra->deuda_saldo,
                'fecha' => $request->fechaPago,
                'descripcion' => $request->descripcion,
                'id_origen_dinero' => $request->idOrigenDinero,
            ]);
    
            $compra->update([
                'deuda_total_abonado' => $compra->deuda_total_abonado + $compra->deuda_saldo,
                'deuda_saldo' => 0,
            ]);
       }
            
        return response()->json([
            'success' => true,
            'message' => 'Pagos registrados correctamente',
        ], 200);
    }
}