<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Eps extends Model
{
    use HasFactory;
    protected $table = 'eps';
    protected $primaryKey = 'id';
    protected $fillable = [
        'name',
        'ruc',
        'status'
    ];

    public function discounts(){
        return $this->hasMany(EpsDescuento::class, 'eps_id', 'id');
    }
}
