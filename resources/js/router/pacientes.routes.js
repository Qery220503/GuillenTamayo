export default [
    /* PACIENTES MAESTROS */
    {
        path: "/pacientes",
        name: "pacientes",
        component: () =>
            import(
        /* webpackChunkName: "product-material" */ "@/pages/maestros/pacientes/List.vue"
            )
    },
    {
        path: "/paciente/editar/:id",
        name: "paciente-editar",
        component: () =>
            import(
        /* webpackChunkName: "product-material" */ "@/pages/maestros/pacientes/EditPage.vue"
            )
    },
    {
        path: "/paciente/crear",
        name: "paciente-crear",
        component: () =>
            import(
        /* webpackChunkName: "product-material" */ "@/pages/maestros/pacientes/CreatePage.vue"
            )
    },
    {
        path: "/pacientes/cuenta-corriente/:id",
        name: "pacientes-cuenta-corriente",
        component: () => import(
      /* webpackChunkName: "paciente-cuenta" */ "@/pages/maestros/pacientes/CuentaCorriente.vue"
        )
    }
];