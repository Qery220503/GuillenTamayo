<?php

namespace App\Http\Controllers;

use App\Models\PreciosLentes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class PreciosLentesController extends Controller
{
  public function __constructor()
  {
    $this->middleware('auth:sanctum');
  }

  public function index(Request $request)
  {
    $authUser = auth('sanctum')->user();
    $datos = PreciosLentes::where([
      ["id_sucursal", $authUser->id_sucursal],
      ["active", 1],
    ]);
    if (isset($request->searchTerm)) {
      $datos->where("nombre_propio", "LIKE", "%" . $request->searchTerm . "%");
    }
    if (isset($request->modelo)) {
      $datos->where("modelo", "LIKE", "%" . $request->modelo . "%");
    }
    if (isset($request->fabricacion)) {
      $datos->where("fabricacion", "LIKE", "%" . $request->fabricacion . "%");
    }
    if (isset($request->material)) {
      $datos->where("material", "LIKE", "%" . $request->material . "%");
    }
    if (isset($request->serie)) {
      $datos->where("serie", "LIKE", "%" . $request->serie . "%");
    }
    if (isset($request->tratamiento)) {
      $datos->where("tratamiento", "LIKE", "%" . $request->tratamiento . "%");
    }
    if (isset($request->fotocromatico)) {
      $datos->where("fotocromatico", "LIKE", "%" . $request->fotocromatico . "%");
    }
    if (isset($request->nombre_propio)) {
      $datos->where("nombre_propio", "LIKE", "%" . $request->nombre_propio . "%");
    }
    if (isset($request->estado) && $request->estado == 1) {
      $datos->where("estado", 1);
    }
    if (isset($request->estado) && $request->estado == 2) {
      $datos->where("estado", 0);
    }

    return $datos->latest()->paginate($request->perPage);
  }

  /**
   * Store a newly created resource in storage.
   *
   * @param  \Illuminate\Http\Request  $request
   * @return \Illuminate\Http\Response
   */
  public function store(Request $request)
  {
    try {
      $marca_data = PreciosLentes::create($request->all());
      return response()->json($marca_data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
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
    try {
      //obtiene la sucursal con sus zonas
      $producto = PreciosLentes::findOrFail($id);
      return response()->json($producto, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
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
    try {
      $producto = PreciosLentes::findOrFail($id);
      $producto->update($request->all());
      return response()->json($producto, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
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
    try {
      $data = PreciosLentes::findOrFail($id);
      $upd_data = array(
        'estado'  =>  0
      );
      $data->update($upd_data);
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  /*public function getDisenio()
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->selectRaw('UPPER(modelo) as text')
        ->groupBy('modelo')
        ->where('id_sucursal', $authUser->id_sucursal)
        ->where('estado', 1)
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }*/

  public function getDisenio()
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->selectRaw('UPPER(modelo) as text')
        ->where('estado', 1)
        ->orderByRaw("CASE WHEN id_sucursal = $authUser->id_sucursal THEN 0 ELSE 1 END")
        ->orderBy('modelo')
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function getFabricacion(Request $request)
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->selectRaw('UPPER(fabricacion) as text')
        ->groupBy('fabricacion')
        //->where('id_sucursal', $authUser->id_sucursal)
        ->where('modelo', $request->disenio)
        ->where('estado', 1)
        ->orderByRaw("CASE WHEN id_sucursal = $authUser->id_sucursal THEN 0 ELSE 1 END")
        ->orderBy('fabricacion')
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function getMaterial(Request $request)
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->selectRaw('UPPER(material) as text')
        ->groupBy('material')
        //->where('id_sucursal', $authUser->id_sucursal)
        ->where('modelo', $request->disenio)
        ->where('fabricacion', $request->fabricacion)
        ->where('estado', 1)
        ->orderByRaw("CASE WHEN id_sucursal = $authUser->id_sucursal THEN 0 ELSE 1 END")
        ->orderBy('material')
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function getSerie(Request $request)
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->selectRaw('UPPER(serie) as text')
        ->groupBy('serie')
        //->where('id_sucursal', $authUser->id_sucursal)
        ->where('modelo', $request->disenio)
        ->where('fabricacion', $request->fabricacion)
        ->where('material', $request->material)
        ->where('estado', 1)
        ->orderByRaw("CASE WHEN id_sucursal = $authUser->id_sucursal THEN 0 ELSE 1 END")
        ->orderBy('serie')
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function getTratamiento(Request $request)
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->selectRaw('UPPER(tratamiento) as text')
        ->groupBy('tratamiento')
        //->where('id_sucursal', $authUser->id_sucursal)
        ->where('modelo', $request->disenio)
        ->where('fabricacion', $request->fabricacion)
        ->where('material', $request->material)
        ->where('serie', $request->serie)
        ->where('estado', 1)
        ->orderByRaw("CASE WHEN id_sucursal = $authUser->id_sucursal THEN 0 ELSE 1 END")
        ->orderBy('tratamiento')
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function getNombre(Request $request)
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->selectRaw('UPPER(nombre) as text')
        ->groupBy('nombre')
        //->where('id_sucursal', $authUser->id_sucursal)
        ->where('modelo', $request->disenio)
        ->where('fabricacion', $request->fabricacion)
        ->where('material', $request->material)
        ->where('serie', $request->serie)
        ->where('tratamiento', $request->tratamiento)
        ->where('estado', 1)
        ->orderByRaw("CASE WHEN id_sucursal = $authUser->id_sucursal THEN 0 ELSE 1 END")
        ->orderBy('nombre')
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function getFotocromatico(Request $request)
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->selectRaw('UPPER(fotocromatico) as text')
        ->groupBy('fotocromatico')
        //->where('id_sucursal', $authUser->id_sucursal)
        ->where('modelo', $request->disenio)
        ->where('fabricacion', $request->fabricacion)
        ->where('material', $request->material)
        ->where('serie', $request->serie)
        ->where('tratamiento', $request->tratamiento)
        ->where('nombre', $request->nombre)
        ->where('estado', 1)
        ->orderByRaw("CASE WHEN id_sucursal = $authUser->id_sucursal THEN 0 ELSE 1 END")
        ->orderBy('fotocromatico')
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function getColor(Request $request)
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->selectRaw('UPPER(color_fotocromatico) as text')
        ->groupBy('color_fotocromatico')
        //->where('id_sucursal', $authUser->id_sucursal)
        ->where('modelo', $request->disenio)
        ->where('fabricacion', $request->fabricacion)
        ->where('material', $request->material)
        ->where('serie', $request->serie)
        ->where('tratamiento', $request->tratamiento)
        ->where('nombre', $request->nombre)
        ->where('fotocromatico', $request->fotocromatico)
        ->where('estado', 1)
        ->orderByRaw("CASE WHEN id_sucursal = $authUser->id_sucursal THEN 0 ELSE 1 END")
        ->orderBy('color_fotocromatico')
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function getPrecioLentes(Request $request)
  {
    $authUser = auth('sanctum')->user();
    try {
      $data = DB::table('precios_lentes')
        ->select('*')

        ->addSelect(DB::raw("UPPER(modelo) as modelo"))
        ->addSelect(DB::raw("UPPER(fabricacion) as fabricacion"))
        ->addSelect(DB::raw("UPPER(material) as material"))
        ->addSelect(DB::raw("UPPER(serie) as serie"))
        ->addSelect(DB::raw("UPPER(tratamiento) as tratamiento"))
        ->addSelect(DB::raw("UPPER(nombre) as nombre"))
        ->addSelect(DB::raw("UPPER(fotocromatico) as fotocromatico"))
        ->addSelect(DB::raw("UPPER(color_fotocromatico) as color_fotocromatico"))

        //->where('id_sucursal', $authUser->id_sucursal)
        ->where('modelo', $request->disenio)
        ->where('fabricacion', $request->fabricacion)
        ->where('material', $request->material)
        ->where('serie', $request->serie)
        ->where('tratamiento', $request->tratamiento)
        ->where('nombre', $request->nombre)
        ->where('fotocromatico', $request->fotocromatico)
        ->where('color_fotocromatico', $request->color_fotocromatico)
        ->where('estado', 1)
        ->get();
      return response()->json($data, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function cambiar_estado(Request $request)
  {
    try {
      $producto = PreciosLentes::findOrFail($request->id);
      $producto->update($request->all());
      return response()->json($producto, 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }

  public function stock(Request $request)
  {
    $datos = PreciosLentes::where([
      ["estado", 1],
    ]);

    return $datos->get();
  }

  public function updatePrecios(Request $request)
  {
    try {
      foreach ($request->data as $key) {
        $lente = PreciosLentes::findOrFail($key['id_precio_lente']);
        $lente->update([
          'precio_venta' => $key['precio_venta_update']
        ]);
      }
      return response()->json(['message' => 'update'], 200);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }
}
