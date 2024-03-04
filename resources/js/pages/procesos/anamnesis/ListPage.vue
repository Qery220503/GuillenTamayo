<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card>
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
            itemsPerPageOptions: [10, 25, 50, 100, 1000]
          }"
          :loading="loadingTable"
          loading-text="Cargando... Por favor, espere"
        >
        <template v-slot:[`item.id_cliente`]="{ item }">
            {{ item.cliente.nombre_razon_social }}
        </template>
        <template v-slot:[`item.estado`]="{ item }">
            <v-chip :color="getColor(item)" small>
                {{ getEstado(item) }}
            </v-chip>
        </template>
          <template v-slot:[`item.actions`]="{ item }">
            <v-tooltip bottom v-if="canCloseAnamnesis(item)">
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                small
                icon
                @click="archivarAnamnesis(item)"
                v-bind="attrs"
                v-on="on"
                >
                  <v-icon small>mdi-close</v-icon>
                </v-btn>
              </template>
              <span>Archivar Anamnesis</span>
            </v-tooltip>
            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                small
                icon
                :to="'/anamnesis/ver/' + item.id_anamnesis"
                v-bind="attrs"
                v-on="on"
                >
                  <v-icon small>mdi-eye</v-icon>
                </v-btn>
              </template>
              <span>Ver Anamnesis</span>
            </v-tooltip>
            <v-tooltip bottom v-if="canRetakeAnamnesis(item)">
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                small
                icon
                @click="retakeAnamnesis(item)"
                v-bind="attrs"
                v-on="on"
                >
                  <v-icon small>mdi-restart</v-icon>
                </v-btn>
              </template>
              <span>Retomar Anamnesis</span>
            </v-tooltip>
          </template>
        </v-data-table>
      </v-row>
    </v-card>
  </div>
</template>
<script>
import API from '../../../api';

export default {
  data() {
    return {
      breadcrumbs_title: "Listado de Anamnesis",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Listado de Anamnesis" }
      ],
      headers: [
        { text: "#", value: "id_anamnesis", align: "left" },
        { text: "Cliente", value: "id_cliente", align: "center" },
        { text: "Estado", value: "estado", align: "center", sortable: false},
        { text: "Fecha de Creación", value: "created_at", align: "center" },
        {
          text: "Acciones",
          sortable: false,
          value: "actions",
          align: "right"
        }
      ],
      //--- Datatable ---
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
      total_reg: 0,
      dataTabOptions: {},
      data_reg: [],
      filter: {
        searchTerm: ""
      },
      estados: {
        anamnesis_creada: "Anamnesis Iniciada",
        anamnesis_paso_1: "Paso 1 completado",
        anamnesis_paso_2: "Paso 2 completado",
        anamnesis_paso_3: "Paso 3 completado",
        anamnesis_cerrada: "Anamnesis Completada",
        anamnesis_archivada_usuario: "Anamnesis archivada por usuario",
        anamnesis_archivada_automaticamente: "Anamnesis archivada automáticamente",
        anamnesis_campana: 'Anamnesis archivada por campaña'
      },
    };
  },
  methods: {
    canCloseAnamnesis(item){
      let states = [
        'anamnesis_creada',
        'anamnesis_paso_1'
      ];
      if(item.last_state.estado in states){
        return true;
      }
      return false;
    },
    canRetakeAnamnesis(item){
      let states = [
        'anamnesis_creada',
        'anamnesis_paso_1',
        'anamnesis_paso_2',
      ]
      if(item.last_state.estado in states){
        return true;
      }
      return false;
    },
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "id_anamnesis") {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.anamnesis.list(
          "?page=" +
            page +
            "&itemsPerPage=" +
            per_page +
            "&sortDesc=" +
            sortDesc +
            "&sortBy=" +
            sortBy +
            "&searchTerm=" +
            this.filter.searchTerm
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
    getEstado(item){
      return this.estados[item.last_state.estado];
    },
    getColor(item){
        if(item.orden == null) return "secondary";
        return "primary";
    },
    retakeAnamnesis(item){
      this.$router.push('/anamnesis?anamnesis=' + item.id_anamnesis);
    },
    async archivarAnamnesis(item){
        const response =  await API.anamnesis.descartar(item.id_anamnesis);
        this.getRegistros();
    }
  },
  created() {
    //this.getRegistros();
  },
  watch: {
    dataTabOptions(event) {
      this.itemsperpage = event.itemsPerPage;
      this.getRegistros(
        event.page,
        event.itemsPerPage,
        event.sortDesc ,
        event.sortBy[0]
      );
    },
  }
};
</script>
