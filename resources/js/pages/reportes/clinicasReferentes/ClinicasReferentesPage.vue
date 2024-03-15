<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card>
      <v-row dense class="pa-2 align-center">
        <v-col cols="12" sm="5" md="5">
          <v-menu
            v-model="menu1"
            :close-on-content-click="false"
            :nudge-right="40"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                filled
                label="Clinica"
                v-model="filter.nombre_clinica"
                type="text"
                dense
                class="mt-1"
                hide-details
                @input="getData()"
              ></v-text-field>
            </template>
          </v-menu>
        </v-col>
        <v-col cols="12" sm="5" md="5">
            <v-menu
            v-model="menu2"
            :close-on-content-click="false"
            :nudge-right="40"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                v-model="form.endDate"
                filled
                label="Mes"
                readonly
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="form.endDate"
              @input="menu2 = false"
            ></v-date-picker>
          </v-menu>
        </v-col>
        <v-col cols="12" sm="1" md="1">
            <v-btn color="success" @click="getData()">
                <v-icon dark>mdi-filter</v-icon>
                Filtrar
            </v-btn>
            <v-btn color="deep-orange" class="mr-2" @click="limpiarFiltros()" dark style="margin-top: 5px;">
                Limpiar <v-icon>mdi-broom</v-icon>
            </v-btn>
            <v-btn color="secondary"
            :href="
              '/api/exportClinicasReferentes' +
                '?begin=' +
                form.startDate +
                '&end=' +
                form.endDate"
               
             style="margin-top: 5px;">
                <v-icon dark>mdi-file-excel</v-icon>
                Exportar
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
          @click:row="handleDataRowClick">
          <template v-slot:[`item.estado_trabajo`]="{ item }">
            <v-chip
                small
                v-if="item.estado_trabajo == 'REGISTRADO'"
                class="ma-2"
                color="primary">
                REGISTRADO
            </v-chip>
            <v-chip
                small
                v-if="item.estado_trabajo == 'APROBADO'"
                class="ma-2"
                color="success">
                APROBADO
            </v-chip>
            <v-chip
                small
                v-if="item.estado_trabajo == 'ENVIADO'"
                class="ma-2"
                color="success">
                ENVIADO
            </v-chip>
            <v-chip
                small
                v-if="item.estado == 'RECHAZADO'"
                class="ma-2"
                color="error">
                RECHAZADO
            </v-chip>
            <v-chip
                small
                v-if="item.estado_trabajo == 'ANULADO'"
                class="ma-2">
                ANULADO
            </v-chip>
            <v-chip
                small
                v-if="item.estado == 'OBSERVADO'"
                class="ma-2"
                color="error">
                OBSERVADO
            </v-chip>
            <v-chip
                small
                v-if="item.estado == 'POR ANULAR'"
                class="ma-2"
                color="error">
                POR ANULAR
            </v-chip>
          </template>
          <template v-slot:[`item.fecha_cpe`]="{ item }">
            <div class="one-line">
              {{ item.fecha_cpe | formatDateGeneral }}
            </div>
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
      loadingTable:false,
      breadcrumbs_title: "Clínicas Referentes",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Reportes", disabled: false, href: "#" },
        { text: "Clínicas Referentes" }
      ],
      menu1: false,
      menu2: false,
      date: null,
      form:{
        startDate: new Date().toISOString().substring(0,10),
        endDate: new Date().toISOString().substring(0,10),
      },
      data_reg: {
        data: []
      },
      total_reg: 0,
      dataTabOptions: {},
      headers: [
        { text: "Clinica Ref.", sortable: false, value: "nombre_clinica" },
        { text: "Fecha", sortable: false, value: "fecha_cpe"},
        {
            text: "Cliente",
            sortable: false,
            value: "nombre"
        },
        { text: "% Descuento", sortable: false, value: "porcen_dscto" },
        { text: "Monto Total", sortable: false, value: "monto_total_venta" },
        { text: "Estado", sortable: false, value: "estado_trabajo" },
        { text: "Doctor Ref.", sortable: false, value: "nombre_doctor" },
      ],
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
      total_reg: 0,
      dataTabOptions: {},
      data_reg: [],
      filter: {
        searchTerm: "",
        nombre_clinica: "",
      },

      addFormTitle: "Agregar Clínica",
      dialogEditar: false,
      validAddForm: false,
      addDialog: false,
      deleteDialog: false,
      rules: {
        required: UTILS.rules.required
      },
      activePicker: null,
      date: null,
      menu: false,

      rules: {
        required: UTILS.nRules.required,
        dni: UTILS.nRules.min8,
        only_numbers: UTILS.nRules.only_numbers,
        email: UTILS.nRules.email
      }
    };
  },
  created(){
    this.getData();
  },
  watch:{
    dataTabOptions(event) {
      this.itemsperpage = event.itemsPerPage;
      this.getData(
        event.page,
        event.itemsPerPage,
      );
    },
  },
  methods: {
    
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      const myParams = new URLSearchParams(this.filter).toString();
      try {
        const response = await API.clinicas.list(
          "?page=" +
            page +
            "&itemsPerPage=" +
            per_page +
            "&sortDesc=" +
            sortDesc +
            "&sortBy=" +
            sortBy +
            "&searchTerm=" +
            this.filter.searchTerm +
            "&" +
            myParams
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
    async getData(page = 1, per_page = 25, sortDesc = 0, sortBy=""){
      this.loadingTable = true;
      this.data_reg = [];
      const myParams = new URLSearchParams(this.filter).toString();
      const response = await API.reportes.clinicasReferentes('?page=' + page +
                                                        '&itemsPerPage=' + per_page +
                                                        "&sortDesc=" + sortDesc +
                                                        "&sortBy=" + sortBy +
                                                        "&searchTerm=" + this.filter.searchTerm +
                                                        "&" +myParams + 
                                                        '&begin=' + this.form.startDate +
                                                        '&end=' + this.form.endDate
                                                        );
        this.data_reg = response.data;
        this.total_reg = this.data_reg.total;
        this.data_reg.data = response.data;
        this.loadingTable = false;
        this.current_page = response.data.current_page;
      console.log(response);
    },
    
    limpiarFiltros() {
        this.form = {
            startDate: new Date().toISOString().substring(0,10),
            endDate: new Date().toISOString().substring(0,10),
        }
        this.getData();
    },
    async exportData(){

    },
  },
};
</script>
<style lang=""></style>
