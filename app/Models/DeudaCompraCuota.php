<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeudaCompraCuota extends Model
{
    use HasFactory;

    protected $table= 'deuda_compra_cuotas';
    protected $primaryKey= 'id_cuota';
    protected $fillable = [
        'id_compra',
        'fecha',
        'monto',
    ];
    public $timestamps = false;

    public function compra(){
        return $this->belongsTo(Compras::class, 'id_compra');
    }
}