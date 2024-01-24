<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Productos extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'productos';
    protected $primaryKey = 'id_producto';
    protected $fillable = [
        'codigo_producto',
        'nombre_producto',
        'id_sucursal', //sucursal donde se creo el producto
        'id_marca',
        'id_categoria',
        'codigo_varilla',
        'codigo_sunat',
        'rango',
        'id_material',
        'id_tipo_aro',
        'id_forma_montura',
        'tipo_rostro',
        'genero',
        'adicionales',
        'descripcion',
        'producto_reto',
        'sobrelentes',
        'liquido',
        'diagonal',
        'puente',
        'varilla',
        'cod_afectacion_igv',
        'precio_compra',
        'precio_venta',
        'stock',
        'estado',
        'pendiente_upd',
    ];

    protected $hidden = [
        'created_at',
        'updated_at'
    ];
    protected $casts = [
        'tipo_rostro' => 'array',
    ];

    public function marca(){
        return $this->belongsTo(ProductosMarca::class, 'id_marca');
    }
    public function categoria(){
        return $this->belongsTo(ProductosCategoria::class, 'id_categoria');
    }
    public function material(){
        return $this->belongsTo(ProductosMaterial::class, 'id_material');
    }
    public function tipo_aro(){
        return $this->belongsTo(ProductoTipoAro::class, 'id_tipo_aro');
    }
    public function forma_montura(){
        return $this->belongsTo(ProductoFormaMontura::class, 'id_forma_montura');
    }
    public function sucursal(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }
    public function stock_sucursal(){
        return $this->hasMany(StockProductoSucursal::class, 'id_producto');
    }

    //--- Accessors ---
    protected $appends = ['st_sucursal', 'st_almacen', 'st_tienda'];

    public function getStSucursalAttribute(){
        $auth = auth('sanctum')->user();

        $data = StockProductoSucursal::where([
            ['id_producto', $this->id_producto],
            ['id_sucursal', $auth->id_sucursal]
        ])->get();

        if($data){
            return $data->sum('stock');
        }

        return 0;
    }
    public function getStAlmacenAttribute(){
        $auth = auth('sanctum')->user();

        $data = StockProductoSucursal::where([
            ['id_producto', $this->id_producto],
            ['id_sucursal', $auth->id_sucursal],
            ['ubicacion', 1]
        ])->first();

        if($data){
            return $data->stock;
        }

        return 0;
    }
    public function getStTiendaAttribute(){
        $auth = auth('sanctum')->user();

        $data = StockProductoSucursal::where([
            ['id_producto', $this->id_producto],
            ['id_sucursal', $auth->id_sucursal],
            ['ubicacion', 2]
        ])->first();

        if($data){
            return $data->stock;
        }

        return 0;
    }
    //--- End ---

    //--- Mutators ---
    public function setNombreProductoAttribute($value){
        $this->attributes['nombre_producto'] = $this->SetUpperCase($value);
    }
    public function setCodigoVarillaAttribute($value){
        $this->attributes['codigo_varilla'] = $this->SetUpperCase($value);
    }
    public function setAdicionalesAttribute($value){
        $this->attributes['adicionales'] = $this->SetUpperCase($value);
    }
    public function setDescripcionAttribute($value){
        $this->attributes['descripcion'] = $this->SetUpperCase($value);
    }
    public function setDiagonalAttribute($value){
        $this->attributes['diagonal'] = $this->SetUpperCase($value);
    }
    public function setPuenteAttribute($value){
        $this->attributes['puente'] = $this->SetUpperCase($value);
    }
    public function setVarillaAttribute($value){
        $this->attributes['varilla'] = $this->SetUpperCase($value);
    }
    //--- End ---
}
