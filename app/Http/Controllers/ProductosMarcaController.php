<?php

namespace App\Http\Controllers;

use App\Models\ProductosMarca;
use Illuminate\Http\Request;

class ProductosMarcaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $data = ProductosMarca::where('estado', 1);
        $itemsPerPage = $request->itemsPerPage;
        $sortBy = $request->sortBy;
        $sortDesc = $request->sortDesc == true ? 'desc' : 'asc';

        if (isset($request->searchTerm)) {
            $data->where(function ($query) use ($request) {
                $query->where('marca_producto', 'like', '%' . $request->searchTerm . '%');
            });
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
            $marca_data = ProductosMarca::create([
                'marca_producto' => $request->marca_producto,
                'sincronizar' => ($request->sincronizar != 1) ? 0 : 1,
                'estado' => 1,
            ]);
            return response()->json($marca_data, 200);
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
            $data = ProductosMarca::findOrFail($id);
            $data->update([
                'marca_producto' => $request->marca_producto,
                'sincronizar' => ($request->sincronizar != 1) ? 0 : 1,
            ]);
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
            $data = ProductosMarca::findOrFail($id);
            $data->update(['estado'=>0]);
            return response()->json($data, 200);
            
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }


    public function combo(){
        try{
            $data = ProductosMarca::where('estado', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
}
