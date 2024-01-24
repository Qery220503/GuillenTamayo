<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoComprobante extends Model
{
    use HasFactory;
    protected $table = 'tipos_comprobantes';
    protected $primaryKey = 'id_tipo_comprobantes';
    protected $fillable = [
        'nombre_tipo_documento',
        'codigo_sunat'
    ];
}
