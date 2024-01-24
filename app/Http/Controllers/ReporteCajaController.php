<?php

namespace App\Http\Controllers;

use App\Models\Comprobante;
use App\Models\ComprobantePagoDeuda;
use App\Models\Egresos;
use Carbon\Carbon;
use Illuminate\Http\Request;

class ReporteCajaController extends Controller
{
    public function comprobantes(Request $request)
    {
        $data = Comprobante::with(['serie','cliente', 'medio_pago', 'caja',
                                'credito' => function ($query){
                                    $query->where('fecha_pago', null);
                                }])->where('fecha_anulacion', null)
                                    ->where("id_caja", "=" ,$request->caja);
        $itemsPerPage = $request->itemsPerPage;
        $sortBy = $request->sortBy;
        $sortDesc = $request->sortDesc == true ? 'desc' : 'asc';
        if (isset($sortBy)) {
            $data->orderBy($sortBy, $sortDesc);
        }
        return $data->paginate($itemsPerPage);
    }

    public function pagosDeudas(Request $request){

        $pagos = ComprobantePagoDeuda::with(['medio_pago','caja','cuota.comprobante.serie', 'cuota.comprobante.cliente'])
                                     ->where('id_caja', $request->caja)
                                     ->get();
        
        return response()->json($pagos);
    }

    public function egresosReporte(Request $request){
        $egresos = Egresos::where('id_caja', $request->caja)
                          ->where('origen', 1)
                          ->where('estado',1)
                          ->get();
        return response()->json($egresos, 200);
    }
}
