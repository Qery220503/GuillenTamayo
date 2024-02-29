<template>
  <div class="flex-grow-1">
    <div class="my-2">
      <v-row dense>
        <v-col cols="12" md="4">
          <v-select
            v-model="$form.header.id_tipo_comprobante"
            :rules="[rules.required]"
            item-text="nombre_tipo_documento"
            item-value="id_tipo_comprobantes"
            label="Tipo Documento"
            filled
            dense
            :items="items_tipo_comprobante"
            @change="handleDocumentChange()"
          ></v-select>
        </v-col>
        <v-col cols="12" md="4">
          <v-select
            v-model="$form.header.id_serie"
            :rules="[rules.required]"
            item-text="serie"
            item-value="id_serie"
            label="Serie"
            filled
            dense
            :items="series"
          ></v-select>
        </v-col>

        <v-col cols="12" md="4">
          <v-text-field
            v-model="$form.header.nombre_cliente"
            :rules="[rules.required]"
            filled
            dense
            label="Nombre Cliente"
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="4">
          <v-text-field
            v-model="$form.header.nro_documento"
            :rules="[rules.required]"
            filled
            dense
            label="Nro. Documento"
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="4">
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
                label="Fecha"
                prepend-inner-icon="mdi-calendar"
                :rules="[rules.required]"
                readonly
                filled
                dense
                v-bind="attrs"
                v-on="on"
                @blur="$form.fecha_entrega = parseDate(dateFormatted)"
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="$form.header.fecha_emision"
              no-title
              @input="menu2 = false"
              :allowed-dates="allowedDates"
              :min="currentDate"
              @update:picker-date="pickerUpdate($event)"
            ></v-date-picker>
          </v-menu>
        </v-col>
        <v-col cols="12" md="4">
          <v-text-field
            v-model="$form.header.direccion_cliente"
            :rules="[rules.required]"
            filled
            dense
            label="Dirección Cliente"
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="4">
          <v-select
            v-model="$form.header.id_medio_pago"
            :items="items_medio_pago"
            label="Medio de Pago"
            filled
            dense
            :rules="[rules.required]"
            item-text="medio_pago"
            item-value="id_medio_pago"
          ></v-select>
        </v-col>
        <v-col cols="12" md="4" v-if="$form.header.id_medio_pago == 5">
          <v-text-field
            :rules="[rules.required]"
            v-model="$form.header.nota_credito_referencia"
            label="Referencia Nota de Crédito"
            filled
            dense
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="4">
          <v-text-field
            v-model="$form.header.nro_operacion"
            label="Nro.Operación"
            filled
            dense
          ></v-text-field>
        </v-col>
        <v-col cols="12" md="4">
          <v-select
            v-model="epsSelected"
            :items="eps_institution"
            @click:clear="clearEps"
            item-text="name"
            item-value="id"
            label="Selecciona la EPS"
            filled
            dense
            clearable
            :disabled="epsDisabled"
          ></v-select>
        </v-col>

        <v-col cols="12" md="4">
          <v-select
            :disabled="epsSelected == null"
            v-model="epsDiscountSelected"
            :items="epsDiscounts"
            @change="updateEpsDiscount"
            item-text="detail"
            item-value="id"
            label="Selecciona el descuento"
            filled
            dense
            return-object
          ></v-select>
        </v-col>
        <v-col cols="12" md="4">
          <v-textarea
            filled
            label="Observaciones"
            v-model="$form.header.observaciones"
            rows="2"
          ></v-textarea>
        </v-col>
        <v-col cols="12" md="4">
          <PaymentCoupons @validated="handleCoupon"></PaymentCoupons>
        </v-col>
      </v-row>
      <v-divider></v-divider>
      <br />
      <v-row dense class="pa-2">
        <v-col cols="9">
          <v-autocomplete
            :disabled="epsActive"
            v-model="get_producto"
            :items="items_producto"
            :search-input.sync="search_productos"
            hide-no-data
            hide-selected
            dense
            item-text="Description"
            item-value="API"
            label="Buscar Producto"
            placeholder="Buscar Producto"
            return-object
          ></v-autocomplete>
        </v-col>
        <v-spacer></v-spacer>
        <v-col cols="auto">
          <v-btn :disabled="epsActive" depressed @click="addGrid()">
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
              <th class="text-left">Producto</th>
              <th style="width: 10%" class="text-left">Unidad</th>
              <th style="width: 10%" class="text-left">CNT</th>
              <th style="width: 15%" class="text-left">P.U (S/.)</th>
              <th style="width: 15%" class="text-left">P.T (S/.)</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in form.detail" :key="index">
              <td>
                <v-btn
                  v-if="!item.disabled"
                  @click="deleteItem(index)"
                  small
                  color="error"
                  icon
                >
                  <v-icon small> mdi-delete</v-icon>
                </v-btn>
              </td>
              <td>
                <v-text-field
                  v-model="item.detalle_item"
                  hide-details
                  outlined
                  dense
                  filled
                  :rules="[rules.required]"
                  :readonly="item.disabled"
                ></v-text-field>
              </td>
              <td>
                <v-select
                  v-model="item.id_unidad_medida"
                  :items="unidades_medida"
                  item-text="nombre_unidad_medida"
                  item-value="id_unidad_medida"
                  :rules="[rules.required]"
                  :readonly="item.disabled"
                  hide-details
                  outlined
                  dense
                  filled
                ></v-select>
              </td>
              <td>
                <v-text-field
                  v-on:keyup="calcularTotalFila(index)"
                  v-model="item.cantidad"
                  hide-details
                  outlined
                  dense
                  filled
                  type="number"
                  :rules="[rules.required]"
                  :readonly="item.disabled"
                ></v-text-field>
              </td>
              <td>
                <v-text-field
                  v-on:keyup="calcularTotalFila(index)"
                  v-model="item.precio_unitario"
                  prefix="S/."
                  hide-details
                  outlined
                  dense
                  type="number"
                  filled
                  step="0.01"
                  :rules="[rules.required]"
                  :readonly="item.disabled"
                ></v-text-field>
              </td>
              <td>
                <v-text-field
                  v-model="item.precio_total"
                  hide-details
                  prefix="S/."
                  outlined
                  dense
                  filled
                  type="number"
                  :rules="[rules.required]"
                  :readonly="item.disabled"
                ></v-text-field>
              </td>
            </tr>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="5" style="text-align: right">
                <b>Subtotal: </b>
              </td>
              <td colspan="2">
                <v-text-field
                  v-model="$form.header.subtotal"
                  readonly
                  hide-details
                  outlined
                  dense
                  filled
                  prefix="S/."
                  :rules="[rules.required]"
                ></v-text-field>
              </td>
            </tr>
            <tr>
              <td colspan="5" style="text-align: right">
                <b>IGV (18%): </b>
              </td>
              <td colspan="2">
                <v-text-field
                  v-model="$form.header.igv"
                  readonly
                  hide-details
                  outlined
                  dense
                  filled
                  prefix="S/."
                  :rules="[rules.required]"
                ></v-text-field>
              </td>
            </tr>
            <tr>
              <td colspan="5" style="text-align: right">
                <b>Descuento Fijo (S/.): </b>
              </td>
              <td colspan="2">
                <v-text-field
                  :disabled="epsActive"
                  v-model="$form.header.dscto_fijo"
                  :min="0"
                  type="number"
                  hide-details
                  outlined
                  dense
                  filled
                  prefix="S/."
                ></v-text-field>
              </td>
            </tr>

            <tr>
              <td colspan="4" style="text-align: right">
                <b>Descuento (%): </b>
              </td>
              <td colspan="1">
                <v-text-field
                  :disabled="epsActive"
                  v-model="$form.header.descuento_porcentaje"
                  hide-details
                  outlined
                  dense
                  filled
                  prefix="%"
                  :min="0"
                  :max="100"
                  type="number"
                ></v-text-field>
              </td>
              <td colspan="2">
                <v-text-field
                  :disabled="epsActive"
                  v-model="$form.header.dscto_porcentaje"
                  readonly
                  hide-details
                  outlined
                  dense
                  filled
                  prefix="S/."
                ></v-text-field>
              </td>
            </tr>

            <tr v-if="form.header.id_eps_discount != null">
              <td colspan="4" style="text-align: right">
                <b>Eps: </b>
              </td>

              <td colspan="1">
                <v-text-field
                  v-on:keyup="recalculateEpsDiscount(true)"
                  @change="recalculateEpsDiscount(true)"
                  :disable="form.header.id_eps_discount == null"
                  v-model="epsDiscountPercentage"
                  hide-details
                  outlined
                  dense
                  filled
                  prefix="%"
                  :min="0"
                  :max="100"
                  type="number"
                  step="0.5"
                ></v-text-field>
              </td>

              <td colspan="1">
                <v-text-field
                  v-on:keyup="recalculateEpsDiscount(false)"
                  @change="recalculateEpsDiscount(false)"
                  :disable="form.header.id_eps_discount == null"
                  v-model="$form.header.eps_discount"
                  hide-details
                  outlined
                  dense
                  filled
                  prefix="S/."
                  min="0"
                  max="100"
                  type="number"
                  step="0.5"
                ></v-text-field>
              </td>
            </tr>
            <tr>
              <td colspan="5" style="text-align: right">
                <b>Total: </b>
              </td>
              <td colspan="2">
                <v-text-field
                  v-model="$form.header.total"
                  readonly
                  hide-details
                  outlined
                  dense
                  filled
                  prefix="S/."
                ></v-text-field>
              </td>
            </tr>
            <tr v-if="form.header.id_eps_discount != null">
              <td colspan="5" style="text-align: right">
                <b>Total (EPS): </b>
              </td>
              <td colspan="2">
                <v-text-field
                  v-model="coberturaEps"
                  readonly
                  hide-details
                  outlined
                  dense
                  filled
                  prefix="S/."
                ></v-text-field>
              </td>
            </tr>

            <tr>
              <td colspan="5" style="text-align: right">
                <b>Adelanto: </b>
              </td>
              <td colspan="2">
                <v-text-field
                  v-model="$form.header.adelanto"
                  hide-details
                  outlined
                  dense
                  filled
                  :disabled="
                    form.header.condicion_pago == 1 ||
                    (form.header.deuda_tipo == 'total' &&
                      form.header.condicion_pago != 1)
                  "
                  prefix="S/."
                  @change="handleAdelanto($event)"
                ></v-text-field>
              </td>
            </tr>
          </tfoot>
        </template>
      </v-simple-table>

      <v-divider></v-divider>
      <br />
      <v-row dense class="pa-2 py-0">
        <v-col cols="12">
          <strong> Deuda Asociada </strong>
        </v-col>
        <v-col cols="3">
          <v-select
            v-model="$form.header.condicion_pago"
            :items="item_tipo_pago"
            label="Condición de Pago"
            item-text="text"
            item-value="value"
            dense
          ></v-select>
        </v-col>

        <v-col cols="3" v-if="form.header.condicion_pago != 1">
          <v-menu
            v-model="menuDeudaDate"
            :close-on-content-click="false"
            :nudge-right="40"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                v-model="form.header.fecha_vencimiento"
                prepend-inner-icon="mdi-calendar"
                readonly
                dense
                label="Fecha de vencimiento"
                v-bind="attrs"
                v-on="on"
                hide-details
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="form.header.fecha_vencimiento"
              no-title
              @input="menuDeudaDate = false"
            ></v-date-picker>
          </v-menu>
        </v-col>

        <v-spacer></v-spacer>
      </v-row>

      <!-- Deudas -->
      <v-row v-if="form.header.condicion_pago == 2" dense class="pa-2 py-0">
        <v-col cols="3">
          <v-select
            @change="handleTipoDeuda"
            v-model="form.header.deuda_tipo"
            :items="tipos_deuda"
            label="Tipo de Deuda"
            item-text="text"
            item-value="value"
          ></v-select>
        </v-col>
        <v-col cols="3">
          <v-text-field
            @change="handleAdelanto($event)"
            v-model="form.header.adelanto"
            label="Adelanto (S/.)"
            type="number"
            min="0"
            :disabled="form.header.deuda_tipo == 'total' ? true : false"
          ></v-text-field>
        </v-col>
        <v-col cols="3">
          <v-text-field
            v-model="saldo"
            label="Saldo (S/.)"
            type="number"
            disabled
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row v-if="form.header.condicion_pago == 3" dense class="pa-2 py-0">
        <v-col cols="6" md="6">
          <v-simple-table>
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">Fecha</th>
                  <th class="text-left">Monto</th>
                  <th class="text-left">Acciones</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(item, index) in $form.cuotas" :key="index">
                  <td>
                    <v-menu
                      v-model="item.menu2"
                      :close-on-content-click="false"
                      :nudge-right="40"
                      transition="scale-transition"
                      offset-y
                      min-width="auto"
                    >
                      <template v-slot:activator="{ on, attrs }">
                        <v-text-field
                          v-model="item.fecha"
                          prepend-inner-icon="mdi-calendar"
                          readonly
                          dense
                          v-bind="attrs"
                          v-on="on"
                          hide-details
                        ></v-text-field>
                      </template>
                      <v-date-picker
                        v-model="item.date"
                        no-title
                        @input="item.menu2 = false"
                      ></v-date-picker>
                    </v-menu>
                  </td>
                  <td>
                    <v-text-field
                      v-model="item.monto"
                      dense
                      :value="form.header.total"
                      prefix="S/."
                      type="number"
                      hide-details
                    ></v-text-field>
                  </td>
                  <td>
                    <v-btn color="error" @click="deleteCuota(index)"
                      >Borrar</v-btn
                    >
                  </td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>

          <v-divider class="mb-1"></v-divider>
          <v-btn color="info" class="ml-2" @click="addCuota()">
            Agregar Cuota <v-icon>mdi-plus</v-icon>
          </v-btn>
        </v-col>
      </v-row>
      <br />
      <v-divider></v-divider>
      <br />
      <v-card-actions class="justify-end">
        <v-spacer />
        <v-btn color="primary" @click="finishAnamnesis()" :loading="loadingBtn"
          >Guardar</v-btn
        >
      </v-card-actions>

      <v-dialog v-model="dialog" max-width="600px">
        <v-card>
          <v-card-title>
            <span class="headline">{{ formTitle }}</span>
          </v-card-title>
          <v-card-text>
            <v-form ref="$form" v-model="valid" lazy-validation>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="6">
                    <v-select
                      :items="tipos_doc"
                      label="Tipo Documento"
                      placeholder="Selecciona un tipo de Documento"
                      v-model="editedItem.id_tipo_doc"
                      required
                      item-text="tipo_documento"
                      item-value="id_tipo_doc"
                    ></v-select>
                    <v-text-field
                      v-model="editedItem.nombre"
                      label="Nombre / Razón Social Proveedor"
                      placeholder="Nombre / Razón Social Proveedor"
                      :rules="requiredRules"
                    ></v-text-field>
                    <v-text-field
                      v-model="editedItem.email"
                      label="Correo Electrónico"
                      placeholder="Correo Electrónico"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="6"
                    ><!--v-on:keyup.enter.prevent="buscarDoc()"-->
                    <v-text-field
                      v-model="editedItem.nro_doc"
                      label="Nro. Documento"
                      placeholder="Nro. Documento"
                      :rules="requiredRules"
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
                      v-if="showAdd"
                      v-model="editedItem.direccion"
                      label="Dirección"
                      placeholder="Dirección"
                      :rules="requiredRules"
                    ></v-text-field>
                    <v-text-field
                      v-model="editedItem.telefono"
                      label="Teléfono"
                      placeholder="Teléfono"
                    ></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <!--<v-btn color="error" dark @click="close">Cancelar</v-btn>-->
            <v-btn color="primary" :disabled="!valid" @click="saveProveedor">
              Guardar
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";
import PaymentCoupons from "../../ventas/components/PaymentCoupons.vue";
export default {
  props: {
    form: {
      type: Object,
      default: () => {},
    },
    send: {
      type: Function,
    },
    convenio: {
      default: "",
      validator(value) {
        // Utiliza la función validator para especificar tus condiciones
        return typeof value === "string" || typeof value === "number";
      },
    },
  },
  components: {
    PaymentCoupons,
  },
  data: (vm) => ({
    loadingBtn: false,
    valid: false,
    eps: false,
    eps_institution: [],
    eps_selected: null,
    rules: {
      required: UTILS.nRules.required,
      dni: UTILS.nRules.min8,
      ruc: UTILS.nRules.min811,
      only_numbers: UTILS.nRules.only_numbers,
      email: UTILS.nRules.email,
      adelanto: [
        (value) =>
          (value !== "" && value !== null && /^\d+$/.test(value)) ||
          "Value must be a number",
        (v) => v >= 0 || "El adelanto no puede ser menor a 0",
      ],
    },
    entries: [],
    searchDocument: "",
    isLoading: false,
    search_provider: null,
    get_provider: {},
    series: [],
    search_productos: null,
    get_producto: {
      id_unidad_medida: {},
    },
    entries_productos: [],
    entries_servicios: [],
    tipos_doc: [],

    editedIndex: -1,
    editedItem: {
      codigo: "",
      categoria: "",
      nro_doc: "",
    },
    defaultItem: {
      codigo: "",
      categoria: "",
      nro_doc: "",
    },
    dialog: false,
    showAdd: true,
    requiredRules: [(v) => !!v || "Campo obligatorio"],
    datosBus: {
      tipoDoc: "",
      numDoc: "",
    },
    tipo_deuda: [
      { text: "Total", value: "total" },
      { text: "Saldo", value: "saldo" },
    ],
    origen_dinero: [],
    unidades_medida: [],
    items_tipo_comprobante: [],
    items_medio_pago: [],
    menu2: false,

    item_tipo_pago: [
      { text: "Al Contado", value: 1 },
      { text: "Al Crédito", value: 2 },
      { text: "Al Crédito con Cuotas", value: 3 },
    ],
    tipos_deuda: [
      { text: "Total", value: "total" },
      { text: "Saldo", value: "saldo" },
    ],
    menuDeudaDate: null,

    // DatePicker
    date: moment().format("YYYY-MM-DD"),
    currentDate: moment().format("YYYY-MM-DD"),
    availableDates: [],
    notAllowdDates: [],
    dateFormatted: vm.formatDate(
      new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10)
    ),
    epsDiscounts: [],
    epsSelected: null,
    epsDiscountSelected: null,
    epsActive: false,
    epsDiscountPercentage: null,
    epsDisabled: false,
    coupon: null,
  }),

  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "Nuevo Proveedor" : "Editar Proveedor";
    },
    items() {
      return this.entries.map((entry) => {
        const Description = entry.nombre;
        return Object.assign({}, entry, { Description });
      });
    },
    items_producto() {
      const products = this.entries_productos.map((entry) => {
        let Description = "";
        let type = "P";
        Description =
          "[" +
          entry.codigo_producto +
          "] " +
          entry.nombre_producto +
          ` | ${entry.codigo_varilla} | TIENDA: ${entry.st_tienda} | ALMACEN: ${entry.st_almacen}`;
        return Object.assign({}, entry, { Description, type });
      });
      const servicios = this.entries_servicios.map((entry) => {
        let Description = "";
        let type = "S";
        Description = "[Servicio] " + entry.nombre_servicio;
        return Object.assign({}, entry, { Description, type });
      });
      return [...products, ...servicios];
    },
    $form: {
      get() {
        return this.form;
      },
      set(value) {
        props.set(this, "$form", value);
      },
    },
    saldo() {
      let saldo = this.$form.header.total - this.$form.header.adelanto;
      if (this.$form.header.id_eps_discount != null)
        saldo -= this.$form.header.eps_discount;

      saldo = saldo < 0 ? 0 : saldo;
      return Number(saldo).toFixed(2);
    },
    coberturaEps() {
      const epsDiscount =
        this.$form.header.total - this.$form.header.eps_discount;
      return epsDiscount < 0 ? 0.0 : Number(epsDiscount).toFixed(2);
    },
  },
  mounted() {
    let vm = this;
    vm.$root.$on("form_anamnesis_change", () => {
      vm.calcularTotal();
    });
  },
  watch: {
    $form() {
      this.calcularTotal();
    },
    epsSelected(val) {
      if (val == null) return;
      const eps = this.eps_institution.find((e) => e.id == val);
      this.epsDiscounts = eps.discounts;
      this.$form.detail.splice(2, this.$form.detail.length);
      this.epsActive = true;
      this.$form.header.dscto_porcentaje = null;
      this.$form.header.descuento_porcentaje = null;
      this.$nextTick(() => {
        this.$form.header.dscto_fijo = null;
      });
    },
    search_provider(val) {
      if (this.items.length > 0) return;
      if (this.isLoading) return;
      this.isLoading = true;
      fetch("/api/combo/proveedores")
        .then((res) => res.json())
        .then((res) => {
          const { count, entries } = res;
          this.count = res.length;
          this.entries = res;
        })
        .catch((err) => {
          console.log(err);
        })
        .finally(() => (this.isLoading = false));
    },
    get_provider(val) {
      this.$form.header.id_proveedor = val.id_proveedor;
      this.$form.header.nombre_proveedor = val.nombre;
      this.$form.header.nro_documento = val.nro_doc;
      this.$form.header.direccion_proveedor = val.direccion;
    },
    search_productos(val) {
      if (val == null || val == "" || val.length <= 3) return;
      //if (this.items_producto.length > 0) return;
      fetch("/api/list/productos")
        .then((res) => res.json())
        .then((res) => {
          this.count = res.length;
          this.entries_productos = res;
        })
        .catch((err) => {
          console.log(err);
        })
        .finally(() => (this.isLoading = false));

      fetch("/api/combo/servicios")
        .then((res) => res.json())
        .then((res) => {
          this.count = res.length;
          this.entries_servicios = res;
        })
        .catch((err) => {
          console.log(err);
        })
        .finally(() => (this.isLoading = false));
    },
    get_producto(val) {
      if (val == null) return;
      let item = {};
      //item.codigo_item = val.id_producto ? val.id_producto : val.id_servicio;
      item.id_producto = val.id_producto ? val.id_producto : null;
      item.id_servicio = val.id_servicio ? val.id_servicio : null;
      item.id_precio_lente = null;
      item.detalle_item = val.nombre_producto
        ? val.nombre_producto
        : val.nombre_servicio;
      item.precio_compra = Number(val.precio_compra).toFixed(2);
      item.precio_unitario = Number(val.precio_venta).toFixed(2);
      item.precio_total = Number(val.precio_venta).toFixed(2);
      item.cantidad = 1;
      item.item_type = val.nombre_producto ? 1 : 3;
      item.id_unidad_medida = val.nombre_producto ? 1 : 3;
      this.$form.detail.push(item);

      if (item.item_type === 1 && val.st_tienda <= 0) {
        this.$swal({
          position: "center",
          icon: "info",
          title: "Sin Stock",
          text: "No existe stock en tienda debe realizar un movimiento de almacen para evitar problemas con el inventario",
          showConfirmButton: true,
        });
      }

      this.calcularTotal();
    },
    "form.header.tipo_deuda"(val) {
      this.$form.header.pago_total = 0.0;
      this.$form.header.pago_saldo = this.$form.header.total;
    },
    "form.header.pago_total"(val) {
      this.$form.header.pago_saldo = this.$form.header.total - val;
    },
    "form.header.descuento_porcentaje"(value) {
      var sumaTotal = this.$form.detail.reduce(function (sum, product) {
        var total_fila = parseFloat(Number(product.precio_total));
        if (!isNaN(total_fila)) {
          return sum + total_fila;
        }
      }, 0);

      if (this.$form.header.id_eps_discount != null) {
        this.$form.header.id_eps_discount = null;
        this.$form.header.eps_discount = null;
        this.epsDiscountSelected = null;
        this.epsDiscountPercentage = null;
      }

      if (value < 0) {
        this.$nextTick(() => {
          this.$form.header.dscto_porcentaje = 0.0;
        });
        this.calcularTotal();
        return;
      }

      if (
        this.$form.header.dscto_fijo != null &&
        this.$form.header.dscto_fijo != 0
      ) {
        this.$form.header.dscto_fijo = 0.0;
      }

      if (isNaN(sumaTotal)) {
        return;
      }
      if (value > 100) {
        this.$nextTick(() => {
          this.$form.header.descuento_porcentaje = 100;
        });
        return;
      }
      let descuento = sumaTotal * (value / 100);
      this.$form.header.dscto_porcentaje = descuento;
      sumaTotal = sumaTotal - descuento;
      this.$form.header.subtotal = parseFloat(sumaTotal / 1.18).toFixed(2);
      this.$form.header.igv = parseFloat(
        sumaTotal - this.$form.header.subtotal
      ).toFixed(2);
      this.$form.header.total = parseFloat(sumaTotal).toFixed(2);
      this.$form.header.adelanto = 0.0;
    },
    "form.header.dscto_fijo"(value) {
      var sumaTotal = this.$form.detail.reduce(function (sum, product) {
        var total_fila = parseFloat(Number(product.precio_total));
        if (!isNaN(total_fila)) {
          return sum + total_fila;
        }
      }, 0);
      if (this.$form.header.id_eps_discount != null) {
        this.$form.header.id_eps_discount = null;
        this.$form.header.eps_discount = null;
        this.epsDiscountSelected = null;
        this.epsDiscountPercentage = null;
      }
      if (
        this.$form.header.dscto_porcentaje != null ||
        this.$form.header.descuento_porcentaje != null
      ) {
        this.$form.header.descuento_porcentaje = "";
      }
      if (value == 0 || value == "" || value < 0 || value == null) {
        this.calcularTotal();
        return;
      }
      if (isNaN(sumaTotal)) {
        return;
      }
      if (value > sumaTotal) {
        this.$nextTick(() => {
          this.$form.header.dscto_fijo = sumaTotal;
        });
        return;
      }
      let descuento = this.form.header.dscto_fijo;
      sumaTotal = sumaTotal - descuento;
      this.$form.header.subtotal = parseFloat(sumaTotal / 1.18).toFixed(2);
      this.$form.header.igv = parseFloat(
        sumaTotal - this.$form.header.subtotal
      ).toFixed(2);
      this.$form.header.total = parseFloat(sumaTotal).toFixed(2);
      this.$form.header.adelanto = 0.0;
    },
    "form.header.fecha_emision"(val) {
      this.dateFormatted = this.formatDate(this.form.header.fecha_emision);
    },
    "form.header.condicion_pago"(val) {
      switch (val) {
        //Contado
        case 1:
          this.$form.cuotas = [];
          this.$form.header.adelanto = null;
          this.$form.header.fecha_vencimiento = null;
          this.$form.header.deuda_tipo = null;
          break;
        //Credito
        case 2:
          this.$form.header.fecha_vencimiento = new Date()
            .toISOString()
            .substring(0, 10);
          this.$form.header.adelanto = Number(0).toFixed(2);
          this.$form.header.deuda_tipo = "saldo";
          break;
        case 3:
          this.$form.header.deuda_tipo = "saldo";
          const cuotas = [];
          let total = this.$form.header.total - this.$form.header.adelanto;
          if (this.$form.header.id_eps_discount != null)
            total -= this.$form.header.eps_discount;
          total = total < 0 ? 0 : total;
          let cuotaMonto = Number(total / 3);
          let lastDate = null;
          for (let index = 0; index < 3; index++) {
            const fecha = new Date();
            fecha.setDate(fecha.getDate() + 1);
            fecha.setMonth(fecha.getMonth() + index);
            if (index == 2) {
              cuotaMonto = total - Number(cuotaMonto).toFixed(2) * 2;
              lastDate = fecha;
            }
            cuotas.push({
              fecha: fecha.toISOString().substring(0, 10),
              menu2: false,
              monto: Number(cuotaMonto).toFixed(2),
            });
          }
          this.$form.header.fecha_vencimiento = lastDate
            .toISOString()
            .substring(0, 10);
          this.$form.cuotas = cuotas;
          break;
        default:
          break;
      }
    },
    "form.header.id_tipo_comprobante"(val) {
      const vm = this;
      vm.getSeries();
    },
  },
  created() {
    this.getTiposDoc();
    this.getMedioPago();
    this.getTipoComprobante();
    this.getUnidadesMedida();
    this.getNotAllowedDates();
    this.getSeries();
    this.getEps();
  },
  methods: {
    async getEps() {
      const response = await API.eps.list();
      this.eps_institution = response.data;
    },
    handleCoupon(coupon) {
      this.epsSelected = null;
      this.clearEps();
      this.epsDisabled = true;
      this.coupon = coupon;
      this.$form.header.descuento_porcentaje = 25;
    },
    handleTipoDeuda() {
      if (this.$form.header.deuda_tipo == "total") {
        this.$form.header.adelanto = Number(0).toFixed(2);
      }
    },
    recalculateEpsDiscount(type) {
      const vm = this;
      const totalMoney = Number(vm.$form.header.total);
      if (type) {
        vm.$form.header.eps_discount = (
          (totalMoney * vm.epsDiscountPercentage) /
          100
        ).toFixed(2);

        return;
      }

      const percentage = (
        (totalMoney * vm.epsDiscountPercentage) /
        100
      ).toFixed(2);
      vm.epsDiscountPercentage = percentage == NaN ? 0 : percentage;
      vm.$form.header.adelanto = 0.0;
    },
    clearEps() {
      const vm = this;
      vm.$form.header.id_eps_discount = null;
      vm.$form.header.eps_discount = 0.0;
      vm.epsDiscounts = [];
      vm.epsDiscountPercentage = null;
      vm.epsActive = false;
    },
    async handleDocumentChange() {
      const vm = this;
      if (vm.$form.header.id_tipo_comprobante == 1) {
        const response = await API.empresas_convenio.show(vm.convenio);
        const empresaConvenio = response.data;
        if (empresaConvenio.cobertura == 1) {
          this.$swal({
            icon: "info",
            title: "Empresa Convenio",
            text: "Verifique la cobertura en su comprobante antes de emitirlo",
            showConfirmButton: true,
          });
        }
        vm.$form.header.deuda_generada = false;
      }
    },
    updateEpsDiscount(value) {
      const vm = this;
      vm.$form.header.adelanto = Number(0).toFixed(2);
      vm.$form.header.id_eps_discount = value.id;
      if (value.discount_type === "AMOUNT") {
        vm.$form.header.eps_discount = Number(value.discount).toFixed(2);
        vm.epsDiscountPercentage = null;
      }
      if (value.discount_type === "PERCENTAGE") {
        const totalMoney = Number(vm.$form.header.total);
        vm.epsDiscountPercentage = Number(value.discount).toFixed(2);
        vm.$form.header.eps_discount = (
          (totalMoney * vm.epsDiscountPercentage) /
          100
        ).toFixed(2);
      }
      vm.$form.header.adelanto = 0.0;
    },
    handleAdelanto(e) {
      const vm = this;
      let total = vm.$form.header.total;
      let value = Number(e);

      if (vm.$form.header.id_eps_discount != null) {
        total = this.coberturaEps;
      }
      if (value === NaN) {
        vm.$form.header.adelanto = Number(0).toFixed(2);
        return;
      }
      if (total < value) {
        vm.$form.header.adelanto = Number(total).toFixed(2);
        return;
      }
      vm.$form.header.adelanto = Number(e).toFixed(2);
      return;
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
    },
    finishAnamnesis() {
      const vm = this;
      try {
        vm.loadingBtn = true;
        vm.$props.send();
      } catch (e) {
        console.error(e);
      } finally {
        vm.loadingBtn = false;
      }
    },
    addCuota() {
      let total = Number(this.$form.header.total);
      const paymentsCount = Number(this.$form.cuotas.length);
      const paymentAmount = Number(this.form.header.adelanto);

      let totalWithDiscounts = total - paymentAmount;
      if (this.$form.header.id_eps_discount != null) {
        totalWithDiscounts -= this.$form.header.eps_discount;
      }
      totalWithDiscounts = totalWithDiscounts < 0 ? 0 : totalWithDiscounts;
      const cuotaAmount = Number(
        totalWithDiscounts / (paymentsCount + 1)
      ).toFixed(2);
      const fecha = new Date();
      fecha.setDate(fecha.getDate() + 1);
      fecha.setMonth(fecha.getMonth() + paymentsCount);
      this.$form.cuotas.forEach((element) => {
        element.monto = cuotaAmount;
      });
      const ultimaCuota =
        totalWithDiscounts - cuotaAmount * this.$form.cuotas.length;
      this.$form.cuotas.push({
        fecha: fecha.toISOString().substring(0, 10),
        menu2: false,
        monto: Number(ultimaCuota).toFixed(2),
      });
      this.$form.header.fecha_vencimiento = fecha
        .toISOString()
        .substring(0, 10);
    },

    deleteCuota(index) {
      this.$form.cuotas.splice(index, 1);
      const total = Number(this.$form.header.total);
      const paymentsCount = Number(this.$form.cuotas.length);
      const paymentAmount = Number(this.form.header.adelanto);

      let totalWithDiscounts = total - paymentAmount;
      if (this.$form.header.id_eps_discount != null) {
        totalWithDiscounts -= this.$form.header.eps_discount;
      }
      totalWithDiscounts = totalWithDiscounts < 0 ? 0 : totalWithDiscounts;

      const cuotaAmount = Number(
        (totalWithDiscounts - paymentAmount) / paymentsCount
      ).toFixed(2);
      let acum = 0;

      for (let index = 0; index < this.$form.cuotas.length; index++) {
        if (index == this.$form.cuotas.length - 1) {
          this.$form.cuotas[index].monto = Number(
            totalWithDiscounts - acum
          ).toFixed(2);
          break;
        }
        this.$form.cuotas[index].monto = cuotaAmount;
        acum += Number(cuotaAmount);
      }
    },
    addGrid() {
      this.$form.detail.push({
        id_producto: null,
        id_precio_lente: null,
        id_servicio: null,
        detalle_item: "",
        precio_compra: 0.0,
        precio_total: 0.0,
        cantidad: 1,
        item_type: null,
        id_unidad_medida: 1,
      });
    },
    async obtenerDataDocumentos() {
      this.$store.commit("loader", true);
      this.datosBus.tipoDoc = this.editedItem.id_tipo_doc;
      this.datosBus.numDoc = this.editedItem.nro_doc;
      const rpta = await axios.post("/api/buscarDniRuc", this.datosBus);
      if (rpta.data.success === true) {
        if (this.datosBus.tipoDoc === 1) {
          this.editedItem.nombre = rpta.data.nombre_o_razon_social;
          this.editedItem.direccion = rpta.data.direccion_completa;
          this.editedItem = JSON.parse(JSON.stringify(this.editedItem));
          this.$store.commit("loader", false);
        } else if (this.datosBus.tipoDoc === 2) {
          this.editedItem.nombre =
            rpta.data.result.Nombres + " " + rpta.data.result.Apellidos;
          this.$store.commit("loader", false);
        }
      } else {
        this.$store.commit("loader", false);
      }

      this.$store.commit("loader", false);
    },
    close() {
      this.dialog = false;
      this.$refs.$form.reset();
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      });
    },
    getTiposDoc() {
      axios
        .get("/api/getTiposDoc")
        .then((response) => {
          this.tipos_doc = response.data;
        })
        .catch((resonse) => {
          console.log("error: " + response.data);
        });
    },
    async getUnidadesMedida() {
      const vm = this;
      const res = await API.unidad_medida.list();
      vm.unidades_medida = res.data;
    },
    calcularTotalFila(indx) {
      this.$form.detail[indx].precio_total = Number(
        this.$form.detail[indx].precio_unitario *
          this.$form.detail[indx].cantidad
      ).toFixed(2);
      this.calcularTotal();
    },
    calcularTotal() {
      var sumaTotal;
      sumaTotal = this.$form.detail.reduce(function (sum, product) {
        var total_fila = parseFloat(Number(product.precio_total));
        if (!isNaN(total_fila)) {
          return sum + total_fila;
        }
      }, 0);

      if (!isNaN(sumaTotal)) {
        this.$form.header.subtotal = parseFloat(sumaTotal / 1.18).toFixed(2);
        this.$form.header.igv = parseFloat(
          sumaTotal - this.$form.header.subtotal
        ).toFixed(2);
        this.$form.header.total = parseFloat(sumaTotal).toFixed(2);
      } else {
        this.$form.header.igv = "";
        this.$form.header.subtotal = "";
        this.$form.header.total = "";
      }
    },
    deleteItem(indx) {
      this.$form.detail.splice(indx, 1);
      this.calcularTotal();
    },
    save() {
      if (this.valid && this.$form.detail.length > 0) {
        this.$store.commit("LOADER", true);
        axios
          .post("/api/compras", this.$form)
          .then((response) => {
            this.$router.push("/compras/ver/" + response.data.id_compra);
            this.$store.commit("LOADER", false);
          })
          .catch((error) => {
            console.log(error);
          });
      } else {
        return;
      }
    },
    searchProviderByDocument() {
      this.loading = true;
      try {
        axios
          .get("/api/proveedor/buscar/" + this.searchDocument)
          .then((response) => {
            if (Object.keys(response.data).length === 0) {
              this.$swal({
                toast: true,
                position: "top-end",
                icon: "error",
                title: "Proveedor no encontrado",
                showConfirmButton: false,
                timerProgressBar: true,
                timer: 2500,
              });
            } else {
              this.loading = false;
              this.$form.header.id_proveedor = response.data.id_proveedor;
              this.$form.header.nombre_proveedor = response.data.nombre;
              this.$form.header.nro_documento = response.data.nro_doc;
              this.$form.header.direccion_proveedor = response.data.direccion;
              this.$swal({
                toast: true,
                position: "top-end",
                icon: "success",
                title: "Proveedor encontrado",
                showConfirmButton: false,
                timerProgressBar: true,
                timer: 2500,
              });
              //this.close();
            }
          });
      } catch (e) {
        console.error(e);
      }
    },
    async saveProveedor() {
      if (this.$refs.$form.validate()) {
        this.loading = true;
        if (this.editedIndex > -1) {
          //Object.assign(this.desserts[this.editedIndex], this.editedItem),
          axios
            .put(
              "/api/provider/" + this.editedItem.id_proveedor,
              this.editedItem
            )
            .then((response) => {
              this.loading = false;
              //this.getlist();
              this.close();
              this.$swal({
                toast: true,
                position: "top-end",
                icon: "success",
                title: "Proveedor Actualizado correctamente",
                showConfirmButton: false,
                timerProgressBar: true,
                timer: 2500,
              });
            })
            .finally(() => (this.cargando = false));
        } else {
          const response = await axios.post("/api/provider", this.editedItem);
          if (response.data.allowed.status) {
            let provider = response.data.cliente;
            this.loading = false;
            //this.getlist();

            this.$form.header.id_proveedor = provider.id_proveedor;
            this.$form.header.nombre_proveedor = provider.nombre;
            this.$form.header.tipo_documento = provider.tipo_doc.tipo_documento;
            this.$form.header.nro_doc = provider.nro_doc;
            this.$form.header.direccion_proveedor = provider.direccion;
            this.close();
            this.$swal({
              toast: true,
              position: "top-end",
              icon: "success",
              title: "Proveedor registrado correctamente",
              showConfirmButton: false,
              timerProgressBar: true,
              timer: 2500,
            });
          } else {
            this.$swal({
              toast: false,
              position: "top-end",
              icon: "error",
              title: "No se pudo registrar al proveedor, (proveedor existente)",
              showConfirmButton: false,
              timerProgressBar: true,
              timer: 2500,
            });
          }
          this.cargando = false;
        }
      } else {
        return;
      }
    },
    async getMedioPago() {
      let vm = this;
      try {
        const response = await API.apis.medioPago();
        vm.origen_dinero = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getTipoComprobante() {
      let vm = this;
      try {
        const response = await API.apis.tipoComprobanteVentas();
        vm.items_tipo_comprobante = response.data;
        vm.$form.header.id_tipo_comprobante =
          vm.items_tipo_comprobante[0].id_tipo_comprobantes;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getMedioPago() {
      let vm = this;
      try {
        const response = await API.apis.medioPago();
        vm.items_medio_pago = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getSeries() {
      const vm = this;
      try {
        const response = await API.servicios.documentos(
          vm.$form.header.id_tipo_comprobante
        );
        vm.series = response.data;
        vm.$form.header.id_serie = vm.series[0].id_serie;
      } catch (e) {
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
  },
};
</script>
<style lang="scss" scoped>
.btn-actions {
  background-color: #fff !important;
  color: #121212;
}
</style>
