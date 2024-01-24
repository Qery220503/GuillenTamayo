<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Provincia extends Model
{
    use HasFactory;
    protected $table = 'ubigeo_provincias';
    protected $primaryKey = 'id_provincia';
    protected $fillable = [
        'nombre_provincia',
        'id_departamento'
    ];
    public $timestamps = false;

    public function departamento(){
        return $this->belongsTo(Departamento::class, 'id_departamento');
    }
}