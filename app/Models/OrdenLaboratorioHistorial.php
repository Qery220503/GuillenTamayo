<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrdenLaboratorioHistorial extends Model
{
    use DatabaseRowsTrait;

    use HasFactory;
    protected $table = 'orden_laboratorio_historial_estados';
    protected $primaryKey = 'id';
    protected $fillable = [
        'id_orden',
        'id_estado',
        'id_usuario',
        'estado',
    ];
    public $timestamps = true;

    public function estadoOrden(){
        return $this->belongsTo(OrdenLaboratorioEstados::class, 'id_estado');
    }
    public function usuario(){
        return $this->belongsTo(User::class, 'id_usuario');
    }
}