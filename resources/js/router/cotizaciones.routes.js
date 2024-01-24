export default [
    {
      path: "/cotizaciones",
      name: "CotizacionesPage",
      component: () => import(
        /* webpackChunkName: "product-categories" */ "@/pages/procesos/cotizaciones/CotizacionList.vue"
      )
    },
    {
      path: "/cotizaciones/:id_cliente/anamnesis/:id_anamnesis?",
      name: "CotizacionesCreate",
      component: () =>
        import(
          /* webpackChunkName: "product-categories" */ "@/pages/procesos/cotizaciones/CotizacionPage.vue"
        )
    },
    
];
  