<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card>
      <v-row dense class="pa-2 align-center">
        <v-spacer></v-spacer>
        <v-col class="text-right">
          <v-btn color="#1D6F42" class="mr-2" dark>
            Exportar<v-icon>mdi-file-excel</v-icon>
          </v-btn>
        </v-col>
      </v-row>
      <v-row dense class="pa-2 align-center">
        <v-data-table
          light
          :headers="headers"
          :items="data_reg.data"
          :page="current_page"
          :items-per-page="itemsperpage"
          :server-items-length="total_reg"
          :options.sync="dataTabOptions"
          class="flex-grow-1 scroll-me"
          :footer-props="{
            itemsPerPageOptions: [25, 50, 100, 1000]
          }"
          :loading="loadingTable"
          loading-text="Cargando... Por favor, espere"
        >
          <template v-slot:[`item.id_guia`]="{ item }">
            <div class="one-line">
              {{ item.id_guia_remision }}
            </div>
          </template>
          <template v-slot:[`item.fecha_emision`]="{ item }">
            <div class="one-line">
              {{ item.fecha_emision }}
            </div>
          </template>
          <template v-slot:[`item.cliente`]="{ item }">
            <div class="one-line">
              {{ item.cliente.nombre_razon_social }}
            </div>
          </template>
          <template v-slot:[`item.numero_guia`]="{ item }">
            <div class="one-line">
              {{ item.id_guia_remision }}
            </div>
          </template>
          <template v-slot:[`item.estado`]="{ item }">
            <div class="one-line">
              {{ (item.estado) = 1 ? "Aceptado" : "Rechazado" }}
            </div>
          </template>
          <template v-slot:[`item.fecha_envio`]="{ item }">
            <div class="one-line">
              {{ item.fecha_traslado }}
            </div>
          </template>
          <template v-slot:[`item.actions`]="{ item }">
            <v-btn
              small
              icon
              :to="'/guia_remision/ver/' + item.id_guia_remision"
              link
            >
            <v-icon small>mdi-eye-outline</v-icon>
            </v-btn>
          </template>
        </v-data-table>
      </v-row>
    </v-card>
  </div>
</template>
<script>
export default {
  data() {
    return {
      breadcrumbs_title: "Guías de remisión",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Guías de remisión" }
      ],

      // Datatable
      headers: [
        { text: "#", value: "id_guia", align: "left" },
        { text: "Fecha emisión", value: "fecha_emision", align: "center" },
        {
          text: "Cliente",
          value: "cliente",
          align: "center",
          sortable: false
        },
        { text: "Número", value: "numero_guia", align: "center" },
        { text: "Estado", value: "estado", align: "center" },
        { text: "Fecha envío", value: "fecha_envio", align: "center" },
        { text: "Acciones", sortable: false, value: "actions", align: "center" }
      ],
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
      /* Cambiar el número total de registros a 0 */
      total_reg: 0,
      dataTabOptions: {},
      data_reg: [],
      filter: {
        searchTerm: ""
      }
    };
  },
  created() {
    this.getRegistros();
  },
  methods: {
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.guia_remision.list(
          "?page=" +
            page +
            "&itemsPerPage=" +
            per_page +
            "&sortDesc=" +
            sortDesc +
            "&sortBy=" +
            sortBy
        );
        this.data_reg = response.data;
        this.current_page = response.data.current_page;
        this.total_reg = this.data_reg.total;
        this.loadingTable = false;
      } catch (e) {
        this.loadingTable = false;
        console.log(e);
      }
    },
    formatoCorrelativo(ct) {
      let c = ct.toString().padStart(8, "0");
      console.log(c, "GR");
      return c;
    }
  },
  watch: {
    dataTabOptions(event) {
      this.itemsperpage = event.itemsPerPage;
      this.getRegistros(
        event.page,
        event.itemsPerPage,
        event.sortDesc,
        event.sortBy[0]
      );
    }
  }
};
</script>
<style></style>
