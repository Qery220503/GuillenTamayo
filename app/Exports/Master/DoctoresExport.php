<?php

namespace App\Exports\Master;

use App\Models\Doctores;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;


class DoctoresExport implements FromCollection, WithHeadings, ShouldAutoSize
{
    function __construct() {
    }

    public function headings(): array
    {
        return [
            'ID',
            'Nombres y Apellidos',
            'Nro. Documento',
            'Correo Electrónico',
            'Teléfono',
            'Enviar Correos',
        ];
    }

    public function collection()
    {
        $data = DB::table('doctores')
        ->where("estado", 1)
        ->select('id_doctor',DB::raw("CONCAT(nombres,' ',apellidos) AS nombres_apellidos"),'nro_documento','email','nro_telefono', DB::raw("IF(enviar_correos=1, 'Autorizado', 'No autorizado') AS enviar_correos") )
        ->get();
        return $data;
    }

}

