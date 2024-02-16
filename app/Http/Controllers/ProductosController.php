<?php

namespace App\Http\Controllers;

use App\Models\Productos;
use App\Models\ProductoTipoAro;
use App\Models\ProductosCategoria;
use App\Models\ProductosMaterial;
use App\Models\ProductoFormaMontura;
use App\Models\ProductosMarca;
use App\Models\StockProductoSucursal;
use App\Traits\DatabaseRowsTrait;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request; 
use Exception;

class ProductosController extends Controller
{
    use DatabaseRowsTrait;

    public function __constructor(){
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request){
        $datos = Productos::with(['marca','material'])
        ->where([
            ["estado", 1],
        ]);

        if(isset($request->codigo_producto)){
            $datos->where("codigo_producto", "LIKE", "%".$request->codigo_producto."%");
        }
        if(isset($request->nombre_producto)){
            $datos->where("nombre_producto", "LIKE", "%".$request->nombre_producto."%");
        }
        if(isset($request->codigo_varilla)){
            $datos->where("codigo_varilla", "LIKE", "%".$request->codigo_varilla."%");
        }
        if(isset($request->marca_producto)){
            $datos->whereHas('marca', function ($query) use ($request) {
                $query->where('marca_producto', 'LIKE', '%' . $request->marca_producto . '%');
            });
        }
        if(isset($request->material_producto)){
            $datos->whereHas('material', function ($query) use ($request) {
                $query->where('nombre_material', 'LIKE', '%' . $request->material_producto . '%');
            });
        }
        if(isset($request->stock)){
            $datos->where("stock", "LIKE", "%".$request->stock."%");
        }
        if(isset($request->precio_compra)){
            $datos->where("precio_compra", "LIKE", "%".$request->precio_compra."%");
        }
        if(isset($request->precio_venta)){
            $datos->where("precio_venta", "LIKE", "%".$request->precio_venta."%");
        }
        if(isset($request->producto_reto)){
            $datos->where("producto_reto", $request->producto_reto);
        }
        if(isset($request->liquido)){
            $datos->where("liquido", $request->liquido);
        }

        return $datos->latest()->paginate($request->perPage);
    }

    public function store(Request $request){
        try{
            $auth = auth('sanctum')->user();
            $marca = ProductosMarca::find($request->marca['id_marca_producto']);
            $request->merge([
                'id_sucursal' => $auth->id_sucursal,
                'id_marca' => $marca->id_marca_producto,
                'codigo_producto' => $this->GenerateProductCode($marca->marca_producto)
            ]);

            $data = Productos::create($request->all());
            StockProductoSucursal::create([
                'id_producto' => $data->id_producto,
                'id_sucursal' => $data->id_sucursal,
                'ubicacion' => 1,
                'stock' => $data->stock,
            ]);

            return response()->json($data, 200);

        }catch(Exception $e){
            return response()->json($e->getTraceAsString(),500);
        }
    }

