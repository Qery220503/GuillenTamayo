<?php

namespace App\Exports\Process;

use App\Models\Compras;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;
use Maatwebsite\Excel\Concerns\WithColumnFormatting;
use Maatwebsite\Excel\Concerns\WithMapping;

class ComprasExport implements FromCollection, WithHeadings, WithMapping, ShouldAutoSize, WithStyles, WithColumnFormatting
{
    private Request $request;
    function __construct(Request $_request){
        $this->request = $_request;
    }

    public function headings(): array{
        return [
            'Compra',
            'Proveedor',
            'Fecha',
            'Origen del dinero',
            'Total',
            'Subtotal',
            'IGV',
            'Total Abonado',
            'Saldo Pendiente',
            'Condición de pago',
            'Estado'
        ];
    }

    public function collection(){
        $authUser = auth('sanctum')->user();

        $idProveedor = $this->request->id_proveedor;
        $searchTerm = $this->request->searchTerm;
        $fechaInicio = $this->request->fechaInicio;
        $fechaFin = $this->request->fechaFin;
        $condicionPago = $this->request->condicionPago;
        $saldoPendiente = $this->request->saldoPendiente;
        $estado = $this->request->estado;
        $data = Compras::where([
            ["id_sucursal", $authUser->id_sucursal],
        ]);
        
        if (isset($idProveedor)) {
            $data = $data->where('id_proveedor', $idProveedor);
        }
        if (isset($searchTerm)) {
            $data = $data->where(function ($query) use ($searchTerm) {
                $query->where('nombre_proveedor', 'like', "%{$searchTerm}%")
                      ->orWhere('nro_documento', 'like', "%{$searchTerm}%");
            });
        }
        if(isset($fechaInicio)){
            if(isset($fechaFin)){
                $data = $data->whereBetween('fecha', [$fechaInicio, $fechaFin]);
            }else{
                $data = $data->where('fecha', '>=', $fechaInicio);
            }
        }
        if(isset($condicionPago)){
            $data = $data->where('condicion_pago', $condicionPago);
        }
        if(isset($saldoPendiente)){
            if($saldoPendiente == 1){
                $data = $data->where('deuda_saldo', ">", 0);
            }else{
                $data = $data->where('deuda_saldo', 0);
            }
        }
        if(isset($estado)){
            $data = $data->where('estado', $estado);
        }
        
        return $data->get();
    }

    public function map($compra): array{
        $estado = $compra->estado == 1? "Aprobada" : "Anulada";
        if($compra->condicion_pago == 1){
            $estadoDeuda = "Al contado";
        }else{
            if($compra->deuda_saldo > 0 && $compra->estado == 1){
                $estadoDeuda = "Con deuda";

            } else if($compra->deuda_saldo == 0 && $compra->estado == 1){
                $estadoDeuda = "Deuda pagada";

            } else if($compra->estado == 0){
                $estadoDeuda = "Deuda anulada";
            }
        }
        return [
            $compra->serie->serie.'-'.$compra->correlativo,
            $compra->proveedor->nombre,
            date("d/m/Y", strtotime($compra->fecha)),
            $compra->origen_dinero->nombre_origen,
            $compra->total,
            $compra->subtotal,
            $compra->igv,
            $compra->deuda_total_abonado,
            $compra->deuda_saldo,
            $estadoDeuda,
            $estado,
        ];
    }

    public function styles($sheet){
        $sheet->getStyle('A1:K1')->getFont()->setBold(true);
    }
    public function columnFormats(): array{
        return [
            'C' => NumberFormat::FORMAT_DATE_DDMMYYYY,
            'E' => NumberFormat::FORMAT_NUMBER_00,
            'F' => NumberFormat::FORMAT_NUMBER_00,
            'G' => NumberFormat::FORMAT_NUMBER_00,
            'H' => NumberFormat::FORMAT_NUMBER_00,
            'I' => NumberFormat::FORMAT_NUMBER_00,
        ];
    }

}