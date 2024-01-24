<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CajaTurno extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'caja_turnos';
    protected $primaryKey = 'id_caja_turno';
    protected $fillable = [
        'nombre_turno'
    ];
    public $timestamps = false;

    //--- Mutators ---
    public function setNombreTurnoAttribute($value){
        $this->attributes['nombre_turno'] = $this->SetUpperCase($value);
    }
    //--- End ---
}