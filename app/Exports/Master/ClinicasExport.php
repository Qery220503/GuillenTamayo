<?php

namespace App\Exports\Master;

use App\Models\Clinicas;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;


class ClinicasExport implements FromCollection, WithHeadings, ShouldAutoSize
{
    function __construct() {
    }

    public function headings(): array
    {
        return [
            'Id',
            'Nombre Clinica',
            'Teléfono',
            'Correo Electrónico',
            'Enviar Correos',
        ];
    }

    public function collection()
    {
        $data = DB::table('clinicas')
        ->where("estado", 1)
        ->select('id_clinica','nombre_clinica','telefono_clinica', 'email_clinica', DB::raw("IF(enviar_correos=1, 'Autorizado', 'No autorizado') AS enviar_correos") )
        ->get();
        return $data;
    }

}
