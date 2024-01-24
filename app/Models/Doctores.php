<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Doctores extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'doctores';
    protected $primaryKey = 'id_doctor';
    protected $fillable = [
        'nombres',
        'apellidos',
        'nro_documento',
        'fecha_nacimiento',
        'email',
        'enviar_correos',
        'convenio',
        'nro_telefono',
        'estado',
        'porcentaje_comision'
    ];
    public $timestamps = true;

    
    //--- Mutators ---
    public function setNombresAttribute($value){
        $this->attributes['nombres'] = $this->SetUpperCase($value);
    }
    public function setApellidosAttribute($value){
        $this->attributes['apellidos'] = $this->SetUpperCase($value);
    }
    public function setEmailAttribute($value){
        $this->attributes['email'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}