<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoNota extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'tipos_nota';
    protected $primaryKey = 'id_tipo_nota';
    protected $fillable = [
        'codigo_sunat',
        'descripcion',
        'id_tipo_comprobantes' // 1 => Nota Crédito, 2 => Nota Debíto
    ];

    
    //--- Mutators ---
    public function setDescripcionAttribute($value){
        $this->attributes['descripcion'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
