<template>
    <div>
        <v-data-table
    light
    :headers="headers"
    :items="tableData"
    :page="currentPage"
    :items-per-page="itemsPerPage"
    :options.sync="dataTabOptions"

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
    
</template>

<script>

export default {
  data() {
    return {
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
        { text: "M. Pago",
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
      filter: {
      searchTerm: "",
      fecha_inicio: "",
      fecha_fin: "",
      tipo: "",
      estado: "",
    },
      tableData: [],
      currentPage: 1,
      pageCount: 1,
      itemsPerPage: 25,
      totalReg: 0,
      dataTabOptions: {},
      loadingTable: false,
    };
  },

  methods: {
    async getRegistrosComprobantes(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
    const id_cliente = this.$route.params.id;
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
            this.filter.estado +
            "&id_cliente=" +
            id_cliente 

        );
        this.tableData = response.data.data;
        console.log(response.data.data);
        console.log(this.tableData);
        this.current_page = response.data.current_page;
        this.total_reg = this.data_reg.total;
        this.loadingTable = false;

      } catch (e) {
        this.loadingTable = false;
        console.error(e);
      }
    },
  },
  created() {
    //this.getRegistrosComprobantes();
  },
  watch: {
    "filter.fecha_inicio"(val) {
      this.dateFormatted = this.formatDate(this.filter.fecha_inicio);
    },
    "filter.fecha_fin"(val) {
      this.dateFormattedEnd = this.formatDate(this.filter.fecha_fin);
    },
    dataTabOptions(event) {
      this.itemsperpage = event.itemsPerPage;
      this.getRegistrosComprobantes(
        event.page,
        event.itemsPerPage,
        event.sortDesc,
        event.sortBy[0]
      );
    },
    
  },
};
</script>

<style>


</style>

