<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs :breadcrumbs_title="breadcrumbs_title" :breadcrumbs="breadcrumbs"></custom-breadcrumbs>
    <v-card class="mb-4">
      <v-row dense class="pa-2 align-center">

            <v-col cols="4">
              <v-text-field  append-icon="mdi-magnify" class="flex-grow-1 mr-1" hide-details
                dense light solo placeholder="Buscar por nombre..."></v-text-field>
            </v-col>
            <v-col>
              <v-btn class="mr-2" color="deep-orange" dark>
                <v-icon>mdi-broom</v-icon> Limpiar Filtros
              </v-btn>
            </v-col>
            <v-col class="text-right">
              <CampaignCreate></CampaignCreate>
            </v-col>

      </v-row>
    </v-card>
  </div>
</template>
<script>
import CampaignCreate from './CampaignCreate.vue';

export default {
  components: {
    CampaignCreate
  },
  data() {
    return {
      breadcrumbs_title: "Campañas",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Campañas" },
      ],
    }
  }
}
</script>
