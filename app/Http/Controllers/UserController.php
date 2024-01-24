<?php

namespace App\Http\Controllers;

use App\Models\BusinessPartnerInformation;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{

    public function auth(Request $request)
    {
        return response()->json($request->user()->getData(), 201);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        try {
            $data = User::listAll($request);
            return response()->json($data, 200);

        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $user = Auth::user();
        try{
            $user_data    = User::create([
                "name"     => $request->name,
                "email"    => $request->email,
                "id_role"   => $request->id_role,
                'id_sucursal' => $user->id_sucursal,
                "password" => Hash::make($request->password),
            ]);

            return response()->json($user_data, 200);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        try{
            $user_data = User::findOrFail($id);
            $user_data->name   = $request->name;
            $user_data->email  = $request->email;
            $user_data->id_role = $request->id_role;
            if($request->password != ""){
                $user_data->password = Hash::make($request->password);
            }
            $user_data->save();

            return response()->json($user_data, 200);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try{
            $data = User::findOrFail($id);
            $data->remove();
            return response()->json($data, 200);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
}
