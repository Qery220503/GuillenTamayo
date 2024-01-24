<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <div class="my-2">
      <v-form ref="form" v-model="validForm">
        <v-card class="mb-4" light style="padding: 15px">
          <v-row dense class="pa-2">
            <v-col cols="12" sm="4" class="d-flex justify-center align-center">
              <v-autocomplete
                label="Buscar proveedor por nombre o nro. documento"
                v-model="providerRes"
                :items="itemsProvider"
                item-value="id_proveedor"
                :item-text="ProviderItemText"
                :search-input.sync="searchProvider"
                v-on:change="handleSubmitProvider()"
                :loading="isLoadingProvider"
                return-object
                clearable
                hide-no-data
              >
              </v-autocomplete>
            </v-col>
            <v-col class="text-right align-center">
              <v-btn depressed color="success" @click="addDialog = true">
                <v-icon right dark class="ma-2 white--text">mdi-plus</v-icon
                >Nuevo Proveedor
              </v-btn>
            </v-col>
          </v-row>
          <v-divider></v-divider>
          <v-row dense class="pa-2">
            <v-col cols="12" md="4">
              <v-select
                label="Serie"
                placeholder="Selecciona una serie"
                v-model="form.header.id_serie"
                :rules="[rules.required]"
                dense
                filled
                item-text="serie"
                item-value="id_serie"
                :items="series"
              ></v-select>
            </v-col>
            <v-col cols="4">
              <v-text-field
                v-model="form.header.nombre_proveedor"
                :rules="[rules.required]"
                label="Nombre Proveedor"
                disabled
                filled
                dense
              ></v-text-field>
            </v-col>
            <v-col cols="4">
              <v-text-field
                v-model="form.header.nro_documento"
                :rules="[rules.required]"
                label="Nro. Documento"
                disabled
                filled
                dense
              ></v-text-field>
            </v-col>
            <v-col cols="4">
              <v-text-field
                v-model="form.header.direccion_proveedor"
                :rules="[rules.required]"
                label="Dirección Proveedor"
                disabled
                filled
                dense
              ></v-text-field>
            </v-col>
            <v-col cols="4">
              <v-text-field
                v-model="form.header.guia_factura"
                :rules="[rules.required]"
                label="Guía/Factura"
                filled
                dense
              ></v-text-field>
            </v-col>
            <v-col cols="4">
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
                    label="Fecha de emisión"
                    filled
                    dense
                    v-bind="attrs"
                    @blur="form.header.fecha = parseDate(dateFormatted)"
                    v-on="on"
                    readonly
                  ></v-text-field>
                </template>
                <v-date-picker
                  v-model="form.header.fecha"
                  no-title
                  @input="menu1 = false"
                  :allowed-dates="allowedDates"
                  :min="currentDate"
                  @update:picker-date="pickerUpdate($event)"
                ></v-date-picker>
              </v-menu>
            </v-col>
            <v-col cols="4">
              <v-select
                v-model="form.header.id_origen_dinero"
                :items="origen_dinero"
                label="Origen Dinero"
                item-text="nombre_origen"
                item-value="id_origen_dinero"
                :rules="[rules.required]"
                filled
                dense
              ></v-select>
            </v-col>
            <v-col cols="4">
              <v-select
                label="Tipo"
                v-model="form.header.id_medio_pago"
                :items="medios_pago"
                item-text="medio_pago"
                item-value="id_medio_pago"
                filled
                dense
              ></v-select>
            </v-col>
            <v-col cols="4">
              <v-text-field
                v-model="form.header.referencia"
                label="Referencia"
                filled
                dense
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-textarea
                v-model="form.observaciones"
                label="Observaciones (Opcional)"
                rows="2"
                filled
                dense
              ></v-textarea>
            </v-col>
          </v-row>
          <v-divider></v-divider>
          <br />
          <v-row dense class="pa-2">
            <v-col cols="9">
              <v-autocomplete
                v-model="get_producto"
                :items="items_producto"
                :search-input.sync="search_productos"
                hide-no-data
                hide-selected
                item-text="Description"
                item-value="API"
                label="Buscar Producto"
                placeholder="Buscar Producto"
                return-object
              ></v-autocomplete>
            </v-col>
            <v-spacer></v-spacer>
            <v-col cols="auto">
              <v-btn depressed @click="addCustomDetail()">
                <v-icon class="ma-2">mdi-plus</v-icon>
                Añadir Fila
              </v-btn>
            </v-col>
          </v-row>
          <v-simple-table>
            <template v-slot:default>
              <thead>
                <tr>
                  <th style="width: 5%" class="text-left"></th>
                  <th class="text-left">Código</th>
                  <th class="text-left">Producto</th>
                  <th style="width: 10%" class="text-left">Unidad</th>
                  <th style="width: 10%" class="text-left">CNT</th>
                  <th style="width: 15%" class="text-left">Acciones</th>
                  <th style="width: 15%" class="text-left">P.U (S/.)</th>
                  <th style="width: 15%" class="text-left">P.T (S/.)</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(item, index) in form.detail" :key="index">
                  <td>
                    <v-btn @click="deleteItem(index)" small color="error" icon
                      ><v-icon small> mdi-delete</v-icon>
                    </v-btn>
                  </td>
                  <td>
                    <v-text-field
                      v-model="item.codigo_producto"
                      hide-details="auto"
                    ></v-text-field>
                  </td>
                  <td>
                    <v-text-field
                      v-model="item.nombre_producto"
                      hide-details="auto"
                    ></v-text-field>
                  </td>
                  <td>
                    <v-text-field
                      v-model="item.unidad_medida"
                      hide-details="auto"
                    ></v-text-field>
                  </td>
                  <td>
                    <v-text-field
                      v-on:change="calcularTotalFila(index)"
                      v-model="item.cantidad"
                      type="number"
                      min="0"
                      hide-details="auto"
                    ></v-text-field>
                  </td>
                  <td>
                    <v-checkbox
                      v-model="item.precio_sin_igv"
                      label="Precio sin IGV"
                      hide-details
                    ></v-checkbox>
                  </td>
                  <td>
                    <v-text-field
                      v-on:change="calcularTotalFila(index)"
                      v-model="item.precio_compra"
                      prefix="S/."
                      type="number"
                      min="0"
                      hide-details="auto"
                    ></v-text-field>
                  </td>
                  <td>
                    <v-text-field
                      v-model="item.precio_total"
                      hide-details="auto"
                      prefix="S/."
                      readonly
                    ></v-text-field>
                  </td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="7" style="text-align: right">
                    <b>Subtotal: </b>
                  </td>
                  <td colspan="2">
                    <v-text-field
                      v-model="form.header.subtotal"
                      readonly
                      hide-details="auto"
                      prefix="S/."
                    ></v-text-field>
                  </td>
                </tr>
                <tr>
                  <td colspan="7" style="text-align: right">
                    <b>IGV (18%): </b>
                  </td>
                  <td colspan="2">
                    <v-text-field
                      v-model="form.header.igv"
                      readonly
                      hide-details="auto"
                      prefix="S/."
                    ></v-text-field>
                  </td>
                </tr>
                <tr>
                  <td colspan="7" style="text-align: right">
                    <b>Total: </b>
                  </td>
                  <td colspan="2">
                    <v-text-field
                      v-model="form.header.total"
                      readonly
                      hide-details="auto"
                      prefix="S/."
                    ></v-text-field>
                  </td>
                </tr>
              </tfoot>
            </template>
          </v-simple-table>
        </v-card>

        <v-card class="mb-4" light style="padding: 15px">
          <v-card-title>Deuda Asociada</v-card-title>
          <v-row dense class="pa-2 py-0">
            <v-col cols="3">
              <v-select
                label="Condición de Pago"
                v-model="form.header.condicion_pago"
                :items="condiciones_pago"
                item-text="text"
                item-value="value"
              ></v-select>
            </v-col>
            <v-col cols="3" v-if="form.header.condicion_pago != 1">
              <v-menu
                v-model="menuEndDate"
                :close-on-content-click="false"
                :nudge-right="40"
                transition="scale-transition"
                offset-y
                min-width="auto"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    label="Fecha de Vencimiento"
                    v-model="formatEndDate"
                    prepend-icon="mdi-calendar"
                    :rules="[rules.required]"
                    v-bind="attrs"
                    v-on="on"
                    readonly
                  ></v-text-field>
                </template>
                <v-date-picker
                  v-model="form.header.fecha_vencimiento"
                  @input="menuEndDate = false"
                  :min="todaysDateDefault((add_days = 1))"
                  locale="es-ES"
                  no-title
                ></v-date-picker>
              </v-menu>
            </v-col>
          </v-row>
          <!-- Al Credito -->
          <v-row dense class="pa-2 py-0" v-if="form.header.condicion_pago == 2">
            <v-col cols="3">
              <v-select
                v-model="form.header.deuda_tipo"
                :items="tipos_deuda"
                label="Tipo de Deuda"
                item-text="text"
                item-value="value"
              ></v-select>
            </v-col>
            <v-col cols="3">
              <v-text-field
                v-model="form.header.deuda_total_abonado"
                label="Adelanto (S/.)"
                type="number"
                min="0"
                :disabled="form.header.deuda_tipo == 'total' ? true : false"
              ></v-text-field>
            </v-col>
            <v-col cols="3">
              <v-text-field
                v-model="form.header.deuda_saldo"
                label="Saldo (S/.)"
                type="number"
                disabled
              ></v-text-field>
            </v-col>
          </v-row>
          <!-- Fin -->
          <!-- Al Credito con Cuotas-->
          <template v-if="form.header.condicion_pago == 3">
            <v-row dense class="pa-2 py-0">
              <v-col cols="5">
                <v-simple-table>
                  <thead>
                    <th class="text-center">Fecha</th>
                    <th class="text-center">Monto</th>
                    <th></th>
                  </thead>
                  <tbody>
                    <tr v-for="(item, i) in cuotas_list" :key="i">
                      <td style="text-align: left; vertical-align: middle">
                        <v-menu
                          v-model="item.menuFechaCuota"
                          :close-on-content-click="false"
                          :nudge-right="40"
                          transition="scale-transition"
                          offset-y
                          min-width="auto"
                        >
                          <template v-slot:activator="{ on, attrs }">
                            <v-text-field
                              label="Fecha de Pago"
                              v-model="item.fecha"
                              prepend-icon="mdi-calendar"
                              v-bind="attrs"
                              v-on="on"
                              :rules="[rules.required]"
                              readonly
                            ></v-text-field>
                          </template>
                          <v-date-picker
                            v-model="item.fecha"
                            @input="item.menuFechaCuota = false"
                            :min="todaysDateDefault((add_days = 1))"
                            locale="es-ES"
                            no-title
                          ></v-date-picker>
                        </v-menu>
                      </td>
                      <td style="text-align: left; vertical-align: middle">
                        <v-text-field
                          v-model="item.monto"
                          type="number"
                          placeholder="0,00"
                          min="0"
                          :rules="[rules.required]"
                          autocomplete="off"
                        ></v-text-field>
                      </td>
                      <td
                        v-if="i > 0"
                        style="text-align: center; vertical-align: middle"
                      >
                        <v-btn
                          small
                          color="error"
                          icon
                          @click="delCuotaRow(item)"
                        >
                          <v-icon small>mdi-delete</v-icon>
                        </v-btn>
                      </td>
                    </tr>
                  </tbody>
                </v-simple-table>
              </v-col>
            </v-row>
            <v-row dense class="pa-2 py-0">
              <v-col cols="3">
                <v-btn depressed small @click="addCuotaRow()">
                  <v-icon color="blue">mdi-plus</v-icon> Agregar Cuota
                </v-btn>
              </v-col>
            </v-row>
          </template>
          <!-- Fin -->
          <br />
          <v-divider></v-divider>
          <br />
          <v-card-actions class="justify-end">
            <v-btn :disabled="!validForm" color="primary" @click="save"
              >Guardar</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-form>
    </div>

    <!-- Add Proveedor Dialog -->
    <v-dialog v-model="addDialog" max-width="40%" persistent>
      <v-card>
        <v-card-title>
          <span class="headline">Agregar Proveedor</span>
        </v-card-title>
        <v-card-text>
          <v-form
            ref="addForm"
            v-model="validAddForm"
            @submit.prevent="saveProveedor()"
            lazy-validation
          >
            <v-row>
              <v-col cols="12" sm="12" md="12">
                <v-text-field
                  label="Nombre o Razón Social *"
                  v-model="addForm.nombre"
                  :rules="[rules.required]"
                  autocomplete="off"
                ></v-text-field>
                <v-select
                  label="Tipo Documento"
                  v-model="addForm.id_tipo_doc"
                  :items="items_tipo_doc"
                  item-text="nombre_tipo_documento"
                  item-value="id_tipo_documento"
                  @change="TipoDocChanged(addForm.id_tipo_doc)"
                ></v-select>
                <v-text-field
                  :label="nrodoc_label"
                  v-model="addForm.nro_doc"
                  :rules="requiredDocRules"
                  autocomplete="off"
                >
                  <template v-slot:append>
                    <v-btn
                      @click="obtenerDataDocumentos()"
                      color="primary"
                      class="ma-0"
                    >
                      <v-icon>mdi-magnify</v-icon>
                    </v-btn>
                  </template>
                </v-text-field>
                <v-text-field
                  label="Correo Electrónico *"
                  v-model="addForm.email"
                  :rules="[rules.required, rules.email]"
                  autocomplete="off"
                ></v-text-field>
                <v-text-field
                  label="Código del proveedor *"
                  v-model="addForm.cod_proveedor"
                  :rules="[rules.required]"
                  autocomplete="off"
                ></v-text-field>
                <v-text-field
                  label="Dirección *"
                  v-model="addForm.direccion"
                  :rules="[rules.required]"
                  autocomplete="off"
                ></v-text-field>
                <v-text-field
                  label="Teléfono *"
                  v-model="addForm.telefono"
                  :rules="[
                    rules.required,
                    (val) =>
                      val.length == 9 || 'El telefono debe tener 9 digitos',
                  ]"
                  autocomplete="off"
                ></v-text-field>
                <v-text-field
                  label="Encargado *"
                  v-model="addForm.encargado"
                  :rules="[rules.required]"
                  autocomplete="off"
                ></v-text-field>
                <v-text-field
                  label="Cuenta Bancaria"
                  v-model="addForm.nro_cuenta"
                  autocomplete="off"
                ></v-text-field>
                <v-text-field
                  label="CCI Bancario"
                  v-model="addForm.cci_bancario"
                  autocomplete="off"
                ></v-text-field>
              </v-col>
            </v-row>
            <br />
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="error" text @click="addDialog = false"
                >Cancelar</v-btn
              >
              <v-btn type="submit" color="primary" :disabled="!validAddForm"
                >Guardar</v-btn
              >
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </v-dialog>
    <!-- End -->
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
export default {
  components: {},
  data: (vm) => ({
    breadcrumbs_title: "Crear Compra",
    breadcrumbs: [
      { text: "Inicio", disabled: false, href: "#" },
      { text: "Compras", disabled: false, href: "/compras" },
      { text: "Crear Compra" },
    ],
    validForm: false,
    form: {
      header: {
        deuda_tipo: "total",
        caja: false,
        rubro: "hotel",
        id_proveedor: "",
        nombre_proveedor: "",
        tipo_documento: "",
        nro_doc: "",
        direccion_proveedor: "",
        nro_factura: "",
        referencia: "",
        fecha: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
          .toISOString()
          // .substr(0, 10),
          .substring(0, 10),
        condicion_pago: 1,
        id_origen_dinero: 1,
        id_medio_pago: 1,
        deuda_saldo: 0,
        deuda_total_abonado: 0,
        id_serie: null,
      },
      detail: [],
    },
    descriptionLimit: 60,
    entries: [],

    search_productos: null,
    get_producto: {
      unidad_medida: {},
    },
    entries_productos: [],

    origen_dinero: [],
    medios_pago: [],

    //--- Condicion de Pago ---
    menuEndDate: false,
    menuFechaCuota: false,
    tipos_deuda: [
      { text: "Total", value: "total" },
      { text: "Saldo", value: "saldo" },
    ],
    condiciones_pago: [
      { text: "Al Contado", value: 1 },
      { text: "Al Crédito", value: 2 },
      { text: "Al Crédito con Cuotas", value: 3 },
    ],
    cuotas_list: [
      { fecha: null, monto: null },
      { fecha: null, monto: null },
      { fecha: null, monto: null },
    ],
    //--- Fin ---

    //--- Proveedor ---
    addDialog: false,
    validAddForm: false,
    nrodoc_label: "Nro. RUC *",
    requiredDocRules: [
      (v) => !!v || "Campo obligatorio",
      (v) => (v && v.length == 11) || "RUC debe tener 11",
    ],
    addForm: {
      id_tipo_doc: 2,
      telefono: "",
    },
    defaultAddForm: {
      id_tipo_doc: 2,
      telefono: "",
    },
    datosBus: {
      tipoDoc: "",
      numDoc: "",
    },
    items_tipo_doc: [],
    //--- Fin ---
    // --- Autocomplete Proveedor ---
    providerRes: {},
    searchProvider: null,
    isLoadingProvider: false,
    itemsProvider: [],
    // --- Fin ---

    date: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
      .toISOString()
      .substr(0, 10),
    dateFormatted: vm.formatDate(
      new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10)
    ),
    menu1: false,

    // DatePicker
    date: moment().format("YYYY-MM-DD"),
    currentDate: moment().format("YYYY-MM-DD"),
    availableDates: [],
    notAllowdDates: [],
    series: [],

    rules: {
      required: UTILS.nRules.required,
      only_numbers: UTILS.nRules.only_numbers,
      email: UTILS.nRules.email,
    },
  }),

  mounted() {
    this.checkIfCashIsOpen("/compras/crear");
    this.calcularFechasCredito();
  },

  created() {
    this.getTiposDoc();
    this.getSeries();
    this.getOrigenDinero();
    this.getMediosPago();
    this.getNotAllowedDates();
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
    addCustomDetail() {
      this.form.detail.push({
        codigo_producto: "000",
        nombre_producto: "",
        precio_compra: 0.0,
        precio_total: 0.0,
        cantidad: 1,
        unidad_medida: "UND",
      });
    },
    calcularTotalFila(indx) {
      this.form.detail[indx].precio_total = Number(
        this.form.detail[indx].precio_compra * this.form.detail[indx].cantidad
      ).toFixed(2);

      this.calcularTotal();
    },
    calcularTotal() {
      var sumaTotal;
      sumaTotal = this.form.detail.reduce(function (sum, product) {
        var total_fila = parseFloat(product.precio_total);
        if (!isNaN(total_fila)) {
          return sum + total_fila;
        }
      }, 0);

      if (!isNaN(sumaTotal)) {
        this.form.header.subtotal = parseFloat(sumaTotal / 1.18).toFixed(2);
        this.form.header.igv = parseFloat(
          sumaTotal - this.form.header.subtotal
        ).toFixed(2);
        this.form.header.total = parseFloat(sumaTotal).toFixed(2);
      } else {
        this.form.header.igv = "";
        this.form.header.subtotal = "";
        this.form.header.total = "";
      }

      this.form.header.deuda_total_abonado = 0.0;
      this.form.header.deuda_saldo = this.form.header.total;

      this.calcularCuotas();
    },
    deleteItem(indx) {
      this.form.detail.splice(indx, 1);
      this.calcularTotal();
    },
    async save() {
      if (!this.validForm || this.form.detail.length < 0) {
        return;
      }
      try {
        // console.log(this.form);
        this.$store.commit("LOADER", true);

        this.form.cuotas = this.cuotas_list;
        const response = await axios.post("/api/compras", this.form);
        // .then((response) => {
        const url = "/compraPDF/" + response.data.id_compra;
        window.open(url, "Compra", "width=500,height=600");
        // window.open(url, "_blank");
        this.$router.push("/compras/ver/" + response.data.id_compra);
        this.$store.commit("LOADER", false);
      } catch (error) {
        console.error(error);
      }
      // })
      // .catch((error) => {
      // });
    },

    async getTiposDoc() {
      let vm = this;
      try {
        const response = await API.tipos_documentos.combo();
        vm.items_tipo_doc = response.data;
      } catch (e) {
        console.error(e);
      }
    },
    async getOrigenDinero() {
      let vm = this;
      try {
        const response = await API.origenDinero.combo();
        vm.origen_dinero = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getMediosPago() {
      try {
        const response = await API.apis.medioPago();
        this.medios_pago = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getSeries() {
      let vm = this;
      try {
        const response = await API.compras.series();
        vm.series = response.data;
        if (vm.series.length > 0) {
          vm.form.header.id_serie = vm.series[0].id_serie;
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getNotAllowedDates() {
      const vm = this;
      try {
        const response = await API.apis.diasNoLaborales();
        vm.notAllowdDates = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    allowedDates(a) {
      return this.availableDates.includes(a);
    },

    pickerUpdate: function (val) {
      let totalDay = moment(val, "YYYY-MM").daysInMonth();
      let availableDates = [];

      let monthNow = moment().format("M");
      let monthSelected = moment(val).format("M");
      let day;
      day = 1;

      for (let i = day; i <= totalDay; i++) {
        let date = val + "-" + String(i).padStart(2, "0");
        if (moment(date).day() !== 0) {
          if (!this.notAllowdDates.includes(date)) {
            availableDates.push(date);
          }
        }
      }
      this.availableDates = [...availableDates];
      this.allowedDates();
    },

    //--- Cuotas Functions ---
    addCuotaRow() {
      this.cuotas_list.push({
        id: null,
        fecha: null,
        monto: null,
      });
      this.calcularCuotas();
    },
    delCuotaRow(item) {
      var idx = this.cuotas_list.indexOf(item);
      if (idx > -1) {
        this.cuotas_list.splice(idx, 1);
      }
      this.calcularCuotas();
    },
    calcularCuotas() {
      if (this.form.header.total > 0) {
        var monto_cuotas = this.form.header.total / this.cuotas_list.length;
        this.cuotas_list.forEach(
          (element) => (element.monto = monto_cuotas.toFixed(2))
        );
      }
    },

    calcularFechasCredito() {
      let date = new Date(),
        y = date.getFullYear(),
        m = date.getMonth();
      let lastDay = new Date(y, m + 1, 0);
      var cuota_2 = new Date(lastDay);
      var cuota_3 = new Date(lastDay);

      cuota_2.setDate(cuota_2.getDate() + 30);
      cuota_3.setDate(cuota_3.getDate() + 60);

      this.form.header.fecha_vencimiento = this.formatDefaultDate(cuota_3);
      this.cuotas_list[0].fecha = this.formatDefaultDate(lastDay);
      this.cuotas_list[1].fecha = this.formatDefaultDate(cuota_2);
      this.cuotas_list[2].fecha = this.formatDefaultDate(cuota_3);
    },
    //--- Fin ---

    //--- Proveedor Functions ---
    TipoDocChanged(tipo_doc) {
      this.addForm.nro_doc = null;
      switch (tipo_doc) {
        case 1:
          this.nrodoc_label = "Nro. DNI *";
          this.requiredDocRules = [
            (v) => !!v || "Campo obligatorio",
            (v) => (v && v.length == 8) || "DNI debe tener 8 cifras",
          ];
          break;

        case 2:
          this.nrodoc_label = "Nro. RUC *";
          this.requiredDocRules = [
            (v) => !!v || "Campo obligatorio",
            (v) => (v && v.length == 11) || "RUC debe tener 11 o menos cifras",
          ];
          break;

        default:
          this.nrodoc_label = "Nro. Documento *";
          this.requiredDocRules = [(v) => !!v || "Campo obligatorio"];
          break;
      }
    },
    async obtenerDataDocumentos() {
      try {
        this.$store.commit("loader", true);
        this.datosBus.tipoDoc = this.addForm.id_tipo_doc;
        this.datosBus.numDoc = this.addForm.nro_doc;

        const rpta = await API.apis.dniruc(this.datosBus);

        this.addForm.nombre = "";
        this.addForm.direccion = "";
        this.$refs.addForm.resetValidation();

        if (rpta.data.success === true) {
          if (this.datosBus.tipoDoc === 2) {
            this.addForm.nombre = rpta.data.nombre_o_razon_social;
            this.addForm.direccion = rpta.data.direccion_completa;
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
            this.addForm.nombre =
              rpta.data.result.Nombres + " " + rpta.data.result.Apellidos;
            this.$store.commit("loader", false);
          }
        } else {
          this.$store.commit("loader", false);
        }
        this.$store.commit("loader", false);
      } catch (error) {
        this.$store.commit("loader", false);
      }
    },
    async saveProveedor() {
      if (!this.$refs.addForm.validate()) return;
      try {
        const response = await API.proveedores.create(this.addForm);
        this.addDialog = false;
        let proveedor = response.data;
        this.form.header.id_proveedor = proveedor.id_proveedor;
        this.form.header.nombre_proveedor = proveedor.nombre;
        this.form.header.nro_doc = proveedor.nro_doc;
        this.form.header.direccion_proveedor = proveedor.direccion;

        UTILS.toastr.success("Proveedor registrado correctamente", this);
      } catch (e) {
        console.error(e);
      }
    },
    //--- End ---
    //--- Autocomplete Proveedor ---
    ProviderItemText(item) {
      if (item.tipo_documento) {
        return `${item.tipo_documento.nombre_tipo_documento} | ${item.nombre} | ${item.nro_doc}`;
      }
    },
    handleSubmitProvider() {
      this.form.header.id_proveedor = this.providerRes.id_proveedor;
      this.form.header.nombre_proveedor = this.providerRes.nombre;
      this.form.header.nro_documento = this.providerRes.nro_doc;
      this.form.header.direccion_proveedor = this.providerRes.direccion;
    },
    //--- Fin ---
  },
  watch: {
    search_productos(val) {
      if (this.items_producto.length > 0) return;
      fetch("/api/list/productos")
        .then((res) => res.json())
        .then((res) => {
          this.count = res.length;
          this.entries_productos = res;
        })
        .catch((e) => {
          console.error(e);
        });
    },
    get_producto(val) {
      let item = {};
      item.id_producto = val.id_producto;
      item.codigo_producto = val.codigo_producto;
      item.nombre_producto = val.nombre_producto;
      item.precio_compra = Number(val.precio_compra).toFixed(2);
      item.precio_total = Number(val.precio_compra).toFixed(2);
      item.cantidad = 1;
      item.unidad_medida = "UND";
      this.form.detail.push(item);

      this.calcularTotal();
    },

    "form.header.deuda_tipo"(val) {
      this.form.header.deuda_total_abonado = 0.0;
      this.form.header.deuda_saldo = this.form.header.total;
    },
    "form.header.deuda_total_abonado"(val) {
      const current = Number(val);
      const total = Number(this.form.header.total);

      if (total > current) {
        this.form.header.deuda_saldo = total - current;
      } else {
        this.form.header.deuda_total_abonado = 0;
        this.$swal({
          toast: true,
          position: "top-end",
          icon: "warning",
          title: "El pago debe ser menor en por lo menos S/. 1.00 a el total.",
          showConfirmButton: false,
          timerProgressBar: true,
          timer: 2500,
        });
      }
    },
    "form.header.fecha"(val) {
      this.dateFormatted = this.formatDate(this.form.header.fecha);
    },
    "form.detail"(val) {
      this.form.header.deuda_total_abonado = 0;
      this.form.header.deuda_saldo = this.form.header.total;
    },

    "form.header.condicion_pago"(val) {
      if (val == 1) {
        this.form.header.deuda_tipo = "total";
      } else if (val == 2) {
        this.form.header.deuda_tipo = "saldo";
      } else {
        this.form.header.deuda_tipo = "cuotas";
      }
    },

    searchProvider(val) {
      if (val != null) {
        if (val.length < 2) return;

        this.isLoadingProvider = true;
        let token = document.head.querySelector('meta[name="csrf-token"]');
        const requestOptions = {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-TOKEN": token.content,
          },
          body: JSON.stringify({ keywords: val }),
        };

        fetch("/api/searchProvider", requestOptions)
          .then((res) => res.json())
          .then((data) => {
            this.itemsProvider = data;
          })
          .catch((e) => {
            console.log(e);
          })
          .finally(() => (this.isLoadingProvider = false));
      }
    },
    addDialog() {
      if (!this.addDialog) {
        this.$refs.addForm.resetValidation();
        this.validAddForm = false;
        this.addForm = Object.assign({}, this.defaultAddForm);

        this.addForm.id_tipo_doc = 2;
        this.nrodoc_label = "Nro. RUC *";
      }
    },
  },
  computed: {
    items() {
      return this.entries.map((entry) => {
        const Description = entry.nombre;
        return Object.assign({}, entry, { Description });
      });
    },
    items_producto() {
      return this.entries_productos.map((entry) => {
        let Description = "";
        Description =
          "[" +
          entry.codigo_producto +
          "] " +
          entry.nombre_producto +
          ` | ${entry.codigo_varilla}`;
        return Object.assign({}, entry, { Description });
      });
    },

    formatEndDate: {
      get: function () {
        return this.formatDate(this.form.header.fecha_vencimiento);
      },
      set: function (newValue) {
        return this.formatDate(newValue);
      },
    },
  },
};
</script>
<style lang="scss" scoped>
.btn-actions {
  background-color: #fff !important;
  color: #121212;
}
</style>
