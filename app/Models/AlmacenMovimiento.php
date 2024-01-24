<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class AlmacenMovimiento extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'almacen_movimientos';
    protected $primaryKey = 'id_almacen_movimientos';
    protected $fillable = [
        'id_tipo_movimiento',
        'id_sucursal',
        'id_producto',
        'stock_inicial',
        'stock_actual',
        'cantidad',
        'precio_unitario',
        'precio_total',
        'codigo_producto',
        'nombre_producto',
    ];

    public $timestamps = true;

    protected $appends = ['fecha_parse'];

    public function producto(){
        return $this->belongsTo(Productos::class, 'id_producto');
    }

    public function tipo_movimiento(){
        return $this->belongsTo(StockEstados::class, 'id_tipo_movimiento');
    }

    public static function devolucionStock($request, $id_sucursal){
        $almacen = new AlmacenMovimiento();
        $producto = Productos::findOrFail($request['id_producto']);
        $productoStock = StockProductoSucursal::where([
            ['id_producto', $request['id_producto']],
            ['id_sucursal', $id_sucursal],
            ['ubicacion', 1]
        ])->first();

        $almacen->id_tipo_movimiento = 3;
        $almacen->id_producto = $request['id_producto'];
        $almacen->cantidad =  $request['cantidad'];
        $almacen->stock_inicial =  $producto->stock;
        $almacen->stock_actual =  $producto->stock + $request['cantidad'];
        $almacen->precio_unitario =  $producto->precio_venta;
        $almacen->precio_total =  $request['precio_total'];
        $almacen->codigo_producto =  $producto->codigo_producto;
        $almacen->nombre_producto =  $producto->nombre_producto;
        $almacen->id_sucursal =  $id_sucursal;
        $almacen->save();

        $productoStock->increment('stock', $request['cantidad']);
        $productoStock->save();
        $producto->increment('stock', $request['cantidad']);
        $producto->save();
    }
    public static function ingresoStock($request, $id_sucursal, $ubicacion){
        $almacen = new AlmacenMovimiento();
        $producto = Productos::findOrFail($request['id_producto']);
        $productoStock = StockProductoSucursal::where([
            ['id_producto', $request['id_producto']],
            ['id_sucursal', $id_sucursal],
            ['ubicacion', $ubicacion]
        ])->first();

        $almacen->id_tipo_movimiento = 1;
        $almacen->id_producto = $request['id_producto'];
        $almacen->cantidad =  $request['cantidad'];
        $almacen->stock_inicial =  $producto->stock;
        $almacen->stock_actual =  $producto->stock + $request['cantidad'];
        $almacen->precio_unitario =  $producto->precio_venta;
        $almacen->precio_total =  $request['precio_total'];
        $almacen->codigo_producto =  $producto->codigo_producto;
        $almacen->nombre_producto =  $producto->nombre_producto;
        $almacen->id_sucursal =  $id_sucursal;
        $almacen->save();

        if($productoStock){
            $productoStock->increment('stock', $request['cantidad']);
            $productoStock->save();
        }else{
            StockProductoSucursal::create([
                'id_producto' => $request['id_producto'],
                'id_sucursal' => $id_sucursal,
                'ubicacion' => 1,
                'stock' => $request['cantidad']
            ]);
        }
        $producto->increment('stock', $request['cantidad']);
        $producto->save();
    }
    public static function egresoStock($request, $id_sucursal, $ubicacion){
        $almacen = new AlmacenMovimiento();
        $producto = Productos::findOrFail($request['id_producto']);
        $productoStock = StockProductoSucursal::where([
            ['id_producto', $request['id_producto']],
            ['id_sucursal', $id_sucursal],
            ['ubicacion', $ubicacion]
        ])->first();

        $almacen->id_tipo_movimiento = 2;
        $almacen->id_producto = $request['id_producto'];
        $almacen->cantidad =  $request['cantidad'];
        $almacen->stock_inicial =  $producto->stock;
        $almacen->stock_actual =  $producto->stock - $request['cantidad'];
        $almacen->precio_unitario =  $producto->precio_venta;
        $almacen->precio_total =  $request['precio_total'];
        $almacen->codigo_producto =  $producto->codigo_producto;
        $almacen->nombre_producto =  $producto->nombre_producto;
        $almacen->id_sucursal =  $id_sucursal;
        $almacen->save();

        //Permite tener stock negativo
        //Por si se les olvida hacer el traslado de stock 
        if($productoStock == null){
            $productoStock = StockProductoSucursal::create([
                'id_producto' => $request['id_producto'],
                'id_sucursal' => $id_sucursal,
                'ubicacion' => 2, //1=Almacen, 2=Tienda
                'stock' => 0,
            ]);
        }

        $productoStock->decrement('stock', $request['cantidad']);
        $productoStock->save();
        $producto->decrement('stock', $request['cantidad']);
        $producto->save();
        return $almacen;
    }

    public function getFechaParseAttribute(){
        return Carbon::parse($this->created_at)->format('d/m/y h:i');
    }
    


    //--- Mutators ---
    public function setCodigoProductoAttribute($value){
        $this->attributes['codigo_producto'] = $this->SetUpperCase($value);
    }
    public function setNombreProductoAttribute($value){
        $this->attributes['nombre_producto'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}