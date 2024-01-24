<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NotaDetalle extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'nota_detalle';
    protected $primaryKey = 'id_nota_detalle';
    protected $fillable = [
        'id_nota',
        'id_precio_lente',
        'id_servicio',
        'id_producto',
        'item_type',
        'id_unidad_medida',
        'descripcion',
        'cantidad',
        'precio_unitario',
        'total'
    ];

    public function unidad_medida(){
        return $this->belongsTo(UnidadMedida::class, 'id_unidad_medida');
    }

    
    //--- Mutators ---
    public function setDescripcionAttribute($value){
        $this->attributes['descripcion'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
