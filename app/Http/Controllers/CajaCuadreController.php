<?php

namespace App\Http\Controllers;

use App\Models\Caja;
use App\Models\CajaCuadre;
use Exception;
use Illuminate\Http\Request;

class CajaCuadreController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $condicion = $request->input($request->estadoCuadre, 0);
        $idCaja = $request->idCaja;
        $porPagina = $request->perPage;

        $data = CajaCuadre::where('id_caja', $idCaja);
        if ($condicion !== 0) {
            $data = $data->where('id_estado', $condicion);
        }
        return $data->latest()->paginate($porPagina);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
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
        try {
            $idCaja = $request->idCaja;
            $total = $request->total;
            $sobrante_faltante = 0;
            $id_estado = 0;

            $sobrante_faltante = $total - $request->montoActual;
            if ($sobrante_faltante == 0) {
                $id_estado = 1;
            } elseif ($sobrante_faltante > 0) {
                $id_estado = 2;
            } else {
                $id_estado = 3;
            }
            $cuadre = $request->all();
            $cuadre["id_caja"] = $request->idCaja;
            $cuadre["id_estado"] = $id_estado;
            $cuadre["sobrante_faltante"] = $sobrante_faltante;
            CajaCuadre::create($cuadre);

            return response()->json($cuadre, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\CajaCuadre  $cajaCuadre
     * @return \Illuminate\Http\Response
     */
    public function show(CajaCuadre $cajaCuadre)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\CajaCuadre  $cajaCuadre
     * @return \Illuminate\Http\Response
     */
    public function edit(CajaCuadre $cajaCuadre)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\CajaCuadre  $cajaCuadre
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, CajaCuadre $cajaCuadre)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\CajaCuadre  $cajaCuadre
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request, CajaCuadre $cajaCuadre)
    {
        try {
            $upd_data = array(
                'estado' => 0,
                'motivo_eliminacion' => $request->motivo_eliminacion,
            );
            $cajaCuadre->update($upd_data);
            return response()->json($cajaCuadre, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }
}
