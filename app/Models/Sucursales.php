<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sucursales extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'sucursales';
    protected $primaryKey = 'id_sucursal';
    protected $fillable = [
        'nombre_sucursal',
        'codigo_sucursal',
        'nro_ruc',
        'razon_social',
        'cod_domicilio_fiscal',
        'direccion_fiscal',
        'direccion_comercial',
        'email',
        'departamento',
        'provincia',
        'distrito',
        'direccion_web',
        'nro_cuenta_bancario',
        'cci_bancario',
        'telefono',
        'url_api',
        'token_api',
        'theme',
        'url_logo',
        'status',
        'mantenimiento_lentes',
        'mantenimiento_productos',
    ];

    protected $hidden = [
        'created_at',
        'updated_at'
    ];


    public function stock_productos(){
        return $this->hasMany(StockProductoSucursal::class, 'id_sucursal');
    }
    public function scopeActive($q){
        return $q->where('estado', 1);
    }
    
    
    //--- Mutators ---
    public function setNombreSucursalAttribute($value){
        $this->attributes['nombre_sucursal'] = $this->SetUpperCase($value);
    }
    public function setCodigoSucursalAttribute($value){
        $this->attributes['codigo_sucursal'] = $this->SetUpperCase($value);
    }
    public function setRazonSocialAttribute($value){
        $this->attributes['razon_social'] = $this->SetUpperCase($value);
    }
    public function setDireccionFiscalAttribute($value){
        $this->attributes['direccion_fiscal'] = $this->SetUpperCase($value);
    }
    public function setDireccionComercialAttribute($value){
        $this->attributes['direccion_comercial'] = $this->SetUpperCase($value);
    }
    public function setEmailAttribute($value){
        $this->attributes['email'] = $this->SetUpperCase($value);
    }
    
    public function setDepartamentoAttribute($value){
        $this->attributes['departamento'] = $this->SetUpperCase($value);
    }
    public function setProvinciaAttribute($value){
        $this->attributes['provincia'] = $this->SetUpperCase($value);
    }
    public function setDistritoAttribute($value){
        $this->attributes['distrito'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}