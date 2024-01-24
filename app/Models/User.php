<?php

namespace App\Models;

use App\Traits\DatabaseRowsTrait;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use App\Utils\EMailer;
use App\Utils\EToolBox;
use Illuminate\Support\Facades\Auth;
use Spatie\Permission\Traits\HasRoles;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Support\Facades\DB;

class User extends Authenticatable
{
    use DatabaseRowsTrait;
    use HasFactory, HasApiTokens, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id_role',
        'id_sucursal',
        'name',
        'email',
        'password',
        'active',
        'estado',
        'codigo_accesso'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];


    /**
     * Get User data (by default this methid encrypt the user ID)
     * Permissions,Roles,School
     * @return Collection
     */

    protected $with = array('role','sucursal');
    public function role(){
        return $this->belongsTo(CustomRole::class, 'id_role');
    }
    public function sucursal(){
        return $this->belongsTo(Sucursales::class, 'id_sucursal');
    }

    public function getData()
    {
        $data = [];
        $data['id'] = $this->id;
        $data['name'] = $this->name;
        $data['email'] = $this->email;
        return $data;
    }



    /** STACTIC METHODS */
    public static function getAuthenticatedUser($auth){
        return $auth->user();
    }

    public static function getUserbyEmail($email){

        $user =  User::where("email", $email)->first();
        if(isset($user)){
            return $user;
        }

        return null;
    }


    public static function allowedToSave($email){
        $user = User::where('email', $email)->first();
        if(isset($user) && $user->active == 1){
            throw new \Exception("Correo Electrónico en uso", 422);
        }
    }
    public static function listAll($request){
        $data = User::where('estado', 1);
        $user = Auth::user();

        $data->where('id_sucursal', $user->id_sucursal);

        $itemsPerPage = $request->itemsPerPage;
        $sortBy = $request->sortBy;
        $sortDesc = $request->sortDesc == 0 ? 'asc' : 'desc';

        if(isset($request->searchTerm)){
            $data->where(function($query) use ($request) {
                $query->where('name', 'like', '%'.$request->searchTerm.'%');
            });
        }
        if(isset($sortBy)){
            $data->orderBy($sortBy, $sortDesc);
        }

        return $data->paginate($itemsPerPage);
    }
    public function remove(){
        try{
            $this->update(['status' => 0]);
        }catch(\Exception $e){
            throw new \Exception($e->getMessage(), 500);
        }
    }
    public function getRecoveryCode(){
        return EToolBox::aes_encode($this->id);
    }
    public static function getUserbyHash($hash){
        try {
            $id = EToolBox::aes_decode($hash);
            $user =  User::findOrFail($id);
            return $user;
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage(), 404);
        }
    }
    public function matchHashcode($hash){
        $user =  User::getUserbyHash($hash);
        if($user->email != $this->email){
            throw new \Exception("hash missmatch", 404);

        }
        return true;
    }
    public function updateField($field, $value){
        if ($field == 'password') {
            $value = bcrypt($value);
        }
        $this[$field] = $value;
        $this->save();
    }


    //--- Mutators ---
    public function setNameAttribute($value){
        $this->attributes['name'] = $this->SetUpperCase($value);
    }
    //--- Fin ---
}
