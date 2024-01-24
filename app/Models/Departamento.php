<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Departamento extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'ubigeo_departamentos';
    protected $primaryKey = 'id_departamento';
    protected $fillable = [
        'nombre_departamento'
    ];
    public $timestamps = false;
    
    
    //--- Mutators ---
    public function setNombreDepartamentoAttribute($value){
        $this->attributes['nombre_departamento'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}