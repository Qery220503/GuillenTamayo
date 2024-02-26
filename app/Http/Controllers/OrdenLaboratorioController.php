<?php

namespace App\Http\Controllers;

use App\Models\OrdenLaboratorio;
use App\Models\OrdenLaboratorioHistorial;
use Illuminate\Http\Request;
use Exception;
use Illuminate\Support\Facades\Auth;
use Mpdf\Mpdf;

class OrdenLaboratorioController extends Controller
{
    public function index(Request $request)
    {
        try {
            $data = OrdenLaboratorio::listAll($request);
            return response()->json($data, 200);
        } catch (Exception $e) {
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
            $data = OrdenLaboratorio::with(
                'anamnesis',
                'montura',
                'cliente',
                'status',
                'usuario',
                'lente',
                'historial.estadoOrden',
                'historial.usuario'
            )->findOrFail($id);
            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function historial($id)
    {
        try {
            $data = OrdenLaboratorio::where('id_cliente', $id)
                ->limit(3)
                ->latest()
                ->get();
            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function vista($id_orden)
    {
        $orden_lab = OrdenLaboratorio::with(
            'anamnesis',
            'montura',
            'cliente',
            'status',
            'usuario',
            'lente',
            'sucursal'
        )->findOrFail($id_orden);


        $receta = [
            "oi" => "",
            "od" => "",
        ];

        $selection = [
            'oi' => '',
            'od' => '',
        ];

        // $recetaData = ($orden_lab->receta['recipe_selection'] === "recipe") ? $orden_lab->receta['recipe'] : $orden_lab->receta['contact_recipe'];
        $recetaData = $orden_lab->receta;
        $oiData = $recetaData['oi'];
        $odData = $recetaData['od'];
        foreach ($oiData as $clave => $valor) {
            if($valor !== null && $valor !== ''){
                $receta['oi'] .= strtoupper($clave) . ": " . $valor . ", ";
            }
        }
        foreach ($oiData as $clave => $valor) {
            if($valor !== null && $valor !== ''){
                $receta['od'] .= strtoupper($clave) . ": " . $valor . ", ";
            }
        }
        // if ($orden_lab->receta['recipe_selection'] === "recipe") {
        $receta['oi'] .= 'DIP: '.$recetaData['dip'];
        $receta['od'] .= 'DIP: '.$recetaData['dip'];
        // }


        // if($orden_lab->receta['recipe_selection'] === "recipe"){
        $selectionOpt = $recetaData['selection'];
        $data = $recetaData[$selectionOpt];


        foreach ($data['oi'] as $clave => $valor) {
            if($valor !== null && $valor !== ''){
                $selection['oi'] .= strtoupper($clave) . ": " . $valor . ", ";
            }
        }
        foreach ($data['od' ] as $clave => $valor) {
            if($valor !== null && $valor !== ''){
                $selection['od'] .= strtoupper($clave) . ": " . $valor . ", ";
            }
        }
        // }

        return view('orden_laboratorio', compact('orden_lab', 'receta', 'selection')); //, compact('orden'));
    }
    public function generarPDF($id)
    {
        $html = $this->vista($id)->render();
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

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try {
            $data = OrdenLaboratorio::findOrFail($id);
            $data->update($request->all());

            OrdenLaboratorioHistorial::create([
                'id_orden' => $id,
                'id_estado' => $request->id_estado_orden_laboratorio,
                'id_usuario' => Auth::user()->id,
            ]);
            return response()->json($data, 200);

        } catch (Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }


    /* Método que retorna ordenes de laboratorio a dashboard */
    public function listDashboard(Request $request)
    {
        $startDate  = $request->startDate;
        $endDate    = $request->endDate;
        try {
            $auth = auth('sanctum')->user();

            $data = OrdenLaboratorio::with(
                'anamnesis',
                'montura',
                'cliente',
                'status',
                'usuario',
                'lente',
                'anamnesis.clinica',
                'anamnesis.doctor'
            )->where('id_sucursal', $auth->id_sucursal)
                ->whereIn('id_estado_orden_laboratorio', [1, 2, 4]);

            if(isset($startDate)){
                if(isset($endDate)){
                    $data = $data->whereBetween('fecha_entrega', [$startDate, $endDate]);
                }else{
                    $data = $data->where('fecha_entrega', '>=', $startDate);
                }
            }

            return response()->json($data->paginate(100), 200);

        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }
}
