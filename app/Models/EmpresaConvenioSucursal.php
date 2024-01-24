<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EmpresaConvenioSucursal extends Model
{
    use HasFactory;
    protected $table = 'empresas_convenio_sucursales';
    protected $primaryKey = 'id_empresa_sucursal';
    protected $fillable = [
        'id_empresa_convenio',
        'id_sucursal'
    ];
    public $timestamps = true;
}
