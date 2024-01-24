<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="cliente.nombre_razon_social"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card class="mb-4" light style="padding: 15px">
      <v-row class="pa-2 align-center" dense>
        <v-col class="text-right">
          <v-btn
            v-if="$can('cuentaspagar_update', 'all')"
            color="info"
            class="mr-2"
            @click="agregarPagoGrupal()"
            :disabled="selectedDebts.length <= 0"
          >
            <v-icon>mdi-cash-multiple</v-icon>Pago Grupal
          </v-btn>
          <v-btn color="#1D6F42" class="mr-2" dark :href="urlToReturn">
            Exportar<v-icon>mdi-file-excel</v-icon>
          </v-btn>
        </v-col></v-row
      >
      <v-data-table
        :headers="headers"
        :items="dataReg.data"
        :page="currentPage"
        :items-per-page="itemsPerPage"
        :server-items-length="totalReg"
        :options.sync="dataTabOptions"
        class="elevation-1"
        :footer-props="{
          itemsPerPageOptions: [25, 50, 100, 250, 500],
          'items-per-page-text': 'Registros por página',
        }"
        :loading="loadingTable"
        loading-text="Cargando... Por favor, espere"
        @click:row="handleDataRowClick"
        ><template v-slot:[`item.select`]="{ item }">
          <v-checkbox
            v-model="selectedDebts"
            :disabled="item.deuda_saldo <= 0"
            :value="item.id_comprobante"
            @click.stop.prevent
          ></v-checkbox>
        </template>
        <template #[`item.index`]="{ item }">
          {{ dataReg.data.indexOf(item) + 1 }}
        </template>
        <template v-slot:[`item.fecha_vencimiento`]="{ item }">
          <div
            v-if="item.saldo > 0 && compareDates(item.fecha_vencimiento) < 0"
            class="font-weight-bold error--text"
          >
            {{ item.fecha_vencimiento | formatDateGeneral }}
          </div>
          <div
            v-else-if="
              item.saldo > 0 && compareDates(item.fecha_vencimiento, 15) > 0
            "
            class="font-weight-bold amber--text"
          >
            {{ item.fecha_vencimiento | formatDateGeneral }}
          </div>
          <div v-else>
            {{ item.fecha_vencimiento | formatDateGeneral }}
          </div>
        </template>
        <template v-slot:[`item.total`]="{ item }">
          s/. {{ item.total }}
        </template>
        <template v-slot:[`item.deuda_saldo`]="{ item }">
          <div class="font-weight-bold error--text">s/. {{ item.saldo }}</div>
        </template>
        <template v-slot:[`item.deuda_total_abonado`]="{ item }">
          <div class="font-weight-bold success--text">
            s/.
            {{
              (
                parseFloat(item.total_abonado) + parseFloat(item.adelanto)
              ).toFixed(2)
            }}
          </div>
        </template>
        <template v-slot:[`item.add_payment`]="{ item }">
          <ClientePaymentModal
            @created="getRegistros"
            v-if="
              (item.condicion_pago == 2 || item.condicion_pago == 3) &&
              item.saldo > 0
            "
            :short="true"
            :receipt="item"
            :methods="metodos"
          />
          <v-chip small v-else-if="item.saldo > 0" class="ma-2" color="error"
            >Deuda Pendiente</v-chip
          >
          <v-chip small v-else class="ma-2" color="success"
            >Deuda Saldada</v-chip
          >
        </template>
        <template v-slot:[`item.detail_payment`]="{ item }">
          <v-btn
            small
            color="deep-orange"
            @click.stop="verDetalleDeuda(item)"
            dark
          >
            <v-icon>mdi-magnify</v-icon>Ver Detalle
          </v-btn>
        </template>
      </v-data-table></v-card
    >
    <ClienteDetailModal />
    <ClientePagoGrupal :methods="metodos" />

    <v-dialog v-model="viewDialog" max-width="50%">
      <v-card>
        <v-card-title>
          <span class="headline">Visualizar Registro</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="viewForm">
            <v-row>
              <v-col cols="12" sm="12" md="12">
                <v-text-field
                  v-model="viewForm.fecha_vencimiento"
                  label="Fecha Vencimiento"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.nro_documento"
                  label="Nro. Documento"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.total"
                  label="Total Deuda"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.adelanto"
                  label="Adelanto"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.saldo"
                  label="Saldo Pendiente"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.total_abonado"
                  label="Total Abonado"
                  readonly
                ></v-text-field>
              </v-col>
            </v-row>
          </v-form>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import API from "../../../api";
