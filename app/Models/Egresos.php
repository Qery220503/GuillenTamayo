<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Egresos extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'egresos';
    protected $primaryKey = 'id_egreso';
    protected $fillable = [
        'descripcion',
        'monto',
        'id_caja',
        'origen',
        'fecha_egreso',
        'id_compra',
        'estado',
        'id_medio_pago',
        'id_proveedor',
        'observaciones',
        'id_user'
    ];
    public $timestamps = true;


    //--- Mutators ---
    public function setDescripcionAttribute($value){
        $this->attributes['descripcion'] = $this->SetUpperCase($value);
    }
    //--- Fin ---

    public function mediopago(){
        return $this->belongsTo(MedioPago::class, 'id_medio_pago');
    }

    public function proveedor(){
        return $this->belongsTo(Proveedores::class, 'id_proveedor');
    }

    public function usuario(){
        return $this->belongsTo(User::class, 'id_user');
    }
}
