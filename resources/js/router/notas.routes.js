export default [
  {
    path: "/notas",
    name: "notas-list",
    component: () =>
      import(
        /* webpackChunkName: "listar-notas" */ "@/pages/procesos/notas/List.vue"
      )
  },
  {
    path: "/notas/crear/:id",
    name: "notas-crear",
    component: () =>
      import(
        /* webpackChunkName: "crear-notas" */ "@/pages/procesos/notas/Create.vue"
      )
  },
  {
    path: "/notas/ver/:id",
    name: "notas-ver",
    component: () => import(
       /* webpackChunkName: "ver-notas" */ "@/pages/procesos/notas/Show.vue"
    )
  }
  

];
