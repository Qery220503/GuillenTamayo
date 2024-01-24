<?php

namespace App\Http\Controllers;

use App\Models\Cupon;
use Exception;
use Illuminate\Http\Request;

class CuponesController extends Controller
{
    public function index(Request $request)
    {
        try{
            $authUser = auth('sanctum')->user();
    
            $searchTerm = $request->searchTerm;
            $fechaInicio = $request->fechaInicio;
            $fechaFin    = $request->fechaFin;

            $data = Cupon::where([
                ['id_sucursal', '=', $authUser->id_sucursal],
                ['active', 1],
            ]);
            
            if(isset($searchTerm)){
                $data = $data->where('codigo_cupon', 'like', "%{$searchTerm}%");
            }
            if(isset($fechaInicio)){
                if(isset($fechaFin)){
                    $data = $data->whereBetween('fecha_vencimiento', [$fechaInicio, $fechaFin]);
                }else{
                    $data = $data->where('fecha_vencimiento', '>=', $fechaInicio);
                }
            }

            return $data->latest()->paginate($request->perPage);
            
        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
    
    public function store(Request $request)
    {
        if($request->codigo_cupon){
            $this->validate($request,[
                'codigo_cupon' => 'unique:App\Models\Cupon,codigo_cupon',
            ]);
        }

        $authUser = auth('sanctum')->user();
        $_merge = $request;
        $_merge['id_usuario'] = $authUser->id;
        $_merge['id_sucursal'] = $authUser->id_sucursal;
        Cupon::create(collect($_merge)->all());

        return response()->json(['success'=>true, 'message' => 'Registro creado correctamente!']);
    }
    
    public function update(Request $request, $id)
    {
        $data = Cupon::findOrFail($id);
        $data->update($request->all());

        return response()->json(['success'=>true, 'message' => 'Registro actualizado correctamente!']);    
    }
    
    public function destroy($id)
    {
        try{            
            $data = Cupon::findOrFail($id);
            $data->customRemove();
            
            return response()->json(["success"=>true], 200);

        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function verify($codigo){
        $cupon = Cupon::where('codigo_cupon', $codigo)
                      ->where('active',1)
                      ->where('status',1)
                      ->first();

        return response()->json($cupon);
    }
}