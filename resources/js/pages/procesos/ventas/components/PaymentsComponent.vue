<template>
  <div>
    <v-tooltip bottom>
      <template v-slot:activator="{ on, attrs }">
        <v-btn text icon v-bind="attrs" v-on="on" small @click="dialog = !dialog">
          <v-icon>mdi-cash-multiple</v-icon>
        </v-btn>
      </template>
      <span>Agregar de pago</span>
    </v-tooltip>
    <v-dialog v-model="dialog" max-width="60%">

      <v-card>
        <v-card-title>
          <span class="headline">Agregar Pago</span>
        </v-card-title>
        <v-divider></v-divider>
        <br />
        <v-card-text>
          <v-form
            ref="paymentForm"
            v-model="validPaymentForm"
            @submit.prevent="registrarPago()"
            lazy-validation
          >
            <v-row>
              <v-col>
                <h4>
                  Comprobante #{{ receipt.serie.serie }} -
                  {{ receipt.correlativo }}
                </h4>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  label="Total Deuda"
                  v-model="receipt.total"
                  disabled
                ></v-text-field>
              </v-col>

              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  label="Total Abonado"
                  v-model="receipt.total_abonado"
                  disabled
                ></v-text-field>
              </v-col>

              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  label="Monto (*)"
                  :rules="[rules.required, rules.monto]"
                  v-model="payment.monto"
                  @change="formatMonto"
                  type="number"
                  min="0"
                  placeholder="0,00"
                  :max="receipt.saldo"
                  autocomplete="off"
                ></v-text-field>
              </v-col>

              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  label="Saldo Pendiente"
                  v-model="saldoPendiente"
                  disabled
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
                      :rules="[rules.required]"
                      v-model="payment.fecha"
                      prepend-icon="mdi-calendar"
                      v-bind="attrs"
                      v-on="on"
                      readonly
                    ></v-text-field>
                  </template>
                  <v-date-picker
                    v-model="payment.fecha"
                    :rules="[rules.required]"
                    @input="menuFechaPago = false"
                    :max="maxDate"
                    locale="es-ES"
                    no-title
                  ></v-date-picker>
                </v-menu>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-select
                  v-model="payment.id_metodo_pago"
                  :rules="[rules.required]"
                  :items="methods"
                  item-text="medio_pago"
                  item-value="id_medio_pago"
                  label="Medio de pago"
                ></v-select>
              </v-col>
              <v-col cols="12">
                <v-textarea
                  label="Descripción"
                  :rules="[rules.required]"
                  v-model="payment.descripcion"
                  rows="3"
                  outlined
                  autocomplete="off"
                ></v-textarea>
              </v-col>
            </v-row>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn
                color="blue darken-1"
                text
                @click="dialog = false"
                :disabled="loading"
                >Cancelar</v-btn
              >
              <v-btn
                type="submit"
                color="primary"
                :disabled="!validPaymentForm"
                :loading="loading"
                >Guardar</v-btn
              >
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
export default {
  props: {
    short: {
      type: Boolean,
      default: false,
    },
    receipt: {
      type: Object,
      required: true,
    },
    methods: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      rules: {
        required: UTILS.nRules.required,
        monto: (v) => Number(v) <= 0 || "El monto no puede ser 0",
      },
      metodos: [],
      loading: false,
      maxDate: new Date().toISOString().substring(0, 10),
      dialog: false,
      payment: {
        monto: Number(0).toFixed(2),
        saldo: Number(0).toFixed(2),
        fecha: new Date(
          new Date().getTime() - new Date().getTimezoneOffset() * 60 * 1000
        )
          .toISOString()
          .substring(0, 10),
        id_comprobante: null,
        id_caja: null,
        id_metodo_pago: null,
        observacion: "",
      },
      validPaymentForm: false,
      menuFechaPago: false,
      rules: {
        required: UTILS.nRules.required,
      },
    };
  },
  methods: {
    async registrarPago() {
      this.loading = true;
      try {
        if (this.$refs.paymentForm.validate()){
          this.payment.id_comprobante = this.receipt.id_comprobante;
        }
        const response = await API.credito.pagar(this.payment);
        this.$swal({
          icon: response.data.success ? "success" : "warning",
          title: response.data.success ? "Pagado" : response.data.msg,
          allowOutsideClick: true,
          showCancelButton: false,
          showConfirmButton: true,
        });
        this.$emit("created");
      } catch (e) {
        console.error(e);
      } finally {
        this.loading = false;
      }
    },

    formatMonto() {
      this.payment.monto = Number(this.payment.monto).toFixed(2);
      if (Number(this.payment.monto) > Number(this.receipt.saldo)) {
        this.payment.monto = this.receipt.saldo;
      }
    },
  },
  computed: {
    saldoPendiente() {
      return Number(this.receipt.saldo - this.payment.monto).toFixed(2);
    },
  },
};
</script>
