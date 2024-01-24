<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrdenLaboratorioEstados extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'orden_laboratorio_estados';
    protected $primaryKey = 'id_estado_orden_laboratorio';
    protected $fillable = [
        'nombre_estado',
        'color'
    ];
    public $timestamps = false;

    
    //--- Mutators ---
    public function setNombreEstadoAttribute($value){
        $this->attributes['nombre_estado'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
