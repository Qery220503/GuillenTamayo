<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use File;
use Response;
use DB;
use Maatwebsite\Excel\Facades\Excel;
 
class DownloadController extends Controller
{
    public function downloadfile()
    {
        $filepath = public_path('images/Reporte_Formato_Compras.xlsx');
        return  Excel::download($filepath, 'Reporte_Formato_Compras.xlsx');
    }
}