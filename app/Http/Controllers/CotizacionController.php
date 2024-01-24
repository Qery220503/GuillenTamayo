<?php

namespace App\Http\Controllers;

use App\Http\Requests\CotizacionCreateRequest;
use App\Models\ComprobanteSerie;
use App\Models\Cotizacion;
use App\Models\CotizacionDetalle;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Mpdf\Mpdf;

class CotizacionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        try{
            $data = Cotizacion::with(['serie', 'cliente'])
                            ->where('cotizaciones.estado', 1);
            $itemsPerPage = $request->itemsPerPage;
            $sortBy = $request->sortBy;
            $sortDesc = $request->sortDesc == true ? 'desc' : 'asc';
            if(isset($request->correlativo)){
                $searchCorrelativo = $request->correlativo;

                $data->join('comprobantes_series', 'comprobantes_series.id_serie', '=', 'cotizaciones.id_serie')
                ->whereRaw("concat(comprobantes_series.serie,'-', lpad(cotizaciones.correlativo, 8, '0')) LIKE ?", ['%'. $searchCorrelativo . '%'])
                ->get();
            }
            if(isset($request->cliente)){
                $searchClient = "%".$request->cliente."%";
                $data->whereHas('cliente', function($query) use ($searchClient){
                    return $query->where('nombre_razon_social', 'LIKE' , "%{$searchClient}%");
                });
            }
            if(isset($request->fecha)){
                $searchDate = new Carbon($request->fecha);
                $data->whereDate('created_at', $searchDate->toDateString());
            }
            if (isset($sortBy)) {
                $data->orderBy($sortBy, $sortDesc);
            }else{
                $data->orderBy("id_cotizacion", "DESC");
            }
            return $data->paginate($itemsPerPage);
        }catch(Exception $e){
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
                'line' => $e->getLine()
            ]);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(CotizacionCreateRequest $request)
    {
        DB::beginTransaction();
        try{
            $logged_user = auth('sanctum')->user();
            $serie = ComprobanteSerie::where('id_tipo_comprobante', 4)->first();
            $correlativo = Cotizacion::where([
                ['id_serie', $serie->id_serie],
                ['id_sucursal', $logged_user->id_sucursal]
            ])->count();
            $cotizacion = Cotizacion::create([
                'id_serie' => $serie->id_serie,
                'id_anamnesis' => $request->id_anamnesis,
                'id_cliente' => $request->id_cliente,
                'correlativo' => $correlativo + 1,
                'receta' => $request->receta,
                'refraccion_lejos' => $request->refraccion_lejos,
                'refraccion_cerca' => $request->refraccion_cerca,
                'refraccion_intermedia' => $request->refraccion_intermedia,
                'vision_intermedia' => $request->vision_intermedia,
                'adiciones' => $request->adiciones,
            ]);
            $detallesCotizacion = array();
            foreach ($request->detalle as $detalle) {
                $d = CotizacionDetalle::create([
                    'id_cotizacion' => $cotizacion->id_cotizacion,
                    'id_producto' => $detalle['id_producto'],
                    'id_precio_lente' => $detalle['id_precio_lente'],
                    'montaje' => $detalle['montaje'],
                    'montura' => $detalle['montura'],
                ]);
                array_push($detallesCotizacion, $d);
            }

            DB::commit();
            return response()->json([
                'success' => true,
                "cotizacion" => $cotizacion,
                "detalle" => $detallesCotizacion
            ]);
        }catch(Exception $e){
            DB::rollBack();
            return response()->json([
                'success' => false,
                'msg' => "Ocurrio un error",
                'error' => $e->getMessage()
            ]);
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
        //
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
    public function vista($id, $detalles = null){
        $cotizacion = Cotizacion::with(['serie', 'cliente', 'anamnesis.clinica'])->findOrFail($id);
        
        $detalle = CotizacionDetalle::with([
            'precio_lente',
            'producto.marca',
            'producto.material',
            'producto.tipo_aro',
            'producto.forma_montura'
        ])->where('id_cotizacion',$id);

        if(sizeof($detalles) != 0){
            $detalle = $detalle->whereIn('id_cotizacion_detalle', $detalles);
        }

        $detalle = $detalle->get()->toArray();
        return view('cotizacion', compact('cotizacion','detalle'));
    }
    public function generarPDF($id, $detalle = null)
    {
        
        $detalles = ($detalle == null) ? [] : explode(',', $detalle);
        $html = $this->vista($id, $detalles);
        $file = 'pdf_' . 'pdf';
        $mpdf = new Mpdf(
            [
                'mode' => 'utf-8',
                'format' => [80, 650],
                'margin_top' => 2,
                'margin_right' => 5,
                'margin_bottom' => 0,
                'margin_left' => 5
            ]
        );
        $mpdf->WriteHTML($html);
        $mpdf->Output($file, 'I');
    }

    public function cotizacionesPacientes($id){
        $cotizaciones = DB::table('cotizaciones_detalle')
                            ->select(
                                'cotizaciones_detalle.id_cotizacion_detalle',
                                'cotizaciones.id_cotizacion',
                                'comprobantes_series.serie',
                                'cotizaciones.correlativo',
                                'precios_lentes.nombre_propio',
                                'precios_lentes.id_precio_lente',
                                'precios_lentes.precio_venta',
                                'cotizaciones.receta',
                                'cotizaciones_detalle.montaje',
                                'cotizaciones_detalle.montura',
                                'productos.id_producto',
                                'productos.precio_venta AS precio_producto',
                                'productos.nombre_producto',
                                'cotizaciones.created_at'
                            )
                            ->join('cotizaciones', 'cotizaciones.id_cotizacion', '=', 'cotizaciones_detalle.id_cotizacion')
                            ->join('comprobantes_series', 'comprobantes_series.id_serie', '=', 'cotizaciones.id_serie')
                            ->join('precios_lentes', 'precios_lentes.id_precio_lente', '=', 'cotizaciones_detalle.id_precio_lente')
                            ->join('productos', 'productos.id_producto', '=', 'cotizaciones_detalle.id_producto')
                            ->where('cotizaciones.id_cliente', $id)
                            ->where('cotizaciones.estado', 1)
                            ->where('cotizaciones.created_at', '>=', Carbon::now()->subMonth())
                            ->orderBy('cotizaciones_detalle.id_cotizacion_detalle', 'DESC')
                            ->get();

        return response()->json($cotizaciones, 200);

    }
    public function detallesCotizacion($id){
        $detalle = CotizacionDetalle::with([
            'precio_lente',
            'producto',
        ])->where('id_cotizacion',$id)->get()->toArray();
        return response()->json($detalle, 200);
    }
}
