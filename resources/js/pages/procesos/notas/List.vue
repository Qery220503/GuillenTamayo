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
            itemsPerPageOptions: [5, 25, 50, 100, 1000]
          }"
          :loading="loadingTable"
          loading-text="Cargando... Por favor, espere"
        >
          <template v-slot:[`item.nota`]="{ item }">
            <div class="one-line">
              {{ item.serie.serie }}-{{ formatCorrelativo(item.correlativo) }}
            </div>
          </template>
          <template v-slot:[`item.tipo`]="{ item }">
            <v-chip small>{{
              item.id_tipo_comprobantes == 6 ? "CRÉDITO" : "DÉBITO"
            }}</v-chip>
          </template>
          <template v-slot:[`item.comprobante`]="{ item }">
            <div class="one-line">
              {{ item.comprobante.serie.serie }}-{{
                formatCorrelativo(item.comprobante.correlativo)
              }}
            </div>
          </template>
          <template v-slot:[`item.created_at`]="{ item }">
            <div>
              {{ item.created_at | formatDateGeneral }}
            </div>
          </template>
          <template v-slot:[`item.estado`]="{ item }">
            <v-chip :color="item.estado_nota.color" small>
              {{ item.estado_nota.nombre_estado }}
            </v-chip>
          </template>
          <template v-slot:[`item.actions`]="{ item }">
            <v-btn
              small
              icon
              :to="'/notas/ver/' + item.id_nota"
              link
            >
              <v-icon small>mdi-eye-outline</v-icon>
            </v-btn>
            <v-btn small icon @click="openPDF(item)">
              <v-icon small>mdi-file-pdf-box</v-icon>
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
      breadcrumbs_title: "Notas de Débito/Crédito",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Notas" }
      ],

      // Datatable
      headers: [
        { text: "Nota", value: "nota", align: "left" },
        {
          text: "Cliente",
          value: "cliente.nombre_razon_social",
          align: "center"
        },
        {
          text: "Comprobante Afectado",
          value: "comprobante",
          align: "center",
          sortable: false
        },
        {
          text: "Tipo",
          value: "tipo",
          align: "center"
        },
        {
          text: "Estado",
          value: "estado",
          align: "center"
        },
        { text: "Fecha de Creación", value: "created_at", align: "center" },
        {
          text: "Acciones",
          sortable: false,
          value: "actions",
          align: "right"
        }
      ],
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
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
        const response = await API.notas.list(
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
        console.error(e);
      }
    },
    formatCorrelativo(ct) {
      let c = ct.toString().padStart(8, "0");
      console.log(c, "PAD");
      return c;
    },
    openPDF(item) {
      let url =
        item.sucursal.url_api + "/print/document/" + item.external_id + '/ticket';
      window.open(url, "Nota", "width=500,height=600");
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
