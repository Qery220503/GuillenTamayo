<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Anamnesis extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'anamnesis';
    protected $primaryKey = 'id_anamnesis';
    protected $fillable = [
        'id_cliente',
        'antecedentes_familiares',
        'sintomas',
        'medicamentos',
        'frecuencia_visita',
        'id_clinica',
        'id_doctor',
        'id_empresa_convenio',
        'id_sucursal',
        'estado',
    ];
    public $timestamps = true;

    protected $casts = [
        'created_at'  => 'date:Y-m-d'
    ];

    public function cliente(){
        return $this->belongsTo(Clientes::class, 'id_cliente');
    }
    public function clinica(){
        return $this->belongsTo(Clinicas::class, 'id_clinica');
    }
    public function doctor(){
        return $this->belongsTo(Doctores::class, 'id_doctor');
    }
    public function empresa(){
        return $this->hasMany(EmpresaConvenio::class, 'id_empresa_convenio');
    }
    public function sucursal(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }
    public function orden(){
        return $this->hasOne(OrdenLaboratorio::class, 'id_anamnesis', 'id_anamnesis');
    }

    //--- Mutators ---
    public function setAntecedentesFamiliaresAttribute($value){
        $this->attributes['antecedentes_familiares'] = $this->SetUpperCase($value);
    }
    public function setSintomasAttribute($value){
        $this->attributes['sintomas'] = $this->SetUpperCase($value);
    }
    public function setMedicamentosAttribute($value){
        $this->attributes['medicamentos'] = $this->SetUpperCase($value);
    }
    public function setFrecuenciaVisitaAttribute($value){
        $this->attributes['frecuencia_visita'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}