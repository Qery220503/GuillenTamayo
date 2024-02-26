<?php

use App\Http\Controllers\ComprobanteController;
use App\Http\Controllers\FilesUploadingController;
use App\Http\Controllers\FileUploadController;
use App\Http\Controllers\ReportingController;
use App\Http\Controllers\LibraryController;
use App\Http\Controllers\MailController;
use App\Mail\CouponMail;
use App\Mail\MultiFocalMail;
use App\Models\Clientes;
use App\Models\Comprobante;
use App\Models\Cupon;
use App\Models\OrdenLaboratorio;
use App\Models\Sucursales;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

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

// Route::get('/correo', function () {
//     $cliente = Clientes::find('2');
//     $cupon=Cupon::find('1');
//     //Mail::to('cuevabeatrice@gmail.com')->queue(new CouponMail($cupon, $cliente));
//     Mail::to('cuevabeatrice@gmail.com')->queue(new MultiFocalMail($cliente));
//     return "enviado";
// });

Route::get('/conformidadMonturaPDF/{id}', [App\Http\Controllers\AnamnesisController::class, 'conformidadMonturaPDF']);
Route::get('/ordenLaboratorioPDF/{id}', [App\Http\Controllers\OrdenLaboratorioController::class, 'generarPDF']);
Route::get('/cotizacionPDf/{id}/{detalle?}', [App\Http\Controllers\CotizacionController::class, 'generarPDF']);
Route::get('/comandaPDF/{id}', [ComprobanteController::class, 'generarComanda']);
Route::get('/compraPDF/{id}', [App\Http\Controllers\ComprasController::class, 'generarPDF']);
Route::get('/multifocalEmail', MailController::class);
Route::get('/comprobantes/notas-venta/{id}', [\App\Http\Controllers\ComprobanteController::class, 'generarNotaVentaPDF']);
Route::get('sincwc', [\App\Http\Controllers\API\SincronizacionWC::class, 'index']);

Route::get('/{any}', function () {
    return view('welcome');
})->where('any', '.*');

Auth::routes();
//Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
Route::post('/signin', [App\Http\Controllers\Auth\LoginController::class, 'authenticate']);


