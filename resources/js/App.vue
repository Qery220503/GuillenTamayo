<template>
  <v-app :locale="locale">
    <!-- Layout component -->
    <component :is="currentLayout" v-if="isRouterLoaded">
      <transition name="fade" mode="out-in">
        <router-view />
      </transition>
      <loading></loading>
    </component>

    <loader v-else></loader>

    <v-snackbar
      v-model="toast.show"
      :timeout="toast.timeout"
      :color="toast.color"
      bottom
    >
      {{ toast.message }}
      <v-btn
        v-if="toast.timeout === 0"
        color="white"
        text
        @click="toast.show = false"
        >{{ $t("common.close") }}</v-btn
      >
    </v-snackbar>
  </v-app>
</template>

<script>
import { mapState } from "vuex";

import Loading from "./components/common/Loading.vue";
import config from "./configs";

// Layouts
import defaultLayout from "./layouts/DefaultLayout";
import simpleLayout from "./layouts/SimpleLayout";
import authLayout from "./layouts/AuthLayout";
import errorLayout from "./layouts/ErrorLayout";
import Loader from "./components/common/Loader";

/*
|---------------------------------------------------------------------
| Main Application Component
|---------------------------------------------------------------------
|
| In charge of choosing the layout according to the router metadata
|
*/
export default {
  data(){
    return {
      locale: 'es-ES'
    }
  },
  components: {
    defaultLayout,
    simpleLayout,
    authLayout,
    errorLayout,
    Loader,
    Loading
  },
  computed: {
    ...mapState("app", ["toast"]),
    isRouterLoaded: function() {
      if (this.$route.name !== null) return true;
      return false;
    },
    currentLayout: function() {
      const layout = this.$route.meta.layout || "default";

      return layout + "Layout";
    }
  },
  head: {
    link: [
      // adds config/icons into the html head tag
      ...config.icons.map(href => ({ rel: "stylesheet", href }))
    ]
  }
};
</script>

<style scoped>
/**
 * Transition animation between pages
 */
.fade-enter-active,
.fade-leave-active {
  transition-duration: 0.2s;
  transition-property: opacity;
  transition-timing-function: ease;
}

.fade-enter,
.fade-leave-active {
  opacity: 0;
}

::-webkit-scrollbar {
  width: 8px !important;
}
::-webkit-scrollbar-button {
  width: 8px !important;
  height: 5px !important;
}
::-webkit-scrollbar-track {
  background: #eee !important;
  border: thin solid lightgray !important;
  box-shadow: 0px 0px 3px #dfdfdf inset !important;
  border-radius: 10px !important;
}
::-webkit-scrollbar-thumb {
  background: #999 !important;
  border: thin solid gray !important;
  border-radius: 10px !important;
}
::-webkit-scrollbar-thumb:hover {
  background: #7d7d7d !important;
}
</style>
