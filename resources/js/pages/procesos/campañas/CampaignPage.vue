<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card class="mb-4">
      <v-row dense class="pa-2 align-center">
        <v-col cols="4">
          <v-text-field
            append-icon="mdi-magnify"
            class="flex-grow-1 mr-1"
            hide-details
            dense
            light
            solo
            placeholder="Buscar por nombre..."
            v-model="searchTerm"
          ></v-text-field>
        </v-col>
        <v-col>
          <v-btn class="mr-2" color="deep-orange" dark @click="clearFilters()">
            <v-icon>mdi-broom</v-icon> Limpiar Filtros
          </v-btn>
        </v-col>
        <v-col class="text-right">
          <CampaignCreate @created="handleCreated"></CampaignCreate>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="12">
          <v-data-table
            item-key="id"
            :loading="loadingTable"
            :headers="headers"
            :items="dataReg.data"
            :page="currentPage"
            :items-per-page="itemsPerPage"
            :server-items-length="totalReg"
            :options.sync="dataTabOptions"
            :footer-props="{
              itemsPerPageOptions: [10, 15, 25, 50, 100, 250, 500],
              'items-per-page-text': 'Registros por página',
            }"
            loading-text="Cargando... Por favor, espere"
          >
            <template v-slot:[`item.active`]="{ item }">
              <v-chip
                v-if="item.active == 1"
                class="ma-2"
                color="primary"
                small
              >
                Abierta
              </v-chip>
              <v-chip v-if="item.active == 0" class="ma-2" color="error" small>
                Cerrada
              </v-chip>
            </template>

            <template v-slot:[`item.actions`]="{ item }">
              <v-tooltip bottom>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    :disabled="item.order_count <= 0 || item.active == 0"
                    small
                    icon
                    v-bind="attrs"
                    v-on="on"
                    :to="'/campaigns/facturar/' + item.id"
                  >
                    <v-icon small>mdi-receipt</v-icon>
                  </v-btn>
                </template>
                <span>Facturar Ordenes</span>
              </v-tooltip>
            </template>
          </v-data-table>
        </v-col>
      </v-row>
    </v-card>
  </div>
</template>
<script>
import API from "../../../api";
import CampaignCreate from "./CampaignCreate";
import CampaignReceipt from "./CampaignReceipt";

export default {
  components: {
    CampaignCreate,
    CampaignReceipt,
  },
  data() {
    return {
      breadcrumbs_title: "Campañas",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Campañas" },
      ],
      headers: [
        { text: "Nº", value: "id", sortable: false },
        { text: "Nombre", sortable: false, value: "name" },
        {
          text: "Nro. Ordenes Asociadas",
          sortable: false,
          align: "center",
          value: "orders_count",
        },
        { text: "Estado", sortable: false, value: "active" },
        {
          text: "Acciones",
          value: "actions",
          align: "center",
          sortable: false,
          align: "right",
        },
      ],
      items: [],
      loadingTable: false,
      currentPage: 1,
      itemsPerPage: 10,
      totalReg: 0,
      dataTabOptions: {},
      dataReg: {},
      searchTerm: "",
      loading: false,
    };
  },
  methods: {
    handleCreated() {
      this.getRecords();
    },
    async getRecords(
      searchTerm = "",
      page = 1,
      perpage = 10,
      sortDesc = 0,
      sortBy = ""
    ) {
      this.loadingTable = true;
      try {
        const parameters = {
          page,
          searchTerm,
          perpage,
          sortDesc,
          sortBy,
        };
        const result = "?" + new URLSearchParams(parameters).toString();
        const response = await API.campaign.list(result);
        Object.assign(this.dataReg, response.data);
        this.currentPage = response.data.current_page;
        this.totalReg = this.dataReg.total;
      } catch (e) {
        console.error(e);
      } finally {
        this.loadingTable = false;
      }
    },
    clearFilters() {
      this.searchTerm = "";
      this.getRecords();
    },
  },
  created() {
    this.getRecords();
  },
  watch: {
    searchTerm() {
      if(!this.loadingTable){
        this.getRecords(this.searchTerm);
      }
    },
    dataTabOptions(event) {
      this.itemsPerPage = event.itemsPerPage;
      this.getRecords(
        this.searchTerm,
        event.page,
        event.itemsPerPage,
        event.sortDesc,
        event.sortBy[0]
      );
    },
  },
};
</script>
