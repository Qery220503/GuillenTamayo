<?php

namespace App\Exports\Master;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class EmpresasExport implements FromCollection, WithHeadings, ShouldAutoSize
{
    function __construct() {
    }

    public function headings(): array
    {
        return [
            'ID',
            'Empresa',
            'RUC',
            'Dirección',
            'Correo Electrónico',
            'Teléfono',
            'Enviar Correos',
        ];
    }

    public function collection()
    {
        $data = DB::table('empresas_convenio')
        ->where("estado", 1)
        ->select('id_empresa_convenio','nombre_empresa','ruc_empresa','direccion_empresa','email_empresa','telefono_empresa', DB::raw("IF(enviar_correos=1, 'Autorizado', 'No autorizado') AS enviar_correos") )
        ->get();
        return $data;
    }
}
