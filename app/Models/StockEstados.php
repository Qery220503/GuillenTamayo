<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockEstados extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'almacen_movimientos_tipos';
    protected $primaryKey = 'id_tipo_movimiento';
    protected $fillable = [
        'tipo_movimiento'
    ];

    
    //--- Mutators ---
    public function setTipoMovimientoAttribute($value){
        $this->attributes['tipo_movimiento'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
