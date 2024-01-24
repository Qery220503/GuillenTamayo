<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductosCategoria extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'productos_categorias';
    protected $primaryKey = 'id_producto_categoria';
    protected $fillable = [
        'nombre_categoria',
        'estado'
    ];
    public $timestamps = false;

    
    //--- Mutators ---
    public function setNombreCategoriaAttribute($value){
        $this->attributes['nombre_categoria'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
