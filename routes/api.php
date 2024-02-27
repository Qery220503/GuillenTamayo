<?php
namespace App\Http\Controllers;
use App\Http\Controllers\Auth\ApiAuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Resources\V1\ResponseResource;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/*
|--------------------------------------------------------------------------
| AUTH API Routes
|--------------------------------------------------------------------------
*/

Route::post("login", [ApiAuthController::class,"login"]);

Route::get('/exportClinica', [ExportController::class, 'exportarClinicas']);
Route::get('/exportDoctores', [ExportController::class, 'exportarDoctores']);
Route::get('/exportEmpresas', [ExportController::class, 'exportarEmpresas']);
Route::get('/exportProveedor', [ExportController::class, 'exportarProveedor']);
Route::get('/exportProveedorCuenta', [ExportController::class, 'exportarProveedorCuenta']);
Route::get('/exportServicios', [ExportController::class, 'exportarServicios']);
Route::get('/exportPacientes', [ExportController::class, 'exportarPacientes']);
Route::get('/exportPacientesCuenta', [ExportController::class, 'exportPacientesCuenta']);
Route::get('/exportPrecioLentes', [ExportController::class, 'exportarPrecioLentes']);
Route::get('/exportPrecioLentesInactivo', [ExportController::class, 'exportarPrecioLentesInactivo']);
Route::get('/exportProductos', [ExportController::class, 'exportarProductos']);
Route::get('/exportProductosStock', [ExportController::class, 'exportProductosStock']);
Route::get('/exportCompras', [ExportController::class, 'exportarCompras']);
Route::get('/exportStockMovimientos', [ExportController::class, 'exportarAlmacen']);
Route::get('/exportReporteFormatoCompras',[ExportController::class,'exportFormatoCompras']);
Route::get('/exportCuadroGeneral', [ReportesController::class, 'cuadroGeneralExcel']);
Route::get('/exportDeudasComprobantes', [ReportesController::class, 'deudasPendientesExcel']);
//API ADMIN PANEL
//Route::group(['middleware' => ['auth:sanctum']], function ()
Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::post('logout', [ApiAuthController::class,'logout']);
    Route::get('/user', function (Request $request) {
        return new ResponseResource(auth('sanctum')->user());
    });
    Route::post('user', [UserController::class, 'auth']);

    Route::apiResource('permissions', PermissionsController::class);
    Route::apiResource('users', UserController::class);
    Route::apiResource('roles', RoleController::class);
    Route::apiResource('marca', ProductosMarcaController::class);
    Route::apiResource('material', ProductosMaterialController::class);
    Route::apiResource('categorias', ProductosCategoriaController::class);
    Route::apiResource('aros', ProductoTipoAroController::class);
    Route::apiResource('forma-montura', ProductoFormaMonturaController::class);
    Route::apiResource('serie', SerieController::class);
    Route::apiResource('sucursales', SucursalesController::class);
    Route::apiResource('productos', ProductosController::class);
    Route::apiResource('proveedores', ProveedoresController::class);
    Route::apiResource('doctores', DoctoresController::class);
    Route::apiResource('clinicas', ClinicasController::class);
    Route::apiResource('empresas-convenio', EmpresaConvenioController::class);
    Route::apiResource('ocupaciones', OcupacionController::class);
    Route::apiResource('servicios', ServiciosController::class);
    Route::apiResource('precios-lentes', PreciosLentesController::class);
    Route::apiResource('clientes', ClientesController::class);
    Route::apiResource('compras', ComprasController::class);
    Route::apiResource('caja', CajaController::class);
    Route::apiResource('orden-laboratorio', OrdenLaboratorioController::class);
    Route::apiResource('comprobantes', ComprobanteController::class);
    Route::apiResource('egresos', EgresosController::class);
    Route::apiResource('almacen-movimientos', StockController::class);
    Route::apiResource('cotizaciones', CotizacionController::class);
    Route::apiResource('notas', NotasController::class);
    Route::apiResource('cupones', CuponesController::class);
    // Route::apiResource('cuentas-cobrar', CuentasCobrarController::class);
    Route::apiResource('cuentas-pagar', CuentasPagarController::class);
    Route::apiResource('caja-cuadre', CajaCuadreController::class);

    Route::get('getDashboardInfo', [DashboardController::class, 'getDashboardInfo']);

    Route::post('cuentas-pagar/pagoGrupal/{deudas}', [CuentasPagarController::class, 'pagoGrupal']);
    Route::post('permissions/assignPermissionsToRole/{id}', [PermissionsController::class,'assignPermissionsToRole']);
    Route::get('combo/roles/', [RoleController::class,'combo']);

    Route::apiResource('guia_remision', GuiaRemisionController::class);
    Route::apiResource('encuestas', EncuestaController::class);
    Route::get('encuestas/comprobante/{comprobante}', [EncuestaController::class, 'encuesta']);
    Route::get('encuestas/preguntas/{comprobante}', [EncuestaController::class, 'preguntas']);
    Route::post('encuestas/responder/{encuesta}', [EncuestaController::class, 'responder']);


    Route::get('list/clientes', [GuiaRemisionController::class,'clientes']);

    Route::get('combo/marca/', [ProductosMarcaController::class,'combo']);
    Route::get('combo/material/', [ProductosMaterialController::class,'combo']);
    Route::get('combo/categorias/', [ProductosCategoriaController::class,'combo']);
    Route::get('combo/aros/', [ProductoTipoAroController::class,'combo']);
    Route::get('combo/forma-montura/', [ProductoFormaMonturaController::class,'combo']);
    Route::get('combo/sucursales/', [SucursalesController::class,'combo']);
    Route::get('combo/tipos-documentos/', [ServicesController::class,'tipos_documentos']);
    Route::get('combo/codigo-afectacion-igv/', [ServicesController::class,'codigo_afectacion_igv']);
    Route::get('combo/servicios/', [ServiciosController::class,'combo']);
    Route::get('combo/series/{documento}', [ServiciosController::class, 'documentosSeries']);
    Route::get('combo/departamentos/', [ServicesController::class,'departamentos']);
    Route::get('combo/provincias/{id_departamento}', [ServicesController::class,'provincias']);
    Route::get('combo/distritos/{provincia}', [ServicesController::class,'distritos']);

    Route::get('combo/ocupacion/', [ServicesController::class,'ocupacion']);
    Route::post('buscarDniRuc', [ServicesController::class,'buscarDniRuc']);
    Route::get('list/productos', [ServicesController::class,'productos']);
    Route::get('compra/series', [ComprasController::class, 'getComprasSeries']);
    Route::get('compra/product/{id}', [ComprasController::class, 'trackProduct']);
    Route::get('combo/proveedores', [ProveedoresController::class,'combo']);
    Route::get('proveedor/cuenta-corriente/{id}', [ProveedoresController::class,'cuenta_corriente']);
    Route::get('combo/origen-dinero', [ServicesController::class,'origen_dinero']);
    Route::post('producto/send-file', [ProductosController::class,'send_file']);
    Route::get('product/generate-code/{marca}', [ProductosController::class,'GenerateProductCode']);
    Route::post('searchProvider', [ServicesController::class,'searchProvider']);
    Route::get('combo/clinicas', [ServicesController::class,'clinicas']);
    Route::get('combo/doctores', [ServicesController::class,'doctores']);
    Route::get('combo/empresas-convenio', [ServicesController::class,'empresas_convenio']);
    Route::get('combo/tipo-comprobante', [ServicesController::class,'tipo_comprobante']);
    Route::get('combo/tipo-comprobante/ventas', [ServicesController::class,'tipo_comprobante_venta']);
    Route::get('combo/medio-pago', [ServicesController::class,'medio_pago']);
    Route::get('combo/caja-turnos', [ServicesController::class,'caja_turnos']);
    Route::get('buscarPaciente', [ServicesController::class,'buscarPaciente']);
    Route::get('buscarCaja', [CajaController::class,'open']);
    Route::get('combo/ord-lab-estados', [ServicesController::class,'orden_lab_estados']);
    Route::get('combo/usuarios', [ServicesController::class,'usuarios']);
    Route::get('combo/comprobante-estados', [ServicesController::class,'comprobante_estados']);
    Route::get('reportes-caja', [ReporteCajaController::class, 'comprobantes']);
    Route::get('reportes-caja/pagos-deudas', [ReporteCajaController::class, 'pagosDeudas']);

    Route::get('sincUniqueProd/{id_prod}', [API\SincronizacionWC::class, 'sincUniqueProd']);

    Route::post('verificarCliente', [ClientesController::class, 'searchClient']);

    Route::post('anamnesis/paso-1', [AnamnesisController::class,'paso1']);
    Route::post('anamnesis/paso-2/{id_anamnesis}', [AnamnesisController::class,'paso2']);
    Route::post('anamnesis/paso-3/{id_anamnesis}', [AnamnesisController::class,'paso3']);

    Route::post('anamnesis/conformidad_montura', [AnamnesisController::class, 'conformidadMontura']);
    Route::post('anamnesis/descartar/{id}', [AnamnesisController::class, 'descartarAnamnesis']);
    Route::get('anamnesis/search/{id}', [AnamnesisController::class,'searchAnamnesis']);
    Route::get('anamnesis/paciente/{id}', [AnamnesisController::class, 'searchAnamnesisPaciente']);
    Route::get('anamnesis/list', [AnamnesisController::class, 'obtenerAnamnesis']);

    Route::get('unidad-medida', UnidadMedidaController::class);

    // Precio lentes
    Route::get('caja/detalles/{id_caja}', [CajaController::class, 'cajaDetalles']);
    Route::post('caja/cerrar/{id_caja}', [CajaController::class, 'close']);

    Route::get('ultima-caja', [CajaController::class, 'ultimaCaja']);
    Route::get('caja-egresos', [ReporteCajaController::class, 'egresosReporte']);
    Route::get('cajas/fecha', [CajaController::class, 'cajasPorFechas']);

    Route::get('cajas-pendientes', [CajaController::class, 'cajasPendientes']);
    Route::post('combo/disenio', [PreciosLentesController::class,'getDisenio']);
    Route::post('combo/fabricacion', [PreciosLentesController::class,'getFabricacion']);
    Route::post('combo/material', [PreciosLentesController::class,'getMaterial']);
    Route::post('combo/serie', [PreciosLentesController::class,'getSerie']);
    Route::post('combo/tratamiento', [PreciosLentesController::class,'getTratamiento']);
    Route::post('combo/nombre', [PreciosLentesController::class,'getNombre']);
    Route::post('combo/fotocromatico', [PreciosLentesController::class,'getFotocromatico']);
    Route::post('combo/color', [PreciosLentesController::class,'getColor']);
    Route::post('combo/preciolente', [PreciosLentesController::class,'getPrecioLentes']);

    Route::get('ordenes-laboratorio/ver-recetas/{id}', [OrdenLaboratorioController::class,'historial']);
    Route::get('ordenes-laboratorio/listDashboard', [OrdenLaboratorioController::class,'listDashboard']);

    Route::get('calendar/dias-no-laborales', [ServicesController::class,'dias_no_laborales']);

    Route::get('documento-serie', DocumentoSerieController::class);
    Route::get('sucursales/series/{id}', [SucursalesController::class, 'series']);
    Route::get('cotizaciones/paciente/{id}', [CotizacionController::class, 'cotizacionesPacientes']);
    Route::get('cotizaciones/detalle/{id}', [CotizacionController::class,  'detallesCotizacion']);

    Route::get('notas/tipos/{nota}', [NotasController::class, 'tiposNota']);
    Route::get('notas/series/{tipo}', [NotasController::class, 'seriesNotas']);
    Route::get('product/stock', [ProductosController::class, 'stock']);
    Route::get('preciolentes/stock', [PreciosLentesController::class, 'stock']);

    //--- Traslado de Productos ---
    Route::get('traslado-productos/indexTrasladoSucursal', [TrasladoProductosController::class,'indexTrasladoSucursal']);
    Route::post('traslado-productos/storeTrasladoSucursal', [TrasladoProductosController::class,'storeTrasladoSucursal']);
    Route::get('traslado-productos/indexTrasladoUbicacion', [TrasladoProductosController::class,'indexTrasladoUbicacion']);
    Route::post('traslado-productos/storeTrasladoUbicacion', [TrasladoProductosController::class,'storeTrasladoUbicacion']);
    //--- Fin ---

    Route::get('mantenimiento/info/', [SucursalesController::class,'getMantenimiento']);
    Route::post('mantenimiento/update', [SucursalesController::class,'updateMantenimiento']);
    Route::post('preciolente/precios', [PreciosLentesController::class,'updatePrecios']);
    Route::post('producto/precios', [ProductosController::class, 'updatePrecios']);
    Route::post('notas/anulacion-operacion/{nota}', [NotasController::class, 'anulacionOperacion']);

    Route::get('clientes/deudas-pendientes/{cliente}', [ClientesController::class, 'deudasPendientes']);
    Route::post('cliente/deudas-pagar', [ComprobanteCreditoController::class, 'pagar']);
    Route::get('cliente/deudas-pagos/{comprobante}', [ComprobanteCreditoController::class, 'pagos']);
    Route::get('clientes/cuenta-corriente/{id}', [ClientesController::class, 'cuenta_corriente']);
    Route::post('cliente/pagoGrupal/{ids}', [ComprobanteCreditoController::class, 'cuentas_pagar']);

    Route::get('cupones/verificar/{codigo}', [CuponesController::class, 'verify']);
    /* Reportes */
    Route::get('reportes/cuadro-general', [ReportesController::class, 'cuadroGeneral']);
    Route::get('reportes/deudas-pendientes', [ReportesController::class, 'deudasPendientes']);

    Route::get('eps', EpsController::class);
});
