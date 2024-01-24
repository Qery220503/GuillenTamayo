export default [
  {
    path: "/contabilidad/reportes",
    name: "contabilidad-reportes",
    component: () =>
      import(
        /* webpackChunkName: "abrir-caja" */ "@/pages/procesos/contabilidad/reportes/Reportes.vue"
      )
  }
];
