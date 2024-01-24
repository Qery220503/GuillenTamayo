<?php

namespace App\Exports\Master;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class PrecioLentesExport implements FromCollection, WithHeadings, ShouldAutoSize
{
    function __construct() {
    }

    public function headings(): array
    {
        return [
            'ID',
            'Modelo',
            'Fabricaciópn',
            'Material',
            'Serie',
            'Tratamiento',
            'Fotocromatico',
            'Nombre Propio'
        ];
    }

    public function collection()
    {
        $data = DB::table('precios_lentes')
        ->where("active", 1)
        ->where("estado", 1)
        ->select('id_precio_lente',
            'modelo',
            'fabricacion',
            'material',
            'serie',
            'tratamiento',
            'fotocromatico',
            'nombre_propio'
        )
        ->get();
        return $data;
    }
}
