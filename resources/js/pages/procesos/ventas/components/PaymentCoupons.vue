<template>
  <div>
    <v-dialog v-model="dialog" max-width="300" v-if="!showAppliedCoupon">
      <template v-slot:activator="{ on, attrs }">
        <v-btn v-bind="attrs" v-on="on" color="primary" depressed>
          <v-icon>mdi-ticket-percent</v-icon>
          Validar Cupon
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">Verificar Cupon</span>
        </v-card-title>
        <v-divider></v-divider>
        <br />
        <v-card-text>
          <v-form
            ref="paymentForm"
            v-model="validPaymentForm"
            @submit.prevent="validarCupon()"
            lazy-validation
          >
            <v-row>
              <v-col cols="12">
                <v-text-field
                  outlined
                  label="Código de cupon"
                  v-model="code"
                ></v-text-field>
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

    <v-text-field
      filled
      v-else
      label="Cupón Aplicado"
      v-model="coupon.codigo_cupon"
      :hint="couponHint"
      readonly
    ></v-text-field>
  </div>
</template>
<script>
import API from "../../../../api";

export default {
  data() {
    return {
      validPaymentForm: false,
      loading: false,
      dialog: false,
      code: "",
      rules: {
        required: UTILS.nRules.required,
      },
      showAppliedCoupon: false,
      coupon: {
        descuento: "",
        tipo_descuento: null,
      },
    };
  },
  methods: {
    async validarCupon() {
      this.loading = true;
      try {
        const response = await API.cupones.verify(this.code);
        if (Object.keys(response.data).length === 0) {
          UTILS.toastr.error("Cupón no válido", this);
        } else {
          this.showAppliedCoupon = true;
          this.coupon = response.data;

          UTILS.toastr.success("Cupón válido", this);
          this.$emit("validated", response.data);
        }
      } catch (e) {
        console.error(e);
      } finally {
        this.code = "";
        this.dialog = false;
        this.loading = false;
      }
    },
    reset() {},
  },
  computed: {
    couponHint() {
      if (this.coupon.tipo_descuento != null) {
        if (this.coupon.tipo_descuento == 2) {
          return "DESCUENTO: " + this.coupon.descuento + "%";
        } else {
          return "DESCUENTO: S/." + this.coupon.descuento;
        }
      }
      return "";
    },
  },
};
</script>
