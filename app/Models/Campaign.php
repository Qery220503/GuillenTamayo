<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Campaign extends Model
{
  use HasFactory;
  protected $table = 'campanas';
  protected $primaryKey = 'id';
  protected $fillable = [
    'name',
    'id_user',
    'id_sucursal',
    'status',
    'active'
  ];
  public $timestamps = true;
  public function orders()
  {
    return $this->hasMany(OrdenLaboratorio::class, 'id_campana', 'id');
  }
}
