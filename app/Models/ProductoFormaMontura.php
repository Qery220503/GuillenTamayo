<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductoFormaMontura extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'productos_forma_montura';
    protected $primaryKey = 'id_forma_montura';
    protected $fillable = [
        'forma_montura',
        'rostros',
        'estado'
    ];
    public $timestamps = false;


    //--- Mutators ---
    public function setFormaMonturaAttribute($value){
        $this->attributes['forma_montura'] = $this->SetUpperCase($value);
    }
    public function setRostrosAttribute($value){
        $this->attributes['rostros'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
