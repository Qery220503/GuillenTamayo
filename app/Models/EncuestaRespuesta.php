<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EncuestaRespuesta extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'encuesta_respuestas'; 
    protected $primaryKey = 'id_encuesta_respuesta';
    protected $fillable = [    
        'id_encuesta',
        'id_encuesta_pregunta',
        'respuesta',
        'estado'	
    ];
    public function pregunta(){
        return $this->hasOne(EncuestaPregunta::class, 'id_encuesta_pregunta','id_encuesta_pregunta');
    }

}
