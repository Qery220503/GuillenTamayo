<?php

namespace App\Http\Controllers;

use App\Exports\Master\ClieCuentaCorrienteExport;
use Illuminate\Http\Request;
use App\Exports\Master\ClinicasExport;
use App\Exports\Master\DoctoresExport;
use App\Exports\Master\EmpresasExport;
use App\Exports\Master\ProveedoresExport;
use App\Exports\Master\ServiciosExport;
use App\Exports\Master\PacienteExport;
use App\Exports\Master\PrecioLentesExport;
use App\Exports\Master\PrecioLentesInactivoExport;
use App\Exports\Master\ProductoExport;
use App\Exports\Process\ComprasExport;
use App\Exports\Process\AlmacenExport;
use App\Exports\Master\ProductoStockExport;
use App\Exports\Master\ProvCuentaCorrienteExport;
use Maatwebsite\Excel\Facades\Excel;


class ExportController extends Controller
{
    public function exportarClinicas()
    {
        return Excel::download(new ClinicasExport(), 'Clinicas.xlsx');
    }

    public function exportarDoctores()
    {
        return Excel::download(new DoctoresExport(), 'Doctores.xlsx');
    }

    public function exportarEmpresas()
    {
        return Excel::download(new EmpresasExport(), 'Empresas.xlsx');
    }

    public function exportarServicios()
    {
        return Excel::download(new ServiciosExport(), 'Servicios.xlsx');
    }

    public function exportarPacientes(Request $request)
    {
        return Excel::download(new PacienteExport($request), 'Pacientes.xlsx');
    }

    public function exportarPrecioLentes()
    {
        return Excel::download(new PrecioLentesExport(), 'PrecioLentes-Activo.xlsx');
    }

    public function exportarPrecioLentesInactivo()
    {
        return Excel::download(new PrecioLentesInactivoExport(), 'PrecioLentes-Inactivo.xlsx');
    }

    public function exportarProductos()
    {
        return Excel::download(new ProductoExport(), 'Productos.xlsx');
    }
    public function exportProductosStock()
    {
        return Excel::download(new ProductoStockExport(), 'ProductoStock.xlsx');
    }


    public function exportarAlmacen(Request $request)
    {
        return Excel::download(new AlmacenExport($request), 'AlmacenMovimientos.xlsx');
    }

    public function exportFormatoCompras(Request $request)
    {
        $filepath = public_path('images/Reporte_Formato_Compras.xlsx');
        return Excel::download($filepath, 'Reporte_Formato_Compras.xlsx');
    }

    public function exportarCompras(Request $request)
    {
        $filename = 'ReporteCompras_' . time() . '.xlsx';
        return Excel::download(new ComprasExport($request), $filename);
    }
    public function exportarProveedor(Request $request)
    {
        $filename = 'ReporteProveedores_' . time() . '.xlsx';
        return Excel::download(new ProveedoresExport($request), $filename);
    }
    public function exportarProveedorCuenta(Request $request)
    {
        $filename = 'ProveedorCuentaCorriente_' . time() . '.xlsx';
        return Excel::download(new ProvCuentaCorrienteExport($request), $filename);
    }
    public function exportPacientesCuenta(Request $request)
    {
        $filename = 'ClienteCuentaCorriente_' . time() . '.xlsx';
        return Excel::download(new ClieCuentaCorrienteExport($request), $filename);
    }

}
