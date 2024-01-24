// import MyError from './utils/MyError'
import callAPI from "./connector";
import PATHS from "./paths";

const API = {
  users: {
    login(credentials) {
      return callAPI("post", PATHS.users.LOGIN, {
        data: credentials,
        csrf_cookie: true,
      });
    },
    auth() {
      return callAPI("post", PATHS.users.AUTH);
    },
    get_ip() {
      return 0;
    },
    logout() {
      return callAPI("post", PATHS.LOGOUT);
    },

    //CRUD
    list(queryParam) {
      return callAPI("get", PATHS.users.LIST + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.users.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.users.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.users.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.users.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.users.COMBO);
    },
  },

  roles: {
    list(queryParam) {
      return callAPI("get", PATHS.roles.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.roles.ROOT, { data: data });
    },
    read(id) {
      return callAPI("get", PATHS.roles.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.roles.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.roles.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.roles.COMBO);
    },
  },
  permissions: {
    list(queryParam) {
      return callAPI("get", PATHS.permissions.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.permissions.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.permissions.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.permissions.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.permissions.SET + id);
    },
    assignPermissionsToRole(id_role, data) {
      return callAPI("post", PATHS.permissions.ASSING_PERMISSION + id_role, {
        data: data,
      });
    },
  },
  producto_marca: {
    list(queryParam) {
      return callAPI("get", PATHS.producto_marca.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.producto_marca.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.producto_marca.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.producto_marca.SET + id, {
        data: data,
      });
    },
    remove(id) {
      return callAPI("delete", PATHS.producto_marca.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.producto_marca.COMBO);
    },
  },
  producto_material: {
    list(queryParam) {
      return callAPI("get", PATHS.producto_material.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.producto_material.ROOT, {
        data: data,
      });
    },
    show(id) {
      return callAPI("get", PATHS.producto_material.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.producto_material.SET + id, {
        data: data,
      });
    },
    remove(id) {
      return callAPI("delete", PATHS.producto_material.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.producto_material.COMBO);
    },
  },
  producto_categoria: {
    list(queryParam) {
      return callAPI("get", PATHS.producto_categoria.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.producto_categoria.ROOT, {
        data: data,
      });
    },
    show(id) {
      return callAPI("get", PATHS.producto_categoria.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.producto_categoria.SET + id, {
        data: data,
      });
    },
    remove(id) {
      return callAPI("delete", PATHS.producto_categoria.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.producto_categoria.COMBO);
    },
  },
  producto_aro: {
    list(queryParam) {
      return callAPI("get", PATHS.producto_aro.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.producto_aro.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.producto_aro.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.producto_aro.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.producto_aro.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.producto_aro.COMBO);
    },
  },
  producto_formas_montura: {
    list(queryParam) {
      return callAPI("get", PATHS.producto_formas_montura.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.producto_formas_montura.ROOT, {
        data: data,
      });
    },
    show(id) {
      return callAPI("get", PATHS.producto_formas_montura.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.producto_formas_montura.SET + id, {
        data: data,
      });
    },
    remove(id) {
      return callAPI("delete", PATHS.producto_formas_montura.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.producto_formas_montura.COMBO);
    },
  },
  //--- End ---

  productos: {
    update_precios(data) {
      return callAPI("post", PATHS.producto.PRECIOUP, { data: data });
    },
    list(queryParam) {
      return callAPI("get", PATHS.producto.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.producto.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.producto.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.producto.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.producto.SET + id);
    },
    sync(id) {
      return callAPI("get", PATHS.producto.SYNC_IND + id);
    },
    combo() {
      return callAPI("get", PATHS.producto.LIST);
    },
    file(data) {
      return callAPI("post", PATHS.producto.FILE, { data: data });
    },
    generate_code(marca) {
      return callAPI("get", PATHS.producto.GENERATE_CODE + marca);
    },
  },
  sucursales: {
    list(queryParam) {
      return callAPI("get", PATHS.sucursal.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.sucursal.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.sucursal.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.sucursal.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.sucursal.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.sucursal.COMBO);
    },
    mantenimiento() {
      return callAPI("get", PATHS.sucursal.MANT);
    },
    mantenimiento_update(data) {
      return callAPI("post", PATHS.sucursal.MANTUP, { data: data });
    },
  },
  proveedores: {
    list(queryParam) {
      return callAPI("get", PATHS.proveedor.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.proveedor.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.proveedor.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.proveedor.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.proveedor.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.proveedor.COMBO);
    },
    cuenta_corriente(id) {
      return callAPI("get", PATHS.proveedor.CUENTA_CORRIENTE + id);
    },
  },
  doctores: {
    list(queryParam) {
      return callAPI("get", PATHS.doctor.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.doctor.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.doctor.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.doctor.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.doctor.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.doctor.COMBO);
    },
  },
  precioslentes: {
    update_precios(data) {
      return callAPI("post", PATHS.preciolente.PRECIOUP, { data: data });
    },
    stock() {
      return callAPI("get", PATHS.preciolente.STOCK);
    },
    list(queryParam) {
      return callAPI("get", PATHS.preciolente.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.preciolente.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.preciolente.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.preciolente.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.preciolente.SET + id);
    },

    disenio() {
      return callAPI("post", PATHS.preciolente.DISENIO);
    },
    fabricacion(data) {
      return callAPI("post", PATHS.preciolente.FABRICACION, { data: data });
    },
    material(data) {
      return callAPI("post", PATHS.preciolente.MATERIAL, { data: data });
    },
    serie(data) {
      return callAPI("post", PATHS.preciolente.SERIE, { data: data });
    },
    tratamiento(data) {
      return callAPI("post", PATHS.preciolente.TRATAMIENTO, { data: data });
    },
    nombre(data) {
      return callAPI("post", PATHS.preciolente.NOMBRE, { data: data });
    },
    foto(data) {
      return callAPI("post", PATHS.preciolente.FOTO, { data: data });
    },
    color(data) {
      return callAPI("post", PATHS.preciolente.COLOR, { data: data });
    },
    precio(data) {
      return callAPI("post", PATHS.preciolente.PRECIO, { data: data });
    },
  },
  clinicas: {
    list(queryParam) {
      return callAPI("get", PATHS.clinica.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.clinica.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.clinica.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.clinica.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.clinica.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.clinica.COMBO);
    },
  },
  tipos_documentos: {
    combo() {
      return callAPI("get", PATHS.tipos_documentos.COMBO);
    },
  },
  afectacion_igv: {
    combo() {
      return callAPI("get", PATHS.afectacion_igv.COMBO);
    },
  },
  empresas_convenio: {
    list(queryParam) {
      return callAPI("get", PATHS.empresas_convenio.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.empresas_convenio.ROOT, {
        data: data,
      });
    },
    show(id) {
      return callAPI("get", PATHS.empresas_convenio.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.empresas_convenio.SET + id, {
        data: data,
      });
    },
    remove(id) {
      return callAPI("delete", PATHS.empresas_convenio.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.empresas_convenio.COMBO);
    },
  },
  ocupacion: {
    list(queryParam) {
      return callAPI("get", PATHS.ocupaciones.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.ocupaciones.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.ocupaciones.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.ocupaciones.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.ocupaciones.SET + id);
    },
  },
  servicios: {
    list(queryParam) {
      return callAPI("get", PATHS.servicios.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.servicios.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.servicios.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.servicios.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.servicios.SET + id);
    },
    combo() {
      return callAPI("get", PATHS.servicios.COMBO);
    },
    documentos(document) {
      return callAPI("get", PATHS.servicios.DOCUMENTOS + document);
    },
  },
  ubigeo: {
    departamentos() {
      return callAPI("get", PATHS.ubigeo.DEPARTAMENTOS);
    },
    provincias(id) {
      return callAPI("get", PATHS.ubigeo.PROVINCIAS + id);
    },
    distritos(id) {
      return callAPI("get", PATHS.ubigeo.DISTRITOS + id);
    },
  },
  clientes: {
    ocupacion() {
      return callAPI("get", PATHS.clientes.OCUPACION);
    },
    rubro() {
      return callAPI("get", PATHS.clientes.RUBRO);
    },
    list(queryParam) {
      return callAPI("get", PATHS.clientes.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.clientes.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.clientes.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.clientes.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.clientes.SET + id);
    },
    buscar(queryParam) {
      return callAPI("get", PATHS.clientes.BUSCAR + queryParam);
    },
    verificar(data) {
      return callAPI("post", PATHS.clientes.VERIFICAR, { data: data });
    },
    deudas(id) {
      return callAPI("get", PATHS.clientes.DEUDAS_PENDIENTES + id);
    },
    cuenta(id) {
      return callAPI("get", PATHS.clientes.CUENTA + id);
    },
    cuenta_corriente(id) {
      return callAPI("get", PATHS.clientes.CUENTA_CORRIENTE + id);
    },
  },
  apis: {
    dniruc(data) {
      return callAPI("post", PATHS.apis.ROOT, { data: data });
    },
    tipoComprobante() {
      return callAPI("get", PATHS.apis.TIPO_COMPROBANTE);
    },
    tipoComprobanteVentas() {
      return callAPI("get", PATHS.apis.TIPO_COMPROBANTE_VENTAS);
    },
    medioPago() {
      return callAPI("get", PATHS.apis.MEDIO_PAGO);
    },
    estadoComprobante() {
      return callAPI("get", PATHS.apis.ESTADO_COMPRONANTE);
    },
    diasNoLaborales() {
      return callAPI("get", PATHS.apis.NO_LABORABLES);
    },
  },
  compras: {
    list(queryParam) {
      return callAPI("get", PATHS.compras.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.compras.ROOT, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.compras.SET + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.compras.SET + id, { data: data });
    },
    remove(id) {
      return callAPI("delete", PATHS.compras.SET + id);
    },
    series() {
      return callAPI("get", PATHS.compras.SERIES);
    },
  },
  origenDinero: {
    combo() {
      return callAPI("get", PATHS.origenDinero.ROOT);
    },
  },
  caja: {
    abrir(data) {
      return callAPI("post", PATHS.caja.ROOT, { data: data });
    },
    turnos() {
      return callAPI("get", PATHS.caja.TURNOS);
    },
    buscar() {
      return callAPI("get", PATHS.caja.BUSCAR);
    },
    cerrar(id) {
      return callAPI("post", PATHS.caja.CERRAR + id);
    },
  },
  anamnesis: {
    list(queryParam = "") {
      return callAPI("get", PATHS.anamnesis.LIST + queryParam);
    },
    paso1(data) {
      // PACIENTE
      return callAPI("post", PATHS.anamnesis.PASO1, { data: data });
    },
    paso2(id_anamnesis, data) {
      // ORDEN LABORATORIO
      return callAPI("post", PATHS.anamnesis.PASO2 + id_anamnesis, {
        data: data,
      });
    },
    paso3(id_anamnesis, data) {
      //
      return callAPI("post", PATHS.anamnesis.PASO3 + id_anamnesis, {
        data: data,
      });
    },
    search(id) {
      return callAPI("get", PATHS.anamnesis.SEARCH + id);
    },
    paciente(id) {
      return callAPI("get", PATHS.anamnesis.PACIENTE + id);
    },
    descartar(id) {
      return callAPI("post", PATHS.anamnesis.DESCARTAR + id);
    },
  },
  cotizaciones: {
    list(queryParam) {
      return callAPI("get", PATHS.cotizaciones.ROOT + queryParam);
    },
    show() {},
    create(data) {
      return callAPI("post", PATHS.cotizaciones.ROOT, { data: data });
    },
    paciente(id) {
      return callAPI("get", PATHS.cotizaciones.PACIENTE + id);
    },
    detalle(id) {
      return callAPI("get", PATHS.cotizaciones.DETALLE + id);
    },
  },
  orden_laboratorio: {
    list(queryParam) {
      return callAPI("get", PATHS.orden_laboratorio.ROOT + queryParam);
    },
    listDashboard(params) {
      return callAPI("get", PATHS.orden_laboratorio.DASHBOARD + params);
    },
    show(id) {
      return callAPI("get", PATHS.orden_laboratorio.SET + id);
    },
    estados() {
      return callAPI("get", PATHS.orden_laboratorio.ESTADOS);
    },
    historial(id) {
      return callAPI("get", PATHS.orden_laboratorio.HISTORIAL + id);
    },
    update(id, data) {
      return callAPI("put", PATHS.orden_laboratorio.SET + id, {
        data: data,
      });
    },
  },
  comprobante: {
    list(queryParam) {
      return callAPI("get", PATHS.comprobantes.ROOT + queryParam);
    },
    show(id) {
      return callAPI("get", PATHS.comprobantes.SET + id);
    },
    create(data) {
      return callAPI("post", PATHS.comprobantes.ROOT, { data: data });
    },
  },
  egresos: {
    list(queryParam) {
      return callAPI("get", PATHS.egresos.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.egresos.ROOT, { data: data });
    },
    update(id, data) {
      return callAPI("put", PATHS.egresos.SET + id, { data: data });
    },
    show(id) {
      return callAPI("get", PATHS.egresos.SET + id);
    },
    delete(id) {
      return callAPI("delete", PATHS.egresos.SET + id);
    },
  },
  almacen_movimientos: {
    list(queryParam) {
      return callAPI("get", PATHS.almacen_movimientos.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.almacen_movimientos.ROOT, {
        data: data,
      });
    },
    stock() {
      return callAPI("get", PATHS.almacen_movimientos.STOCK);
    },
  },
  documento_serie: {
    list() {
      return callAPI("get", PATHS.documento_serie.ROOT);
    },
  },
  unidad_medida: {
    list() {
      return callAPI("get", PATHS.unidades_medida.ROOT);
    },
  },
  series: {
    create(data) {
      return callAPI("post", PATHS.serie.ROOT, { data: data });
    },
    delete(id) {
      return callAPI("delete", PATHS.serie.SET + id);
    },
    sucursal(id) {
      return callAPI("get", PATHS.serie.SUCURSALES + id);
    },
  },
  reportes_caja: {
    comprobantes(queryParam) {
      return callAPI("get", PATHS.reporte_caja.COMPROBANTES + queryParam);
    },
    pagosDeudas(queryParam) {
      return callAPI("get", PATHS.reporte_caja.PAGOS_DEUDAS + queryParam);
    },
    egresos(queryParam) {
      return callAPI("get", PATHS.reporte_caja.EGRESOS + queryParam);
    },
  },
  notas: {
    tipos(tipo) {
      return callAPI("get", PATHS.notas.TIPOS + tipo);
    },
    series(tipo) {
      return callAPI("get", PATHS.notas.SERIES + tipo);
    },
    list(queryParam) {
      return callAPI("get", PATHS.notas.ROOT + queryParam);
    },
    create(data) {
      return callAPI("post", PATHS.notas.ROOT, {
        data: data,
      });
    },
    show(id) {
      return callAPI("get", PATHS.notas.SET + id);
    },
    anulacionOperacion(id) {
      return callAPI("post", PATHS.notas.ANULACION_OPERACION + id);
    },
  },
  credito: {
    pagar(data) {
      return callAPI("post", PATHS.credito.PAGAR, { data: data });
    },
    pagos(data) {
      return callAPI("get", PATHS.credito.PAGOS + data);
    },
  },
  guia_remision: {
    list(queryParam) {
      return callAPI("get", PATHS.guia_remision.ROOT + queryParam);
    },
    create(data) {
      return callApi("post", PATHS.guia_remision.ROOT, {
        data: data,
      });
    },
  },
  encuestas: {
    create(data) {
      return callAPI("post", PATHS.encuestas.ROOT, { data: data });
    },

    preguntas(id) {
      return callAPI("get", PATHS.encuestas.PREGUNTAS + id);
    },
    comprobante(id) {
      return callAPI("get", PATHS.encuestas.COMPROBANTE + id);
    },
    responder(id, data) {
      return callAPI("post", PATHS.encuestas.RESPONDER + id, { data: data });
    },
  },
  reportes: {
    cuadroGeneral(params) {
      return callAPI("get", PATHS.reportes.CUADRO_GENERAL + params);
    },
    deudasPendientes(params) {
      return callAPI("get", PATHS.reportes.DEUDAS_PENDIENTES + params);
    },
  },

  cuentas_cobrar: {
    list(params) {
      return callAPI("get", PATHS.cuentas_cobrar.ROOT + params);
    },
  },
  cuentas_pagar: {
    list(params) {
      return callAPI("get", PATHS.cuentas_pagar.ROOT + params);
    },
  },

  cupones: {
    list(params) {
      return callAPI("get", PATHS.cupones.ROOT + params);
    },
    verify(code) {
      return callAPI("get", PATHS.cupones.VERIFY + code);
    },
  },

  eps: {
    list() {
      return callAPI("get", PATHS.eps.ROOT);
    },
  },
};

export default API;
