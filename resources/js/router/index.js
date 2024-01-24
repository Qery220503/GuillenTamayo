import Vue from "vue";
import Router from "vue-router";

//--- Routes ---
import PagesRoutes from "./pages.routes";
import UsersRoutes from "./users.routes";
import ConfigurationRoutes from "./configuration.routes";
import ProductosRoutes from "./productos.routes";
import GeneralRoutes from "./general.routes";
import PacientesRoutes from "./pacientes.routes";
import ProcedimientosRoutes from "./procedimientos.routes";
import AnamnesisRoutes from "./anamnesis.routes";
import CajaRoutes from "./caja.routes";
import CotizacionesRoutes from "./cotizaciones.routes";
import NotasRoutes from "./notas.routes";
import GuiasRemision from "./guia_remision.routes";
import ContabilidadRoutes from "./contabilidad.routes";
import ReportesRoutes from "./reportes.routes";
import EncuestaRoutes from "./encuesta.routes";
//--- Fin ---

Vue.use(Router);

export const routes = [
    { path: "/", redirect: "/dashboard" },
    { path: "/dashboard", name: "dashboard", component:()=>import("@/pages/dashboard/DashboardPage.vue"), gate: "dashboard" },
    { path: "/login", name: "auth-signin", component:()=>import("@/pages/auth/SigninPage.vue"),
        meta: { layout: "auth" }
    },
    ...PagesRoutes,
    ...UsersRoutes,
    ...ConfigurationRoutes,
    ...ProductosRoutes,
    ...GeneralRoutes,
    ...PacientesRoutes,
    ...ProcedimientosRoutes,
    ...AnamnesisRoutes,
    ...NotasRoutes,
    ...GuiasRemision,
    ...CajaRoutes,
    ...CotizacionesRoutes,
    ...ContabilidadRoutes,
    ...ReportesRoutes,
    ...EncuestaRoutes,
    { path: "/blank", name: "blank",  component:()=> import("@/pages/BlankPage.vue") },
    { path: "*", name: "error", component:()=>import("@/pages/error/NotFoundPage.vue"),
        meta: { layout: "error" }
    }
];

const router = new Router({
    mode: "history",
    base: process.env.BASE_URL, // || '/',
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition) return savedPosition;
        return { x: 0, y: 0 };
    },
    routes
});

/**
 * Before each route update
 */
router.beforeEach((to, from, next) => {
    //INTEGRAR VUEX
    let user_data = localStorage.getItem("user_id");
    if (to.path != "/login") {
        if (!user_data) {
            next("/login");
        } else {
            next();
        }
    } else {
        if (user_data) {
            next("/dashboard");
        } else {
            next();
        }
    }
});

router.afterEach((to, from) => { });

export default router;