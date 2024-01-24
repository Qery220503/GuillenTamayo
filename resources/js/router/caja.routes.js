export default [
  {
    path: "/abrir-caja",
    name: "abrir-caja",
    component: () =>
      import(
        /* webpackChunkName: "abrir-caja" */ "@/pages/procesos/caja/AbrirCajaPage.vue"
      )
  },
  {
    path: "/ver-caja",
    name: "ver-caja",
    component: () =>
      import(
        /* webpackChunkName: "ver-caja" */ "@/pages/procesos/caja/VerCajaPage.vue"
      )
  },
  {
    path: "/reporte-caja",
    name: "reporte-caja",
    component: () =>
      import(
        /* webpackChunkName: "reporte-caja" */ "@/pages/procesos/caja/ReportesPage.vue"
      )
  }
];
