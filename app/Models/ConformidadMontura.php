<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConformidadMontura extends Model
{
    use HasFactory;
    protected $table = 'conformidad_montura';
    protected $primaryKey = 'id';
    protected $fillable = [
        'id_anamnesis',
        'p1',
        'p1_respuesta',
        'p2',
        'p2_respuesta',
        'p3',
        'p3_respuesta',
        'p4',
        'p4_respuesta',
        'observaciones'
    ];

    protected $casts = [
        'receta' => 'array',
        'p1_respuesta' => 'array',
        'p2_respuesta' => 'array',
        'p3_respuesta' => 'array',
        'p4_respuesta' => 'array',
    ];

    public function anamnesis(){
        return $this->hasOne(Anamnesis::class, 'id_anamnesis', 'id_anamnesis');
    }
}
