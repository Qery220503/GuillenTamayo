<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CajaCuadre extends Model
{
    use HasFactory;
    protected $table = 'caja_cuadre';
    protected $primaryKey = 'id_cuadre';
    public $timestamps = true;
    protected $fillable = [
        "id_caja",
        "id_estado",
        "centimos10",
        "centimos20",
        "centimos50",
        "soles1",
        "soles2",
        "soles5",
        "soles10",
        "soles20",
        "soles50",
        "soles100",
        "soles200",
        "total",
        "sobrante_faltante",
        "observacion",
        "estado",
        "motivo_eliminacion",
    ];
    protected $with = ["estado_cuadre", "caja"];
    public function caja()
    {
        return $this->belongsTo(Caja::class, 'id_caja');
    }
    public function estado_cuadre()
    {
        return $this->belongsTo(CajaCuadreEstado::class, 'id_estado');
    }
}
