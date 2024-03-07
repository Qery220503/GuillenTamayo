<template>
    <v-card class="px-5 py-2">
      <v-card-text>
        <v-data-table
          light
          :headers="headers"
          :items="tableData"
          :page="currentPage"
          :items-per-page="itemsPerPage"
          :options.sync="dataTabOptions"
          class="flex-grow-1 scroll-me"
          :footer-props="{
            itemsPerPageOptions: [25, 50, 100, 1000],
          }"
          :loading="loadingTable"
          loading-text="Cargando... Por favor, espere"
        >
        </v-data-table>
      </v-card-text>
    </v-card>
  </template>
  
  <script>
  import { getAnamnesisService } from "../services/paciente.services";
  
  export default {
    props: {
      documento: {
        required: true,
        default: 0,
      },
    },
    data() {
      return {
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
      ],
        tableData: [],
        currentPage: 1,
        pageCount: 1,
        itemsPerPage: 25,
        totalReg: 0,
        dataTabOptions: {},
        loadingTable: false,
      };
    },
    created() {
      this.getDataAnamnesis();
    },
    methods: {
      async getDataAnamnesis() {
        try {
          const data = await getAnamnesisService(this.documento);
          this.tableData = data.map((e) => ({
            ...e,
            id: e.id_anamnesis,
            fecha: e.created_at,
            empresa: e.empresa[0] ? e.empresa[0].nombre_empresa : null,
            doctor: e.doctor.nombres,
            antecedentes: e.antecedentes_familiares,
          }));
        } catch (error) {
          console.log(error);
        }
      },
    },
  };
  </script>
  
  <style></style>
  