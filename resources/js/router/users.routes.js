export default [
  {
    path: "/users",
    redirect: "read_users" //'users-list'
  },
  {
    path: "/users/list",
    name: "read_users", //'users-list',
    component: () =>
      import(/* webpackChunkName: "users-list" */ "@/pages/users/UsersPage.vue")
  },
  {
    path: "/roles_permisos",
    name: "read_roles",
    component: () =>
        import(
            /* webpackChunkName: "blank" */ "@/pages/roles_permissions/RolesPermissionsPage.vue"
        )
  }
];
