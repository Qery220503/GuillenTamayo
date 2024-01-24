<template>
  <v-dialog v-model="paymentDialog" max-width="60%">
    <v-card>
      <v-card-title>
        <span class="headline">Pago Grupal</span>
      </v-card-title>
      <v-divider></v-divider>
      <br />
      <v-card-text>
        <v-simple-table>
          <thead>
            <tr>
              <th class="text-left">Comprobante #</th>
              <th class="text-left">Emitido por</th>
              <th class="text-left">Total Deuda</th>
              <th class="text-left">Total Abonado</th>
              <th class="text-left">Saldo Pendiente</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, i) in debtsData" :key="i">
              <td>{{ item.id_comprobante }}</td>
              <td>{{ item.nombre_cliente }}</td>
              <td>S/. {{ item.total }}</td>
              <td>S/. {{ item.total_abonado }}</td>
              <td>S/. {{ item.saldo }}</td>
            </tr>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="4" style="text-align: right"><b>Total: </b></td>
              <td colspan="1">
                <b>S/. {{ calcularTotalSaldoPendiente() }}</b>
              </td>
            </tr>
          </tfoot>
        </v-simple-table>
        <v-divider class="my-2"></v-divider>
        <v-form
          ref="paymentForm"
          v-model="validPaymentForm"
          @submit.prevent="registrarPagoGrupal()"
          lazy-validation
        >
          <v-row>
            <v-col cols="12" sm="4" md="4">
              <v-select
                v-model="formPago.id_metodo_pago"
                :rules="[rules.required]"
                :items="methods"
                item-text="medio_pago"
                item-value="id_medio_pago"
                label="Medio de pago"
              ></v-select>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                label="Monto *"
                v-model="formPago.montoAbonado"
                type="number"
                min="0"
                placeholder="0,00"
                :max="formPago.deuda_saldo"
                :rules="[rules.required]"
                autocomplete="off"
                readonly
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-menu
                v-model="menuFechaPago"
                :close-on-content-click="false"
                :nudge-right="40"
                transition="scale-transition"
                offset-y
                min-width="auto"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    label="Fecha de Pago"
                    v-model="formatoFechaPago"
                    prepend-icon="mdi-calendar"
                    v-bind="attrs"
                    v-on="on"
                    readonly
                  ></v-text-field>
                </template>
                <v-date-picker
                  v-model="formPago.fechaPago"
                  @input="menuFechaPago = false"
                  locale="es-ES"
                  no-title
                ></v-date-picker>
              </v-menu>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" sm="12" md="12">
              <v-textarea
                label="Descripción"
                v-model="formPago.descripcion"
                rows="2"
                outlined
                autocomplete="off"
              ></v-textarea>
            </v-col>
          </v-row>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue darken-1" text @click="paymentDialog = false"
              >Cancelar</v-btn
            >
            <v-btn type="submit" color="primary" :disabled="!validPaymentForm"
              >Guardar</v-btn
            >
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    cuentaRoute: String,
    methods: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      //--- Dialog Payment ---
      paymentDialog: false,
      validPaymentForm: false,
      debtsData: [],
      formPago: {
        idOrigenDinero: 1,
      },
      menuFechaPago: false,
      origenesDinero: [],
      //--- Fin ---

      rules: {
        required: UTILS.nRules.required,
      },
    };
  },
  mounted() {
    this.$root.$on("cuentas_pago_grupal", (data) => {
      this.debtsData = data;
      this.paymentDialog = true;
    });

    this.formPago.fechaPago = this.todaysDateDefault();
    this.getOrigenesDinero();
  },
  methods: {
    registrarPagoGrupal() {
      const debtsData = this.debtsData.map((e) => e.id_comprobante);
      let IDs = debtsData.join(",");
      axios
        .post("/api/cliente/pagoGrupal/" + IDs, this.formPago)
        .then((response) => {
          this.paymentDialog = false;
          UTILS.toastr.success(response.data.message, this);

          if (typeof this.$parent.getRegistros() === "function") {
            this.$parent.getRegistros();
          }
        })
        .catch((e) => {
          console.error(e);
          UTILS.toastr.error(e.response.data.message, this);
        });
    },
    calcularTotalSaldoPendiente() {
      let total = 0;
      this.debtsData.forEach(function (item) {
        total += Number(item.saldo);
      });

      this.formPago.montoAbonado = total;
      return Number(total).toFixed(2);
    },

    async getOrigenesDinero() {
      try {
        const response = await API.origenDinero.combo();
        this.origenesDinero = response.data;
      } catch (e) {
        console.error(e);
      }
    },
  },
  watch: {
    paymentDialog() {
      if (!this.paymentDialog) {
        this.$refs.paymentForm.resetValidation();
        this.validPaymentForm = false;
        this.formPago = {};
        this.formPago.idOrigenDinero = 1;
        this.formPago.fechaPago = this.todaysDateDefault();
      }
    },
  },
  computed: {
    formatoFechaPago: {
      get: function () {
        return this.formatDate(this.formPago.fechaPago);
      },
      set: function (newValue) {
        return this.formatDate(newValue);
      },
    },
  },
};
</script>
