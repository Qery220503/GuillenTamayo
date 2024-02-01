<?php

use App\Http\Controllers\ComprobanteController;
use App\Http\Controllers\FilesUploadingController;
use App\Http\Controllers\FileUploadController;
use App\Http\Controllers\ReportingController;
use App\Http\Controllers\LibraryController;
use App\Http\Controllers\MailController;
use App\Models\Comprobante;
use App\Models\Sucursales;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Carbon;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/conformidadMonturaPDF/{id}', [App\Http\Controllers\AnamnesisController::class, 'conformidadMonturaPDF']);
Route::get('/ordenLaboratorioPDF/{id}', [App\Http\Controllers\OrdenLaboratorioController::class, 'generarPDF']);
Route::get('/cotizacionPDf/{id}/{detalle?}', [App\Http\Controllers\CotizacionController::class, 'generarPDF']);
Route::get('/comandaPDF/{id}', [ComprobanteController::class, 'generarComanda']);
Route::get('/compraPDF/{id}', [App\Http\Controllers\ComprasController::class, 'generarPDF']);
Route::get('/multifocalEmail', MailController::class);
Route::get('/comprobantes/notas-venta/{id}', [\App\Http\Controllers\ComprobanteController::class, 'generarNotaVentaPDF']);
Route::get('sincwc', [\App\Http\Controllers\API\SincronizacionWC::class, 'index']);
//Route::get('guia_remision', [\App\Http\Controllers\GuiaRemisionController::class, 'index']);
//Route::get('list/clientes', [App\Http\Controllers\GuiaRemisionController::class,'clientes']);

Route::get('/{any}', function () {
    return view('welcome');
})->where('any', '.*');

Auth::routes();
//Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
Route::post('/signin', [App\Http\Controllers\Auth\LoginController::class, 'authenticate']);


