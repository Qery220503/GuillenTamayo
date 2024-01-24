<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrasladoProductoSucursal extends Model
{
    use HasFactory;

    protected $table = 'traslado_productos_sucursales';
    protected $primaryKey = 'id';
    protected $fillable = [
        'id_sucursal_origen',
        'id_sucursal_destino',
        'id_producto',
        'cantidad',
        'fecha_traslado',
        'active'
    ];
    public $timestamps = true;

    
    // protected $with = array('producto');
    public function sucursal_origen(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal_origen');
    }
    public function sucursal_destino(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal_destino');
    }
    public function producto(){
        return $this->belongsTo(Productos::class, 'id_producto');
    }
}