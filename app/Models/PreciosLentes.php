<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PreciosLentes extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'precios_lentes';
    protected $primaryKey = 'id_precio_lente';
    protected $fillable = [
        'fabricacion',
        'material',
        'serie',
        'tratamiento',
        'nombre',
        'modelo',
        'fotocromatico',
        'color_fotocromatico',
        'laboratorio',
        'nombre',
        'nombre_propio',
        'nombre_laboratorio',
        'precio_compra',
        'precio_venta',
        'tiempo_espera',
        'id_sucursal',
        'es_trio',
        'estado',
    ];
    public $timestamps = true;


    //--- Mutators ---
    public function setModeloAttribute($value){
        $this->attributes['modelo'] = $this->SetUpperCase($value);
    }
    public function setFabricacionAttribute($value){
        $this->attributes['fabricacion'] = $this->SetUpperCase($value);
    }
    public function setMaterialAttribute($value){
        $this->attributes['material'] = $this->SetUpperCase($value);
    }
    public function setSerieAttribute($value){
        $this->attributes['serie'] = $this->SetUpperCase($value);
    }
    public function setTratamientoAttribute($value){
        $this->attributes['tratamiento'] = $this->SetUpperCase($value);
    }
    public function setNombreAttribute($value){
        $this->attributes['nombre'] = $this->SetUpperCase($value);
    }
    public function setFotocromaticoAttribute($value){
        $this->attributes['fotocromatico'] = $this->SetUpperCase($value);
    }
    public function setColorFotocromaticoAttribute($value){
        $this->attributes['color_fotocromatico'] = $this->SetUpperCase($value);
    }
    public function setLaboratorioAttribute($value){
        $this->attributes['laboratorio'] = $this->SetUpperCase($value);
    }
    public function setNombrePropioAttribute($value){
        $this->attributes['nombre_propio'] = $this->SetUpperCase($value);
    }
    public function setNombreLaboratorioAttribute($value){
        $this->attributes['nombre_laboratorio'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
