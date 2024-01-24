<template>
    <v-dialog v-model="paymentDialog" max-width="60%">
        <v-card>
            <v-card-title>
                <span class="headline">Agregar Pago</span>
            </v-card-title>
            <v-divider></v-divider>
            <br>
            <v-card-text>
                <v-form ref="paymentForm"
                    v-model="validPaymentForm"
                    @submit.prevent="registrarPago()"
                    lazy-validation>
                    <v-row>
                        <v-col>
                            <h4>Compra {{formDetail.serie.serie + "-" + formDetail.correlativo}}</h4>
                            <h4>Guía / Factura #{{formDetail.guia_factura}}</h4>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="12" sm="4" md="4">
                            <v-text-field label="Total Deuda" v-model="formDetail.total" disabled></v-text-field>
                            <v-select label="Origen *" v-model="formPago.idOrigenDinero"
                                :items="origenesDinero"
                                item-text="nombre_origen"
                                item-value="id_origen_dinero"
                                :rules="[rules.required]"
                            ></v-select>
                            <v-text-field label="Banco *" v-model="formPago.banco" :rules="[rules.required]"></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="4" md="4">
                            <v-text-field label="Total Abonado" v-model="formDetail.deuda_total_abonado" disabled></v-text-field>
                            <v-text-field label="Monto *" v-model="formPago.montoAbonado" type="number"
                                min="0"
                                placeholder="0,00"
                                :max='formDetail.deuda_saldo'
                                :rules="[
                                  (val) => !!val && val >= 1 || 'El monto debe ser mayor o igual a S/. 1.00'
                                ]"
                                autocomplete="off"
                            ></v-text-field>
                            <v-text-field label="Nro. Operación/Voucher" v-model="formPago.nroOperacion"></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="4" md="4">
                            <v-text-field label="Saldo Pendiente" v-model="formDetail.deuda_saldo" disabled></v-text-field>
                            <v-menu
                                v-model="menuFechaPago"
                                :close-on-content-click="false"
                                :nudge-right="40"
                                transition="scale-transition"
                                offset-y
                                min-width="auto">
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
                                    @input="menuFechaPago=false"
                                    locale="es-ES"
                                    no-title
                                ></v-date-picker>
                            </v-menu>

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
                        <v-btn color="blue darken-1" text @click="paymentDialog = false" >Cancelar</v-btn>
                        <v-btn type="submit" color="primary" :disabled="!validPaymentForm">Guardar</v-btn>
                    </v-card-actions>
                </v-form>
            </v-card-text>
        </v-card>
    </v-dialog>
</template>

<script>
export default {
    props:{
        cuentaRoute: String,
        getRegistros: Function,
    },
    data(){
        return{
            //--- Dialog Payment ---
            paymentDialog: false,
            validPaymentForm: false,
            formPago: {
                fechaPago: null,
                montoAbonado: null,
                idOrigenDinero: 1,
            },
            formDetail:{
                serie:{}
            },
            menuFechaPago: false,
            defaultFormPago: {
                fechaPago: null,
                montoAbonado: null,
                idOrigenDinero: 1,
            },
            origenesDinero:[],
            //--- Fin ---

            rules:{
                required: UTILS.nRules.required,
            }
        }
    },
    mounted() {
        this.$root.$on("cuentas_agregar_pago", data => {
            this.formDetail = Object.assign({}, data);
            this.formPago.id_compra = data.id_compra;
            this.paymentDialog = true;
        });

        this.formPago.fechaPago = this.todaysDateDefault();
        this.getOrigenesDinero();
    },
    methods:{
        //--- Add Payment Functions ---
        registrarPago(){
            if(!this.$refs.paymentForm.validate()){
              return;
            }
            axios.post('/api/'+this.cuentaRoute, this.formPago).then((response)=>{
                this.paymentDialog = false;
                UTILS.toastr.success(response.data.message, this);

                this.getRegistros();

                /*
                if(typeof this.$parent.getRegistros()  === "function"){
                    console.log(this.$parent.getRegistros());
                    this.$parent.getRegistros();
                }
                */

            }).catch(e => {
                console.error(e);
                UTILS.toastr.error(e.response.data.message, this);

            });
        },
        //--- Fin ---


        async getOrigenesDinero(){
            try {
                const response = await API.origenDinero.combo();
                this.origenesDinero = response.data;

            } catch (e) {
                console.error(e);
            }
        },

    },
    watch:{
        /*
        "formPago.montoAbonado"(value){
          if(value < 0) {
            this.formPago.montoAbonado = 1;
          }
        },
        */
        paymentDialog(){
            if(!this.paymentDialog){
                this.$refs.paymentForm.resetValidation();
                this.validPaymentForm = false;
                this.formPago = Object.assign({}, this.defaultFormPago);
                this.formPago.fechaPago = this.todaysDateDefault();
            }
        },

    },
    computed:{
        formatoFechaPago: {
            get: function () {
                return this.formatDate(this.formPago.fechaPago)
            },
            set: function (newValue) {
                return this.formatDate(newValue);
            }
        },
    },
}
</script>
