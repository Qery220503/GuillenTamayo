<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Clinicas extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'clinicas';
    protected $primaryKey = 'id_clinica';
    protected $fillable = [
        'id_sucursal',
        'nombre_clinica',
        'telefono_clinica',
        'email_clinica',
        'enviar_correos',
        'afiliacion',
        'descuento',
        'estado'
    ];
    public $timestamps = true;

    //--- Mutators ---
    public function setNombreClinicaAttribute($value){
        $this->attributes['nombre_clinica'] = $this->SetUpperCase($value);
    }
    public function setTelefonoClinicaAttribute($value){
        $this->attributes['telefono_clinica'] = $this->SetUpperCase($value);
    }
    public function setEmailClinicaAttribute($value){
        $this->attributes['email_clinica'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}