<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>

    <v-card>
      <v-data-table
        light
        :headers="headers"
        :items="data_reg.data"
        class="flex-grow-1 scroll-me"
        :footer-props="{
          itemsPerPageOptions: [25, 50, 100, 1000]
        }"
        :loading="loadingTable"
        loading-text="Cargando... Por favor, espere"
      >
        <template v-slot:top>
          <v-toolbar flat>
            <v-spacer></v-spacer>
            <v-btn color="success" href="/api/exportDeudasComprobantes">
              <v-icon>mdi-file-excel</v-icon>
              Exportar Excel
            </v-btn>
          </v-toolbar>
        </template>

        <template v-slot:item.fecha_emision="{ item }">
          <div>
            {{ item.fecha_emision | formatDateGeneral }}
          </div>
        </template>
        <template v-slot:item.cpe="{ item }">
          <div>
            {{ item.serie.serie }}-{{ formatCorrelativo(item.correlativo) }}
          </div>
        </template>
        <template v-slot:item.tipo_comprobante="{ item }">
          <div>
            {{ item.tipo_comprobante.nombre_tipo_documento }}
          </div>
        </template>
        <template v-slot:item.pagado="{ item }">
          <div>
            {{ parseFloat(Number(item.total) - Number(item.saldo)).toFixed(2) }}
          </div>
        </template>
      </v-data-table>
    </v-card>
  </div>
</template>
<script>
import API from "../../../api";

export default {
  data() {
    return {
      loadingTable: false,
      breadcrumbs_title: "Deudas Pendientes",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Reportes", disabled: false, href: "#" },
        { text: "Deudas Pendientes" }
      ],
      data_reg: {
        data: []
      },
      total_reg: 0,
      dataTabOptions: {},
      headers: [
        { text: "Fecha", sortable: false, value: "fecha_emision" },
        { text: "Comprobante", sortable: false, value: "cpe" },
        {
          text: "Tipo Comprobante",
          sortable: false,
          value: "tipo_comprobante"
        },
        {
          text: "Cliente",
          sortable: false,
          value: "cliente.nombre_razon_social"
        },
        { text: "Total", sortable: false, value: "total" },
        { text: "Pendiente", sortable: false, value: "saldo" },
        { text: "Pagado", sortable: false, value: "pagado" }
      ]
    };
  },
  created() {
    this.getData();
  },
  watch: {
    dataTabOptions(event) {
      this.itemsperpage = event.itemsPerPage;
      this.getData(event.page, event.itemsPerPage);
    }
  },
  methods: {
    formatCorrelativo(ct) {
      let c = ct.toString().padStart(8, "0");
      return c;
    },
    async getData(page = 1, per_page = 25) {
      const response = await API.reportes.deudasPendientes(
        "?page=" + page + "&perpage=" + per_page
      );
      this.data_reg = response.data;
      this.current_page = response.data.current_page;
      this.total_reg = this.data_reg.total;

      //this.data_reg.data = response.data;
    },
    async exportData() {}
  }
};
</script>
<style lang=""></style>
