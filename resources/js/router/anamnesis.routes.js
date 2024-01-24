export default [
  {
    path: "/anamnesis",
    name: "anamnesis",
    component: () =>
      import(
        /* webpackChunkName: "product-categories" */ "@/pages/procesos/anamnesis/AnamnesisPage.vue"
      )
  },
  {
    path: "/anamnesis-lista",
    name: "anamnesis-lista",
    component: () =>
      import(
        /* webpackChunkName: "product-categories" */ "@/pages/procesos/anamnesis/ListPage.vue"
      )
  },
  {
    path: "/orden-laboratorio",
    name: "orden-laboratorio",
    component: () =>
      import(
        /* webpackChunkName: "product-categories" */ "@/pages/procesos/orden-laboratorio/ListPage.vue"
      )
  },
  {
    path: "/orden-laboratorio/detalle/:id",
    name: "orden-laboratorio-detalle",
    component: () =>
      import(
        /* webpackChunkName: "product-categories" */ "@/pages/procesos/orden-laboratorio/DetallePage.vue"
      )
  }
];
