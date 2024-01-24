<?php

namespace App\Http\Controllers;

use App\Models\Comprobante;
use App\Models\Encuesta;
use App\Models\EncuestaPregunta;
use App\Models\EncuestaRespuesta;
use App\Models\OrdenLaboratorio;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx\Rels;

class EncuestaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Encuesta  $encuesta
     * @return \Illuminate\Http\Response
     */
    public function show(Encuesta $encuesta)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Encuesta  $encuesta
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Encuesta $encuesta)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Encuesta  $encuesta
     * @return \Illuminate\Http\Response
     */
    public function destroy(Encuesta $encuesta)
    {
        //
    }

    public function encuesta($comprobante){
        $encuesta = Encuesta::where('id_comprobante', $comprobante)->first();
        return response()->json($encuesta, 200);
    }

    public function preguntas($comprobante){
        $comprobante = Comprobante::findOrFail($comprobante);
        $encuesta = Encuesta::where('id_comprobante', $comprobante->id_comprobante)->first();


        $ordenLab = OrdenLaboratorio::findOrFail($comprobante->id_orden_lab);
        $user = Auth::user();

        if($encuesta == null){
            $encuesta = Encuesta::create([
                'id_cliente' => $comprobante->id_cliente,
                'id_sucursal' => $user->id_sucursal,	
                'id_user' => $user->id,
                'id_comprobante' => $comprobante->id_comprobante,
                'id_anamnesis'  => $ordenLab->id_anamnesis,
            ]);

            $preguntas = EncuestaPregunta::whereHas('etapa', function ($query) {
                $query->where('parte', 1);
            })->get();
            return response()->json([
                'parte' => 1,
                'encuesta' => $encuesta,
                'preguntas' => $preguntas
            ]);
        }


        $respuestas = EncuestaRespuesta::with(['pregunta.etapa'])->where('id_encuesta', $encuesta->id_encuesta)->get();

        if($respuestas->count() == 0){
            
            $preguntas = EncuestaPregunta::whereHas('etapa', function ($query) {
                $query->where('parte', 1);
            })->get();

            return response()->json([
                'parte' => 1,
                'encuesta' => $encuesta,
                'preguntas' => $preguntas
            ]);
        }

        $estaEnSegundaParte = $respuestas->contains(function ($respuesta) {
            return $respuesta->pregunta->etapa->parte ===  2;
        });

        if(!$estaEnSegundaParte){
            $preguntas = EncuestaPregunta::whereHas('etapa', function ($query) {
                $query->where('parte', 2);
            })->get();

            return response()->json([
                'parte' => 2,
                'encuesta' => $encuesta,
                'preguntas' => $preguntas
            ]);
        }



        return response()->json([
            'parte' => 3,
            'encuesta' => $encuesta,
        ]);
    }

    public function responder(Request $request, $encuesta){
        //return response()->json($request->all());
        $data = $request->all();
        EncuestaRespuesta::insert($data['respuestas']);
        $res = Encuesta::findOrFail($encuesta);
        $res->sugerencias = $request->sugerencias;
        $res->nivel_satisfaccion = $request->nivel_satisfaccion;
        $res->save();
        

        return response()->json(['success' => true]);
    }
}
