<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comprobante extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'comprobantes';
    protected $primaryKey = 'id_comprobante';
    protected $fillable = [
        'id_cliente',
        'id_tipo_comprobante',
        'id_tipo_documento',
        'id_usuario',
        'id_sucursal',
        'id_estado_comprobante',
        'id_medio_pago',
        'id_serie',
        'correlativo',
        'nombre_cliente',
        'nro_documento',
        'direccion_cliente',
        'fecha_emision',
        'factura_gratuita',
        'nro_operacion',
        'porcentaje_igv',
        'igv',
        'subtotal',
        'total',
        'condicion_pago',
        'adelanto',
        'saldo',
        'dscto_porcentaje',
        'dscto_fijo',
        'comentario',
        'external_id',
        'formato_impresion',
        'fecha_anulacion',
        'motivo_anulacion',
        'id_caja',
        'id_orden_lab',
        'id_eps_discount',
        'eps_discount',
        'fecha_vencimiento',
        'total_abonado',
        'id_comprobante_eps',
        'observaciones',
        'nota_credito_referencia'
    ];
    public $timestamps = true;


    public function sucursal(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }
    public function usuario(){
        return $this->belongsTo(User::class, 'id_usuario');
    }
    public function estado_comprobante(){
        return $this->belongsTo(ComprobanteEstado::class, 'id_estado_comprobante');
    }
    public function tipo_comprobante(){
        return $this->belongsTo(TipoComprobante::class, 'id_tipo_comprobante');
    }
    public function detalle(){
        return $this->hasMany(ComprobanteDetalle::class, 'id_comprobante');
    }
    public function cliente(){
        return $this->belongsTo(Clientes::class, 'id_cliente');
    }
    public function medio_pago(){
        return $this->belongsTo(MedioPago::class, 'id_medio_pago');
    }
    public function serie(){
        return $this->belongsTo(ComprobanteSerie::class, 'id_serie');
    }
    public function caja(){
        return $this->belongsTo(Caja::class, 'id_caja');
    }
    public function tipo_documento(){
        return $this->belongsTo(TipoDocumento::class, 'id_tipo_documento');
    }
    public function deuda(){
        return $this->hasMany(ComprobanteDeuda::class,  'id_comprobante');
    }
    public function encuesta(){
        return $this->hasOne(Encuesta::class,'id_comprobante','id_comprobante');
    }
    public function pagos(){
        return $this->hasMany(ComprobantePago::class, 'id_comprobante');
    }
    public function orden_laboratorio(){
        return $this->belongsTo(OrdenLaboratorio::class, 'id_orden_lab');
    }
    public function comprobanteEps(){
      return $this->hasOne(Comprobante::class, 'id_comprobante_eps', 'id_comprobante');
    }
    public static function listAll($request){
        $auth = auth('sanctum')->user();
        $data = Comprobante::with(
            'sucursal',
            'usuario',
            'estado_comprobante',
            'detalle',
            'cliente',
            'medio_pago',
            'serie',
            'caja',
            'orden_laboratorio')
                        ->where('id_sucursal', $auth->id_sucursal);
        $itemsPerPage = $request->itemsPerPage;
        $sortBy = $request->sortBy;
        $sortDesc = $request->sortDesc == 0 ? 'asc' : 'desc';

        $date_start = $request->fecha_inicio;
        $date_end = $request->fecha_fin;

        $tipo = $request->tipo;
        $status = $request->estado;

        if(isset($sortBy)){
            $data->orderBy($sortBy, $sortDesc);
        }

        if(isset($date_start) && isset($date_end)){
            $data->whereBetween('fecha_emision', [$date_start, $date_end]);
        }
        //Refiere a comprobante sin o con deuda

        if(isset($tipo) && $tipo == 1){
          $data->where('saldo','>',0)
               ->where('condicion_pago', '<>', 1);
        }

        if(isset($tipo) && $tipo == 0){
          $data->where('saldo', '=', 0)
               ->where('condicion_pago', '=', 1);
        }

        //if(isset($tipo)){
        //    $data->where('id_tipo_comprobante', $tipo);
        //}

        if(isset($status)){
            $data->where('id_estado_comprobante', $status);
        }

        return $data->latest()->paginate($itemsPerPage);
    }


    //--- Mutators ---
    public function setNombreClienteAttribute($value){
        $this->attributes['nombre_cliente'] = $this->SetUpperCase($value);
    }
    public function setDireccionClienteAttribute($value){
        $this->attributes['direccion_cliente'] = $this->SetUpperCase($value);
    }
    public function setComentarioAttribute($value){
        $this->attributes['comentario'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
