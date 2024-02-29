<template>
  <div class="d-flex flex-grow-1 flex-column">
    <custom-breadcrumbs :breadcrumbs_title="breadcrumbs_title" :breadcrumbs="breadcrumbs"></custom-breadcrumbs>
    <div>
      <v-row dense>
        <v-col cols="12" md="2">
          <v-menu v-model="menuStartDate" :close-on-content-click="false" :nudge-right="40" transition="scale-transition"
            offset-y min-width="auto">
            <template v-slot:activator="{ on, attrs }">
              <v-text-field label="Fecha de Inicio" v-model="formatStartDate" prepend-icon="mdi-calendar" v-bind="attrs"
                v-on="on" dense outlined readonly></v-text-field>
            </template>
            <v-date-picker v-model="filter.startDate" @input="menuStartDate = false" locale="es-ES"
              no-title></v-date-picker>
          </v-menu>
        </v-col>
        <v-col cols="12" md="2">
          <v-menu v-model="menuEndDate" :close-on-content-click="false" :nudge-right="40" transition="scale-transition"
            offset-y min-width="auto">
            <template v-slot:activator="{ on, attrs }">
              <v-text-field label="Fecha de Fin" v-model="formatEndDate" prepend-icon="mdi-calendar" v-bind="attrs"
                v-on="on" dense outlined readonly></v-text-field>
            </template>
            <v-date-picker v-model="filter.endDate" @input="menuEndDate = false" locale="es-ES" no-title></v-date-picker>
          </v-menu>
        </v-col>
        <v-col class="text-right" cols="12" md="1">
          <v-btn color="primary" class="mr-2" @click="GetRecords()" dark>
            <v-icon>mdi-magnify</v-icon>Buscar
          </v-btn>
          <v-btn class="mr-2" @click="ClearFilters()">
            <v-icon>mdi-reload</v-icon>Limpiar
          </v-btn>
        </v-col>
      </v-row>
      <v-row dense class="pa-1" style="padding-top: 0px !important">
        <v-col class="pa-1">
          <v-card color="success" class="text-center py-1 card_hover" to="/anamnesis" style="height: 100%">
            <v-icon color="white" large> mdi-plus </v-icon>
            <div class="text-subtitle-1 font-weight-bold white--text text-center">
              Iniciar Venta
            </div>
            <div class="white--text text-center" style="font-size: 15px">
              (Anamnesis)
            </div>
          </v-card>
        </v-col>
        <v-col class="pa-1">
          <v-card color="info" class="text-center py-1" style="height: 100%">
            <v-icon color="white" large> mdi-cash </v-icon>
            <div class="text-subtitle-1 font-weight-bold white--text text-center">
              Total Vendido<br />{{ dashboard_info.total_ventas }}
            </div>
          </v-card>
        </v-col>
        <v-col class="pa-1">
          <v-card color="teal accent-4" class="text-center py-1" style="height: 100%">
            <v-icon color="white" large> mdi-chart-bar </v-icon>
            <div class="text-subtitle-1 font-weight-bold white--text text-center">
              Total Ganancia<br />{{ dashboard_info.total_ganancia }}
            </div>
          </v-card>
        </v-col>
      </v-row>
      <v-row dense>
        <v-col cols="6">
          <div class="text-center my-2">
            <h2 class="my-1">Top Compras</h2>
            <v-simple-table v-if="dashboard_info.top_compras">
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">Nro.</th>
                    <th class="text-left">Nombre</th>
                    <!-- <th class="text-left">Cantidad</th> -->
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(item, index) in dashboard_info.top_compras" :key="index">
                    <td class="text-left">{{ index + 1 }}</td>
                    <td class="text-left">{{ item.codigo_producto }}</td>
                    <!-- <td class="text-left">{{ item.cnt }}</td> -->
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
          </div>
        </v-col>
        <v-col cols="6">
          <div class="text-center my-2">
            <h2 class="my-1">Top Ventas</h2>
            <v-simple-table v-if="dashboard_info.top_ventas">
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">Nro.</th>
                    <th class="text-left">Nombre</th>
                    <!-- <th class="text-left">Cantidad</th> -->
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(item, index) in dashboard_info.top_ventas" :key="index">
                    <td class="text-left">{{ index + 1 }}</td>
                    <td class="text-left">{{ item.detalle_item }}</td>
                    <!-- <td class="text-left">{{ item.cnt }}</td> -->
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
          </div>
        </v-col>
      </v-row>
    </div>
    <div class="text-center my-2">
      <v-divider></v-divider>
      <h2 class="my-1">Órdenes Laboratorio</h2>
      <v-divider></v-divider>
      <div class="mt-2">
        <v-data-table :headers="headers" :items="ol.data" :page="current_page" :items-per-page="itemsperpage"
          :server-items-length="total_reg" :options.sync="dataTabOptions" class="flex-grow-1 scroll-me" :footer-props="{
            itemsPerPageOptions: [25, 50, 100, 1000],
          }" :loading="loadingTable" :item-class="itemRowBackground" loading-text="Cargando... Por favor, espere">
          <template v-slot:[`item.codigo_orden_lab`]="{ item }">
            <div class="one-line">OL-{{ item.codigo_orden_lab }}</div>
          </template>
          <template v-slot:[`item.cliente.nombre_razon_social`]="{ item }">
            <div class="one-line">{{ item.cliente.nombre_razon_social }}</div>
          </template>
          <template v-slot:[`item.created_at`]="{ item }">
            <div class="one-line">
              {{ item.created_at | formatDateGeneral }}
            </div>
          </template>
          <template v-slot:[`item.fecha_entrega`]="{ item }">
            <div class="one-line">
              {{ item.fecha_entrega | formatDateGeneral }}
              {{ item.hora_entrega }}
            </div>
          </template>
          <template v-slot:[`item.estado`]="{ item }">
            <v-chip class="ma-2" :color="item.status.color" small>
              <span class="font-weight-medium">{{
                item.status.nombre_estado
              }}</span>
            </v-chip>
          </template>

          <template v-slot:[`item.actions`]="{ item }">
            <v-btn small icon :to="'/orden-laboratorio/detalle/' + item.id_orden_laboratorio" link>
              <v-icon small>mdi-eye-outline</v-icon>
            </v-btn>
            <v-btn small icon :href="'/ordenLaboratorioPDF/' + item.id_orden_laboratorio" target="_blank">
              <v-icon small>mdi-file-pdf-box</v-icon>
            </v-btn>
          </template>
        </v-data-table>
      </div>
    </div>

    <div class="text-center my-2">
      <v-divider></v-divider>
      <h2 class="my-1">Comprobantes próximos a vencer</h2>
      <v-divider></v-divider>
      <div class="mt-2">
        <v-simple-table v-if="dashboard_info.next_sells">
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">
                  Comprobante
                </th>
                <th class="text-left">
                  Cliente
                </th>
                <th class="text-left">
                  Dias restantes
                </th>
                <th class="text-left">
                  Acciones
                </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in dashboard_info.next_sells" :key="item.id_comprobante"
                :class="getTableRowClass(item.days)">
                <td class="text-left">{{ item.serie.serie }}-{{ pad('000000', item.correlativo, true) }}</td>
                <td class="text-left">{{ item.nombre_cliente }}</td>
                <td class="text-center">{{ item.days }}</td>
                <td>
                  <v-btn icon :to="'/comprobantes/ver/' + item.id_comprobante">
                    <v-icon>mdi-eye</v-icon>
                  </v-btn>
                </td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </div>
    </div>

    <div class="text-center my-2">
      <v-divider></v-divider>
      <h2 class="my-1">Compras próximos a vencer</h2>
      <v-divider></v-divider>
      <div class="mt-2">
        <v-simple-table v-if="dashboard_info.next_purchases">
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">
                  Comprobante
                </th>
                <th class="text-left">
                  Cliente
                </th>
                <th class="text-left">
                  Dias restantes
                </th>
                <th class="text-left">
                  Acciones
                </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in dashboard_info.next_purchases" :key="item.id_compra"
                :class="getTableRowClass(item.days)">
                <td class="text-left">{{ item.serie.serie }}-{{ pad('000000', item.correlativo, true) }}</td>
                <td class="text-left">{{ item.nombre_proveedor }}</td>
                <td class="text-center">{{ item.days }}</td>
                <td>
                  <v-btn icon :to="'/compras/ver/' + item.id_compra">
                    <v-icon>mdi-eye</v-icon>
                  </v-btn>
                </td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </div>
    </div>

  </div>
