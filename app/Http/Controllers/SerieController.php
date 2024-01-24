<?php

namespace App\Http\Controllers;

use App\Models\ComprobanteSerie;
use Illuminate\Http\Request;

class SerieController extends Controller
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
        try{

            $documento = ComprobanteSerie::where('serie', $request->serie)
                ->first();
            if($documento){
                return response()->json([
                    'msg' => 'Serie ya registrada'
                ], 422);
            }

            $serie = ComprobanteSerie::create([
                'serie' => ucfirst($request->serie),
                'id_tipo_comprobante' => $request->id_serie_documento,
                'id_sucursal' => $request->id_sucursal,
            ]);
            return response()->json($serie, 201);
        }catch(\Exception $e){
            return response()->json($e->getMessage(),500);
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
        
        $serie = ComprobanteSerie::where('id_serie', $id)->first();
        if(!$serie){
            return response()->json([
                'msg' => 'Serie no encontrada'
            ], 404);
        }


        $serie->update([
            'estado' => 0
        ]);

        return response()->json([
            'msg' => 'Serie eliminada'
        ],200);
    }
}
