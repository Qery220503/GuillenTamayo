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
        'status',
        'active'
    ];
    public $timestamps = true;
}
