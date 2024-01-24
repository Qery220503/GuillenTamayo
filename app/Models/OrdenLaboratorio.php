<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

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
        'lensometria',
        'angulos',
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

        //'seleccion_medidas'
    ];
    public $timestamps = true;

    protected $casts = [
        'receta' => 'array',
        'lensometria' => 'array',
        'angulos' => 'array',
    ];
    protected $with = array('status');

    protected $appends = ['codigo_orden_lab', 
                        'fecha_emision', 
                        'fecha_entrega_parse', 
                        'doctor_nombre', 
                        'clinica_nombre', 
                        'angulos_parse', 
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

    //--- Funciones ---
    public static function listAll($request){
        $auth = auth('sanctum')->user();
        $data = OrdenLaboratorio::with(
            'anamnesis',
            'montura',
            'cliente',
            'status',
            'usuario',
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

    /*
    public function getRefraccionLejosParseAttribute(){
        $data = $this->refraccion_lejos;
        return [ 
            'od' =>'ESF: '.$data['od']['esfera'].' CIL: '.$data['od']['cilindro'].' EJE: '.$data['od']['eje'].' DNP:'.$data['od']['dnp'].' ALT: '.$data['od']['alt'].' PRISM: '.$data['od']['prismas'].'',
            'oi' =>'ESF: '.$data['oi']['esfera'].' CIL: '.$data['oi']['cilindro'].' EJE: '.$data['oi']['eje'].' DNP:'.$data['oi']['dnp'].' ALT: '.$data['oi']['alt'].' PRISM: '.$data['oi']['prismas'].''
        ];
    }
    public function getRefraccionCercaParseAttribute(){
        $data = $this->refraccion_cerca;
        return [ 
            'od' =>'ESF: '.$data['od']['esfera'].' CIL: '.$data['od']['cilindro'].' EJE: '.$data['od']['eje'].' DNP:'.$data['od']['dnp'].' ALT: '.$data['od']['alt'].' PRISM: '.$data['od']['prismas'].'',
            'oi' =>'ESF: '.$data['oi']['esfera'].' CIL: '.$data['oi']['cilindro'].' EJE: '.$data['oi']['eje'].' DNP:'.$data['oi']['dnp'].' ALT: '.$data['oi']['alt'].' PRISM: '.$data['oi']['prismas'].''
        ];
    }*/
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
    public function getAngulosParseAttribute(){
        return $this->angulos;
        //return json_decode($this->angulos, true);
    }
    //--- Fin ---


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