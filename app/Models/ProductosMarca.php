<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductosMarca extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'productos_marcas';
    protected $primaryKey = 'id_marca_producto';
    protected $fillable = [
        'marca_producto',
        'estado',
        'sincronizar'
    ];

    protected $hidden = [
        'created_at',
        'updated_at'
    ];

    
    //--- Mutators ---
    public function setMarcaProductoAttribute($value){
        $this->attributes['marca_producto'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
