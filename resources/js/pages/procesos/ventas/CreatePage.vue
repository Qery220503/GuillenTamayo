<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <div class="my-2">
      <v-form
        ref="form"
        v-model="valid"
        lazy-validation
        @submit.prevent="save()"
      >
        <v-card class="mb-4" light style="padding: 15px">
          <v-row dense>

            <v-col cols="12" md="4">
              <v-select
                v-model="form.header.id_tipo_comprobante"
                :rules="[rules.required]"
                item-text="nombre_tipo_documento"
                item-value="id_tipo_comprobantes"
                label="Tipo Comprobante"
                filled
                @change="getSeries"
                dense
                :items="items_tipo_comprobante"
              ></v-select>
            </v-col>

            <v-col cols="12" md="4">
              <v-select
                v-model="form.header.id_serie"
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
              <v-select
                :items="items_tipo_doc"
                label="Tipo Documento"
                placeholder="Selecciona un tipo documento"
                v-model="form.header.id_tipo_documento"
                :rules="[rules.required]"
                required
                item-text="nombre_tipo_documento"
                item-value="id_tipo_documento"
                filled
                dense
              ></v-select>
            </v-col>
            <v-col cols="12" md="4">
              <v-text-field
                v-model="form.header.nro_documento"
                label="Nro. Documento"
                :rules="[rules.required, rules.dni]"
                v-if="form.header.id_tipo_documento == 1"
                filled
                dense
                autocomplete="off"
                maxlength="8"
              >
                <template v-slot:append>
                  <v-tooltip bottom>
                    <template v-slot:activator="{ on }">
                      <v-btn
                        color="primary"
                        class="mb-1 mx-1"
                        @click="obtenerDataDocumentos()"
                        v-on="on"
                        dark
                        small
                      >
                        <v-icon>mdi-magnify</v-icon>
                      </v-btn>
                    </template>
                    Buscar
                  </v-tooltip>

                  <ClientDialog
                    @created="HandleClient"
                    :doc_type="form.header.id_tipo_documento"
                  />
                </template>
                <template v-slot:prepend-inner>
                  <v-tooltip bottom>
                    <template v-slot:activator="{ on }">
                      <v-icon
                        color="primary"
                        class="mr-2"
                        @click="defaultClient()"
                        v-on="on"
                      >
                        mdi-account-multiple
                      </v-icon>
                    </template>
                    Clientes Varios
                  </v-tooltip>
                </template>
              </v-text-field>
              <v-text-field
                v-model="form.header.nro_documento"
                label="Nro. Documento"
                :rules="[rules.required, rules.ruc]"
                v-if="form.header.id_tipo_documento == 2"
                filled
                dense
                autocomplete="off"
                maxlength="11"
              >
                <template #append>
                  <v-tooltip bottom>
                    <template v-slot:activator="{ on }">
                      <v-btn
                        color="primary"
                        class="mb-1 mx-1"
                        @click="obtenerDataDocumentos()"
                        v-on="on"
                        dark
                        small
                      >
                        <v-icon>mdi-magnify</v-icon>
                      </v-btn>
                    </template>
                    Buscar
                  </v-tooltip>

                  <ClientDialog
                    @created="HandleClient"
                    :doc_type="form.header.id_tipo_documento"
                  />
                </template>
              </v-text-field>
              <v-text-field
                v-model="form.header.nro_documento"
                label="Nro. Documento"
                :rules="[rules.required]"
                v-if="
                  form.header.id_tipo_documento != 1 &&
                  form.header.id_tipo_documento != 2
                "
                filled
                dense
                autocomplete="off"
                maxlength="11"
              >
                <template #append>
                  <v-tooltip bottom>
                    <template v-slot:activator="{ on }">
                      <v-btn
                        color="primary"
                        class="mb-1 mx-1"
                        @click="obtenerDataDocumentos()"
                        v-on="on"
                        dark
                        small
                      >
                        <v-icon>mdi-magnify</v-icon>
                      </v-btn>
                    </template>
                    Buscar
                  </v-tooltip>

                  <ClientDialog
                    @created="HandleClient"
                    :doc_type="form.header.id_tipo_documento"
                  />
                </template>
              </v-text-field>
            </v-col>
            <v-col cols="12" md="4">
              <v-text-field
                v-model="form.header.nombre_cliente"
                :rules="[rules.required]"
                filled
                dense
                label="Nombre Cliente"
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
                    v-model="form.header.fecha_emision"
                    label="Fecha"
                    prepend-inner-icon="mdi-calendar"
                    :rules="[rules.required]"
                    readonly
                    filled
                    dense
                    v-bind="attrs"
                    v-on="on"
                  ></v-text-field>
                </template>
                <v-date-picker
                  v-model="form.header.fecha_emision"
                  no-title
                  @input="menu2 = false"
                ></v-date-picker>
              </v-menu>
            </v-col>
            <v-col cols="12" md="4">
              <v-text-field
                v-model="form.header.direccion_cliente"
                :rules="[rules.required]"
                filled
                dense
                label="Dirección Cliente"
              ></v-text-field>
            </v-col>
            <v-col cols="12" md="4">
              <v-select
                v-model="form.header.id_medio_pago"
                :items="items_medio_pago"
                label="Medio de Pago"
                filled
                dense
                :rules="[rules.required]"
                item-text="medio_pago"
                item-value="id_medio_pago"
              ></v-select>
            </v-col>
            <v-col cols="12" md="4">
              <v-text-field
                v-model="form.header.nro_operacion"
                label="Nro.Operación"
                filled
                dense
              ></v-text-field>
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
                dense
                item-text="Description"
                item-value="API"
                label="Buscar Producto"
                placeholder="Buscar Producto"
                return-object
                clearable
              ></v-autocomplete>
            </v-col>
            <v-spacer></v-spacer>
            <v-col cols="auto">
              <v-btn depressed @click="addGrid()">
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
                      v-model="form.header.subtotal"
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
                      v-model="form.header.igv"
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
                      v-model="form.header.dscto_fijo"
                      hide-details
                      outlined
                      dense
                      filled
                      prefix="S/."
                      type="number"
                      step="0.01"
                    ></v-text-field>
                  </td>
                </tr>
                <tr>
                  <td colspan="4" style="text-align: right">
                    <b>Descuento (%):</b>
                  </td>
                  <td colspan="1">
                    <v-text-field
                      v-model="form.header.descuento_porcentaje"
                      hide-details
                      outlined
                      dense
                      filled
                      prefix="%"
                      type="number"
                      step="0.01"
                    ></v-text-field>
                  </td>
                  <td colspan="2">
                    <v-text-field
                      v-model="form.header.dscto_porcentaje"
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
                    <b>Total: </b>
                  </td>
                  <td colspan="2">
                    <v-text-field
                      v-model="form.header.total"
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
                    <b>Adelanto: </b>
                  </td>
                  <td colspan="2">
                    <v-text-field
                      v-model="form.header.adelanto"
                      hide-details
                      outlined
                      dense
                      filled
                      :disabled="form.header.condicion_pago == 1"
                      prefix="S/."
                      @change="handleAdelanto($event)"
                      :min="0"
                      type="number"
                      step="0.01"
                    ></v-text-field>
                  </td>
                </tr>
              </tfoot>
            </template>
          </v-simple-table>

          <v-divider></v-divider>
          <br />
          <v-row dense class="pa-2 py-0">
            <v-col cols="3">
              <v-select
                v-model="form.header.condicion_pago"
                :items="condiciones_pago"
                label="Condición de Pago"
                item-text="text"
                item-value="value"
                :disabled="
                  form.header.id_cliente == '1' || form.header.factura_gratuita
                "
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
            <v-col cols="3" v-if="form.header.id_tipo_comprobante == 1">
              <v-checkbox
                v-model="form.header.factura_gratuita"
                :disabled="form.header.id_cliente == '1'"
                label="Factura Gratuita"
              ></v-checkbox>
            </v-col>
          </v-row>

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
                    <tr v-for="(item, index) in form.cuotas" :key="index">
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
            <v-btn color="primary" type="submit" :loading="loading"
              >Guardar</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-form>
    </div>
    <v-dialog v-model="dialog" persistent max-width="350">
      <v-card>
        <v-card-title class="text-subtitle">
          Ingrese su clave administrador
        </v-card-title>
        <v-card-text>
          <div class="ma-auto position-relative" style="max-width: 300px">
            <v-otp-input
              v-model="otp"
              :disabled="otp_loading"
              @finish="onFinish"
              type="password"
            ></v-otp-input>
            <v-overlay absolute :value="otp_loading">
              <v-progress-circular
                indeterminate
                color="primary"
              ></v-progress-circular>
            </v-overlay>
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="error" text @click="dialog = false"> Cancelar </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog v-model="receiptDialog" style="width: 80%" @click:outside="exitReceiptDialog()">
      <v-card>
        <v-toolbar flat color="primary" dark>
          <v-toolbar-title>Recibo</v-toolbar-title>
        </v-toolbar>
        <v-tabs>
          <v-tab>
            <v-icon left> mdi-receipt </v-icon>
            Recibo
          </v-tab>
          <v-tab v-if="showCoupon">
            <v-icon left> mdi-ticket-percent </v-icon>
            Cupon
          </v-tab>

          <v-tab-item>
            <v-card flat>
              <v-card-text v-if="showFormats">
                <v-select
                  :items="['a4', 'a5', 'ticket']"
                  v-model="format"
                  outlined
                  hide-details
                  label="Formato comprobante"
                ></v-select>
              </v-card-text>
              <v-card-text>
                <iframe
                  :src="receiptUrlFormated"
                  frameborder="0"
                  style="width: 100%; height: 450px"
                ></iframe>
              </v-card-text>
            </v-card>
          </v-tab-item>
          <v-tab-item v-if="showCoupon">
            <v-card flat>
              <v-card-text>
                <CouponTicket :coupon="coupon" />
              </v-card-text>
            </v-card>
          </v-tab-item>
        </v-tabs>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="exitReceiptDialog">Salir</v-btn>
          <v-btn color="secondary" :href="'/comprobantes/ver/' + id_comprobante">Ver Comprobante</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from "axios";
