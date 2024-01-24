<template>
  <div>
    <v-dialog v-model="dialog" max-width="50%">
      <template v-slot:activator="{ on, attrs }">
        <v-btn v-bind="attrs" v-on="on" primary depressed>
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
  </div>
</template>
<script>
import API from '../../../../api';

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
    };
  },
  methods: {
    async validarCupon(){
        this.loading = true;
        try{
            const response = await API.cupones.verify(this.code);
            if(Object.keys(response.data).length === 0){
                UTILS.toastr.error("Cupón no válido", this);
            }else{
                UTILS.toastr.success("Cupón válido", this);
                this.$emit("validated", response.data);
            }
        }catch(e){
            console.error(e)
        }finally{
            this.code = "";
            this.dialog = false;
            this.loading = false;
        }
    },
    reset(){
        
    }
  },
  computed: {},
};
</script>
