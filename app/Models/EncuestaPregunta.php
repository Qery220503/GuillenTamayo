<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EncuestaPregunta extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'encuesta_preguntas'; 
    protected $primaryKey = 'id_encuesta_pregunta';
    protected $fillable = [    
        'pregunta',
        'id_etapa_encuesta',
        'alternativas',
        'estado',	
    ];

    public $timestamps = false;

    public function etapa(){
        return $this->belongsTo(EncuestaEtapa::class, 'id_etapa_encuesta');
    }

    protected $with = ['etapa'];

    
    //--- Mutators ---
    public function setPreguntaAttribute($value){
        $this->attributes['pregunta'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
