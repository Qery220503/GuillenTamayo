<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EpsDescuento extends Model
{
    use HasFactory;
    protected $table = 'eps_descuentos';
    protected $fillable = ['eps_id', 'detail', 'discount_type', 'discount', 'status'];

    public function eps()
    {
        return $this->belongsTo(Eps::class, 'eps_id');
    }
}
