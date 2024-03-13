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
                v-model="form.startDate"
                label="Fecha de Inicio"
                readonly
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="form.startDate"
              @input="menu1 = false"
            ></v-date-picker>
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
                label="Fecha de Fin"
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
              '/api/exportCuadroGeneral' +
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
    </v-card>

    <v-card>
        <v-data-table
          light
          :headers="headers"
          :items="data_reg.data"
          :hide-default-footer="true"
          class="flex-grow-1 scroll-me"
          :footer-props="{
            itemsPerPageOptions: [25, 50, 100, 1000]
          }"
          :loading="loadingTable"
          loading-text="Cargando... Por favor, espere"
        ></v-data-table>
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
        { text: "Fecha", sortable: false, value: "fecha_cpe"},
        { text: "Comprobante", sortable: false, value: "cpe" },
        {
            text: "Cliente",
            sortable: false,
            value: "nombre"
        },
        { text: "Nro. Documento", sortable: false, value: "doc" },
        { text: "Telefono", sortable: false, value: "telefono" },
        { text: "Correo", sortable: false, value: "correo" },
        { text: "Servicio", sortable: false, value: "nombre_servicio" },
        { text: "Montura", sortable: false, value: "montura" },
        { text: "Tipo M.", sortable: false, value: "tipo_montura" },
        { text: "Precio M.", sortable: false, value: "precio_montura" },
        { text: "Diseño", sortable: false, value: "disenio_lentes" },
        { text: "AR", sortable: false, value: "tratamiento" },
        { text: "Fotosensible", sortable: false, value: "fotocroma_lentes" },
        { text: "Fabricacion", sortable: false, value: "fabricacion_lentes" },
        { text: "Medida", sortable: false, value: "medida" },
        { text: "Cant. Lentes.", sortable: false, value: "cantidad_lentes" },
        { text: "Precio L.", sortable: false, value: "precio_lentes" },
        { text: "Proveedor L.", sortable: false, value: "proveedor_lentes" },
        { text: "Factura L.", sortable: false, value: "comprobante_compra" },
        { text: "Fec. Entrega", sortable: false, value: "fecha_entrega" },
        { text: "Fec. Entregado", sortable: false, value: "fecha_entregado" },
        { text: "% Descuento", sortable: false, value: "porcen_dscto" },
        { text: "Monto Total", sortable: false, value: "ganancia_bruta" },
        { text: "Estado", sortable: false, value: "estado_trabajo" },
        { text: "Costo L.", sortable: false, value: "compra_laboratorio" },
        { text: "Costo Montura.", sortable: false, value: "compra_montura" },
        { text: "Ganancia Neta", sortable: false, value: "ganancia_bruta" },
        { text: "Clinica Ref.", sortable: false, value: "nombre_clinica" },
        { text: "Doctor Ref.", sortable: false, value: "nombre_doctor" },
      ],
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
    async getData(page = 1, per_page = 25){
      const response = await API.reportes.cuadroGeneral('?page=' + page +
                                                        '&itemsPerPage=' + per_page + 
                                                        '&begin=' + this.form.startDate +
                                                        '&end=' + this.form.endDate);
                                                        this.data_reg = response.data;
        //this.current_page = response.data.current_page;
        this.total_reg = this.data_reg.total;

        this.data_reg.data = response.data;
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

    }
  },
};
</script>
<style lang=""></style>
