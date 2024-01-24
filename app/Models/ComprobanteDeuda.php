<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComprobanteDeuda extends Model
{
    use HasFactory;
    protected $table = 'comprobantes_deudas';
    protected $primaryKey = 'id';
    protected $fillable = [
        'monto',
        'fecha',
        'id_comprobante',
        'status'
    ];
}
