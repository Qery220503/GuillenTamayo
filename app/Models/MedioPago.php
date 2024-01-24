<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MedioPago extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'medio_pago';
    protected $primaryKey = 'id_medio_pago';
    protected $fillable = [
        'medio_pago'
    ];

    
    //--- Mutators ---
    public function setMedioPagoAttribute($value){
        $this->attributes['medio_pago'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
