<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Compras extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'compras';
    protected $primaryKey = 'id_compra';
    protected $fillable = [
        'id_proveedor',
        'nombre_proveedor',
        'nro_documento',
        'direccion_proveedor',
        'guia_factura',
        'fecha',
        'id_sucursal',
        'id_origen_dinero',
        'id_medio_pago',
        'total',
        'subtotal',
        'igv',
        'condicion_pago', //1=al contado, 2=al credito, 3=al credito con cuotas
        'deuda_tipo', // ('TOTAL','SALDO', 'CUOTAS')
        'deuda_total_abonado',
        'deuda_saldo',
        'fecha_vencimiento',
        'user_id',
        'user_id_update',
        'estado', // 1 -> aprobado, 0 -> anulado
        'id_serie',
        'correlativo',
        'referencia',
        'observaciones',

        /*'tipo_comprobante',
        'serie',
        'numero',
        'fecha_emision',
        'fecha_vencimiento',*/

    ];
    public $timestamps = true;
    protected $appends = [ 'fecha_parse' ];


    protected $with = array('serie', 'proveedor');
    public function serie(){
        return $this->belongsTo(ComprobanteSerie::class, 'id_serie');
    }
    public function proveedor(){
        return $this->belongsTo(Proveedores::class, 'id_proveedor');
    }
    public function sucursal(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }
    public function origen_dinero(){
        return $this->belongsTo(OrigenDinero::class, 'id_origen_dinero');
    }
    public function medio_pago(){
        return $this->belongsTo(MedioPago::class, 'id_medio_pago');
    }
    public function detalle(){
        return $this->hasMany(ComprasDetalle::class, 'id_compra');
    }
    public function usuario(){
        return $this->belongsTo(User::class, 'user_id');
    }
    public function pagos_deuda(){
        return $this->hasMany(DeudaCompraPago::class, 'id_compra');
    }
    public function cuotas(){
        return $this->hasMany(DeudaCompraCuota::class, 'id_compra');
    }


    //--- Mutators ---
    public function setNombreProveedorAttribute($value){
        $this->attributes['nombre_proveedor'] = $this->SetUpperCase($value);
    }
    public function setDireccionProveedorAttribute($value){
        $this->attributes['direccion_proveedor'] = $this->SetUpperCase($value);
    }
    //--- Fin ---

    public function getCorrelativoAttribute($value){
        return str_pad($value, 6, "0", STR_PAD_LEFT);
    }
    public function getFechaParseAttribute(){
        return Carbon::parse($this->fecha)->format('d/m/y');
    }
}
