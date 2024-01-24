export default [
    {
      path: "/reportes/cuadro-general",
      name: "cuadro_general",
      component: () => import(/* webpackChunkName: "users-list" */ "@/pages/reportes/cuadroGeneral/CuadroGeneralPage.vue")
    },
    {
      path: "/reportes/deudas-comprobantes",
      name: "ReporteDeudas",
      component: () => import("@/pages/reportes/deudasComprobantes/deudasComprobantesPage.vue")
    }
  ];