import ClienteDetailModal from "../../procesos/cliente/components/ClienteDetailModal.vue";
import ClientePaymentModal from "../../procesos/cliente/components/ClientePaymentModal.vue";
import ClientePagoGrupal from "../../procesos/cliente/components/ClientePagoGrupal.vue";
export default {
  components: {
    ClienteDetailModal,
    ClientePaymentModal,
    ClientePagoGrupal,
  },
  data() {
    return {
      viewDialog: false,
      viewForm: {},

      idCliente: null,
      cliente: {},
      selectedDebts: [],

      metodos: [],

      //--- Datatable ---
      loadingTable: false,
      currentPage: 1,
      pageCount: 1,
      itemsPerPage: 25,
      totalReg: 0,
      dataTabOptions: {},
      dataReg: {},
      headers: [
        { text: "", value: "select" },
        { text: "Nº", value: "index", sortable: false },
        { text: "Fecha V.", value: "fecha_vencimiento", sortable: false },
        { text: "Nro. Documento", value: "nro_documento", sortable: false },
        { text: "Total Deuda", value: "total", sortable: false },
        { text: "Saldo Pendiente", value: "deuda_saldo", sortable: false },
        {
          text: "Total Abonado",
          value: "deuda_total_abonado",
          sortable: false,
        },
        {
          text: "Agregar Pago",
          value: "add_payment",
          sortable: false,
          align: "center",
        },
        {
          text: "Detalle",
          value: "detail_payment",
          sortable: false,
          align: "center",
        },
      ],
      urlToReturn: "",
      selectedDebts: [],
      //--- End ---

      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Pacientes", disabled: false, href: "/pacientes" },
        { text: "Cuenta Corriente" },
      ],
    };
  },
  created() {
    this.idCliente = this.$route.params.id;
    this.getCliente();
    this.getMetodosPago();
  },
  methods: {
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.dataReg = [];
      this.selectedDebts = [];
      const myParams = new URLSearchParams(this.filter).toString();
      try {
        const response = await API.clientes.cuenta_corriente(this.idCliente);
        this.dataReg = response.data;
        this.currentPage = response.data.current_page;
        this.totalReg = this.dataReg.total;
        this.loadingTable = false;
        this.getExportData();
      } catch (e) {
        this.loadingTable = false;
        console.error(e);
      }
    },
    async getCliente() {
      const response = await API.clientes.show(this.idCliente);
      this.cliente = response.data;
    },
    async getMetodosPago() {
      const response = await API.apis.medioPago();
      this.metodos = response.data;
    },
    compareDates(date, range = 0) {
      var today = new Date(this.todaysDateDefault());
      date = new Date(date);
      if (today >= date) {
        // Fecha Venc. es hoy o ya pasó
        return -1;
      }

      today.setDate(today.getDate() + range);
      if (today >= date) {
        // Fecha Venc. se encuentra en los próximos "range" días
        return 1;
      }

      return 0; // Fecha Venc. es lejana
    },
    getExportData() {
      this.urlToReturn =
        "/api/exportPacientesCuenta/?idCliente=" + this.idCliente;
    },
    handleDataRowClick(row) {
      this.viewForm = Object.assign({}, row);
      this.viewDialog = true;
    },
    verDetalleDeuda(item) {
      this.$root.$emit("cliente_pago_detalle", item);
    },
    agregarPagoGrupal() {
      let data = this.dataReg.data.filter((item) => {
        return this.selectedDebts.includes(item.id_comprobante);
      });
      this.$root.$emit("cuentas_pago_grupal", data);
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
  },
};
</script>
