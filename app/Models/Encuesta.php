<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Encuesta extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'encuestas_satisfaccion'; 
    protected $primaryKey = 'id_encuesta';
    protected $fillable = [    
        'id_cliente',
        'id_sucursal',	
        'id_user',
        'id_comprobante',
        'id_anamnesis',
        'nivel_satisfaccion',
        'estado',
        'sugerencias',
    ];

    public function respuestas(){
        return $this->hasMany(EncuestaRespuesta::class, 'id_encuesta');
    }

    
    //--- Mutators ---
    public function setSugerenciaAttribute($value){
        $this->attributes['sugerencias'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
