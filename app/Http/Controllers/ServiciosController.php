<?php

namespace App\Http\Controllers;

use App\Models\ComprobanteSerie;
use App\Models\Servicio;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ServiciosController extends Controller
{
/**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        
        $data = Servicio::with('afectacion')->where('estado', 1)->where('id_sucursal', Auth::user()->id_sucursal);
        $itemsPerPage = $request->itemsPerPage;
        $sortBy = $request->sortBy;
        $sortDesc = $request->sortDesc == true ? 'desc' : 'asc';
        
        if(isset($request->nombre_servicio)){
            $data->where("nombre_servicio", "LIKE", "%".$request->nombre_servicio."%");
        }
        if(isset($request->precio_compra)){
            $data->where("precio_compra", "LIKE", "%".$request->precio_compra."%");
        }
        if(isset($request->precio_venta)){
            $data->where("precio_venta", "LIKE", "%".$request->precio_venta."%");
        }
        if(isset($request->cod_afectacion_igv)){
            $data->where("cod_afectacion_igv", "LIKE", "%".$request->cod_afectacion_igv."%");
        }

        if (isset($sortBy)) {
            $data->orderBy($sortBy, $sortDesc);
        }
        return $data->paginate($itemsPerPage);
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
            $user = Auth::user();
            $create_data = $request->except('_token');
            $create_data['id_sucursal'] = $user->id_sucursal;
            $create_data['estado'] = 1;
            $data = Servicio::create($create_data);
            return response()->json($data, 200);
        } catch (\Exception $e) {
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
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
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
        try {
            $data = Servicio::findOrFail($id);
            $data->update($request->except('_token'));
            return response()->json($data, 200);
            
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {
            $data = Servicio::findOrFail($id);
            $data->update(['estado'=>0]);
            return response()->json($data, 200);

        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }


    public function combo(){
        try{
            $data = Servicio::where('estado', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function documentosSeries(Request $request){

        $user = Auth::user();

        $data = ComprobanteSerie::where([
            ['id_tipo_comprobante', $request->documento],
            ['id_sucursal', $user->id_sucursal]
        ])
            ->get();

        return response()->json($data, 200);
    }
}
