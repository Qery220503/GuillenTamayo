<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductosMaterial extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'productos_material';
    protected $primaryKey = 'id_material';
    protected $fillable = [
        'nombre_material',
        'estado'
    ];
    public $timestamps = false;


    //--- Mutators ---
    public function setNombreMaterialAttribute($value){
        $this->attributes['nombre_material'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
