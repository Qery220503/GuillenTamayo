<template>
  <div
    v-shortkey="['ctrl', '/']"
    class="d-flex flex-grow-1"
    @shortkey="onKeyup"
  >

    <!-- Navigation -->
    <v-navigation-drawer
      v-model="drawer"
      app
      floating
      class="elevation-1"
      :right="$vuetify.rtl"
      dark
      color="#043c77"
    >
      <!-- Navigation menu info -->
      <template v-slot:prepend>
        <div class="pa-2 align-center">
          <div class="align-center" style="text-align: center; display: flex; justify-content: center; align-items: center;"><!-- style="padding: 20px 10px;"-->
            <img width="200" src="/images/illustrations/logo-white.png"/>
          </div>
        </div>
      </template>

      <!-- Navigation menu -->
      <main-menu :menu="navigation.menu" />

      <!-- Navigation menu footer -->
      <template v-slot:append>
        <!-- Footer navigation links -->
        <div class="pa-1 text-center">
          <v-btn
            v-for="(item, index) in navigation.footer"
            :key="index"
            :href="item.href"
            :target="item.target"
            small
            text
          >
            {{ item.key ? $t(item.key) : item.text }}
          </v-btn>
        </div>
      </template>

    </v-navigation-drawer>


    <!-- Toolbar -->
    <!-- :color="isToolbarDetached ? 'surface' : undefined"-->
    <v-app-bar class="toolbar-content"
        :color="isToolbarDetached ? 'surface' : undefined"
        :flat="isToolbarDetached"
        app
        dark>
    <!--
    :light="toolbarTheme === 'light'"
    :dark="toolbarTheme === 'dark'"
    -->
        <v-card color="#043c77" class="flex-grow-1 d-flex" :class="[isToolbarDetached ? 'pa-1 mt-3 mx-1' : 'pa-1 mx-1 mt-2']" :flat="!isToolbarDetached">
        <div class="d-flex flex-grow-1 align-center">

            <!-- search input mobile -->
            <!--<v-text-field
        v-if="showSearch"
        append-icon="mdi-close"
        placeholder="Search"
        prepend-inner-icon="mdi-magnify"
        hide-details
        solo
        flat
        autofocus
        @click:append="showSearch = false"
        ></v-text-field>-->

            <div class="d-flex flex-grow-1 align-center">
            <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

            <v-spacer class="d-none d-lg-block"></v-spacer>

            <!-- search input desktop -->
            <!--<v-text-field
            ref="search"
            class="mx-1 hidden-xs-only"
            :placeholder="$t('menu.search')"
            prepend-inner-icon="mdi-magnify"
            hide-details
            filled
            rounded
            dense
        ></v-text-field>

        <v-spacer class="d-block d-sm-none"></v-spacer>

        <v-btn class="d-block d-sm-none" icon @click="showSearch = true">
            <v-icon>mdi-magnify</v-icon>
        </v-btn>

        <toolbar-language />

        <div class="hidden-xs-only mx-1">
            <toolbar-currency />
        </div>

        <toolbar-apps />

        <div :class="[$vuetify.rtl ? 'ml-1' : 'mr-1']">
            <toolbar-notifications />
        </div>-->
                <v-spacer></v-spacer>
            <span>¡Hola {{ username.name }}!</span>
            <toolbar-user />
            </div>
        </div>
        </v-card>
    </v-app-bar>

    <v-main>
      <v-container class="fill-height" :fluid="!isContentBoxed">
        <v-layout>
          <slot></slot>
        </v-layout>
      </v-container>

      <v-footer app inset>
        <v-spacer></v-spacer>
        <div class="overline">
          Guillen Tamayo 2023
        </div>
      </v-footer>
    </v-main>
  </div>
</template>

<script>
import { mapState } from 'vuex'

// navigation menu configurations
import config from '../configs'

import MainMenu from '../components/navigation/MainMenu'
import ToolbarUser from '../components/toolbar/ToolbarUser'
import ToolbarApps from '../components/toolbar/ToolbarApps'
import ToolbarLanguage from '../components/toolbar/ToolbarLanguage'
import ToolbarCurrency from '../components/toolbar/ToolbarCurrency'
import ToolbarNotifications from '../components/toolbar/ToolbarNotifications'

export default {
  components: {
    MainMenu,
    ToolbarUser,
    ToolbarApps,
    ToolbarLanguage,
    ToolbarCurrency,
    ToolbarNotifications
  },
  data() {
    return {
      drawer: null,
      showSearch: false,
      username: {},
      navigation: config.navigation
    }
  },
  created() {
    //INTEGRAR VUEX
    if(localStorage.getItem('user_data')){
        this.username = JSON.parse(localStorage.getItem('user_data'));
    }
  },
  mounted() {
    // if(!this.$can(this.$route.name, 'all')){
    //   this.$router.push('/error/not-found')
    // }
  },
  computed: {
    ...mapState('app', ['product', 'isContentBoxed', 'menuTheme', 'toolbarTheme', 'isToolbarDetached'])
  },
  methods: {
    onKeyup(e) {
      this.$refs.search.focus()
    }
  }
}
</script>

<style scoped>
.toolbar-content {
    z-index: 10 !important;
}
</style>
