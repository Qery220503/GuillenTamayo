<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\Clientes;
use App\Models\Comprobante;
use Illuminate\Http\Request;
use Exception;

class ClientesController extends Controller
{
    public function __constructor()
    {
        $this->middleware('auth:sanctum');
    }

    public function index(Request $request)
    {
        $datos = Clientes::with([
            'tipo_documento',
            'comprobantes.deuda',
            'comprobantes.pagos',
            'ocupacion'
        ])->where([
            ['estado', 1],
        ]);

        if (isset($request->nombre_razon_social)) {
            $datos->where("nombre_razon_social", "LIKE", "%" . $request->nombre_razon_social . "%");
        }
        if (isset($request->nro_documento)) {
            $datos->where("nro_documento", "LIKE", "%" . $request->nro_documento . "%");
        }
        if (isset($request->email)) {
            $datos->where("email", "LIKE", "%" . $request->email . "%");
        }
        if (isset($request->telefono)) {
            $datos->where("telefono", "LIKE", "%" . $request->telefono . "%");
        }
        if (isset($request->debts) && $request->debts == 'debt') {
            $datos->whereHas('comprobantes.deuda', function ($q) {
                return $q->where('saldo','>', 0);
            });
        }
        if (isset($request->debts) && $request->debts == 'no-debt') {
            $datos->whereDoesntHave('comprobantes.deuda', function ($q) {
                return $q->where('saldo', '=',0);
            });
        }
        if (isset($request->ocupacion)) {
            $datos->where('id_ocupacion', $request->ocupacion);
        }

        return $datos->paginate($request->perpage);
    }

    public function store(Request $request)
    {
        try {
            $auth = auth('sanctum')->user();
            $cliente = Clientes::create($request->all());

            return response()->json($cliente, 200);
        } catch (\Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function show($id)
    {
        try {
            $cliente = Clientes::findOrFail($id);
            return response()->json($cliente, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $cliente = Clientes::findOrFail($id);
            $cliente->update($request->all());
            return response()->json($cliente, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function destroy($id)
    {
        try {
            $data = Clientes::findOrFail($id);
            $upd_data = array(
                'estado'  =>  0
            );
            $data->update($upd_data);
            return response()->json($data, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }

    public function searchClient(Request $request)
    {   
        /*
        DB::beginTransaction();
        try {
            $auth = auth('sanctum')->user();

            $toCreate = $request->all();
            $cliente = Clientes::firstOrCreate([
                'nro_documento' => $request->nro_documento,
                'cod_tipo_doc' => $request->cod_tipo_doc

            ], $toCreate);

            DB::commit();
            return response()->json($cliente, 200);
        } catch (Exception $e) {
            DB::rollBack();

            return response()->json([
                "success" => false,
                "msg" => "Ocurrio un error",
                "error" => $e->getMessage()
            ], 500);
        }*/
        $auth = auth('sanctum')->user();

        $toCreate = $request->all();
        $cliente = Clientes::firstOrCreate([
            'nro_documento' => $request->nro_documento,
            'cod_tipo_doc' => $request->cod_tipo_doc

        ], $toCreate);

        //DB::commit();
        return response()->json($cliente, 200);

    }

    public function deudasPendientes($cliente)
    {
        $comprobantes = Comprobante::with(['credito.pagos.medio_pago', 'credito.pagos.user', 'serie'])
            ->where('condicion_pago', 2)
            ->where('id_cliente', $cliente)
            ->where('saldo', '>', '0')
            ->get();
        return response()->json($comprobantes);
    }

    public function cuenta_corriente(Request $request, $id)
    {
        try{
            $itemsPerPage = $request->itemsPerPage;
            $data = Comprobante::with('serie')
            ->where([
                ['id_cliente', $id],
                ['condicion_pago', '!=', 1], // 1 = al contado
                //['estado', 1],
            ])->orderBy('fecha_vencimiento','asc')
            ->paginate($itemsPerPage);
                
            return response()->json($data);
        }
        catch(\Exception $e){
            return response()->json($e->getMessage(),500);
        }
    }
}