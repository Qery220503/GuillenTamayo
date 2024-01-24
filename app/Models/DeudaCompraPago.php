<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeudaCompraPago extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'deuda_compra_pagos';
    protected $primaryKey = 'id_pago_deuda';
    protected $fillable = [
        'id_compra',
        'id_origen_dinero',
        'user_id',
        'monto_abonado',
        'saldo',
        'fecha',
        'descripcion',
        'banco',
        'nro_operacion',
    ];
    public $timestamps = true;

    //protected $appends = ['origen_dinero'];

    protected $with = array('origen_dinero', 'usuario');
    public function compra(){
        return $this->belongsTo(Compras::class, 'id_compra');
    }
    public function origen_dinero(){
        return $this->belongsTo(OrigenDinero::class, 'id_origen_dinero');
    }
    public function usuario(){
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    
    //--- Mutators ---
    public function setDescripcionAttribute($value){
        $this->attributes['descripcion'] = $this->SetUpperCase($value);
    }
    public function setBancoAttribute($value){
        $this->attributes['banco'] = $this->SetUpperCase($value);
    }
    public function setNroOperacionAttribute($value){
        $this->attributes['nro_operacion'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}