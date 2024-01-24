<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CalendarioFeriados extends Model
{
    use HasFactory;
    protected $table = 'calendario_feriados';
    protected $primaryKey = 'id';
    protected $fillable = [
        'fecha'
    ];
    public $timestamps = false;
}