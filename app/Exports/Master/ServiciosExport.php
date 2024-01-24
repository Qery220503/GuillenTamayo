<?php

namespace App\Exports\Master;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class ServiciosExport implements FromCollection, WithHeadings, ShouldAutoSize
{
    function __construct() {
    }

    public function headings(): array
    {
        return [
            'ID',
            'Servicio',
            'Precio Venta',
            'Codigo Afectación'
        ];
    }

    public function collection()
    {
        $data = DB::table('servicios')
        ->where("estado", 1)
        ->join('afectacion_igv', 'servicios.cod_afectacion_igv', '=', 'afectacion_igv.cod_afectacion')
        ->select('id_servicio','nombre_servicio','precio_venta',DB::raw("CONCAT(servicios.cod_afectacion_igv,' - ',afectacion_igv.descripcion)") )
        ->get();
        return $data;
    }
}
