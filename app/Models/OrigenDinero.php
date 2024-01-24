<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrigenDinero extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'origen_dinero';
    protected $primaryKey = 'id_origen_dinero';
    protected $fillable = [
        'nombre_origen',
        'descripcion_origen',
        'id_sucursal'
    ];
    public $timestamps = true;

    
    //--- Mutators ---
    public function setNombreOrigenAttribute($value){
        $this->attributes['nombre_origen'] = $this->SetUpperCase($value);
    }
    public function setDescripcionOrigenAttribute($value){
        $this->attributes['descripcion_origen'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
