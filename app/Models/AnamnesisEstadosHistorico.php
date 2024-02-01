<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AnamnesisEstadosHistorico extends Model
{
    use HasFactory;
    protected $table = 'anamnesis_estados_historico';
    protected $primaryKey = 'id';
    protected $fillable = [
        'anamnesis_id',
        'user_id',
        'fecha',
        'estado'
    ];
    public $timestamps = true;

    protected $casts = [
    ];
    protected $with = [];

    protected $appends = [];
    
    public function anamnesis():BelongsTo{
        return $this->belongsTo(Anamnesis::class, 'anamnesis_id', 'id_anmnesis');
    }
}
