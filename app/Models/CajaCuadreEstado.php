<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CajaCuadreEstado extends Model
{
    use HasFactory;
    protected $table = 'caja_cuadre_estado';
    protected $primaryKey = 'id_estado';
    protected $fillable = [
        "nombre_estado",
        "color"
    ];
}
