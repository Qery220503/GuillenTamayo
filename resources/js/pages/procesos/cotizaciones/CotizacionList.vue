<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card>
      <v-row dense class="pa-2 align-center">
        <v-spacer></v-spacer>
        <v-col v-if="$can('cotizaciones_create', 'all')" class="text-right">
          <v-btn color="info" class="mr-2" @click="openCotizacion()">
            Agregar Cotizacion <v-icon>mdi-cash</v-icon>
          </v-btn>
        </v-col>
      </v-row>
      <v-row dense class="pa-2 align-center overflow-x-auto">
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
          <template v-slot:body.prepend>
            <tr>
              <td>
                <v-text-field
                  type="text"
                  outlined
                  dense
                  class="mt-1"
                  hide-details
                  v-model="filter.correlativo"
                  @input="searchCotizaciones()"
                ></v-text-field>
              </td>
              <td>
                <v-text-field
                  type="text"
                  outlined
                  dense
                  class="mt-01"
                  hide-details
                  v-model="filter.cliente"
                  @input="searchCotizaciones()"
                ></v-text-field>
              </td>
              <td>
                <!--<v-text-field
                  type="date"
                  outlined
                  dense
                  class="mt-1"
                  hide-details
                  v-model="filter.fecha"
                  @input="searchCotizaciones()"
                ></v-text-field>-->

                <v-menu
                  v-model="menu"
                  :close-on-content-click="false"
                  :nudge-right="40"
                  transition="scale-transition"
                  offset-y
                  min-width="auto"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                      v-model="filter.fecha"
                      outlined
                      dense
                      hide-details
                      v-bind="attrs"
                      v-on="on"
                      readonly
                      @change="searchCotizaciones()"
                      clearable
                    ></v-text-field>
                  </template>
                  <v-date-picker
                    v-model="filter.fecha"
                    @input="
                      menu = false;
                      searchCotizaciones();
                    "
                  ></v-date-picker>
                </v-menu>
              </td>
              <td>
                <v-btn small icon @click="limpiarFiltros">
                  <v-icon small>mdi-broom</v-icon>
                </v-btn>
              </td>
            </tr>
          </template>

          <template v-slot:[`item.created_at`]="{ item }">
            {{ item.created_at | formatDateGeneral }}
          </template>
          <template v-slot:[`item.cliente`]="{ item }">
            <div
              :class="{
                indicador: true,
                indicador_rojo: item.cliente.lista_negra == 1,
              }"
              style="
                width: 5px;
                height: 5px;
                display: inline-block;
                border-radius: 50%;
              "
            ></div>
            <span>{{ item.cliente.nombre_razon_social }}</span>
          </template>

          <template v-slot:[`item.correlativo`]="{ item }">
            {{ item.serie.serie }}-{{ formatCorrelativo(item.correlativo) }}
          </template>
          <template v-slot:[`item.actions`]="{ item }">
            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  color="primary"
                  icon
                  v-bind="attrs"
                  v-on="on"
                  @click="loadDetallesCotizacion(item.id_cotizacion)"
                >
                  <v-icon small>mdi-file-cog-outline</v-icon>
                </v-btn>
              </template>
              <span>Cotización por opción</span>
            </v-tooltip>

            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  color="primary"
                  icon
                  :href="'/cotizacionPDf/' + item.id_cotizacion"
                  target="_blank"
                  v-bind="attrs"
                  v-on="on"
                >
                  <v-icon small>mdi-file-multiple</v-icon>
                </v-btn>
              </template>
              <span>Cotización Global</span>
            </v-tooltip>
          </template>
        </v-data-table>
      </v-row>
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

    <!-- Listado de cotizaciones -->
    <v-dialog
      v-model="cotizacionesDialog"
      scrollable
      :overlay="false"
      width="85%"
    >
      <v-card>
        <v-card-text>
          <v-data-table
            :headers="headersCotizacion"
            :items="detalle_cotizacion"
            show-select
            v-model="seleccionCotizaciones"
            item-key="id_cotizacion_detalle"
          >
            <template v-slot:top>
              <v-toolbar flat>
                <v-toolbar-title>
                  <b>DETALLE COTIZACIÓN</b>
                </v-toolbar-title>
                <v-divider class="mx-4" inset vertical></v-divider>
                <v-spacer></v-spacer>
                <v-btn color="primary" @click="generatePDF">Generar</v-btn>
              </v-toolbar>
            </template>
            <template v-slot:[`item.actions`]="{ item }">
              <v-btn
                icon
                small
                color="blue darken-4"
                class="ml-1"
                @click="
                  loadPdfOpcion(item.id_cotizacion, item.id_cotizacion_detalle)
                "
              >
                <v-icon>mdi-file-pdf-box</v-icon>
              </v-btn>
            </template>
          </v-data-table>
        </v-card-text>
      </v-card>
    </v-dialog>
    <!-- Seleccionar cliente cotizacion -->
    <v-dialog
      v-model="dialogCliente"
      @click:outside="resetCotizacion"
      max-width="60%"
    >
      <v-card>
        <v-card-title class="text-h5">
          Crear Cotización
          <div
            :class="{
              indicador: true,
              indicador_rojo: cliente.lista_negra == 1,
            }"
          ></div>
        </v-card-title>

        <v-card-text class="px-5">
          <v-form
            ref="clientForm"
            v-model="valid"
            @submit.prevent="sendCotizacion()"
          >
            <v-row class="mt-2" style="padding: 0px 10px !important">
              <v-col class="py-2 px-1" cols="12" md="4">
                <v-select
                  :items="items_tipo_doc"
                  label="Tipo Documento"
                  placeholder="Selecciona un tipo documento"
                  v-model="cliente.cod_tipo_doc"
                  :rules="[rules.required]"
                  required
                  item-text="nombre_tipo_documento"
                  item-value="id_tipo_documento"
                  filled
                  dense
                ></v-select>
              </v-col>
              <v-col class="py-2 px-1" cols="12" md="4">
                <v-text-field
                  v-model="cliente.nro_documento"
                  label="Nro. Documento"
                  :rules="[rules.required, rules.dni]"
                  v-if="cliente.cod_tipo_doc == 1"
                  filled
                  dense
                  autocomplete="off"
                  maxlength="8"
                >
                  <template #append-outer>
                    <v-btn
                      color="primary"
                      class="mb-1"
                      @click="obtenerDataDocumentos()"
                    >
                      <v-icon>mdi-magnify</v-icon>
                    </v-btn>
                  </template>
                </v-text-field>
                <v-text-field
                  v-model="cliente.nro_documento"
                  label="Nro. Documento"
                  :rules="[rules.required, rules.ruc]"
                  v-if="cliente.cod_tipo_doc == 2"
                  filled
                  dense
                  autocomplete="off"
                  maxlength="11"
                >
                  <template #append-outer>
                    <v-btn
                      color="primary"
                      class="mb-1"
                      @click="obtenerDataDocumentos()"
                    >
                      <v-icon>mdi-magnify</v-icon>
                    </v-btn>
                  </template>
                </v-text-field>
                <v-text-field
                  v-model="cliente.nro_documento"
                  label="Nro. Documento"
                  :rules="[rules.required, rules.maxlength]"
                  v-if="cliente.cod_tipo_doc != 1 && cliente.cod_tipo_doc != 2"
                  filled
                  dense
                  autocomplete="off"
                >
                  <template #append-outer>
                    <v-btn
                      color="primary"
                      class="mb-1"
                      @click="obtenerDataDocumentos()"
                    >
                      <v-icon>mdi-magnify</v-icon>
                    </v-btn>
                  </template>
                </v-text-field>
              </v-col>
              <v-col class="py-2 px-1" cols="12" md="4">
                <v-text-field
                  v-model="cliente.nombre_razon_social"
                  label="Nombre"
                  :rules="[rules.required, rules.maxlength]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
              </v-col>
              <v-col class="py-2 px-1" cols="12" md="4">
                <v-menu
                  v-model="menu2"
                  :close-on-content-click="false"
                  transition="scale-transition"
                  offset-y
                  min-width="auto"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                      v-model="cliente.fecha_nacimiento"
                      label="Fecha Nacimiento"
                      prepend-inner-icon="mdi-calendar"
                      v-bind="attrs"
                      v-on="on"
                      :rules="[rules.required]"
                      dense
                      filled
                    ></v-text-field>
                  </template>
                  <v-date-picker
                    v-model="cliente.fecha_nacimiento"
                    @input="menu2 = false"
                    :max="limitDate"
                    no-title
                  ></v-date-picker>
                </v-menu>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field
                  v-model="cliente.telefono"
                  label="Teléfono Principal"
                  maxlength="9"
                  :rules="[rules.phoneNumber]"
                  filled
                  dense
                  autocomplete="off"
                ></v-text-field>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field
                  v-model="cliente.telefono_adic"
                  label="Teléfono Adicional"
                  maxlength="9"
                  :rules="[rules.phoneNumber]"
                  filled
                  dense
                  autocomplete="off"
                ></v-text-field>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field
                  v-model="cliente.email"
                  label="Correo Electrónico"
                  :rules="[rules.email]"
                  filled
                  dense
                  autocomplete="off"
                  type="email"
                ></v-text-field>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-select
                  :items="items_ocupacion"
                  label="Ocupación/Trabajo"
                  placeholder="Selecciona una ocupación"
                  v-model="cliente.id_ocupacion"
                  filled
                  dense
                  item-text="nombre_ocupacion"
                  item-value="id_ocupacion"
                ></v-select>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-select
                  :items="items_departamento"
                  label="Departamento"
                  placeholder="Selecciona un departamento"
                  v-model="cliente.id_departamento"
                  :rules="[rules.required]"
                  filled
                  dense
                  item-text="nombre_departamento"
                  item-value="id_departamento"
                ></v-select>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-select
                  :items="items_provincia"
                  label="Provincia"
                  placeholder="Selecciona una provincia"
                  v-model="cliente.id_provincia"
                  :rules="[rules.required]"
                  filled
                  dense
                  item-text="nombre_provincia"
                  item-value="id_provincia"
                ></v-select>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-select
                  :items="items_distrito"
                  label="Distrito"
                  placeholder="Selecciona un distrito"
                  v-model="cliente.id_distrito"
                  :rules="[rules.required]"
                  filled
                  dense
                  item-text="nombre_distrito"
                  item-value="id_distrito"
                ></v-select>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field
                  v-model="cliente.direccion"
                  label="Dirección"
                  :rules="[rules.required]"
                  filled
                  dense
                  autocomplete="off"
                ></v-text-field>
              </v-col>
            </v-row>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="error" class="ml-2" @click="resetCotizacion"
                >Cancelar</v-btn
              >
              <v-btn color="primary" type="submit">
                <v-icon>mdi-cash-multiple</v-icon>Cotizar
              </v-btn>
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import API from "../../../api";

