<?php

namespace App\Exports\Master;

use App\Models\Comprobante;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;
use Maatwebsite\Excel\Concerns\WithMapping;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;

class ClieCuentaCorrienteExport implements FromCollection, WithHeadings, WithMapping, WithColumnFormatting, ShouldAutoSize
{
    private Request $request;
    function __construct(Request $_request)
    {
        $this->request = $_request;
    }

    public function headings(): array
    {
        return [
            'Nombre Cliente',
            'Fecha V.',
            'Nro. Documento',
            'Total Deuda',
            'Saldo Pendiente',
            'Total Abonado',
        ];
    }

    public function collection()
    {
        $data = Comprobante::with(['medio_pago', 'cliente'])
            ->where([
                ['id_cliente', $this->request->idCliente],
                ['condicion_pago', '!=', 1], // 1 = al contado
            ])->orderBy('fecha_vencimiento', 'asc');

        return $data->get();
    }

    public function map($compra): array
    {
        return [
            $compra->nombre_cliente,
            date("d/m/Y", strtotime($compra->fecha_vencimiento)),
            $compra->nro_documento,
            $compra->total,
            $compra->saldo,
            $compra->total_abonado,
        ];
    }

    public function columnFormats(): array
    {
        return [
            'B' => NumberFormat::FORMAT_DATE_DDMMYYYY,
            'D' => NumberFormat::FORMAT_NUMBER_00,
            'E' => NumberFormat::FORMAT_NUMBER_00,
            'F' => NumberFormat::FORMAT_NUMBER_00,
        ];
    }
}