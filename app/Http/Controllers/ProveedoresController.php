<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Proveedores;
use App\Models\Compras;
use Illuminate\Support\Facades\Auth;

class ProveedoresController extends Controller
{
    public function __constructor()
    {
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request)
    {
        $data = Proveedores::where('estado', 1);
        $itemsPerPage = $request->itemsPerPage;
        $sortBy = $request->sortBy;
        $sortDesc = $request->sortDesc == true ? 'desc' : 'asc';


        if (isset($request->nombre)) {
            $data->where("nombre", "LIKE", "%" . $request->nombre . "%");
        }
        if (isset($request->nro_doc)) {
            $data->where("nro_doc", "LIKE", "%" . $request->nro_doc . "%");
        }
        if (isset($request->email)) {
            $data->where("email", "LIKE", "%" . $request->email . "%");
        }
        if (isset($request->telefono)) {
            $data->where("telefono", "LIKE", "%" . $request->telefono . "%");
        }
        if (isset($request->cod_proveedor)) {
            $data->where("cod_proveedor", "LIKE", "%" . $request->cod_proveedor . "%");
        }

        if(isset($request->deuda)) {
            if ($request->deuda == 'debt') {
                $data->whereHas('compras', function ($q) {
                    $q->where([
                        ['condicion_pago', '!=', 1],
                        ['deuda_saldo', '>', 0],
                        ['estado', 1]
                    ]);
                });
            }
            if ($request->deuda == 'no-debt') {
                $data->whereDoesntHave('compras', function ($q) {
                    $q->where([
                        ['condicion_pago', '!=', 1],
                        ['deuda_saldo', '>', 0],
                        ['estado', 1]
                    ]);
                });
            }
        }

        if (isset($sortBy)) {
            $data->orderBy($sortBy, $sortDesc);
        }
        return $data->paginate($itemsPerPage);
    }

    public function create()
    {
        //
    }

    public function store(Request $request)
    {
        try {
            $data = Proveedores::create($request->all());
            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function show($id)
    {
        try {
            $data = Proveedores::findOrFail($id);
            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function edit($id)
    {
        //
    }

    public function update(Request $request, $id)
    {
        try {
            $data = Proveedores::findOrFail($id);
            $data->update($request->except(['_token', 'id_proveedor']));
            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function destroy($id)
    {
        try {
            $data = Proveedores::findOrFail($id);
            $data->update(['estado' => 0]);
            return response()->json($data, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function combo()
    {
        try {
            $data = Proveedores::select('id_proveedor', 'nombre', 'nro_doc', 'direccion')->where([
                ['estado', 1],
            ])->get();
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function cuenta_corriente(Request $request, $id)
    {
        try {
            $itemsPerPage = $request->itemsPerPage;
            $data = Compras::with('pagos_deuda')
                ->where([
                    ['id_proveedor', $id],
                    ['condicion_pago', '!=', 1], // 1 = al contado
                    ['estado', 1],
                ])->orderBy('fecha_vencimiento', 'asc')
                ->paginate($itemsPerPage);

            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function compras_realizadas(Request $request, $id)
    {
        try {
            $itemsPerPage = $request->itemsPerPage;
            $data = Compras::where('estado', 1)
                ->where('id_proveedor', $id)
                ->paginate($itemsPerPage);
            return response()->json($data);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }
}
