<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CotizacionDetalle extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'cotizaciones_detalle';
    protected $primaryKey = 'id_cotizacion_detalle';
    protected $fillable = [
        'id_cotizacion',
        'id_precio_lente',
        'id_producto', 
        'montaje',
        'montura',
    ];
    public $timestamps = false;
    public function precio_lente(){
        return $this->hasOne(PreciosLentes::class, 'id_precio_lente', 'id_precio_lente');
    }
    public function producto(){
        return $this->hasOne(Productos::class, 'id_producto', 'id_producto');
    }

    
    //--- Mutators ---
    public function setMontajeAttribute($value){
        $this->attributes['montaje'] = $this->SetUpperCase($value);
    }
    public function setMonturaAttribute($value){
        $this->attributes['montura'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
