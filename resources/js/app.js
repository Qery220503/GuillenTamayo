import "./bootstrap";
import Vue from "vue";
import App from "./App.vue";

// VUEX - https://vuex.vuejs.org/
import store from "./store";

// VUE-ROUTER - https://router.vuejs.org/
import router from "./router";

// PLUGINS
import vuetify from "./plugins/vuetify";
import i18n from "./plugins/vue-i18n";
import "./plugins/vue-google-maps";
import "./plugins/vue-shortkey";
import "./plugins/vue-head";
import "./plugins/vue-gtag";
import "./plugins/apexcharts";
import "./plugins/echarts";
import "./plugins/animate";
import "./plugins/clipboard";
import "./plugins/moment";

// FILTERS
import "./filters/capitalize";
import "./filters/lowercase";
import "./filters/uppercase";
import "./filters/formatCurrency";
import "./filters/formatDate";
import "./filters/formatTime";
import "./filters/formatFixed";
import "./filters/formatCorrelative";

// STYLES
// Main Theme SCSS
import "../sass/theme.scss";

// Animation library - https://animate.style/
import "animate.css/animate.min.css";

// Set this to false to prevent the production tip on Vue startup.
Vue.config.productionTip = false;

import VueSweetalert2 from "vue-sweetalert2";


//--- Casl ---
import { abilitiesPlugin } from '@casl/vue';
import ability from './plugins/ability';

Vue.use(abilitiesPlugin, ability)
//--- End ---


/*
|---------------------------------------------------------------------
| Main Vue Instance
|---------------------------------------------------------------------
|
| Render the vue application on the <div id="app"></div> in index.html
|
| https://vuejs.org/v2/guide/instance.html
|
*/
import VueSmooth from "vue2-smooth-scroll";

//--- Global Components ---
Vue.component(
  "custom-breadcrumbs",
  require("./components/common/CustomBreadcrumbs.vue").default
);

Vue.component(
  "PagoIndividualModal",
  require("./pages/procesos/cuentas/components/PagoIndividualModal.vue").default
);
Vue.component(
  "PagoGrupalModal",
  require("./pages/procesos/cuentas/components/PagoGrupalModal.vue").default
);
Vue.component(
  "PagoDetailModal",
  require("./pages/procesos/cuentas/components/PagoDetailModal.vue").default
);
//--- End ---

Vue.use(VueSmooth);
Vue.use(VueSweetalert2);

Vue.mixin({
    methods: {
        //--- Date Formatting ---
        todaysDateDefault(add_days=0){
            var todaysDate = new Date;
            todaysDate.setDate(todaysDate.getDate() + add_days);

            return todaysDate.getFullYear()
            +"-"+(((todaysDate.getMonth()+1) < 10)?"0":"") + (todaysDate.getMonth()+1)
            +"-"+((todaysDate.getDate() < 10)?"0":"") + todaysDate.getDate();
        },
        todaysDateShort(){
            var date = new Date;
            return date.getFullYear().toString().substring(2,4)
            +"-"+(((date.getMonth()+1) < 10)?"0":"") + (date.getMonth()+1);
        },
        formatDefaultDate(date){

            return date.getFullYear()
            +"-"+(((date.getMonth()+1) < 10)?"0":"") + (date.getMonth()+1)
            +"-"+((date.getDate() < 10)?"0":"") + date.getDate();
        },
        formatDate (date) {
            if (!date) return null

            const [year, month, day] = date.split('-')
            return `${day}-${month}-${year}`
        },
        //--- End ---

        //--- Global Methods ---
        async checkIfCashIsOpen(redirect_route="") {
            try {
                const response = await API.caja.buscar();
                let isCashOpen = response.data.success;
                if (!isCashOpen) {
                    this.$router.push({
                        path: "/abrir-caja",
                        query: { redirect: redirect_route }
                    });
                }
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        //--- End ---
    },
});

export default new Vue({
  i18n,
  vuetify,
  router,
  store,
  render: h => h(App)
}).$mount("#app");
