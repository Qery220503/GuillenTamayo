<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Cotizacion extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'cotizaciones';
    protected $primaryKey = 'id_cotizacion';
    protected $fillable = [
        'id_serie',
        'id_anamnesis',
        'id_sucursal',
        'id_cliente',
        'correlativo',
        'receta',
        'estado'
    ];

    protected $casts = [
        'receta' => 'array',
    ];


    public function getCreatedAtAttribute($value){
        return Carbon::parse($value)->format('Y-m-d H:i:s');
    }
    public function serie(){
        return $this->hasOne(ComprobanteSerie::class, 'id_serie', 'id_serie');
    }
    public function anamnesis(){
        return $this->hasOne(Anamnesis::class, 'id_anamnesis', 'id_anamnesis');
    }
    public function sucursal(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }
    public function detalle(){
        return $this->hasMany(CotizacionDetalle::class,'id_cotizacion', 'id_cotizacion');
    }
    public function cliente(){
        return $this->belongsTo(Clientes::class, 'id_cliente', 'id_cliente');
    }

    //--- Mutators ---
    //--- Fin ---
}
