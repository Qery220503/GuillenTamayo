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
                v-model="filter.fecha_inicio"
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
                v-model="filter.fecha_fin"
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
            ></v-date-picker>
          </v-menu>
        </v-col>
        <v-col>
          <v-autocomplete
            :items="items_usuarios"
            label="Usuarios"
            hide-details
            dense
            outlined
            item-value="id"
            item-text="name"
            v-model="filter.user"
          ></v-autocomplete>
        </v-col>
        <v-col>
          <v-select
            :items="items_estados"
            label="Estado"
            hide-details
            dense
            outlined
            item-value="id_estado_orden_laboratorio"
            item-text="nombre_estado"
            v-model="filter.estado"
          ></v-select>
        </v-col>
        <v-col class="text-right">
          <v-btn color="primary" class="mr-2" @click="getRegistros()">
            Filtrar <v-icon>mdi-filter</v-icon>
          </v-btn>
        <v-btn color="deep-orange" class="mr-2" @click="limpiarFiltros()" dark style="margin-top: 5px;">
            Limpiar <v-icon>mdi-broom</v-icon>
        </v-btn>
        </v-col>
      </v-row>
    </v-card>
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
          <template v-slot:[`item.estado`]="{ item }">
            <v-chip class="ma-2" :color="item.status.color" small>
              <span class="font-weight-medium">{{
                item.status.nombre_estado
              }}</span>
            </v-chip>
          </template>
          <template v-slot:[`item.codigo_orden_lab`]="{ item }">
            <div class="one-line">OL-{{ item.codigo_orden_lab }}</div>
          </template>
          <template v-slot:[`item.created_at`]="{ item }">
            <div class="one-line">{{ item.created_at | formatDateGeneral }}</div>
          </template>
          <template v-slot:[`item.cliente.nombre_razon_social`]="{ item }">
            <div class="one-line">{{ item.cliente.nombre_razon_social }}</div>
          </template>
          <template v-slot:[`item.anamnesis.clinica.nombre_clinica`]="{ item }">
            <div class="one-line">
              {{ item.anamnesis.clinica.nombre_clinica }}
            </div>
          </template>
          <template v-slot:[`item.lente.nombre_propio`]="{ item }">
            <div class="one-line">{{ item.lente.nombre_propio }}</div>
          </template>
          <template v-slot:[`item.doctor`]="{item}">
            <div>
              {{ item.anamnesis.doctor.nombres + " " + (item.anamnesis.doctor.apellidos ?? '')}}
            </div>
          </template>
          <template v-slot:[`item.comprobante_generado`]="{item}">
            <v-chip
              color="primary"
              v-if="item.comprobante_generado"
            >
              Generado
            </v-chip>

            <v-chip
              v-else
              color="secondary"
            >
              Sin generar
            </v-chip>
          </template>
          <template v-slot:[`item.actions`]="{ item }">

            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  small
                  icon
                  :to="'/orden-laboratorio/detalle/' + item.id_orden_laboratorio"
                  link
                  v-bind="attrs"
                  v-on="on"
                >
                  <v-icon small>mdi-eye-outline</v-icon>
                </v-btn>
              </template>
              <span>Ver Orden</span>
            </v-tooltip>



            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">

                <v-btn
                  v-bind="attrs"
                  v-on="on"
                  small
                  icon
                  :href="'/ordenLaboratorioPDF/' + item.id_orden_laboratorio"
                  target="_blank"
                >
                  <v-icon small>mdi-file-pdf-box</v-icon>
                </v-btn>
              </template>
              <span>PDF</span>
            </v-tooltip>




            <v-tooltip bottom v-if="!item.comprobante_generado">
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                small
                icon
                @click="retakeAnamnesis(item)"
                v-bind="attrs"
                v-on="on"
                >
                  <v-icon small>mdi-receipt</v-icon>
                </v-btn>
              </template>
              <span>Facturar</span>
            </v-tooltip>
          </template>
        </v-data-table>
      </v-row>
    </v-card>
  </div>
</template>
<script>
import API from "../../../api";

export default {
  data() {
    return {
      breadcrumbs_title: "Órdenes de Laboratorio",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Órdenes de Laboratorio" }
      ],
      headers: [
        { text: "#", value: "codigo_orden_lab", align: "left" },
        { text: "Fecha", value: "created_at", align: "left" },
        {
          text: "Cliente",
          value: "cliente.nombre_razon_social",
          align: "left"
        },
        { text: "Lente", value: "lente.nombre_propio", align: "left" },
        {
          text: "Clínica",
          sortable: false,
          value: "anamnesis.clinica.nombre_clinica",
          align: "left"
        },
        { text: "Comprobante", value: "comprobante_generado", align: "center", sortable: false},
        {
          text: "Doctor",
          sortable: false,
          value: "doctor",
          align: "left"
        },
        {
          text: "Estado",
          sortable: false,
          value: "estado",
          align: "center"
        },
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
        searchTerm: "",
        fecha_inicio: "",
        fecha_fin: "",
        user: "",
        estado: ""
      },
      items_estados: [],
      items_usuarios: [],
      menu2: false,
      menu3: false
    };
  },
  methods: {
    limpiarFiltros() {
        this.filter = {
            searchTerm: "",
            fecha_inicio: "",
            fecha_fin: "",
            user: "",
            estado: ""
        };
        this.getRegistros();
    },
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.orden_laboratorio.list(
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
            "&fecha_inicio=" +
            this.filter.fecha_inicio +
            "&fecha_fin=" +
            this.filter.fecha_fin +
            "&user=" +
            this.filter.user +
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
    async getEstados() {
      let vm = this;
      try {
        const response = await API.orden_laboratorio.estados();
        vm.items_estados = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getUsuarios() {
      let vm = this;
      try {
        const response = await API.users.combo();
        vm.items_usuarios = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    retakeAnamnesis(item){
      this.$router.push('/anamnesis?anamnesis=' + item.id_anamnesis);
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
    }
  },
  created() {
    this.getRegistros();
    this.getEstados();
    this.getUsuarios();
  }
};
</script>
