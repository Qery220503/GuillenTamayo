<template>
  <v-card class="px-5 py-2">
    <v-card-text>
      <v-data-table
        light
        :headers="headersTable"
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
      headersTable: [
        { text: "Nº", value: "id", align: "left" },
        { text: "Fecha", value: "fecha", align: "left" },
        { text: "Empresa", value: "empresa", align: "left" },
        { text: "Doctor", value: "doctor", align: "left" },
        {
          text: "Frecuencia visitas",
          value: "frecuencia_visita",
          align: "left",
        },
        { text: "Antecedentes", value: "antecedentes", align: "left" },
        { text: "Sintomas", value: "sintomas", align: "left" },
        { text: "Medicamentos", value: "medicamentos", align: "left" },
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
