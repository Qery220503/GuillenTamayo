<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EmpresaConvenio extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'empresas_convenio';
    protected $primaryKey = 'id_empresa_convenio';
    protected $fillable = [
        'nombre_empresa',
        'direccion_empresa',
        'ruc_empresa',
        'telefono_empresa',
        'email_empresa',
        'enviar_correos',
        'cobertura',
        'descuento_cobertura',
        'estado'
    ];
    public $timestamps = true;

    public function sucursales(){
        return $this->belongToMany(Sucursales::class)->withPivot('created_at');
    }
    public static function allowedToSave($ruc_empresa){
        $empresa =  EmpresaConvenio::where('ruc_empresa', $ruc_empresa)->first();
        if (isset($empresa) && $empresa->estado == 1) {
            throw new \Exception("Empresa existente", 422);
        }
    }

    
    //--- Mutators ---
    public function setNombreEmpresaAttribute($value){
        $this->attributes['nombre_empresa'] = $this->SetUpperCase($value);
    }
    public function setDireccionEmpresaAttribute($value){
        $this->attributes['direccion_empresa'] = $this->SetUpperCase($value);
    }
    public function setEmailEmpresaAttribute($value){
        $this->attributes['email_empresa'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
