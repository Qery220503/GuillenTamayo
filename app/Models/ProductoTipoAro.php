<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductoTipoAro extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'productos_tipo_aro';
    protected $primaryKey = 'id_tipo_aro';
    protected $fillable = [
        'tipo_aro',
        'estado'
    ];
    public $timestamps = false;
    
    
    //--- Mutators ---
    public function setTipoAroAttribute($value){
        $this->attributes['tipo_aro'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
