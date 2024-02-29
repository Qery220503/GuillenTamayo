<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-row dense class="mx-auto my-2">
      <div class="d-flex flex-row align-center justify-center ">
        <v-menu
          ref="menu1"
          v-model="menu1"
          :close-on-content-click="false"
          transition="scale-transition"
          offset-y
          max-width="290px"
          min-width="auto"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="dateFormatted"
              label="Ingrese una fecha"
              v-bind="attrs"
              v-on="on"
              hide-details
              light
              solo
              @blur="date = parseDate(dateFormatted)"
            ></v-text-field>
          </template>
          <v-date-picker
            v-model="date"
            no-title
            @input="menu1 = false"
            @change="handleNewDate()"
            :max="today"
          ></v-date-picker>
        </v-menu>
        <v-select
          :items="cajas"
          label="Caja"
          class="mx-2"
          v-model="cajaActual"
          return-object
          hide-details
          light
          solo
        >
          <template v-slot:selection="{ item }">
            Caja {{ new Date(item.created_at).toLocaleTimeString() }}
          </template>
          <template v-slot:item="{ item }">
            Caja {{ new Date(item.created_at).toLocaleTimeString() }}
          </template>
        </v-select>
        <v-btn color="success" class="mx-2" @click="filterData()">
          Filtrar
          <v-icon dark>
            mdi-filter
          </v-icon>
        </v-btn>
      </div>
      <v-spacer></v-spacer>
      <v-btn text icon color="primary" @click="filterData()">
        <v-icon>mdi-refresh</v-icon>
      </v-btn>
    </v-row>

    <h2 class="my-2">Comprobantes</h2>
    <v-card class="mx-auto my-2">
      <v-card-text>
        <v-data-table
          light
          :headers="comprobantesHeader"
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
          <template v-slot:item.comprobante="{ item }">
            {{ item.serie.serie }}-{{ item.correlativo }}
          </template>
          <template v-slot:item.deuda="{ item }">
            {{ item.credito == null || item.credito.length == 0 ? "NO" : "SI" }}
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>

    <h2 class="my-2">Pagos Deudas</h2>
    <v-card class="mx-auto my-2">
      <v-card-text>
        <v-simple-table dense>
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
                  Monto
                </th>
                <th class="text-left">
                  Medio de pago
                </th>
              </tr>
            </thead>
            <tbody v-if="pagosDeudas.length > 0">
              <tr v-for="pago in pagosDeudas">
                <td>
                  {{ pago.cuota.comprobante.serie.serie }} -
                  {{ pago.cuota.comprobante.correlativo }}
                </td>
                <td>
                  {{ pago.cuota.comprobante.cliente.nombre_razon_social }}
                </td>
                <td>{{ pago.monto }}</td>
                <td>{{ pago.medio_pago.medio_pago }}</td>
              </tr>
            </tbody>
            <tbody v-else>
              <tr>
                <td colspan="4">
                  <h5 style="text-align: center;">
                    Aún sin pagos
                  </h5>
                </td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </v-card-text>
    </v-card>

    <h2 class="my-2">Egresos</h2>
    <v-card class="mx-auto my-2">
      <v-card-text>
        <v-simple-table dense>
          <template v-slot:default>
            <thead>
              <tr>
                <th class="text-left">
                  Concepto
                </th>
                <th class="text-left">
                  Monto
                </th>
                <th class="text-left">
                  Fecha de Egreso
                </th>
              </tr>
            </thead>
            <tbody v-if="egresosCaja.length > 0">
              <tr v-for="e in egresosCaja">
                <td>{{ e.descripcion }}</td>
                <td>{{ e.monto }}</td>
                <td>{{ e.fecha_egreso }}</td>
              </tr>
            </tbody>
            <tbody v-else>
              <td colspan="3">
                <h5 style="text-align: center;">
                  Aún sin egresos
                </h5>
              </td>
            </tbody>
          </template>
        </v-simple-table>
      </v-card-text>
    </v-card>

    <v-row>
      <v-col cols="4">
        <v-card class="mx-auto my-2 mx-1">
          <v-card-title>Egresos/Gastos</v-card-title>
          <v-card-text>
            <v-simple-table dense>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">
                      Concepto
                    </th>
                    <th class="text-right">
                      Caja Chica
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="font-weight-bold">Egresos</td>
                    <td class="text-right">
                      S/. {{ Number(egresos.egresos).toFixed(2) }}
                    </td>
                  </tr>
                  <tr>
                    <td class="font-weight-bold">Depósitos</td>
                    <td class="text-right">
                      S/. {{ Number(egresos.cancelaciones).toFixed(2) }}
                    </td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
            <v-divider class="my-1"></v-divider>
            <div class="d-flex">
              <div class="red--text font-weight-bold text-h6">
                Total Egresos:
              </div>
              <v-spacer></v-spacer>
              <div class="font-weight-bold text-h6">
                S/. {{ total_egresos }}
              </div>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
      <v-col cols="8">
        <v-card class="mx-auto my-2 mx-1">
          <v-card-title>Ingresos</v-card-title>
          <v-card-text>
            <v-simple-table dense>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">
                      Concepto
                    </th>
                    <th v-for="titulo in ingresos.ventas" class="text-left">
                      {{ titulo.medio }}
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>Ventas</td>
                    <td v-for="venta in ingresos.ventas">{{ venta.total }}</td>
                  </tr>

                  <tr>
                    <td>Deudas Clientes</td>
                    <td v-for="venta in ingresos.deudas_clientes">
                      {{ venta.total }}
                    </td>
                  </tr>

                  <tr>
                    <td>Totales</td>
                    <td v-for="total in ingresos_totales">
                      {{ total.total.toFixed(2) }}
                    </td>
                  </tr>

                  <tr>
                    <td class="font-weight-bold">Caja Inicial</td>
                    <td class="font-weight-bold">
                      S/.{{ cajaActual.monto_inicial }}
                    </td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
            <v-divider class="my-1"></v-divider>
            <div class="d-flex">
              <div class="success--text font-weight-bold text-h6">
                Total Ingresos:
              </div>
              <div class="font-weight-bold text-h6 ml-3">
                S/. {{ total_ingresos }}
              </div>
            </div>
            <div class="d-flex">
              <div class=" font-weight-bold text-h6">
                <span class="success--text">Ingresos</span> -
                <span class="error--text">Egresos</span>
              </div>
              <div class="font-weight-bold text-h6 ml-3">
                S/. {{ total_ingresos - total_egresos }}
              </div>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>
