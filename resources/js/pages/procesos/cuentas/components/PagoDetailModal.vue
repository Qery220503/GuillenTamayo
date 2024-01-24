<template>
    <!-- Ver Detalle Deuda -->
    <v-dialog v-model="paymentDetailDialog" max-width="60%">
        <v-card>
            <v-card-title>
                <span class="headline">Detalle Pagos</span>
            </v-card-title>
            <v-divider></v-divider>
            <br>
            <v-card-text>
                <v-row>
                    <v-col>
                        <h4>Compra: {{formDetail.serie.serie + "-" + formDetail.correlativo}}</h4>
                        <h4>Guía/Factura: #{{formDetail.guia_factura}}</h4>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12" sm="4" md="4">
                        <v-text-field label="Total Deuda" v-model="formDetail.total" readonly></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="4" md="4">
                        <v-text-field label="Total Abonado" v-model="formDetail.deuda_total_abonado" readonly></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="4" md="4">
                        <v-text-field label="Saldo Pendiente" v-model="formDetail.deuda_saldo" readonly></v-text-field>
                    </v-col>
                </v-row>
                <v-simple-table>
                    <tbody>
                        <tr>
                            <th>Fecha</th>
                            <th>Usuario</th>
                            <th>Monto Abonado</th>
                            <th>Origen</th>
                            <th>Banco</th>
                            <th>Nro. Operación/Voucher</th>
                            <th>Descripción</th>
                        </tr>
                        <tr v-if="deudaPagos.length<= 0">
                            <td colspan="7" class="text-center"><b>Aún no se han agregado pagos a esta deuda</b></td>
                        </tr>
                        <tr v-for="(item, i) in deudaPagos" :key="i">
                            <td>{{item.fecha | formatDateGeneral}}</td>
                            <td>{{item.usuario.name}}</td>
                            <td>{{item.monto_abonado}}</td>
                            <td>{{item.origen_dinero.nombre_origen}}</td>
                            <td>{{item.banco}}</td>
                            <td>{{item.nro_operacion}}</td>
                            <td>{{item.descripcion}}</td>
                        </tr>
                    </tbody>
                </v-simple-table>
            </v-card-text>
        </v-card>
    </v-dialog>
    <!-- Fin -->
</template>

<script>
export default {
    props:{
        cuentaRoute: String,
    },
    data(){
        return{
            paymentDetailDialog: false,
            formDetail: {
                serie:{}
            },
            deudaPagos: [],
        }
    },
    mounted() {
        this.$root.$on("cuentas_pago_detalle", data => {
            this.formDetail = Object.assign({}, data);
            this.getDetallePagos(data);
        });
    },
    methods:{
        getDetallePagos(item){
            axios.get('/api/'+this.cuentaRoute+'/'+item.id_compra).then(response => {
                this.deudaPagos = response.data.pagos_deuda;
                this.paymentDetailDialog = true;

            }).catch(e => {
                console.error(e);
                UTILS.toastr.error("Ups! Ocurrió un error", this);
            });
        }
    }, 
    watch:{
        paymentDialog(){
            if(!this.paymentDetailDialog){
                this.deudaPagos = [];
            }
        },
    }
}
</script>