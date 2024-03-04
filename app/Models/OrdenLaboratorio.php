<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class OrdenLaboratorio extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'orden_laboratorio';
    protected $primaryKey = 'id_orden_laboratorio';
    protected $fillable = [
        'id_montura',
        'id_cliente',
        'id_precio_lentes',
        'id_estado_orden_laboratorio',
        'receta',
        'observaciones',
        'montura_cliente',
        'fecha_entrega',
        'hora_entrega',
        'id_sucursal',
        'id_anamnesis',
        'id_usuario',
        'montura',
        'monto_compra_proyectado',
        'monto_compra_detallado',
        'tipo_montura',
        'montaje',
        'id_campana',
        'id_comprobante'
    ];
    public $timestamps = true;

    protected $casts = [
        'receta' => 'array',
    ];
    protected $with = array('status');

    protected $appends = [
      'codigo_orden_lab',
      'fecha_emision',
      'fecha_entrega_parse',
      'doctor_nombre',
      'clinica_nombre',
      'comprobante_generado'
    ];

    public function historial(){
        return $this->hasMany(OrdenLaboratorioHistorial::class, 'id_orden', 'id_orden_laboratorio');
    }
    public function anamnesis(){
        return $this->belongsTo(Anamnesis::class, 'id_anamnesis');
    }
    public function montura(){
        return $this->belongsTo(Productos::class, 'id_montura');
    }
    public function cliente(){
        return $this->belongsTo(Clientes::class, 'id_cliente');
    }
    public function status(){
        return $this->belongsTo(OrdenLaboratorioEstados::class, 'id_estado_orden_laboratorio');
    }
    public function usuario(){
        return $this->belongsTo(User::class, 'id_usuario');
    }
    public function lente(){
        return $this->belongsTo(PreciosLentes::class, 'id_precio_lentes');
    }
    public function sucursal(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }
    public function estadoComprobante(){
        return $this->belongsTo(OrdenLaboratorioEstados::class, 'id_estado_orden_laboratorio','id_estado_orden_laboratorio');
    }
    public function comprobante(){
      return $this->belongsTo(Comprobante::class,'id_comprobante');
    }
    //--- Funciones ---
    public static function listAll($request){
        $auth = auth('sanctum')->user();
        $data = OrdenLaboratorio::with(
            'anamnesis',
            'cliente',
            'status',
            'lente',
            'anamnesis.clinica',
            'anamnesis.doctor'
        )
            ->where('id_sucursal', $auth->id_sucursal);
        $itemsPerPage = $request->itemsPerPage;
        $sortBy = $request->sortBy;
        $sortDesc = $request->sortDesc == 0 ? 'asc' : 'desc';

        $date_start = $request->fecha_inicio;
        $date_end = $request->fecha_fin;

        $usuario = $request->user;
        $status = $request->estado;

        if (isset($request->searchTerm)) {
            $data->where(function ($query) use ($request) {
                $query->where('name', 'like', '%' . $request->searchTerm . '%');
            });
        }
        if (isset($sortBy)) {
            $data->orderBy($sortBy, $sortDesc);
        }

        if (isset($date_start) && isset($date_end)) {
            $data->whereBetween('created_at', [$date_start, $date_end]);
        }

        if (isset($usuario)) {
            $data->where('id_usuario', $usuario);
        }

        if (isset($status)) {
            $data->where('id_estado_orden_laboratorio', $status);
        }

        return $data->latest()->paginate($itemsPerPage);
    }


    //--- Accessors ---
    public function getCodigoOrdenLabAttribute(){
        return str_pad($this->id_orden_laboratorio, 8, "0", STR_PAD_LEFT);
    }
    public function getFechaEmisionAttribute(){
        return Carbon::parse($this->created_at)->format('d/m/y');
    }
    public function getFechaEntregaParseAttribute(){
        return Carbon::parse($this->fecha_entrega)->format('d/m/y');
    }
    public function getDoctorNombreAttribute(){
        return $this->anamnesis->doctor['nombres'] . ' ' . $this->anamnesis->doctor['apellidos'];
    }
    public function getClinicaNombreAttribute(){
        return $this->anamnesis->clinica['nombre_clinica'];
    }
    public function getComprobanteGeneradoAttribute(){
      return !is_null($this->comprobante);
    }

    //--- Mutators ---
    public function setObservacionesAttribute($value){
        $this->attributes['observaciones'] = $this->SetUpperCase($value);
    }
    public function setTipoMonturaAttribute($value){
        $this->attributes['tipo_montura'] = $this->SetUpperCase($value);
    }
    public function setMontajeAttribute($value){
        $this->attributes['montaje'] = $this->SetUpperCase($value);
    }
    //--- End ---
}
