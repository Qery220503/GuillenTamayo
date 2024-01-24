<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComprobanteDetalle extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'comprobantes_detalles';
    protected $primaryKey = 'id_comprobante_detalle';
    protected $fillable = [
        'id_comprobante',
        'id_precio_lente',
        'id_servicio',
        'id_producto',
        'id_unidad_medida',
        'item_type',
        'detalle_item',
        'cantidad',
        'precio_unitario',
        'precio_total',
    ];
    public $timestamps = true;

    public function unidad(){
        return $this->hasOne(UnidadMedida::class, 'id_unidad_medida', 'id_unidad_medida');
    }

    
    //--- Mutators ---
    public function setDetalleItemAttribute($value){
        $this->attributes['detalle_item'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
