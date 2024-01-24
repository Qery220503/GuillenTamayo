<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComprobanteSerie extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'comprobantes_series';
    protected $primaryKey = 'id_serie';
    protected $fillable = [
        'id_sucursal',
        'id_tipo_comprobante',
        'serie',
        'estado'
    ];
    public $timestamps = false;
    public function documento(){
        return $this->hasOne(TipoComprobante::class,'id_tipo_comprobantes','id_tipo_comprobante');
    }
    public function sucursal(){
        return $this->hasOne(Sucursales::class, 'id_sucursal', 'id_sucursal');
    }
    
    //--- Mutators ---
    public function setSerieAttribute($value){
        $this->attributes['serie'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
