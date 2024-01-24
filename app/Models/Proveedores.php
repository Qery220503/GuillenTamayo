<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Proveedores extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'proveedores';
    protected $primaryKey = 'id_proveedor';
    protected $fillable = [
        'id_tipo_doc',
        'nombre',
        'nro_doc',
        'direccion',
        'email',
        'telefono',
        'encargado',
        'nro_cuenta',
        'cci_bancario',
        'cod_proveedor',
        'estado',
        'updated_at',
        'created_at',
    ];
    public $timestamps = true;

    protected $hidden = [
        'created_at',
        'updated_at'
    ];


    public function getData()
    {
        $data = [];
        $data['id'] = $this->id;
        $data['nombre'] = $this->nombre;
        $data['nro_doc'] = $this->nro_doc;
        $data['id_tipo_doc'] = $this->id_tipo_doc;
        $data['direccion'] = $this->direccion;
        $data['email'] = $this->email;
        return $data;
    }

    protected $with = array('tipo_documento');
    public function tipo_documento()
    {
        return $this->belongsTo(TipoDocumento::class, 'id_tipo_doc');
    }
    public function compras()
    {
        return $this->hasMany(Compras::class, 'id_proveedor');
    }


    //--- Mutators ---
    public function setNombreAttribute($value)
    {
        $this->attributes['nombre'] = $this->SetUpperCase($value);
    }
    public function setDireccionAttribute($value)
    {
        $this->attributes['direccion'] = $this->SetUpperCase($value);
    }
    public function setEmailAttribute($value)
    {
        $this->attributes['email'] = $this->SetUpperCase($value);
    }
    public function setEncargadoAttribute($value)
    {
        $this->attributes['encargado'] = $this->SetUpperCase($value);
    }
    public function setCodProveedorAttribute($value)
    {
        $this->attributes['cod_proveedor'] = $this->SetUpperCase($value);
    }


    protected $appends = ['has_deudas'];
    public function getHasDeudasAttribute()
    {
        $data = $this->compras()
            ->where([
                ['condicion_pago', '!=', 1],
                ['deuda_saldo', '>', 0],
                ['estado', 1]
            ])
            ->count();

        return $data > 0;
    }
    //--- Fin ---
}
