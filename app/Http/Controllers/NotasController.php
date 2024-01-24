<?php

namespace App\Http\Controllers;

use App\Models\Comprobante;
//use App\Models\ComprobanteCredito;
use App\Models\ComprobanteSerie;
use App\Models\Nota;
use App\Models\NotaDetalle;
use App\Models\AlmacenMovimiento;
use App\Models\TipoNota;
use App\Services\NotasService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class NotasController extends Controller
{
    public function index(Request $request)
    {
        return Nota::listAll($request);
    }

    public function store(Request $request)
    {
        DB::beginTransaction();
        try{
            //return response()->json($request->all(),500);
            $user = Auth::user();
            $header = $request->except('detalle');
            $header['id_sucursal'] = $user->id_sucursal;
            $header['id_estado_comprobante'] = 4;
            //calcular correlativo,
            $correlativo = Nota::where('id_tipo_comprobantes', $header['id_tipo_comprobantes'])
                            ->where('id_sucursal', $user->id_sucursal)
                            ->where('id_serie', $header['id_serie'])
                            ->count();
            
            //correlativo provisional
            $header['correlativo'] = ++$correlativo;
            $nota = Nota::create($header);

            foreach ($request->detalle as $detalle) {
                $detalle["id_nota"] = $nota->id_nota;
                NotaDetalle::create($detalle);
            }
            $facturadorData = NotasService::enviar($nota->id_nota);
            $facturadorData['id_nota'] = $nota->id_nota;
            DB::commit();
            return response()->json($facturadorData, 200);
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }

    }

    public function show($id)
    {
        $auth = Auth::user();
        $nota = Nota::with([
            'cliente',
            'sucursal',
            'serie',
            'comprobante.serie',
            'estado_nota',
            'detalle.unidad_medida',
            'tipo'
        ])
        ->where('id_sucursal', $auth->id_sucursal)
        ->where('estado', 1)
        ->where('id_nota', $id)
        ->first();

        return response()->json($nota);
    }

    public function update(Request $request, $id)
    {
        //
    }

    public function destroy($id)
    {
        //
    }

    public function tiposNota($nota){
        $data = TipoNota::where('id_tipo_comprobantes', $nota)->get();
        return response()->json($data);
    }

    public function seriesNotas($tipo){
        try{
            $user = Auth::user();
            $seriesNotas = ComprobanteSerie::where('estado', 1)
                            ->with('documento')
                            ->where('id_sucursal', $user->id_sucursal)
                            ->where('id_tipo_comprobante', $tipo)
                            ->get();
            return response()->json($seriesNotas);
        }catch(Exception $e){
            return response()->json([
                'msg' => $e->getMessage(),
                'success' => false
            ], 500);
        }
    }

    //Regresa el stock y cancela cualquier deuda que tenga un cliente si se emite 
    //una nota de credito de tipo anilación de operación.
    public function anulacionOperacion($nota){
        DB::beginTransaction();
        try{
            $nota  = Nota::with(['comprobante.detalle', 'detalle'])->findOrFail($nota);
            $comprobante = $nota->comprobante;
            $detalles = $nota->detalle;
            $user = Auth::user();
            //Devolución de stock
            foreach($detalles as $detalle){
                if($detalle->item_type == 1){
                    AlmacenMovimiento::devolucionStock([
                        "id_producto" => $detalle->id_producto,
                        "cantidad" => $detalle->cantidad,
                        "precio_total" => $detalle->total
                    ], $user->id_sucursal);
                }
            }
            //Eliminación de deudas

            //$inv_credito = ComprobanteCredito::where('id_comprobante', $nota->id_comprobante)->first();
            //$inv_credito->update(['estado' => 0]);

            DB::commit();
            return response()->json(['success' => true], 200);
        }catch(Exception $e){
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ]);
        }
        

    }
}
