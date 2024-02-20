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
            itemsPerPageOptions: [25, 50, 100, 1000]
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
            
            <v-btn v-if="item.orden == null" small icon @click="archivarAnamnesis(item)">
                <v-icon small>mdi-close</v-icon>
            </v-btn>
            
            <v-btn  small icon :to="'/anamnesis/ver/' + item.id_anamnesis">
                <v-icon small>mdi-eye</v-icon>
            </v-btn>

            <!--<v-btn small icon @click="retakeAnamnesis(item)">
              <v-icon small>mdi-restart</v-icon>
            </v-btn>-->
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
      }
    };
  },
  methods: {
    async getRegistros(page = 1, per_page = 25, sortDesc = 1, sortBy = "") {
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
        if(item.orden == null) return "Pendiente Orden Lab.";
        return "Pendiente Comprobante";
    },
    getColor(item){
        if(item.orden == null) return "secondary";
        return "primary";
    },
    retakeAnamnesis(item){
        // console.log(item)
    },
    async archivarAnamnesis(item){
        const response =  await API.anamnesis.descartar(item.id_anamnesis);
        this.getRegistros();
    }
  },
  created() {
    this.getRegistros();
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
