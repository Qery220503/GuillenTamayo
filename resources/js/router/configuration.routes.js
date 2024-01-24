export default [
  {
    path: "/config",
    component: () =>
      import(
        /* webpackChunkName: "auth-signup" */ "@/pages/configuration/ConfigurationPage.vue"
      )
  },
  {
    path: "/config/frequent-questions",
    component: () =>
      import(
        /* webpackChunkName: "auth-signup" */ "@/pages/configuration/FrequentQuestionsPage.vue"
      )
  },
  {
    path: "/payment-methods",
    component: () =>
      import(
        /* webpackChunkName: "auth-signup" */ "@/pages/configuration/PaymentMethods.vue"
      )
  }
];
