<?php

namespace App\Exports\Process;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class AlmacenExport implements FromCollection, WithHeadings, ShouldAutoSize
{
    function __construct() {
    }

    public function headings(): array
    {
        return [
            'Id',
            'Codigo',
            'Producto',
            'Fecha Movimiento',
            'Tipo Movimiento',
            'Stock Inicial',
            'Cantidad',
            'Stock Actual',
        ];
    }
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        $data = DB::table('almacen_movimientos')
        ->join('almacen_movimientos_tipos', 'almacen_movimientos_tipos.id_tipo_movimiento', '=', 'almacen_movimientos.id_tipo_movimiento')
        ->select('id_almacen_movimientos','codigo_producto','nombre_producto','created_at','almacen_movimientos_tipos.tipo_movimiento','stock_inicial','cantidad','stock_actual' )
        ->get();
        return $data;
    }
}