<script>
import axios from "axios";

export default {
  data: vm => ({
    breadcrumbs_title: "Ver Caja",
    breadcrumbs: [
      { text: "Inicio", disabled: false, href: "#" },
      { text: "Procesos", disabled: false, href: "#" },
      { text: "Ver Caja" }
    ],
    date: new Date().toISOString().substr(0, 10),
    menu1: false,

    comprobantesHeader: [
      {
        text: "Comprobante",
        align: "start",
        sortable: false,
        value: "comprobante"
      },
      { text: "Cliente", value: "cliente.nombre_razon_social" },
      { text: "Adelanto", value: "adelanto" },
      { text: "Total", value: "total" },
      { text: "Medio de Pago", value: "medio_pago.medio_pago" },
      { text: "Deuda", value: "deuda" }
    ],
    comprobantes: [],
    loadingTable: false,
    current_page: 1,
    itemsperpage: 25,
    total_reg: 0,
    dataTabOptions: {},
    data_reg: [],
    filter: {
      searchTerm: "",
      fecha_inicio: "",
      fecha_fin: "",
      deuda: "",
      estado: ""
    },

    cajas: [],

    /* PAGOS DEUDAS */
    pagosDeudas: [],

    /* EGRESOS E INGRESOS */
    egresos: {},
    ingresos: {},
    ingresos_totales: [],
    total_ingresos: 0,
    total_egresos: 0,
    headers: [],
    egresosCaja: [],
    cajaActual: {
      id_caja: null,
      monto_inicial: 0
    },
    today: new Date().toISOString().substr(0, 10),
    dateFormatted: vm.formatDate(
      new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10)
    )
  }),
  watch: {
    dataTabOptions(event) {
      this.itemsperpage = event.itemsPerPage;
      this.getComprobantes(
        event.page,
        event.itemsPerPage,
        event.sortDesc,
        event.sortBy[0]
      );
    },
    date(old, current) {
      const vm = this;
      vm.getCajas();
      this.dateFormatted = this.formatDate(this.date);
    }
  },
  mounted() {
    const vm = this;
    vm.ultimaCaja();
  },
  methods: {
    formatDate(date) {
      if (!date) return null;
      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    parseDate(date) {
      if (!date) return null;
      const [day, month, year] = date.split("/");
      return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
    },
    filterData() {
      const vm = this;
      vm.getComprobantes();
      vm.getPagosDeudas();
      vm.loadDetails();
      vm.getEgresos();
    },
    async ultimaCaja() {
      const vm = this;
      const response = await axios.get("api/ultima-caja");
      vm.cajaActual = response.data;
      vm.date = new Date(vm.cajaActual.created_at).toISOString().substr(0, 10);

      vm.getCajas();
      vm.getComprobantes();
      vm.getPagosDeudas();
      vm.loadDetails();
      vm.getEgresos();
    },
    async getEgresos() {
      const vm = this;
      const response = await API.reportes_caja.egresos(
        "?caja=" + vm.cajaActual.id_caja
      );
      vm.egresosCaja = [];
      vm.egresosCaja = response.data;
    },
    async getCajas() {
      const vm = this;
      const response = await axios.get("api/cajas/fecha?date=" + vm.date);
      vm.cajas = response.data;
    },
    async getComprobantes(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      if (this.cajaActual.id_caja == null) return;
      this.loadingTable = true;
      this.data_reg = [];

      try {
        const response = await API.reportes_caja.comprobantes(
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
            "&caja=" +
            this.cajaActual.id_caja
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
    async getPagosDeudas() {
      try {
        const response = await API.reportes_caja.pagosDeudas(
          "?caja=" + this.cajaActual.id_caja
        );

        this.pagosDeudas = response.data;
      } catch (e) {
        console.error(e);
      }
    },
    async loadDetails() {
      const vm = this;
      const { data } = await axios.get(
        "api/caja/detalles/" + vm.cajaActual.id_caja
      );

      vm.ingresos = {};
      vm.egresos = {};
      vm.ingresos_totales = [];

      vm.ingresos = data.data.ingresos;
      vm.egresos = data.data.egresos;

      vm.total_ingresos = 0;
      vm.total_egresos = 0;

      for (let index = 0; index < vm.ingresos.ventas.length; index++) {
        let totalIngreso = {
          medio: vm.ingresos.ventas[index].medio,
          total:
            Number(vm.ingresos.ventas[index].total) +
            Number(vm.ingresos.deudas_clientes[index].total)
        };
        vm.ingresos_totales.push(totalIngreso);
      }
      vm.ingresos_totales.forEach(e => {
        vm.total_ingresos += e.total;
      });

      vm.total_ingresos = Number(vm.total_ingresos).toFixed(2);
      vm.total_egresos = Number(
        vm.egresos.egresos + vm.egresos.cancelaciones
      ).toFixed(2);
    },
    handleNewDate() {
      console.log("new date");
    }
  }
};
</script>
