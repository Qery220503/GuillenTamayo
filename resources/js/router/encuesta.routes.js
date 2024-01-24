export default [
  {
    path: "/encuesta/:comprobante",
    name: "EncuestasPage",
    component: () =>
      import(
        /* webpackChunkName: "users-list" */ "@/pages/procesos/encuestas/EncuestaPage.vue"
    )
  }
];
