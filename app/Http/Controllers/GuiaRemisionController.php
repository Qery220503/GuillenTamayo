<?php

namespace App\Http\Controllers;

use App\Models\Clientes;
use App\Models\GuiaRemision;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class GuiaRemisionController extends Controller
{
    public function index(Request $request) {
        return GuiaRemision::listAll($request );
    }

    public function store(Request $request) {
        DB::beginTransaction();
        try {
            $user = Auth::user();
            $header = $request->except('detalle');
            $header['id_sucursal'] = $user->id_sucursal;
            $header['estado'] = 1;
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function clientes() {
        try {
            $data = Clientes::all();
            return response()->json($data);
        }
        catch(\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }
}