export default {
  data() {
    return {
      breadcrumbs_title: "Cotizaciones",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Cotizaciones" },
      ],
      headers: [
        { text: "Correlativo", sortable: false, value: "correlativo" },
        {
          text: "Cliente",
          sortable: false,
          value: "cliente",
        },
        { text: "Fecha", sortable: false, value: "created_at" },
        {
          text: "Acciones",
          value: "actions",
          align: "center",
          sortable: false,
          align: "right",
        },
      ],
      valid: false,
      addForm: {},
      //--- Datatable ---
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
      total_reg: 0,
      dataTabOptions: {},
      data_reg: [],
      filter: {
        searchTerm: "",
        correlativo: "",
        cliente: "",
        fecha: "",
      },
      limitDate: new Date().toISOString().substr(0, 10),
      deleteDialog: false,

      /* Detalles de cotizacion */
      detalle_cotizacion: [],
      cotizacionesDialog: false,
      headersCotizacion: [
        { text: "Lente", value: "precio_lente.nombre_propio" },
        { text: "Precio Lente.", value: "precio_lente.precio_venta" },
        { text: "Montura", value: "producto.nombre_producto" },
        { text: "Precio Montura.", value: "producto.precio_venta" },
        {
          text: "Acciones",
          value: "actions",
          align: "center",
          sortable: false,
        },
      ],
      /* CLIENTE */
      dialogCliente: false,
      items_ocupacion: [],
      items_tipo_doc: [],
      cliente: {
        cod_tipo_doc: 1,
        nro_documento: "",
        nombre_razon_social: null,
        direccion: null,
        id_departamento: 4,
        id_provincia: 401,
        id_distrito: 40101,
        lista_negra: 0,
      },
      rules: {
        required: UTILS.nRules.required,
        dni: UTILS.nRules.min8,
        ruc: UTILS.nRules.min811,
        only_numbers: UTILS.nRules.only_numbers,
        email: UTILS.nRules.email,
        phoneNumber: UTILS.nRules.phoneLength,
        maxlength: UTILS.nRules.maxLength
      },
      datosBus: {
        tipoDoc: null,
        numDoc: null,
      },
      items_departamento: [],
      items_provincia: [],
      items_distrito: [],
      menu2: false,
      menu: false,
      seleccionCotizaciones: [],
      selectedCotizacion: null,
    };
  },
  methods: {
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      if (this.filter.fecha == null) this.filter.fecha = "";
      const extraParams = new URLSearchParams(this.filter).toString();
      try {
        const response = await API.cotizaciones.list(
          "?page=" +
            page +
            "&itemsPerPage=" +
            per_page +
            "&sortDesc=" +
            sortDesc +
            "&sortBy=" +
            sortBy +
            "&" +
            extraParams
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
    limpiarFiltros() {
      this.filter = {
        searchTerm: "",
        correlativo: "",
        cliente: "",
        fecha: "",
      };
      this.getRegistros();
    },
    formatCorrelativo(ct) {
      let c = ct.toString().padStart(8, "0");
      console.log(c, "PAD");
      return c;
    },
    async deleteRegConfirm(data) {
      console.log(data, "Data");
    },
    async loadDetallesCotizacion(id_cotizacion) {
      const vm = this;
      vm.selectedCotizacion = id_cotizacion;
      const response = await API.cotizaciones.detalle(id_cotizacion);
      vm.detalle_cotizacion = response.data;
      vm.cotizacionesDialog = true;
    },
    async loadPdfOpcion(id_cotizacion, id_cotizacion_detalle) {
      const vm = this;
      const detalle = [id_cotizacion_detalle];
      let pdfURL = "/cotizacionPDf/" + id_cotizacion + "/" + detalle.join(",");
      vm.cotizacionesDialog = false;
      window.open(pdfURL, "Cotizacion", "width=500,height=600");
    },
    async openCotizacion() {
      const vm = this;
      vm.dialogCliente = true;
    },
    async obtenerDataDocumentos() {
      try {
        Object.assign(this.cliente, {
          nombre_razon_social: null,
          direccion: null,
          id_departamento: 4,
          id_provincia: 401,
          id_distrito: 40101,
          lista_negra: null,
        });

        this.$store.commit("loader", true);
        this.datosBus.tipoDoc = this.cliente.cod_tipo_doc;
        this.datosBus.numDoc = this.cliente.nro_documento;

        const rpta = await API.apis.dniruc(this.datosBus);
        if (rpta.data.success === true) {
          UTILS.toastr.success(
            "Paciente encontrado en RENIEC, debe llenar los demás datos del paciente",
            this
          );
          if (this.datosBus.tipoDoc === 2) {
            this.cliente.nombre_razon_social = rpta.data.nombre_o_razon_social;
            this.cliente.direccion = rpta.data.direccion_completa;
            if (
              rpta.data.estado == "ACTIVO" &&
              rpta.data.condicion == "HABIDO"
            ) {
              UTILS.toastr.success(
                "El documento ingresado se encuentra ACTIVO y HABIDO",
                this
              );
            } else {
              UTILS.toastr.info(
                "Cuidado, el documento ingresado se encuentra " +
                  rpta.data.estado +
                  " y " +
                  rpta.data.condicion,
                this
              );
            }
            this.$store.commit("loader", false);
          } else if (this.datosBus.tipoDoc === 1) {
            this.cliente.nombre_razon_social =
              rpta.data.result.Nombres + " " + rpta.data.result.Apellidos;
            this.cliente.direccion = rpta.data.direccion_completa;
            this.$store.commit("loader", false);
          }
        } else {
          this.$store.commit("loader", false);
        }
        this.$store.commit("loader", false);
      } catch (error) {
        this.$store.commit("loader", false);
        console.error(error, "ERROR");
      }
    },
    async buscarPaciente() {
      const vm = this;
      try {
        const response = await API.clientes.buscar(
          "?nro_nro_documento=" +
            vm.cliente.nro_documento +
            "&cod_tipo_doc=" +
            vm.cliente.cod_tipo_doc
        );
        if (!response.data.success) {
          vm.obtenerDataDocumentos();
        } else {
          vm.cliente = response.data.data;
          console.log(vm.cliente);
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getDepartamento() {
      let vm = this;
      try {
        const response = await API.ubigeo.departamentos();
        vm.items_departamento = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getProvincia(id_departamento) {
      let vm = this;
      try {
        const response = await API.ubigeo.provincias(id_departamento);
        vm.items_provincia = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getDistrito(id_provincia) {
      let vm = this;
      try {
        const response = await API.ubigeo.distritos(id_provincia);
        vm.items_distrito = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getOcupacion() {
      let vm = this;
      try {
        const response = await API.clientes.ocupacion();
        vm.items_ocupacion = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getTipos() {
      let vm = this;
      try {
        const response = await API.tipos_documentos.combo();
        vm.items_tipo_doc = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async sendCotizacion() {
      if (this.$refs.clientForm.validate()) {
        const response = await API.clientes.verificar(this.cliente);
        this.$router.push({
          path: "/cotizaciones/" + response.data.id_cliente + "/anamnesis",
        });
      }
    },
    resetCotizacion() {
      this.dialogCliente = false;
      Object.assign(this.cliente, {
        cod_tipo_doc: 1,
        nro_documento: "",
        nombre_razon_social: null,
        direccion: null,
        id_departamento: 4,
        id_provincia: 401,
        id_distrito: 40101,
        lista_negra: null,
      });
    },
    searchCotizaciones() {
      this.getRegistros();
    },
    generatePDF() {
      console.log(this.seleccionCotizaciones);

      const detalles = this.seleccionCotizaciones.map(
        (e) => e.id_cotizacion_detalle
      );

      let pdfURL =
        "/cotizacionPDf/" + this.selectedCotizacion + "/" + detalles.join(",");

      this.cotizacionesDialog = false;
      window.open(pdfURL, "Cotizacion", "width=500,height=600");

      console.log(pdfURL, detalles);
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
    "cliente.nro_documento"(value) {
      if (value == null || value == undefined) return;
      let isRuc = value.substr(0, 2);
      if (value.length == 8 && !(isRuc == 10 || isRuc == 20)) {
        this.buscarPaciente();
      }
      if (value.length == 11) {
        this.buscarPaciente();
      }
    },
  },

  created() {
    let vm = this;
    vm.getRegistros();
    vm.getTipos();
    vm.getOcupacion();
    vm.getDepartamento();
    vm.getProvincia(4);
    vm.getDistrito(401);
  },
  mounted() {},
};
</script>
<style scoped>
.indicador {
  width: 15px;
  height: 15px;
  border-radius: 100%;
  margin-left: 10px;
  background-color: gainsboro;
}

.indicador_rojo {
  background-color: red;
}
</style>
