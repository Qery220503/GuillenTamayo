<?php

namespace App\Exports\Reports;

use Maatwebsite\Excel\Concerns\FromCollection;
use App\Models\Comprobante;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class DeudasPendientesExport implements FromCollection, WithHeadings, ShouldAutoSize, WithMapping, WithStyles
{
    /**
     * @return \Illuminate\Support\Collection
     */
    public function collection()
    {
        return Comprobante::where("deuda_saldo", ">", 0)->with(['cliente', 'serie', 'tipo_comprobante'])->get();
    }
    public function headings(): array
    {
        return [
            "FECHA",
            "COMPROBANTE",
            "TIPO COMPROBANTE",
            "CLIENTE",
            "TOTAL COMPROBANTE",
            "PENDIENTE",
            "PAGADO"
        ];
    }

    public function map($registro): array
    {
        return [
            $registro->fecha_emision,
            $registro->serie->serie."-".$registro->correlativo,
            $registro->tipo_comprobante->nombre_tipo_documento,
            $registro->cliente->nombre_razon_social,
            $registro->total,
            $registro->deuda_saldo,
            $registro->total - $registro->deuda_saldo
        ];
    }

    public function styles(Worksheet $sheet)
    {
        $sheet->getStyle('A1:G1')->applyFromArray([
            'font' => [
                'bold' => true,
            ],
        ]);
    }
}
