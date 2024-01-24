<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GuiaRemisionDetalle extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'guia_remision_detalle';
    protected $primaryKey = 'id_guia_remision_detalle';
    protected $fillable = [
        'id_guia_remision',	
        'codigo_producto',	
        'nombre_producto',	
        'unidad_medida',	
        'cantidad',	
        'precio_compra',	
        'precio_total',	
        'precio_sin_igv',
    ];

    public function guia_remision() {
        return $this->belongsTo(GuiaRemision::class, 'id_guia_remision');
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