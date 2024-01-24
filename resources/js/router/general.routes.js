export default [
    /* PRODUCTOS MAESTROS */
    {
        path: "/sucursales",
        name: "sucursales",
        component: () =>
            import(
        /* webpackChunkName: "product-categories" */ "@/pages/maestros/sucursales/SucursalesPage.vue"
            )
    },
    {
        path: "/proveedores",
        name: "proveedores",
        component: () =>
            import(
        /* webpackChunkName: "product-brands" */ "@/pages/maestros/proveedores/ProveedorPage.vue"
            )
    },
    {
        path: "/proveedores/cuenta-corriente/:proveedor_id",
        name: "proveedores-cuenta-corriente",
        component: () =>
            import(
        /* webpackChunkName: "product-brands" */ "@/pages/maestros/proveedores/CuentaCorriente.vue"
            )
    },
    {
        path: "/doctores",
        name: "doctores",
        component: () =>
            import(
        /* webpackChunkName: "product-categories" */ "@/pages/maestros/doctores/DoctoresPage.vue"
            )
    },
    {
        path: "/precios-lentes",
        name: "precios-lentes",
        component: () =>
            import(
        /* webpackChunkName: "product-categories" */ "@/pages/maestros/precios_lentes/PreciosLentesPage.vue"
            )
    },
    {
        path: "/clinicas",
        name: "clinicas",
        component: () =>
            import(
        /* webpackChunkName: "product-categories" */ "@/pages/maestros/clinicas/ClinicasPage.vue"
            )
    },
    {
        path: "/servicios",
        name: "Servicios",
        component: () =>
            import(
        /* webpackChunkName: "product-categories" */ "@/pages/maestros/servicios/ServiciosPage.vue"
            )
    },
    {
        path: "/ocupaciones",
        name: "ocupaciones",
        component: () =>
            import(
        /* webpackChunkName: "product-categories" */ "@/pages/maestros/ocupaciones/OcupacionesPage.vue"
            )
    },
    {
        path: "/empresas-convenios",
        name: "empresas-convenios",
        component: () =>
            import(
        /* webpackChunkName: "product-categories" */ "@/pages/maestros/empresaConvenios/EmpresaConvenios.vue"
            )
    },
    {
        path: "/egresos",
        name: "Egresos",
        component: () =>
            import(
        /* webpackChunkName: "product-categories" */ "@/pages/procesos/egresos/EgresosPage.vue"
            )
    },

    
    { path: '/cupones', component:()=>import("@/pages/maestros/cupones/CuponesPage.vue") },
];