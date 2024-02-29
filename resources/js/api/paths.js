const PATHS = {
  EXPORT: "/api/exportar/report/",
  LOGIN: "/login", //"api/login",
  LOGOUT: "api/logout",

  //--- User Routes ---
  users: {
    ROOT: "api/users",
    GET_IP: "get_ip",
    SET: "api/users/",
    AUTH: "api/user",
    LIST: "api/users",
    LOGIN: "/signin",
    API_LOGIN: "api/login",
    API_LOGOUT: "api/logout",
    COMBO: "api/combo/usuarios",
  },
  roles: {
    ROOT: "api/roles",
    SET: "api/roles/",
    COMBO: "api/combo/roles",
  },
  permissions: {
    ROOT: "api/permissions",
    SET: "api/permissions/",
    ASSING_PERMISSION: "api/permissions/assignPermissionsToRole/",
  },
  cuadre: {
    ROOT: "api/caja-cuadre",
    SET: "api/caja-cuadre/",
  },
  producto_marca: {
    ROOT: "api/marca",
    SET: "api/marca/",
    COMBO: "api/combo/marca/",
  },
  producto_material: {
    ROOT: "api/material",
    SET: "api/material/",
    COMBO: "api/combo/material/",
  },
  producto_categoria: {
    ROOT: "api/categorias",
    SET: "api/categorias/",
    COMBO: "api/combo/categorias/",
  },
  producto_aro: {
    ROOT: "api/aros",
    SET: "api/aros/",
    COMBO: "api/combo/aros/",
  },
  producto_formas_montura: {
    ROOT: "api/forma-montura",
    SET: "api/forma-montura/",
    COMBO: "api/combo/forma-montura/",
  },
  producto: {
    ROOT: "api/productos",
    SET: "api/productos/",
    LIST: "api/list/productos",
    FILE: "api/producto/send-file",
    SYNC_IND: "api/sincUniqueProd/",
    PRECIOUP: "api/producto/precios",
    GENERATE_CODE: "api/product/generate-code/",
  },
  clinica: {
    ROOT: "api/clinicas",
    SET: "api/clinicas/",
    COMBO: "api/combo/clinicas",
  },
  preciolente: {
    ROOT: "api/precios-lentes",
    SET: "api/precios-lentes/",
    DISENIO: "api/combo/disenio",
    FABRICACION: "api/combo/fabricacion",
    MATERIAL: "api/combo/material",
    SERIE: "api/combo/serie",
    TRATAMIENTO: "api/combo/tratamiento",
    NOMBRE: "api/combo/nombre",
    FOTO: "api/combo/fotocromatico",
    COLOR: "api/combo/color",
    PRECIO: "api/combo/preciolente",
    PRECIOUP: "api/preciolente/precios",
    STOCK: "api/preciolentes/stock",
  },
  doctor: {
    ROOT: "api/doctores",
    SET: "api/doctores/",
    COMBO: "api/combo/doctores",
  },
  sucursal: {
    ROOT: "api/sucursales",
    SET: "api/sucursales/",
    COMBO: "api/combo/sucursales/",
    MANT: "api/mantenimiento/info/",
    MANTUP: "api/mantenimiento/update",
  },
  proveedor: {
    ROOT: "api/proveedores",
    SET: "api/proveedores/",
    COMBO: "api/combo/proveedores/",
    CUENTA_CORRIENTE: "api/proveedor/cuenta-corriente/",
  },
  tipos_documentos: {
    COMBO: "api/combo/tipos-documentos/",
  },
  afectacion_igv: {
    COMBO: "api/combo/codigo-afectacion-igv/",
  },
  empresas_convenio: {
    ROOT: "api/empresas-convenio",
    SET: "api/empresas-convenio/",
    COMBO: "api/combo/empresas-convenio",
  },
  ocupaciones: {
    ROOT: "api/ocupaciones",
    SET: "api/ocupaciones/",
  },
  servicios: {
    ROOT: "api/servicios",
    SET: "api/servicios/",
    COMBO: "api/combo/servicios/",
    DOCUMENTOS: "api/combo/series/",
  },
  ubigeo: {
    DEPARTAMENTOS: "api/combo/departamentos",
    PROVINCIAS: "api/combo/provincias/",
    DISTRITOS: "api/combo/distritos/",
  },
  clientes: {
    ROOT: "api/clientes",
    SET: "api/clientes/",
    OCUPACION: "api/combo/ocupacion",
    RUBRO: "api/combo/rubro-trabajo",
    BUSCAR: "api/buscarPaciente",
    VERIFICAR: "api/verificarCliente",
    DEUDAS_PENDIENTES: "api/clientes/deudas-pendientes/",
    CUENTA: "api/clientes/cuenta/",
    CUENTA_CORRIENTE: "api/clientes/cuenta-corriente/",
  },
  apis: {
    ROOT: "api/buscarDniRuc",
    TIPO_COMPROBANTE: "api/combo/tipo-comprobante",
    TIPO_COMPROBANTE_VENTAS: "api/combo/tipo-comprobante/ventas",
    MEDIO_PAGO: "api/combo/medio-pago",
    ESTADO_COMPRONANTE: "api/combo/comprobante-estados",
    NO_LABORABLES: "api/calendar/dias-no-laborales",
  },
  compras: {
    ROOT: "api/compras",
    SET: "api/compras/",
    SERIES: "api/compra/series",
    PRODUCTOS: "api/compra/product/",
  },
  origenDinero: {
    ROOT: "api/combo/origen-dinero",
  },
  caja: {
    ROOT: "api/caja",
    SET: "api/caja/",
    TURNOS: "api/combo/caja-turnos",
    CERRAR: "api/caja/cerrar/",
    BUSCAR: "api/buscarCaja",
  },
  anamnesis: {
    LIST: "api/anamnesis/list",
    PASO1: "api/anamnesis/paso-1",
    PASO2: "api/anamnesis/paso-2/",
    PASO3: "api/anamnesis/paso-3/",
    SEARCH: "api/anamnesis/search/",
    PACIENTE: "api/anamnesis/paciente/",
    DESCARTAR: "api/anamnesis/descartar/",
  },
  orden_laboratorio: {
    ROOT: "api/orden-laboratorio",
    SET: "api/orden-laboratorio/",
    ESTADOS: "api/combo/ord-lab-estados",
    HISTORIAL: "api/ordenes-laboratorio/ver-recetas/",
    DASHBOARD: "api/ordenes-laboratorio/listDashboard/",
  },
  comprobantes: {
    ROOT: "api/comprobantes",
    SET: "api/comprobantes/",
  },
  egresos: {
    ROOT: "api/egresos",
    SET: "api/egresos/",
  },
  almacen_movimientos: {
    ROOT: "api/almacen-movimientos",
    SET: "api/almacen-movimientos/",
    STOCK: "api/product/stock",
  },
  documento_serie: {
    ROOT: "api/documento-serie",
    SET: "api/documento-serie/",
  },
  serie: {
    ROOT: "api/serie",
    SET: "api/serie/",
    SUCURSALES: "api/sucursales/series/",
  },
  cotizaciones: {
    ROOT: "api/cotizaciones",
    SET: "api/cotizaciones/",
    PACIENTE: "api/cotizaciones/paciente/",
    DETALLE: "api/cotizaciones/detalle/",
  },
  unidades_medida: {
    ROOT: "api/unidad-medida",
  },
  reporte_caja: {
    COMPROBANTES: "api/reportes-caja",
    PAGOS_DEUDAS: "api/reportes-caja/pagos-deudas",
    EGRESOS: "api/caja-egresos",
  },
  notas: {
    TIPOS: "api/notas/tipos/",
    SERIES: "api/notas/series/",
    ROOT: "api/notas",
    SET: "api/notas/",
    ANULACION_OPERACION: "api/notas/anulacion-operacion/",
  },
  credito: {
    PAGAR: "api/cliente/deudas-pagar",
    PAGOS: "api/cliente/deudas-pagos/",
    ANULACION_OPERACION: "api/notas/anulacion-operacion/",
  },
  guia_remision: {
    ROOT: "api/guia_remision",
  },
  encuestas: {
    ROOT: "api/encuestas",
    PREGUNTAS: "api/encuestas/preguntas/",
    RESPONDER: "api/encuestas/responder/",
    COMPROBANTE: "api/encuestas/comprobante/",
  },
  reportes: {
    CUADRO_GENERAL: "api/reportes/cuadro-general",
    DEUDAS_PENDIENTES: "api/reportes/deudas-pendientes",
  },

  cuentas_cobrar: {
    ROOT: "api/cuentas-cobrar",
  },
  cuentas_pagar: {
    ROOT: "api/cuentas-pagar",
  },
  cupones: {
    ROOT: "api/cupones",
    VERIFY: "api/cupones/verificar/",
  },

  eps: {
    ROOT: "api/eps",
  },
  campaigns: {
    ROOT: 'api/campaigns',
    SET: 'api/campaigns/',
    COMBO: 'api/combo/campaigns',
    FACTURAR: 'api/campaigns/facturar',
  }
};

export default PATHS;
