<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoDocumento extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'tipos_documentos';
    protected $primaryKey = 'id_tipo_documento';
    protected $fillable = [
        'nombre_tipo_documento',
        'codigo_sunat'
    ];

    
    //--- Mutators ---
    public function setNombreTipoDocumentoAttribute($value){
        $this->attributes['nombre_tipo_documento'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