import API from "../../../api";
import Vue from "vue";
import ClientDialog from "./components/ClientDialog.vue";
import CouponTicket from "./components/CouponTicket.vue";

export default {
  components: {
    CouponTicket,
    ClientDialog,
  },
  data: () => ({
    valid: false,
    format: '',
    series: [],
    receiptDialog: false,
    receiptURL: "",
    showCoupon: false,
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
    coupon: {
      codigo_cupon: '',
    },
    search_productos: null,
    get_producto: {
      unidad_medida: {},
    },
    entries_productos: [],
    entries_servicios: [],
    tipos_doc: [],
    id_comprobante: "",
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
    items_tipo_comprobante: [],
    items_tipo_doc: [],
    items_medio_pago: [],
    menu2: false,
    menuDeudaDate: false,
    condiciones_pago: [
      { text: "Al Contado", value: 1 },
      { text: "Al Crédito", value: 2 },
      { text: "Al Crédito con Cuotas", value: 3 },
    ],
    tipos_deuda: [
      { text: "Total", value: "total" },
      { text: "Saldo", value: "saldo" },
    ],
    dialog: false,
    otp_loading: false,
    snackbar: false,
    otp: "",
    text: "",
    form: {
      header: {
        id_cliente: "",
        id_tipo_comprobante: 2,
        id_estado_comprobante: "",
        id_tipo_documento: 1,
        id_medio_pago: 1,
        id_serie: "",
        condicion_pago: 1,
        nombre_cliente: "",
        nro_documento: "",
        direccion_cliente: "",
        fecha_emision: new Date(
          Date.now() - new Date().getTimezoneOffset() * 60000
        )
          .toISOString()
          .substr(0, 10),
        fecha_vencimiento: new Date(
          Date.now() - new Date().getTimezoneOffset() * 60000
        )
          .toISOString()
          .substr(0, 10),
        nro_operacion: "",
        igv: 0.0,
        subtotal: 0.0,
        total: 0.0,
        adelanto: 0.0,
        saldo: 0.0,
        dscto_porcentaje: 0.0,
        descuento_porcentaje: null,
        dscto_fijo: 0.0,
        comentario: "",
        factura_gratuita: false,
      },
      detail: [],
      unidad_medida: [],
      cuotas: [],
    },
    loading: false,
    breadcrumbs_title: "Crear Comprobante",
    breadcrumbs: [
      { text: "Inicio", disabled: false, href: "#" },
      { text: "Procesos", disabled: false, href: "#" },
      { text: "Comprobantes" },
    ],
    unidades_medida: [],
    series: [],
    showFormats: false,
  }),

  computed: {
    saldo() {
      let saldo = this.form.header.total - this.form.header.adelanto;
      saldo = saldo < 0 ? 0 : saldo;
      return Number(saldo).toFixed(2);
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
    receiptUrlFormated(){
      return this.receiptURL + "/" + this.format;
    }
  },

  mounted() {
    this.checkIfCashIsOpen("comprobantes/crear");
    this.getTipos();
    this.getSeries();
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
      let detailIndex = this.form.detail.findIndex((e) => {
        if (item.item_type === 1) {
          return e.id_producto === item.id_producto;
        } else if (item.item_type === 2) {
          return e.id_precio_lente === item.id_precio_lente;
        } else if (item.item_type === 3) {
          return e.id_servicio === item.id_servicio;
        } else {
          return false;
        }
      });
      if (detailIndex != -1) {
        Vue.set(
          this.form.detail[detailIndex],
          "cantidad",
          this.form.detail[detailIndex].cantidad + 1
        );
        return;
      }

      if (item.item_type === 1 && val.st_tienda <= 0) {
        //alert("");
        this.$swal({
          position: "center",
          icon: "info",
          title: "Sin Stock",
          text: "No existe stock en tienda debe realizar un movimiento de almacen para evitar problemas con el inventario",
          showConfirmButton: true,
        });
      }
      this.form.detail.push(item);
      this.calcularTotal();
      return;
    },
    "form.header.tipo_deuda"(val) {
      this.form.header.pago_total = 0.0;
      this.form.header.pago_saldo = this.form.header.total;
    },
    "form.header.pago_total"(val) {
      this.form.header.pago_saldo = this.form.header.total - val;
    },
    "form.header.nro_documento"(value) {
      this.$store.commit("loader", true);
      let isRuc = value.substr(0, 2);
      if (value.length == 8 && !(isRuc == 10 || isRuc == 20)) {
        this.buscarPaciente();
      }
      if (value.length == 11) {
        this.buscarPaciente();
      }
      this.$store.commit("loader", false);
    },
    "form.header.id_cliente"(value) {
      this.form.header.condicion_pago = 1;
      this.form.header.factura_gratuita = false;
      this.form.cuotas = [];
    },
    "form.header.factura_gratuita"(value) {
      this.form.cuotas = [];
      this.form.header.adelanto = 0.0;
      this.form.header.fecha_vencimiento = new Date(
        Date.now() - new Date().getTimezoneOffset() * 60000
      )
        .toISOString()
        .substr(0, 10);
      this.form.header.deuda_tipo = null;
    },
    "form.header.condicion_pago"(value) {
      switch (value) {
        //Contado
        case 1:
          this.form.cuotas = [];
          this.form.header.adelanto = 0.0;
          this.form.header.fecha_vencimiento = new Date(
            Date.now() - new Date().getTimezoneOffset() * 60000
          )
            .toISOString()
            .substr(0, 10);
          this.form.header.deuda_tipo = null;
          break;
        //Credito
        case 2:
          var date = new Date();
          var newDate = new Date(date.setMonth(date.getMonth() + 3));

          this.form.header.fecha_vencimiento = newDate
            .toISOString()
            .substring(0, 10);

          this.form.header.adelanto = Number(0).toFixed(2);
          this.form.header.deuda_tipo = "saldo";
          this.form.cuotas = [];
          break;

        case 3:
          this.form.header.deuda_tipo = "saldo";
          const cuotas = [];
          let total = this.form.header.total - this.form.header.adelanto;
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
          this.form.header.fecha_vencimiento = lastDate
            .toISOString()
            .substring(0, 10);
          this.form.cuotas = cuotas;
          break;
        default:
          break;
      }
    },
    "form.header.id_tipo_comprobante"(value) {
      this.form.header.id_tipo_documento = value == 1 ? 2 : 1;
    },
    "form.header.descuento_porcentaje"(value) {
      if (value > 0 && value != "") {
        if (
          this.form.header.dscto_fijo != null ||
          this.form.header.dscto_fijo != 0
        ) {
          this.form.header.dscto_fijo = 0.0;
        }
        var sumaTotal;
        sumaTotal = this.form.detail.reduce(function (sum, product) {
          var total_fila = parseFloat(Number(product.precio_total));
          if (!isNaN(total_fila)) {
            return sum + total_fila;
          }
        }, 0);
        if (!isNaN(sumaTotal)) {
          let descuento = sumaTotal * (value / 100);
          sumaTotal = sumaTotal - descuento;
          this.form.header.dscto_porcentaje = parseFloat(descuento).toFixed(2);
          this.form.header.subtotal = parseFloat(sumaTotal / 1.18).toFixed(2);
          this.form.header.igv = parseFloat(
            sumaTotal - this.form.header.subtotal
          ).toFixed(2);
          this.form.header.total = parseFloat(sumaTotal).toFixed(2);
        }
      } else {
        this.calcularTotal();
      }
    },
    "form.header.dscto_fijo"(value) {
      if (value > 0 && value != "") {
        if (
          this.form.header.descuento_porcentaje != null ||
          this.form.header.descuento_porcentaje != 0
        ) {
          this.form.header.descuento_porcentaje = null;
          this.form.header.dscto_porcentaje = 0;
        }

        var sumaTotal;
        sumaTotal = this.form.detail.reduce(function (sum, product) {
          var total_fila = parseFloat(Number(product.precio_total));
          if (!isNaN(total_fila)) {
            return sum + total_fila;
          }
        }, 0);
        if (!isNaN(sumaTotal)) {
          let descuento = this.form.header.dscto_fijo;
          sumaTotal = sumaTotal - descuento;
          this.form.header.subtotal = parseFloat(sumaTotal / 1.18).toFixed(2);
          this.form.header.igv = parseFloat(
            sumaTotal - this.form.header.subtotal
          ).toFixed(2);
          this.form.header.total = parseFloat(sumaTotal).toFixed(2);
        }
      } else {
        this.calcularTotal();
      }
    },
  },
  created() {
    this.getTiposDoc();
    this.getMedioPago();
    this.getTipoComprobante();
    this.getUnidadesMedida();
  },
  methods: {
    HandleClient(client) {
      const vm = this;
      vm.form.header.nro_documento = client.nro_documento;
      vm.form.header.id_cliente = client.id_cliente;
      vm.form.header.nombre_cliente = client.nombre_razon_social;
      vm.form.header.direccion_cliente = client.direccion;
      vm.form.header.id_tipo_documento = client.cod_tipo_doc;
    },
    handleTipoDeuda() {
      if (this.form.header.deuda_tipo == "total") {
        this.form.header.adelanto = Number(0).toFixed(2);
      }
    },
    exitReceiptDialog(){
      const vm = this;
      vm.$router.push("/comprobantes");
    },
    handleAdelanto(e) {
      const vm = this;

      let value = Number(e);
      if (value === NaN) {
        vm.form.header.adelanto = Number(0).toFixed(2);
        return;
      }
      if (vm.form.header.total < value) {
        vm.form.header.adelanto = vm.form.header.total;
        return;
      }
      vm.form.header.adelanto = Number(e).toFixed(2);
      return;
    },
    onFinish(rsp) {
      this.otp_loading = true;
      setTimeout(() => {
        this.otp_loading = false;
        this.snackbar = true;
      }, 3500);
    },
    addCuota() {
      const cuotas = this.form.cuotas.length;
      const lastDate = new Date();

      let total = this.form.header.total - this.form.header.adelanto;
      total = total < 0 ? 0 : total;
      let cuotaMonto = Number(total / (this.form.cuotas.length + 1)).toFixed(2);

      lastDate.setDate(lastDate.getDate() + 1);
      lastDate.setMonth(lastDate.getMonth() + cuotas);
      this.form.cuotas.forEach((e) => (e.monto = cuotaMonto));
      this.form.cuotas.push({
        fecha: lastDate.toISOString().substring(0, 10),
        menu2: false,
        monto: cuotaMonto,
      });
    },
    addGrid() {
      this.form.detail.push({
        codigo_producto: "000",
        nombre_producto: "",
        precio_compra: 0.0,
        precio_total: 0.0,
        cantidad: 1,
        unidad_medida: "UND",
      });
    },
    async getTipos() {
      let vm = this;
      try {
        const response = await API.tipos_documentos.combo();
        vm.items_tipo_doc = response.data;
      } catch (e) {
        UTILS.toastrr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

    async buscarPaciente() {
      const vm = this;
      try {
        this.$store.commit("loader", true);
        vm.clearPaciente();
        const response = await API.clientes.buscar(
          "?nro_nro_documento=" +
            vm.form.header.nro_documento +
            "&cod_tipo_doc=" +
            vm.form.header.id_tipo_documento
        );
        if (!response.data.success) {
          this.obtenerDataDocumentos();
        } else {
          let data = response.data.data;
          vm.form.header.id_cliente = data.id_cliente;
          vm.form.header.nombre_cliente = data.nombre_razon_social;
          vm.form.header.direccion_cliente = data.direccion;
          vm.form.header.id_tipo_documento = data.cod_tipo_doc;
          /*
          vm.form.header.id_tipo_comprobante =
            data.id_tipo_documento == 1 ? 2 : 1;*/
        }
      } catch (e) {
        UTILS.toastrr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      } finally {
        this.$store.commit("loader", false);
      }
    },
    defaultClient() {
      this.form.header.nro_documento = "00000000";
      //this.obtenerDataDocumentos();
    },
    async getSeries() {
      const vm = this;
      try {
        const response = await API.servicios.documentos(
          vm.form.header.id_tipo_comprobante
        );
        vm.series = response.data;
        vm.form.header.id_serie = vm.series[0].id_serie;
      } catch (e) {
        console.error(e);
      }
    },
    async obtenerDataDocumentos() {
      if (this.form.header.nro_documento == "") return;
      if (this.form.header.nro_documento == "00000000") return;
      try {
        this.$store.commit("loader", true);
        this.datosBus.tipoDoc = this.form.header.id_tipo_documento;
        this.datosBus.numDoc = this.form.header.nro_documento;
        const rpta = await API.apis.dniruc(this.datosBus);
        if (rpta.data.success === false) {
          UTILS.toastr.info(
            "No se logro encontrar información sobre este documento",
            this
          );
          return;
        }

        if (this.datosBus.tipoDoc == 2) {
          this.form.header.nombre_cliente = rpta.data.nombre_o_razon_social;
          this.form.header.direccion_cliente = rpta.data.direccion_completa;
          if (rpta.data.estado == "ACTIVO" && rpta.data.condicion == "HABIDO") {
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
        } else {
          this.form.header.nombre_cliente =
            rpta.data.result.Nombres + " " + rpta.data.result.Apellidos;
          this.form.header.direccion_cliente =
            rpta.data.result.direccion_completa;
        }
        UTILS.toastr.success("Cliente encontrado", this);
      } catch (error) {
        console.error(error);
        UTILS.toastr.error("Ups! Ocurrio un error", this);
      } finally {
        this.$store.commit("loader", false);
      }
    },
    clearPaciente() {
      this.form.header.id_cliente = "";
      this.form.header.nombre_cliente = "";
      this.form.header.direccion_cliente = "";
      this.$refs.form.resetValidation();
    },
    close() {
      this.dialog = false;
      this.$refs.form.reset();
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
    calcularTotalFila(indx) {
      this.form.detail[indx].precio_total = Number(
        this.form.detail[indx].precio_unitario * this.form.detail[indx].cantidad
      ).toFixed(2);
      console.log(this.form.detail[indx]);
      this.calcularTotal();
    },
    calcularTotal() {
      var sumaTotal;
      sumaTotal = this.form.detail.reduce(function (sum, product) {
        var total_fila = parseFloat(Number(product.precio_total));
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
    },
    deleteItem(indx) {
      this.form.detail.splice(indx, 1);
      this.calcularTotal();
    },
    calculateTotalCuotas() {
      const vm = this;
      return vm.form.cuotas.reduce((a, c) => Number(a) + Number(c.monto), 0);
    },
    async save() {
      const vm = this;
      vm.loading = true;
      try {
        if (vm.form.header.condicion_pago === 3) {
          let totalCuotas = vm.calculateTotalCuotas();
          let totalComprobante = totalCuotas + Number(vm.form.header.adelanto);
          if (totalComprobante != Number(vm.form.header.total)) {
            UTILS.toastr.error("Verificar el total de las cuotas", vm);
            return;
          }
        }

        if (vm.form.detail.length == 0) {
          UTILS.toastr.error(
            "Necesita tener al menos un elemento en el comprobante",
            vm
          );
          return;
        }

        if (!vm.$refs.form.validate()) {
          return;
        }

        if (
          vm.form.header.id_tipo_comprobante == 1 &&
          vm.form.header.id_tipo_documento != 2
        ) {
          UTILS.toastr.info("Verifique el tipo de documento", vm);
          return;
        }

        if (vm.form.header.id_cliente == 1 && vm.form.header.total >= 700) {
          UTILS.toastr.info(
            "No se pueden realizar ventas superiores a S/.700 a CLIENTES VARIOS",
            vm
          );
          return;
        }
        const response = await API.comprobante.create(vm.form);
        if (!response.data.success) {
          UTILS.toastr.error("Error de comprobación con SUNAT", vm);
          return;
        }

        const data = response.data;
        let url = "";

        if (data.cupon != null) {
          this.coupon = data.cupon;
          this.showCoupon = true;
        }

        if (data.pdf) {
          url = data.facturador + "/print/document/" + data.external_id;
          this.id_comprobante = data.comprobante.id_comprobante;
          this.format = 'ticket';
          this.showFormats = true;
        } else {
          url = "/comprobantes/notas-venta/" + data.comprobante.id_comprobante;
          this.id_comprobante = data.comprobante.id_comprobante;
        }

        this.receiptURL = url;
        this.receiptDialog = true;
        //vm.$router.push("/comprobantes");
      } catch (e) {
        UTILS.toastr.error(
          "Ocurrio un error durante la creación del comprobante",
          this
        );
        console.error(e);
      } finally {
        vm.loading = false;
      }
    },

    async getUnidadesMedida() {
      const vm = this;
      const res = await API.unidad_medida.list();
      vm.unidades_medida = res.data;
    },
    searchProviderByDocument() {
      this.loading = true;
      try {
        axios
          .get("/api/proveedor/buscar/" + this.searchDocument)
          .then((response) => {
            if (Object.keys(response.data).length === 0) {
              this.$swal({
                toastr: true,
                position: "top-end",
                icon: "error",
                title: "Proveedor no encontrado",
                showConfirmButton: false,
                timerProgressBar: true,
                timer: 2500,
              });
            } else {
              this.loading = false;
              this.form.header.id_proveedor = response.data.id_proveedor;
              this.form.header.nombre_proveedor = response.data.nombre;
              this.form.header.nro_documento = response.data.nro_doc;
              this.form.header.direccion_proveedor = response.data.direccion;
              this.$swal({
                toastr: true,
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

    async getMedioPago() {
      let vm = this;
      try {
        const response = await API.apis.medioPago();
        vm.origen_dinero = response.data;
      } catch (e) {
        UTILS.toastrr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getTipoComprobante() {
      let vm = this;
      try {
        const response = await API.apis.tipoComprobanteVentas();
        vm.items_tipo_comprobante = response.data;
        //vm.form.header.id_tipo_comprobante = vm.items_tipo_comprobante[0].id_tipo_comprobantes;
        console.log(vm.form.header);
      } catch (e) {
        UTILS.toastrr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getMedioPago() {
      let vm = this;
      try {
        const response = await API.apis.medioPago();
        vm.items_medio_pago = response.data;
      } catch (e) {
        UTILS.toastrr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
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
