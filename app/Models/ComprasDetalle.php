<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComprasDetalle extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'compras_detalle';
    protected $primaryKey = 'id_compra_detalle';
    protected $fillable = [
        'id_compra',
        'codigo_producto',
        'nombre_producto',
        'unidad_medida',
        'cantidad',
        'precio_compra',
        'precio_total',
        'precio_sin_igv',
    ];
    public $timestamps = true;

    public function compra(){
        return $this->belongsTo(Compras::class, 'id_compra', 'id_compra');
    }
    
    //--- Mutators ---
    public function setCodigoProductoAttribute($value){
        $this->attributes['codigo_producto'] = $this->SetUpperCase($value);
    }
    public function setNombreProductoAttribute($value){
        $this->attributes['nombre_producto'] = $this->SetUpperCase($value);
    }
    public function setUnidadMedidaAttribute($value){
        $this->attributes['unidad_medida'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}