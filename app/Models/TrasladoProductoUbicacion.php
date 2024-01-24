<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrasladoProductoUbicacion extends Model
{
    use HasFactory;

    protected $table = 'traslado_productos_ubicacion';
    protected $primaryKey = 'id';
    protected $fillable = [
        'ubicacion_origen',
        'ubicacion_destino',
        'id_producto',
        'cantidad',
        'fecha_traslado',
        'active'
    ];
    public $timestamps = true;

    
    // protected $with = array('producto');
    public function producto(){
        return $this->belongsTo(Productos::class, 'id_producto');
    }
}