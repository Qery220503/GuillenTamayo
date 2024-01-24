<?php 

namespace APP\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MotivoTraslado extends Model
{
    use DatabaseRowsTrait;
    
    use HasFactory;
    protected $table = 'motivo_traslado'; 
    protected $primaryKey = 'id_motivo_traslado';
    protected $fillable = [
        'description'
    ];

    
    //--- Mutators ---
    public function setDescriptionAttribute($value){
        $this->attributes['description'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}