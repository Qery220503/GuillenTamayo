<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cupon extends Model
{
    use HasFactory;
    use DatabaseRowsTrait;

    protected $table = 'cupones';
    protected $primaryKey = 'id';
    protected $fillable = [
        'id_usuario',
        'id_sucursal',
        'codigo_cupon',
        'tipo_descuento',
        'descuento',
        'fecha_vencimiento',
        'status',
        'active',
        'id_comprobante_origen',
        'id_comprobante_uso',
    ];

    public $timestamps = true;

    // protected $with = array('sucursal');
    public function usuario(){
        return $this->belongsTo(User::class, 'id_usuario');
    }
    public function sucursal(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }

    //--- Mutators ---
    public function setCodigoCuponAttribute($value){
        $this->attributes['codigo_cupon'] = $this->SetUpperCase($value);
    }
    //--- End ---


    //--- Static Methods ---
    public function customRemove(){
        try{
            if($this->active != 1){
                $this->active = 1;
                $this->status = 1;

            } else {
                $this->active = 0;
                $this->status = 0;

            }
            $this->save();

        }catch(\Exception $e){
            throw new \Exception($e->getMessage(), 500);
        }
    }
    //--- End ---
}
