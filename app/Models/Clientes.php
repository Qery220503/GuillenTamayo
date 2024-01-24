<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Clientes extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'clientes';
    protected $primaryKey = 'id_cliente';
    protected $fillable = [
        'cod_tipo_doc',
        'nro_documento',
        'nombre_razon_social',
        'fecha_nacimiento',
        'telefono',
        'telefono_adic',
        'email',
        'id_ocupacion',
        'id_departamento',
        'id_provincia',
        'id_distrito',
        'direccion',
        'lista_negra',
        'estado'
    ];
    public $timestamps = true;


    protected $with = array('departamento', 'provincia', 'distrito');
    public function tipo_documento()
    {
        return $this->belongsTo(TipoDocumento::class, 'cod_tipo_doc');
    }
    public function ocupacion()
    {
        return $this->belongsTo(Ocupacion::class, 'id_ocupacion');
    }
    public function departamento()
    {
        return $this->belongsTo(Departamento::class, 'id_departamento');
    }
    public function provincia()
    {
        return $this->belongsTo(Provincia::class, 'id_provincia');
    }
    public function distrito()
    {
        return $this->belongsTo(Distrito::class, 'id_distrito');
    }
    public function comprobantes()
    {
        return $this->hasMany(Comprobante::class, 'id_cliente');
    }

    //--- Mutators ---
    public function setNombreRazonSocialAttribute($value)
    {
        $this->attributes['nombre_razon_social'] = $this->SetUpperCase($value);
    }
    public function setEmailAttribute($value)
    {
        $this->attributes['email'] = $this->SetUpperCase($value);
    }
    public function setDireccionAttribute($value)
    {
        $this->attributes['direccion'] = $this->SetUpperCase($value);
    }

    
    protected $appends = ['has_deudas'];
    public function getHasDeudasAttribute()
    {
        $data = $this->comprobantes()
        ->where([
            ['condicion_pago', '!=', 1],
            /*['deuda_saldo', '>', 0],*/
            ['id_estado_comprobante', 1]
        ])
        ->count();

        return $data > 0;
    }
    //--- End ---
}
