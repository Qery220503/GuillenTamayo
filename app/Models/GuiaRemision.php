<?php 

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GuiaRemision extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'guia_remision'; 
    protected $primaryKey = 'id_guia_remision';
    protected $fillable = [
        'id_serie',
        'id_sucursal',	
        'fecha_emision',
        'fecha_traslado',
        'id_cliente',
        'modo_traslado',
        'id_motivo_traslado',	
        'descripcion_motivo_traslado',	
        'id_unidad_medida',	
        'peso_total',	
        'cantidad',	
        'observaciones',	
        'id_departamento_partida',	
        'id_provincia_partida',	
        'id_distrito_partida',	
        'direccion_partida',	
        'id_departamento_llegada',	
        'id_provincia_llegada',	
        'id_distrito_llegada',	
        'direccion_llegada',	
        'datos_publico',	
        'datos_privado',
    ];

    public function serie()  {
        return $this->belongsTo(ComprobanteSerie::class, 'id_serie');
    }
    public function sucursal() {
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }
    public function cliente() {
        return $this->belongsTo(Clientes::class, 'id_cliente');
    }
    public function motivo_traslado() {
        return $this->belongsTo(MotivoTraslado::class, 'id_motivo_traslado');
    }
    public function unidad_medida() {
        return $this->belongsTo(UnidadMedida::class, 'id_unidad_medida');
    }
    public function departamento_partida() {
        return $this->belongsTo(Departamento::class, 'id_departamento');
    }
    public function provincia_partida() {
        return $this->belongsTo(Provincia::class, 'id_departamento');
    }
    public function distrito_partida() {
        return $this->belongsTo(Distrito::class, 'id_departamento');
    }
    public function departamento_llegada() {
        return $this->belongsTo(Departamento::class, 'id_departamento');
    }
    public function provincia_llegada() {
        return $this->belongsTo(Provincia::class, 'id_departamento');
    }
    public function distrito_llegada() {
        return $this->belongsTo(Distrito::class, 'id_departamento');
    }

    public static function listAll($request) {
        $auth = auth('sanctum')->user();
        $data = GuiaRemision::with(
            'serie',
            'sucursal',
            'cliente',
            'motivo_traslado',
            'unidad_medida',
            'departamento_partida',
            'provincia_partida',
            'distrito_partida',
            'departamento_llegada',
            'provincia_llegada',
            'distrito_llegada'
        )->where('id_sucursal', $auth->id_sucursal);

        $itemsPerPage = $request->itemsPerPage;

        return $data->latest()->paginate($itemsPerPage);
    }


    //--- Mutators ---
    public function setDescripcionMotivoTrasladoAttribute($value){
        $this->attributes['descripcion_motivo_traslado'] = $this->SetUpperCase($value);
    }
    public function setObservacionesAttribute($value){
        $this->attributes['observaciones'] = $this->SetUpperCase($value);
    }
    public function setDireccionPartidaAttribute($value){
        $this->attributes['direccion_partida'] = $this->SetUpperCase($value);
    }
    public function setDireccionLlegadaAttribute($value){
        $this->attributes['direccion_llegada'] = $this->SetUpperCase($value);
    }
    public function setDatosPublicoAttribute($value){
        $this->attributes['datos_publico'] = $this->SetUpperCase($value);
    }
    public function setDatosPrivadoAttribute($value){
        $this->attributes['datos_privado'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}