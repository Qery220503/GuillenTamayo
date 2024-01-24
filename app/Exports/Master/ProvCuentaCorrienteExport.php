<?php

namespace App\Exports\Master;

use App\Models\Compras;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;
use Maatwebsite\Excel\Concerns\WithMapping;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;

class ProvCuentaCorrienteExport implements FromCollection, WithHeadings, WithMapping, WithColumnFormatting, ShouldAutoSize
{
    private Request $request;
    function __construct(Request $_request) {
        $this->request = $_request;
    }

    public function headings(): array{
        return [
            'Proveedor',
            'Fecha V.',
            'Nro. Documento',
            'Total Deuda',
            'Saldo Pendiente',
            'Total Abonado',
        ];
    }

    public function collection(){
        $data = Compras::with('pagos_deuda')
        ->where([
            ['id_proveedor', $this->request->idProveedor],
            ['condicion_pago', '!=', 1], // 1 = al contado
            ['estado', 1],
        ])->orderBy('fecha_vencimiento','asc');
                
        return $data->get();
    }

    public function map($compra): array{
        return [
            $compra->proveedor->nombre,
            date("d/m/Y", strtotime($compra->fecha_vencimiento)),
            $compra->nro_documento,
            $compra->total,
            $compra->deuda_saldo,
            $compra->deuda_total_abonado,
        ];
    }

    public function columnFormats(): array{
        return [
            'B' => NumberFormat::FORMAT_DATE_DDMMYYYY,
            'D' => NumberFormat::FORMAT_NUMBER_00,
            'E' => NumberFormat::FORMAT_NUMBER_00,
            'F' => NumberFormat::FORMAT_NUMBER_00,
        ];
    }
}