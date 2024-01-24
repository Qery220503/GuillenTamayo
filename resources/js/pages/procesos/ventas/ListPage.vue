<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card class="mb-4">
      <v-row dense class="pa-2 align-center">
        <v-col>
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
        <v-col>
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
        <v-col>
          <v-select
            :items="filter_deuda"
            label="Estado Deuda"
            hide-details
            dense
            outlined
            v-model="filter.tipo"
            item-value="value"
            item-text="text"
          ></v-select>
        </v-col>
        <v-col>
          <v-select
            :items="items_estados"
            label="Estado"
            hide-details
            dense
            outlined
            v-model="filter.estado"
            item-value="id_estado_comprobante"
            item-text="nombre_estado"
          ></v-select>
        </v-col>
        <v-col class="text-right">
          <v-btn color="primary" class="mr-2" @click="getRegistros()">
            Filtrar <v-icon>mdi-filter</v-icon>
          </v-btn>
          <v-btn
            color="deep-orange"
            class="mr-2"
            @click="limpiarFiltros()"
            dark
          >
            Limpiar <v-icon>mdi-broom</v-icon>
          </v-btn>
        </v-col>
      </v-row>
    </v-card>
    <v-card>
      <v-row dense class="pa-2 align-center">
        <v-spacer></v-spacer>
        <v-col class="text-right">
          <v-btn color="primary" class="mr-2" to="/comprobantes/crear" link>
            Crear Comprobante <v-icon>mdi-plus</v-icon>
          </v-btn>
        </v-col>
      </v-row>
      <div dense class="pa-2 align-center overflow-x-auto">
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
            itemsPerPageOptions: [25, 50, 100, 1000],
          }"
          :loading="loadingTable"
          loading-text="Cargando... Por favor, espere"
        >
          <template v-slot:[`item.estado`]="{ item }">
            <v-chip :color="item.estado_comprobante.color" small>
              {{ item.estado_comprobante.nombre_estado }}
            </v-chip>
          </template>
          <template v-slot:[`item.orden_laboratorio`]="{ item }">
            <v-chip
              v-if="item.orden_laboratorio"
              :color="item.orden_laboratorio.status.color"
              small
              :to="
                '/orden-laboratorio/detalle/' +
                item.orden_laboratorio.id_orden_laboratorio
              "
            >
              {{ item.orden_laboratorio.codigo_orden_lab }} -
              {{ item.orden_laboratorio.status.nombre_estado }}
            </v-chip>
            <v-chip v-else small> Sin orden laboratorio </v-chip>
          </template>
          <template v-slot:[`item.correlativo`]="{ item }">
            <div class="one-line">
              {{ item.serie.serie }}-{{
                item.correlativo.toString().padStart(8, "0")
              }}
            </div>
          </template>
          <template v-slot:[`item.nombre_cliente`]="{ item }">
            <div class="one-line">{{ item.nombre_cliente }}</div>
          </template>
          <template v-slot:[`item.fecha_emision`]="{ item }">
            <div class="one-line">
              {{ item.fecha_emision | formatDateGeneral }}
            </div>
          </template>
          <template v-slot:[`item.actions`]="{ item }">
            <PaymentsComponent
              @created="getRegistros"
              v-if="(item.condicion_pago == 2 || item.condicion_pago == 3) && item.saldo > 0"
              :short="true"
              :receipt="item"
              :methods="metodos"
            ></PaymentsComponent>
            <PaymentsList v-if="item.condicion_pago == 2 || item.condicion_pago == 3" :receipt="item" :short="true"></PaymentsList>
            <v-btn small icon :to="'/comprobantes/ver/' + item.id_comprobante">
              <v-icon small>mdi-eye-outline</v-icon>
            </v-btn>

            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  v-if="
                    item.id_tipo_comprobante == 1 ||
                    item.id_tipo_comprobante == 2
                  "
                  small
                  icon
                  :to="'/notas/crear/' + item.id_comprobante"
                  v-bind="attrs"
                  v-on="on"
                >
                  <v-icon small>mdi-note</v-icon>
                </v-btn>
              </template>
              <span>Generar Nota Crédito/Débito</span>
            </v-tooltip>
          </template>
        </v-data-table>
      </div>
    </v-card>

    <!-- Delete Dialog -->
    <v-dialog v-model="deleteDialog" max-width="400">
      <v-card>
        <v-card-title class="d-flex justify-center">
          <span class="headline"
            >¿Estás seguro que deseas anular este registro?</span
          >
        </v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="deleteRegConfirm">Aceptar</v-btn>
          <v-btn color="error" text @click="deleteDialog = false"
            >Cancelar</v-btn
          >
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Fin -->
  </div>
