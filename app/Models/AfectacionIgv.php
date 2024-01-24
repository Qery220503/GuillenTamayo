<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AfectacionIgv extends Model
{
    use HasFactory;
    protected $table = 'afectacion_igv';
    protected $primaryKey = 'cod_afectacion';
    protected $fillable = [
        'descripcion'
    ];
    public $timestamps = false;

    //--- Mutators ---
    public function setDescripcionAttribute($value){
        $this->attributes['descripcion'] = $this->SetUpperCase($value);
    }
    //--- End ---
}
