<?php

namespace App\Http\Controllers;

use App\Models\Productos;
use App\Models\Clientes;
use App\Models\Compras;
use App\Models\Comprobante;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class DashboardController extends Controller
{
  public function getDashboardInfo(Request $request)
  {
    try {
      $startDate  = $request->startDate;
      $endDate    = $request->endDate;

      $clientes = Clientes::where('estado', 1)->get();
      $productos = Productos::where('estado', 1)->get();
      $ventas = new Comprobante;

      if (isset($startDate)) {
        if (isset($endDate)) {
          $ventas = $ventas->whereBetween('fecha_emision', [$startDate, $endDate]);
        } else {
          $ventas = $ventas->where('fecha_emision', '>=', $startDate);
        }
      }

      $top_compras = DB::table('compras_detalle')
        ->select('codigo_producto', DB::raw('COUNT(*) AS cnt'))
        ->groupBy('codigo_producto')
        ->orderByRaw('COUNT(*) DESC')
        ->take(5)
        ->get();

      $top_ventas = DB::table('comprobantes_detalles')
        ->select('detalle_item', DB::raw('COUNT(*) AS cnt'))
        ->groupBy('detalle_item')
        ->orderByRaw('COUNT(*) DESC')
        ->take(5)
        ->get();

      $today = Carbon::now()->format('Y-m-d');;
      $limit = Carbon::now()->addDays(7)->format('Y-m-d');
      $todayCarbon = Carbon::now();


      $purchases = Compras::whereBetween('fecha_vencimiento', [$today, $limit])
        ->where('estado', 1)
        ->orderBy('fecha_vencimiento', 'ASC')
        ->get();

      $sells = Comprobante::with(['serie'])->whereBetween('fecha_vencimiento', [$today, $limit])
        ->where('fecha_anulacion', null)
        ->where('saldo', '>', 0)
        ->orderBy('fecha_vencimiento', 'ASC')
        ->get();

      foreach ($purchases as $purchase) {
        $date = Carbon::parse($purchase->fecha_vencimiento);
        $days = $todayCarbon->diffInDays($date);
        $purchase['days'] = $days;
      }

      foreach ($sells as $sell) {
        $date = Carbon::parse($purchase->fecha_vencimiento);
        $days = $todayCarbon->diffInDays($date);
        $sell['days'] = $days;
      }

      return response()->json([
        'total_clientes' => $clientes->count(),
        'total_productos' => $productos->count(),
        'total_ventas' => $ventas->sum('total'),
        'top_compras' => $top_compras,
        'top_ventas' => $top_ventas,
        'next_purchases' => $purchases,
        'next_sells' => $sells
      ]);
    } catch (\Exception $e) {
      return response()->json($e->getMessage(), 500);
    }
  }
}
