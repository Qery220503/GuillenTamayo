<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Nota extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'notas';
    protected $primaryKey = 'id_nota';
    protected $fillable = [
        'id_serie',
        'id_comprobante',
        'id_tipo_nota',
        'id_cliente',
        'id_sucursal',
        'correlativo',
        'external_id',
        'id_estado_comprobante',
        'id_tipo_comprobantes',
        'fecha_emision',
        'descripcion',
        'total',
        'subtotal',
        'igv',
        'total',
        'estado',
    ];

    public function cliente(){
        return $this->belongsTo(Clientes::class, 'id_cliente');
    }
    public function sucursal(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }
    public function serie(){
        return $this->belongsTo(ComprobanteSerie::class, 'id_serie');
    }
    public function comprobante(){
        return $this->belongsTo(Comprobante::class, 'id_comprobante');
    }
    public function tipo_comprobante(){
        return $this->belongsTo(TipoComprobante::class, 'id_tipo_comprobantes');
    }
    public function  estado_nota(){
        return $this->belongsTo(ComprobanteEstado::class, 'id_estado_comprobante');
    }
    public function detalle(){
        return $this->hasMany(NotaDetalle::class, 'id_nota');
    }
    public function tipo(){
        return $this->belongsTo(TipoNota::class, 'id_tipo_nota');
    }

    public static function listAll($request){
        $auth = auth('sanctum')->user();
        $data = Nota::with([
                        'cliente',
                        'sucursal',
                        'serie',
                        'comprobante.serie',
                        'estado_nota',
                    ])
                    ->where('id_sucursal', $auth->id_sucursal)
                    ->where('estado', 1);

        $itemsPerPage = $request->itemsPerPage;
        $sortBy = $request->sortBy;
        $sortDesc = $request->sortDesc == 0 ? 'asc' : 'desc';

        $date_start = $request->fecha_inicio;
        $date_end = $request->fecha_fin;

        $usuario = $request->user;
        $status = $request->estado;

        /*
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
        */

        return $data->latest()->paginate($itemsPerPage);
    }

    
    //--- Mutators ---
    public function setDescripcionAttribute($value){
        $this->attributes['descripcion'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
