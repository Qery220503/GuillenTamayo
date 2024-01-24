<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComprobantePago extends Model
{
    use HasFactory;
    protected $table = 'comprobantes_pagos';
    protected $primaryKey = 'id';
    protected $fillable = [
        'monto',
        'saldo',
        'fecha',
        'id_comprobante',
        'id_caja',
        'id_metodo_pago',
        'observacion',
        'status',
        'id_user'
    ];

    public function medio_pago(){
        return $this->belongsTo(MedioPago::class, 'id_metodo_pago');
    }
    public function usuario(){
        return $this->belongsTo(User::class, 'id_user');
    }
}
