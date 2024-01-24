<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Distrito extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'ubigeo_distritos';
    protected $primaryKey = 'id_distrito';
    protected $fillable = [
        'nombre_distrito',
        'id_provincia',
        'id_departamento'
    ];
    public $timestamps = false;

    public function departamento(){
        return $this->belongsTo(Departamento::class, 'id_departamento');
    }
    public function provincia(){
        return $this->belongsTo(Departamento::class, 'id_provincia');
    }

    
    //--- Mutators ---
    public function setNombreDistritoAttribute($value){
        $this->attributes['nombre_distrito'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
