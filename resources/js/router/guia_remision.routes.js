export default [
    {
        path: "/guias_remision",
        name: "guia_remision-list",
        component: () =>
            import(
                /* webpackChunkName: "abrir-caja" */ "@/pages/procesos/guias_remision/List.vue"
            )
    },
    {
        /* path: "/guia_remision/crear/:id", */
        path: "/guias_remision/crear",
        name: "guia_remision-crear",
        component: () =>
            import(
                /* webpackChunkName: "abrir-caja" */ "@/pages/procesos/guias_remision/Create.vue"
            )
    },
];