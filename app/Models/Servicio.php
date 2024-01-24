<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Servicio extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'servicios';
    protected $primaryKey = 'id_servicio';
    protected $fillable = [
        'nombre_servicio',
        'precio_compra',
        'precio_venta',
        'cod_afectacion_igv',
        'id_sucursal',
        'estado'
    ];

    protected $hidden = [
        'created_at',
        'updated_at'
    ];

    public function afectacion(){
        return $this->hasOne(AfectacionIgv::class, 'cod_afectacion', 'cod_afectacion_igv');
    }


    //--- Mutators ---
    public function setNombreServicioAttribute($value){
        $this->attributes['nombre_servicio'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
