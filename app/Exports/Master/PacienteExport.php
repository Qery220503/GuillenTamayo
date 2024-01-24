<?php

namespace App\Exports\Master;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Illuminate\Http\Request;
use App\Models\Clientes;
use App\Models\User;
use Maatwebsite\Excel\Concerns\WithMapping;
use Illuminate\Support\Facades\Log;

class PacienteExport implements FromCollection, WithHeadings, ShouldAutoSize, WithMapping
{
    public Request $request;
    function __construct($rq)
    {
        $this->request = $rq;
    }

    public function headings(): array
    {
        return [
            'Id',
            'Nombre / Razon Social',
            'T. Documento',
            'Nro. Documento',
            'Teléfono',
            'Correo Electrónico',
        ];
    }
    public function map($row): array
    {
        return [
            $row->id_cliente,
            $row->nombre_razon_social,
            $row->tipo_documento->nombre_tipo_documento,
            $row->nro_documento,
            $row->telefono,
            $row->email,
        ];
    }

    public function collection()
    {
        $datos = Clientes::query()
        ->with(['tipo_documento', 'comprobantes.credito'])
        ->where([
            ['estado', 1],
        ]);

        if (isset($this->request->nombre_razon_social)) {
            $datos->where("nombre_razon_social", "LIKE", "%" . $this->request->nombre_razon_social . "%");
        }
        if (isset($this->request->nro_documento)) {
            $datos->where("nro_documento", "LIKE", "%" . $this->request->nro_documento . "%");
        }
        if (isset($this->request->email)) {
            $datos->where("email", "LIKE", "%" . $this->request->email . "%");
        }
        if (isset($this->request->telefono)) {
            $datos->where("telefono", "LIKE", "%" . $this->request->telefono . "%");
        }
        if (isset($this->request->debts) && $this->request->debts == 'debt') {
            $datos->whereHas('comprobantes.credito', function ($q) {
                return $q->where('fecha_pago', null);
            });
        }
        if (isset($this->request->debts) && $this->request->debts == 'no-debt') {
            $datos->whereDoesntHave('comprobantes.credito', function ($q) {
                return $q->where('fecha_pago', null);
            });
        }
        if (isset($this->request->ocupacion)) {
            $datos->where('id_ocupacion', $this->request->ocupacion);
        }
        $datos = $datos->get();

        Log::info('Resultados de la consulta:', $datos->toArray());

        return $datos;
    }
}