</template>
<script>
import API from "../../../api";
import PaymentsComponent from "./components/PaymentsComponent.vue";
import PaymentsList from "./components/PaymentsList.vue";

export default {
  components: {
    PaymentsComponent,
    PaymentsList,
  },
  data: (vm) => ({
    breadcrumbs_title: "Comprobantes",
    breadcrumbs: [
      { text: "Inicio", disabled: false, href: "#" },
      { text: "Procesos", disabled: false, href: "#" },
      { text: "Comprobantes" },
    ],
    headers: [
      { text: "Comprobante", sortable: false, value: "correlativo" },
      { text: "Cliente", sortable: false, value: "nombre_cliente" },
      { text: "Usuario", sortable: false, value: "usuario.name" },
      { text: "O.Lab", sortable: false, value: "orden_laboratorio" },
      { text: "Fecha", sortable: false, value: "fecha_emision" },
      { text: "Estado", sortable: false, value: "estado" },
      { text: "Total", sortable: false, value: "total" },
      { text: "Adelanto", sortable: false, value: "adelanto" },
      { text: "Saldo", sortable: false, value: "saldo" },
      {
        text: "M. Pago",
        sortable: false,
        value: "medio_pago.medio_pago",
      },
      {
        text: "Acciones",
        value: "actions",
        align: "center",
        sortable: false,
        align: "right",
      },
    ],
    addForm: {
      id_cliente: null,
      nombre_categoria: null,
    },
    filter_estado: [
      { text: "Activo", value: "1" },
      { text: "Anulado", value: "0" },
    ],
    filter_deuda: [
      { text: "Con deuda", value: "1" },
      { text: "Al Contado", value: "0" },
    ],
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
      tipo: "",
      estado: "",
    },
    deleteDialog: false,
    items_estados: [],
    items_tipo_comprobante: [],
    menu2: false,
    menu3: false,
    dateFormatted: vm.formatDate(null),
    dateFormattedEnd: vm.formatDate(null),
    metodos: [],
  }),
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
    limpiarFiltros() {
      this.filter = {
        searchTerm: "",
        fecha_inicio: "",
        fecha_fin: "",
        tipo: "",
        estado: "",
      };
      this.getRegistros();
    },
    async getMetodosPago() {
      const response = await API.apis.medioPago();
      this.metodos = response.data;
    },
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.comprobante.list(
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
            "&tipo=" +
            this.filter.tipo +
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
    deleteReg(item) {
      this.addForm = Object.assign({}, item);
      this.deleteDialog = true;
    },
    async deleteRegConfirm() {
      this.loadingTable = true;
      this.$store.commit("loader", true);
      try {
        const response = await API.compras.remove(this.addForm.id_compra);
        UTILS.toastr.success("Compra anulada correctamente", this);
        this.deleteDialog = false;
        this.getRegistros();
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      } finally {
        this.$store.commit("loader", false);
        this.loadingTable = false;
      }
    },
    async getTipoComprobante() {
      let vm = this;
      try {
        const response = await API.apis.tipoComprobante();
        vm.items_tipo_comprobante = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getEstadoComprobante() {
      let vm = this;
      try {
        const response = await API.apis.estadoComprobante();
        vm.items_estados = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
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
    },
  },
  created() {
    this.getRegistros();
    this.getTipoComprobante();
    this.getEstadoComprobante();
    this.getMetodosPago();
  },
};
</script>