</template>

<script>
import API from "../../api";
export default {
  data: () => ({
    loadingTable: false,
    current_page: 1,
    itemsperpage: 100,
    total_reg: 0,
    dataTabOptions: {},
    breadcrumbs_title: "Dashboard",
    breadcrumbs: [
      {
        text: "Inicio",
        disabled: false,
        href: "#"
      },
      {
        text: "Dashboard"
      }
    ],
    headers: [
      { text: "#", value: "codigo_orden_lab", align: "left" },
      { text: "Cliente", value: "cliente.nombre_razon_social", align: "left" },
      { text: "Fecha Recep.", value: "created_at" },
      { text: "Fecha Entrega	", value: "fecha_entrega" },
      { text: "Estado", value: "estado" },
      { text: "Ver", value: "actions" }
    ],
    ol: [
    ],


    filter: {
      searchTerm: "",
      startDate: '',
      endDate: '',
    },
    menuStartDate: false,
    menuEndDate: false,
    dashboard_info: {},
  }),
  mounted() {
    this.filter.startDate = this.todaysDateDefault();
    this.GetDashboardInfo();
  },
  methods: {
    GetRecords() {
      this.GetDashboardInfo();
      this.getOrdenesLaboratorio();
    },
    pad(pad, str, padLeft) {
      if (typeof str === 'undefined')
        return pad;
      if (padLeft) {
        return (pad + str).slice(-pad.length);
      } else {
        return (str + pad).substring(0, pad.length);
      }
    },

    async GetDashboardInfo() {
      const response = await axios.get("api/getDashboardInfo?startDate=" + this.filter.startDate
        + '&endDate=' + this.filter.endDate);

      this.dashboard_info.total_clientes = response.data.total_clientes;
      this.dashboard_info.total_productos = response.data.total_productos;
      this.dashboard_info.total_ventas = response.data.total_ventas;
      this.dashboard_info.top_compras = response.data.top_compras;
      this.dashboard_info.top_ventas = response.data.top_ventas;
      this.dashboard_info.next_purchases = response.data.next_purchases;
      this.dashboard_info.next_sells = response.data.next_sells;

    },
    async getOrdenesLaboratorio(page = 1, itemsPerPage = 100, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.orden_laboratorio.listDashboard("?startDate=" + this.filter.startDate
          + '&endDate=' + this.filter.endDate);

        this.ol = response.data;
        this.current_page = response.data.current_page;
        this.total_reg = this.data_reg.total;
        this.loadingTable = false;

      } catch (e) {
        this.loadingTable = false;
        console.error(e);
      }
    },
    ClearFilters() {
      this.filter.startDate = this.todaysDateDefault();
      this.filter.startDate = "";
      this.filter.endDate = "";
      this.GetRecords();
    },


    itemRowBackground: function (item) {
      //console.log(item);
      var today = new Date();
      var dd = String(today.getDate()).padStart(2, '0');
      var mm = String(today.getMonth() + 1).padStart(2, '0');
      var yyyy = today.getFullYear();
      var today_date = yyyy + '-' + mm + '-' + dd;

      var tomorrow = new Date();
      tomorrow.setDate(tomorrow.getDate() + 1);
      var dd2 = String(tomorrow.getDate()).padStart(2, '0');
      var mm2 = String(tomorrow.getMonth() + 1).padStart(2, '0');
      var yyyy2 = tomorrow.getFullYear();
      var tomorrow_date = yyyy2 + '-' + mm2 + '-' + dd2;

      if (today_date == item.fecha_entrega) {
        return 'row_red';
      } else if (tomorrow_date == item.fecha_entrega) {
        return 'row_yellow';
      } else {
        return '';
      }
    },
    getTableRowClass(days) {
      if (days <= 1) {
        return 'table-danger';
      } else if (days <= 3) {
        return 'table-warning';
      } else if (days <= 7) {
        return 'table-info';
      } else {
        return '';
      }
    }
  },
  computed: {
    formatStartDate: {
      get: function () {
        return this.formatDate(this.filter.startDate)
      },
      set: function (newValue) {
        return this.formatDate(newValue);
      }
    },
    formatEndDate: {
      get: function () {
        return this.formatDate(this.filter.endDate)
      },
      set: function (newValue) {
        return this.formatDate(newValue);
      }
    },
  },
  watch: {
    dataTabOptions(event) {
      // this.itemsPerPage = event.itemsPerPage;
      this.getOrdenesLaboratorio(event.page, event.itemsPerPage);
    },
  },
};
</script>
<style>
.row_red {
  background-color: rgb(252, 194, 194);
}

.row_yellow {
  background-color: rgb(252, 241, 174);
}

.card_hover:hover {
  background-color: #099c75 !important;
}


.table-danger {
  background-color: #ff394a;
}

.table-warning {
  background-color: #ffd149;
}

.table-info {
  background-color: #81ecff;
}
</style>
