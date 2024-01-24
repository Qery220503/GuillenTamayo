<?php

namespace App\Exports\Master;

use App\Models\Proveedores;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithMapping;

class ProveedoresExport implements FromCollection, WithHeadings, WithMapping, ShouldAutoSize
{
    private Request $request;
    function __construct(Request $_request) {
        $this->request = $_request;
    }

    public function headings(): array{
        return [
            'ID',
            'Código Proveedor',
            'Proveedor',
            'Nro. Documento',
            'Dirección',
            'Correo Electrónico',
            'Teléfono',
            'Encargado',
            'Nro. Cuenta'
        ];
    }

    public function collection(){
        $data = Proveedores::where('estado', 1);

        if(isset($this->request->nombre)){
            $data->where("nombre", "LIKE", "%".$this->request->nombre."%");
        }
        if(isset($this->request->nro_doc)){
            $data->where("nro_doc", "LIKE", "%".$this->request->nro_doc."%");
        }
        if(isset($this->request->email)){
            $data->where("email", "LIKE", "%".$this->request->email."%");
        }
        if(isset($this->request->telefono)){
            $data->where("telefono", "LIKE", "%".$this->request->telefono."%");
        }
        if(isset($this->request->cod_proveedor)){
            $data->where("cod_proveedor", "LIKE", "%".$this->request->cod_proveedor."%");
        }

        if(isset($this->request->deuda)) {
            if ($this->request->deuda == 'debt') {
                $data->whereHas('compras', function ($q) {
                    $q->where([
                        ['condicion_pago', '!=', 1],
                        ['deuda_saldo', '>', 0],
                        ['estado', 1]
                    ]);
                });
            }
            if ($this->request->deuda == 'no-debt') {
                $data->whereDoesntHave('compras', function ($q) {
                    $q->where([
                        ['condicion_pago', '!=', 1],
                        ['deuda_saldo', '>', 0],
                        ['estado', 1]
                    ]);
                });
            }
        }
        
        return $data->get();
    }

    public function map($data): array{
        return [
            $data->id_proveedor,
            $data->cod_proveedor,
            $data->nombre,
            $data->nro_doc,
            $data->direccion,
            $data->email,
            $data->telefono,
            $data->encargado,
            $data->nro_cuenta,
        ];
    }
}