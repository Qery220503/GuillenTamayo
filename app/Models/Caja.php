<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Caja extends Model
{
    use HasFactory;
    protected $table = 'caja';
    protected $primaryKey = 'id_caja';
    protected $fillable = [
        'monto_inicial',
        'id_sucursal',
        'id_usuario',
        'estado',
    ];
    public $timestamps = true;

}