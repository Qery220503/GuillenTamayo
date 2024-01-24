<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ocupacion extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'ocupaciones';
    protected $primaryKey = 'id_ocupacion';
    protected $fillable = [
        'nombre_ocupacion',
        'estado'
    ];
    protected $appends = ['PacientesCount'];
    public $timestamps = false;

    public function pacientes(){
      return $this->hasMany(Clientes::class, 'id_ocupacion');
    }

    public function getPacientesCountAttribute(){
      return $this->pacientes()->count();
    }

    
    //--- Mutators ---
    public function setNombreOcupacionAttribute($value){
        $this->attributes['nombre_ocupacion'] = $this->SetUpperCase($value);
    }
    //--- End ---
}