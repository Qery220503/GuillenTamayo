export default [
    // --- Compras ---
    { path: "/compras", name:"compras", component: () => import("@/pages/procesos/compras/ListPage.vue") },
    { path: "/compras/crear", name:"compras-crear", component: () => import("@/pages/procesos/compras/CreatePage.vue") },
    { path: "/compras/ver/:id", name:"compras-ver", component: () => import("@/pages/procesos/compras/DetailPage.vue") },

    //--- Ventas ---
    { path: "/comprobantes", name:"comprobantes", component:()=>import("@/pages/procesos/ventas/ListPage.vue") },
    { path: "/comprobantes/crear", name:"comprobantes-crear", component:()=>import("@/pages/procesos/ventas/CreatePage.vue") },
    { path: "/comprobantes/ver/:id", name:"comprobantes-ver", component:()=>import("@/pages/procesos/ventas/DetallePage.vue")},

    //--- Cuentas ---
    // { path: '/cuentas-pagar', component:()=>import("@/pages/procesos/cuentas/CuentasPorPagar.vue") },
    //--- Campaigns ---

    { path: "/campaigns", name:"campaigns-list", component:()=>import("@/pages/procesos/Campañas/CampaignPage.vue")},

];
