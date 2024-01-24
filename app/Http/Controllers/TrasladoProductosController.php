<?php

namespace App\Http\Controllers;

use App\Models\AlmacenMovimiento;
use App\Models\Productos;
use App\Models\StockProductoSucursal;
use App\Models\TrasladoProductoSucursal;
use App\Models\TrasladoProductoUbicacion;
use Exception;
use Illuminate\Http\Request;

class TrasladoProductosController extends Controller
{
    public function indexTrasladoSucursal(Request $request){
        try{
            $searchTerm = $request->searchTerm;
            $fechaInicio = $request->fechaInicio;
            $fechaFin    = $request->fechaFin;

            $data = TrasladoProductoSucursal::with(
                'sucursal_origen', 'sucursal_destino', 'producto'
            );
            if(isset($searchTerm)){
                $data = $data->whereHas('productos', function ($query) use ($searchTerm) {
                    $query->where('nombre_producto', 'like', "%{$searchTerm}%")
                        ->orWhere('codigo_producto', 'like', "%{$searchTerm}%");
                });
            }
            if(isset($fechaInicio)){
                if(isset($fechaFin)){
                    $data = $data->whereBetween('fecha_traslado', [$fechaInicio, $fechaFin]);
                }else{
                    $data = $data->where('fecha_traslado', '>=', $fechaInicio);
                }
            }

            return $data->latest()->paginate($request->perPage);
            
        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
    
    public function storeTrasladoSucursal(Request $request){
        try{
            $idProducto = $request->producto['id_producto'];
            
            // Validacion
            $productoStock = StockProductoSucursal::where([
                ['id_producto', $idProducto],
                ['id_sucursal', $request->id_sucursal_origen],
                ['ubicacion', 1]
            ])->first();
            if($productoStock->stock < $request['cantidad'] || $request['cantidad'] <= 0) {
                return response()->json(['success' => false], 500);
            }

            // Generacion de movimientos en almacen
            $almacenMovimiento = [
                'id_producto' => $idProducto,
                'cantidad' => $request['cantidad'],
                'precio_total' => 0,
            ];
            AlmacenMovimiento::egresoStock($almacenMovimiento, $request->id_sucursal_origen, 1);
            AlmacenMovimiento::ingresoStock($almacenMovimiento, $request->id_sucursal_destino, 1);
            
            //Creacion de traslado sucursal de productos
            $_merge = $request;
            $_merge["id_producto"] = $idProducto;
            TrasladoProductoSucursal::create(collect($_merge)->all());

            return response()->json(['success'=>true, 'message' => 'Registro creado correctamente!']);
            
        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function indexTrasladoUbicacion(Request $request){
        try{
            $searchTerm = $request->searchTerm;
            $fechaInicio = $request->fechaInicio;
            $fechaFin    = $request->fechaFin;

            $data = TrasladoProductoUbicacion::with(
                'producto'
            );
            if(isset($searchTerm)){
                $data = $data->whereHas('productos', function ($query) use ($searchTerm) {
                    $query->where('nombre_producto', 'like', "%{$searchTerm}%")
                        ->orWhere('codigo_producto', 'like', "%{$searchTerm}%");
                });
            }
            if(isset($fechaInicio)){
                if(isset($fechaFin)){
                    $data = $data->whereBetween('fecha_traslado', [$fechaInicio, $fechaFin]);
                }else{
                    $data = $data->where('fecha_traslado', '>=', $fechaInicio);
                }
            }
            
            return $data->latest()->paginate($request->perPage);
            
        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    public function storeTrasladoUbicacion(Request $request){
        try{
            $idProducto = $request->producto['id_producto'];
            $idSucursal = $request->id_sucursal;
            if($request->switch_ubicacion){
                //Almacen -> Tienda
                $ubicacionOrigen = 1;
                $ubicacionDestino = 2;

            }else{
                //Tienda -> Almacen
                $ubicacionOrigen = 2;
                $ubicacionDestino = 1;
            }

            // Validacion
            $stockOrigen = StockProductoSucursal::where([
                ['id_producto', $idProducto],
                ['id_sucursal', $idSucursal],
                ['ubicacion', $ubicacionOrigen]
            ])->first();
            if($stockOrigen->stock < $request['cantidad'] || $request['cantidad'] <= 0) {
                return response()->json(['success' => false], 500);
            }
            
            //Generacion del movimiento
            $stockDestino = StockProductoSucursal::where([
                ['id_producto', $idProducto],
                ['id_sucursal', $idSucursal],
                ['ubicacion', $ubicacionDestino]
            ])->first();

            $stockOrigen->decrement('stock', $request['cantidad']);
            $stockOrigen->save();
            
            if($stockDestino){
                $stockDestino->increment('stock', $request['cantidad']);
                $stockDestino->save();
            }else{
                StockProductoSucursal::create([
                    'id_producto' => $idProducto,
                    'id_sucursal' => $idSucursal,
                    'ubicacion' => $ubicacionDestino,
                    'stock' => $request['cantidad'],
                ]);
            }

            //Creacion de traslado ubicacion de productos
            $_merge = $request;
            $_merge["id_producto"] = $idProducto;
            $_merge["ubicacion_origen"] = $ubicacionOrigen;
            $_merge["ubicacion_destino"] = $ubicacionDestino;
            TrasladoProductoUbicacion::create(collect($_merge)->all());

        }catch(Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
}