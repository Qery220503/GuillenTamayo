<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EncuestaEtapa extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'encuesta_etapas'; 
    protected $primaryKey = 'id_etapa_encuesta';
    protected $fillable = [    
        'parte',
        'etapa',	
    ];

    public $timestamps = false;

    
    //--- Mutators ---
    public function setEtapaAttribute($value){
        $this->attributes['etapa'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
