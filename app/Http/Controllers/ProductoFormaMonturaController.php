<?php

namespace App\Http\Controllers;

use App\Models\ProductoFormaMontura;
use Illuminate\Http\Request;

class ProductoFormaMonturaController extends Controller
{
    public function index(Request $request)
    {
        $data = ProductoFormaMontura::where('estado', 1);
        $itemsPerPage = $request->itemsPerPage;
        $sortBy = $request->sortBy;
        $sortDesc = $request->sortDesc == true ? 'desc' : 'asc';

        if (isset($request->searchTerm)) {
            $data->where(function ($query) use ($request) {
                $query->where('forma_montura', 'like', '%' . $request->searchTerm . '%');
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
            $marca_data = ProductoFormaMontura::create([
                'forma_montura' => $request->forma_montura,
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
            $data = ProductoFormaMontura::findOrFail($id);
            $upd_data = array(
                'forma_montura' => $request->forma_montura,
                'rostros' => $request->rostros
            );
            $data->update($upd_data);
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
            $data = ProductoFormaMontura::findOrFail($id);
            $upd_data = array(
                'estado'  =>  0
            );
            $data->update($upd_data);
            return response()->json($data, 200);
            
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }


    public function combo(){
        try{
            $data = ProductoFormaMontura::where('estado', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
}
