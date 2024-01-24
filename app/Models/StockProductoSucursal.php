<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockProductoSucursal extends Model
{
    use HasFactory;

    protected $table= 'stock_productos_sucursales';
    protected $primaryKey= 'id';
    protected $fillable = [
        'id_producto',
        'id_sucursal',
        'ubicacion', //1=Almacen, 2=Tienda
        'stock',
    ];
    public $timestamps = false;
}