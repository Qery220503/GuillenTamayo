<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card class="mb-4">
      <v-row dense class="pa-2 align-center">
        <v-col cols="3">
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
                v-model="dateFormatted"
                @blur="filter.fecha_inicio = parseDate(dateFormatted)"
                label="Fecha Inicio"
                prepend-inner-icon="mdi-calendar"
                readonly
                hide-details
                dense
                outlined
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="filter.fecha_inicio"
              @input="menu2 = false"
              no-title
            ></v-date-picker>
          </v-menu>
        </v-col>
        <v-col cols="3">
          <v-menu
            v-model="menu3"
            :close-on-content-click="false"
            :nudge-right="40"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                @blur="filter.fecha_fin = parseDate(dateFormattedEnd)"
                v-model="dateFormattedEnd"
                label="Fecha Fin"
                prepend-inner-icon="mdi-calendar"
                readonly
                hide-details
                dense
                outlined
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="filter.fecha_fin"
              @input="menu3 = false"
              no-title
            ></v-date-picker>
          </v-menu>
        </v-col>
        <v-col cols="4">
          <v-autocomplete
            :items="filter_productos"
            label="Producto"
            hide-details
            dense
            outlined
            v-model="filter.producto"
            item-text="nombre_producto"
            item-value="id_producto"
          ></v-autocomplete>
        </v-col>
        <v-col cols="2">
          <v-select
            :items="filter_estado"
            label="Estado"
            hide-details
            dense
            outlined
            v-model="filter.estado"
          ></v-select>
        </v-col>
        <v-col class="text-right">
          <v-btn
            color="#1D6F42"
            class="mr-2"
            dark
            :href="
              '/api/exportStockMovimientos' +
                '?fecha_inicio=' +
                filter.fecha_inicio +
                '&fecha_fin=' +
                filter.fecha_fin +
                '&producto=' +
                filter.producto +
                '&estado=' +
                filter.estado
            "
          >
            Exportar<v-icon>mdi-file-excel</v-icon>
          </v-btn>
          <v-btn color="primary" class="mr-2" @click="getRegistros()">
            Filtrar <v-icon>mdi-filter</v-icon>
          </v-btn>
          <v-btn color="deep-orange" class="mr-2" @click="limpiarFiltros()" dark>
            Limpiar <v-icon>mdi-broom</v-icon>
          </v-btn>
        </v-col>
      </v-row>
    </v-card>
    <v-card>
      <v-row dense class="pa-2 align-center overflow-x-auto ">
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
          <template v-slot:[`item.cantidad`]="{ item }">
            <div>
              <v-icon
                class="green--text darken-1"
                v-if="Number(item.stock_actual) > Number(item.stock_inicial)"
              >
                mdi-arrow-up
              </v-icon>
              <v-icon
                class="red--text darken-2"
                v-if="Number(item.stock_inicial) > Number(item.stock_actual)"
              >
                mdi-arrow-down
              </v-icon>
              <strong
                class="green--text darken-1"
                v-if="Number(item.stock_actual) > Number(item.stock_inicial)"
              >
                {{ item.cantidad }}
              </strong>
              <strong
                class="red--text darken-2"
                v-if="Number(item.stock_inicial) > Number(item.stock_actual)"
              >
                {{ item.cantidad }}
              </strong>
            </div>
          </template>
        </v-data-table>
      </v-row>
    </v-card>
  </div>
</template>
<script>
import API from "../../../api";

export default {
  components: {},
  data: vm => ({
    breadcrumbs_title: "Movimientos en Almacén",
    breadcrumbs: [
      { text: "Inicio", disabled: false, href: "#" },
      { text: "Procesos", disabled: false, href: "#" },
      { text: "Movimientos en Almacén" }
    ],
    headers: [
      { text: "Codigo", sortable: false, value: "codigo_producto" },
      { text: "Producto", sortable: false, value: "nombre_producto" },
      { text: "Tipo Movimiento", sortable: false, value: "tipo_movimiento.tipo_movimiento" },
      { text: "Fecha Movimiento", sortable: false, value: "fecha_parse" },
      { text: "Stock Inicial", sortable: false, value: "stock_inicial" },
      { text: "Cantidad", sortable: false, value: "cantidad" },
      { text: "Stock Actual", sortable: false, value: "stock_actual" }
    ],
    addForm: {
      id_cliente: null,
      nombre_categoria: null
    },
    filter_estado: [
      { text: "Entrada Compra", value: "1" },
      { text: "Salida Venta", value: "2" },
      { text: "Devolución", value: "3" },
      { text: "Entrada Manual", value: "4" }
    ],
    filter_productos: [],
    //--- Datatable ---
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
      producto: "",
      estado: ""
    },
    menu2: false,
    menu3: false,
    selectedCompras: [],
    dateFormatted: vm.formatDate(null),
    dateFormattedEnd: vm.formatDate(null)
  }),
  methods: {
    limpiarFiltros() {
        this.filter = {
            searchTerm: "",
            fecha_inicio: "",
            fecha_fin: "",
            producto: "",
            estado: ""
        };
        this.getRegistros();
    },
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.almacen_movimientos.list(
          "?page=" +
            page +
            "&itemsPerPage=" +
            per_page +
            "&sortDesc=" +
            sortDesc +
            "&sortBy=" +
            sortBy +
            "&fecha_inicio=" +
            this.filter.fecha_inicio +
            "&fecha_fin=" +
            this.filter.fecha_fin +
            "&producto=" +
            this.filter.producto +
            "&estado=" +
            this.filter.estado
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
    async getProductos() {
      let vm = this;
      try {
        const response = await API.productos.combo();
        vm.filter_productos = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    formatDate(date) {
      if (!date) return null;
      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    parseDate(date) {
      if (!date) return null;
      const [day, month, year] = date.split("/");
      return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
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
    },
    "filter.fecha_inicio"(val) {
      this.dateFormatted = this.formatDate(this.filter.fecha_inicio);
    },
    "filter.fecha_fin"(val) {
      this.dateFormattedEnd = this.formatDate(this.filter.fecha_fin);
    }
  },
  created() {
    this.getRegistros();
    this.getProductos();
  },
  mounted() {
    let vm = this;
    vm.$root.$on("compras_reload", () => {
      vm.getRegistros();
    });
  }
};
</script>