    public function show($id){
        try{
            $producto = Productos::findOrFail($id);
            return response()->json($producto, 200);

        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function update(Request $request, $id){
        try{
            $data = Productos::findOrFail($id);
            $data->update($request->all());
            $data->save();

            return response()->json($data, 200);

        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function destroy($id){
        try{
            $data = Productos::findOrFail($id);
            $data->update(['estado'=>0]);
            return response()->json($data, 200);

        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function combo(){
        try{
            $data = Productos::where('estado', 1)->get();
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }


    //--- Aditional Functions ---
    public function GenerateProductCode($marca){
        $past_data = new Productos;
        $letter = 'A';
        $correlative = 1;

        if($past_data->first()){
            //Se encontraron productos de registros
            $last_record = $past_data->latest()->first();
            $letter = substr($last_record->codigo_producto, 0, 1);
            $correlative = substr($last_record->codigo_producto, 1, 3);

            if($correlative>='999'){
                // Se llego al limite de la letra
                ++$letter;
                $correlative = 1;

            } else {
                // Se continua con el siguiente correlativo en la misma letra
                ++$correlative;
            }
        }

        $codigo_producto  = $letter
                            .str_pad($correlative, 3, "0", STR_PAD_LEFT)
                            .'-'.date("m")
                            .substr($marca, 0, 3)
                            .date("y");

        return $this->SetUpperCase($codigo_producto);
    }

    public function send_file(Request $request){
        DB::beginTransaction();

        try{
            $categorias = ProductosCategoria::where('estado', 1)->get();
            $tipo_aros = ProductoTipoAro::where('estado', 1)->get();
            $marcas = ProductosMarca::where('estado', 1)->get();
            $materiales = ProductosMaterial::where('estado', 1)->get();
            $forma_monturas = ProductoFormaMontura::where('estado', 1)->get();

            foreach ($request->data as $value) {
                $marca = $marcas->where('marca_producto', $value['marca'])->first();
                $categoria = $categorias->where('nombre_categoria', $value['categoria'])->first();
                $material = $materiales->where('nombre_material', $value['material']);
                $tipo_aro = $tipo_aros->where('tipo_aro', $value['tipo_aro']);
                $forma_montura = $forma_monturas->where('forma_montura', $value['forma_montura']);
                $genero = 0;
                if($value['forma_montura'] == 'varon')  $genero = 1;
                if($value['forma_montura'] == 'dama') $genero = 2;
                if($value['forma_montura'] == 'niño') $genero = 3;
                if($value['forma_montura'] ==  'niña') $genero = 4;
                if($value['forma_montura'] == 'unisex') $genero = 5;
                $rango = '';
                if($value['precio_venta']<= 150){
                    $rango = 'ECONÓMICO';
                }
                if($value['precio_venta'] > 150 && $value['precio_venta']<= 350){
                    $rango = 'INTERMEDIO';
                }
                if($value['precio_venta'] > 350){
                    $rango = 'CARA';
                }

                Productos::create([
                    'codigo_producto' => $this->GenerateProductCode($marca->marca_producto),
                    'nombre_producto' => $marca->marca_producto.'-'.$this->GenerateProductCode($marca->marca_producto),
                    'id_marca' => $marca->id_marca,
                    'id_categoria' => $categoria->id_producto_categoria,
                    'codigo_varilla' => $value['codigo_varilla'],
                    'codigo_sunat' => $value['codigo_sunat'],
                    'rango' => $rango,
                    'id_material' => $material->id_material,
                    'id_tipo_aro' => $tipo_aro->id_tipo_aro,
                    'id_forma_montura' => $forma_montura->id_forma_montura,
                    'tipo_rostro' => $forma_montura->rostros,
                    'genero' => $genero,
                    'adicionales' => $value['adicionales'],
                    'descripcion' => $value['descripcion'],
                    'producto_reto' => $value['producto_reto'] == 'si' ? 1 : 0,
                    'sobrelentes' => $value['sobrelentes'] == 'si' ? 1 : 0,
                    // 'liquido' => $value['liquido'] == 'si' ? 1 : 0,
                    'diagonal' => $value['diagonal'],
                    'puente' => $value['puente'],
                    'varilla' => $value['varilla'],
                    'cod_afectacion_igv' => $value['producto_reto'],
                    'precio_compra' => $value['precio_compra'],
                    'precio_venta' => $value['precio_venta'],
                    'stock' => $value['stock'],
                    'estado' => 1,
                    'id_sucursal' => 1,
                ]);
            }
            DB::commit();
            return response()->json(['message'=>'success']);
        }
        catch(\Exception $e){
            DB::rollBack();
            return response()->json($e->getMessage(),500);
        }
    }

    public function stock(Request $request){
        $datos = Productos::with('marca')
            ->where([
                ["estado", 1],
            ]);

        return $datos->get();
    }

    public function updatePrecios(Request $request){
        try{
            foreach ($request->data as $key) {
                $lente = Productos::findOrFail($key['id_producto']);
                $lente->update([
                    'precio_venta' => $key['precio_venta_update']
                ]);
            }
            return response()->json(['message' => 'update'], 200);

        }catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
    //--- End ---
}
