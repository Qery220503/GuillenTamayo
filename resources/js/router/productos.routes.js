export default [
  /* PRODUCTOS MAESTROS */
  {
    path: "/productos/categorias",
    name: "categorias-producto",
    component: () =>
      import(
        /* webpackChunkName: "product-categories" */ "@/pages/maestros/categorias/CategoriasPage.vue"
      )
  },
  {
    path: "/productos/marcas",
    name: "marcas-producto",
    component: () =>
      import(
        /* webpackChunkName: "product-brands" */ "@/pages/maestros/marcas/MarcasPage.vue"
      )
  },
  {
    path: "/productos/materiales",
    name: "material-producto",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/maestros/material/MaterialPage.vue"
      )
  },
  {
    path: "/productos/aros",
    name: "aros-producto",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/maestros/aros/ArosPage.vue"
      )
  },
  {
    path: "/productos/monturas",
    name: "monturas-producto",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/maestros/monturas/MonturasPage.vue"
      )
  },
  {
    path: "/producto",
    name: "producto",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/maestros/productos/List.vue"
      )
  },
  {
    path: "/producto/editar/:id",
    name: "producto-editar",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/maestros/productos/EditPage.vue"
      )
  },
  {
    path: "/producto/crear",
    name: "producto-crear",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/maestros/productos/CreatePage.vue"
      )
  },
  /* PRODUCTOS MAESTROS */

  /* ALMACEN DE PRODUCTOS */
  {
    path: "/almacen-movimientos",
    name: "almacen-movimientos",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/procesos/almacen_movimientos/ListPage.vue"
      )
  },
  {
    path: "/stock-productos",
    name: "stock-productos",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/procesos/almacen_movimientos/StockProductos.vue"
      )
  },
    {
        path: "/traslado-productos",
        name: "traslado-productos",
        component: () =>
        import(
            /* webpackChunkName: "product-material" */ "@/pages/procesos/traslado_productos/TrasladoProductos.vue"
        )
    },
  {
    path: "/mantenimiento/precios-productos",
    name: "mantenimiento-precios-productos",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/procesos/almacen_movimientos/ListaPreciosProductos.vue"
      )
  },
  {
    path: "/mantenimiento/precios-lentes",
    name: "mantenimiento-precios-lentes",
    component: () =>
      import(
        /* webpackChunkName: "product-material" */ "@/pages/procesos/almacen_movimientos/ListaPreciosLentes.vue"
      )
  }
];
