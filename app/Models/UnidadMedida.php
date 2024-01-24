<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UnidadMedida extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'unidades_medida';
    protected $primaryKey = 'id_unidad_medida';
    protected $fillable = [
        'nombre_unidad_medida',
        'codigo_sunat'
    ];

    
    //--- Mutators ---
    public function setNombreUnidadMedidaAttribute($value){
        $this->attributes['nombre_unidad_medida'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
