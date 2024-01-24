<template>
    <div class="d-flex flex-column flex-grow-1">
        <custom-breadcrumbs
            :breadcrumbs_title="proveedor.nombre"
            :breadcrumbs="breadcrumbs"
        ></custom-breadcrumbs>
        <v-card class="mb-4" light style="padding: 15px">
            <v-row class="pa-2 align-center" dense>
                <v-col class="text-right">
                    <v-btn v-if="$can('cuentaspagar_update', 'all')"
                        @click="agregarPagoGrupal()"
                        color="info"
                        class="mr-2"
                        :disabled="selectedDebts.length <= 0">
                        <v-icon>mdi-cash-multiple</v-icon>Pago Grupal
                    </v-btn>
                    <v-btn color="#1D6F42" class="mr-2" dark :href="urlToReturn">
                        Exportar<v-icon>mdi-file-excel</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
            <v-data-table
                :headers="headers"
                :items="dataReg.data"
                :page="currentPage"
                :items-per-page="itemsPerPage"
                :server-items-length="totalReg"
                :options.sync="dataTabOptions"
                class="elevation-1"
                :footer-props="{
                    itemsPerPageOptions: [25,50,100,250,500],
                    'items-per-page-text':'Registros por página',
                }"
                :loading="loadingTable" loading-text="Cargando... Por favor, espere"
                @click:row="handleDataRowClick">
                <template v-slot:[`item.select`]="{ item }">
                    <v-checkbox
                        v-model="selectedDebts"
                        :disabled="item.deuda_saldo <= 0"
                        :value="item.id_compra"
                        @click.stop.prevent
                    ></v-checkbox>
                </template>
                <template #[`item.index`]="{ item }">
                    {{ dataReg.data.indexOf(item) + 1 }}
                </template>
                <template v-slot:[`item.total`]="{ item }">
                    s/. {{ item.total }}
                </template>
                <template v-slot:[`item.deuda_saldo`]="{ item }">
                    <div class="font-weight-bold error--text">
                        s/. {{ item.deuda_saldo }}
                    </div>
                </template>
                <template v-slot:[`item.deuda_total_abonado`]="{ item }">
                    <div class="font-weight-bold success--text">
                        s/. {{ item.deuda_total_abonado }}
                    </div>
                </template>
                <template v-slot:[`item.fecha_vencimiento`]="{ item }">
                    <div v-if="(item.deuda_saldo > 0 && item.estado==1) && compareDates(item.fecha_vencimiento) < 0" class="font-weight-bold error--text">
                        {{ item.fecha_vencimiento | formatDateGeneral}}
                    </div>
                    <div v-else-if="(item.deuda_saldo > 0 && item.estado==1) && compareDates(item.fecha_vencimiento, 15) > 0" class="font-weight-bold amber--text">
                        {{ item.fecha_vencimiento | formatDateGeneral}}
                    </div>
                    <div v-else>
                        {{ item.fecha_vencimiento | formatDateGeneral}}
                    </div>
                </template>
                <template v-slot:[`item.estado_deuda`]="{ item }">
                    <v-chip
                        v-if="item.deuda_saldo > 0 && item.estado == 1"
                        class="ma-2"
                        color="error"
                        small>
                        Con deuda
                    </v-chip>
                    <v-chip
                        v-if="item.deuda_saldo == 0 && item.estado == 1"
                        class="ma-2"
                        color="success"
                        small>
                        Deuda pagada
                    </v-chip>
                    <v-chip
                        v-if="item.estado == 0"
                        class="ma-2"
                        color="warning"
                        small>
                        Deuda Anulada
                    </v-chip>
                </template>
                <template v-slot:[`item.add_payment`]="{ item }">
                    <v-btn v-if="$can('cuentaspagar_update', 'all') && item.deuda_saldo > 0"
                        @click.stop="agregarPago(item)"
                        color="primary"
                        small>
                        <v-icon>mdi-plus</v-icon>Agregar Pago
                    </v-btn>
                    <v-chip small v-else-if="item.deuda_saldo > 0" class="ma-2" color="error">Deuda Pendiente</v-chip>
                    <v-chip small v-else class="ma-2" color="success">Deuda Saldada</v-chip>
                </template>
                <template v-slot:[`item.detail_payment`]="{ item }">
                    <v-btn small color="deep-orange" @click.stop="verDetalleDeuda(item)" dark>
                        <v-icon>mdi-magnify</v-icon>Ver Detalle
                    </v-btn>
                </template>
            </v-data-table>
        </v-card>

        <PagoIndividualModal :cuentaRoute="'cuentas-pagar'" :getRegistros="getRegistros"/>
        <PagoGrupalModal :cuentaRoute="'cuentas-pagar'"/>
        <PagoDetailModal :cuentaRoute="'cuentas-pagar'"/>

        <!-- View Dialog -->
        <v-dialog v-model="viewDialog" max-width="50%">
            <v-card>
                <v-card-title>
                <span class="headline">Visualizar Registro</span>
                </v-card-title>
                <v-card-text>
                    <v-form ref="viewForm">
                        <v-row>
                            <v-col cols="12" sm="12" md="12">
                                <v-text-field
                                    v-model="viewForm.fecha_vencimiento"
                                    label="Fecha Vencimiento"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.nro_documento"
                                    label="Nro. Documento"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.total"
                                    label="Total Deuda"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.deuda_saldo"
                                    label="Saldo Pendiente"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.deuda_total_abonado"
                                    label="Total Abonado"
                                    readonly
                                ></v-text-field>
                            </v-col>
                        </v-row>
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
            breadcrumbs_title: "Cuenta Corriente Proveedor",
            breadcrumbs: [
                { text: "Inicio", disabled: false, href: "/dashboard" },
                { text: "Proveedores", disabled: false, href: "/proveedores" },
                { text: "Cuenta Corriente" }
            ],

            idProveedor: null,
            proveedor:{},
            //--- Datatable ---
            loadingTable: false,
            currentPage: 1,
            pageCount: 1,
            itemsPerPage: 25,
            totalReg: 0,
            dataTabOptions: {},
            dataReg: {},
            headers: [
                {text: '', value: 'select'},
                {text: 'Nº', value: 'index',  sortable: false},
                {text: "Fecha V.", value: "fecha_vencimiento", sortable: false},
                {text: "Nro. Documento", value: "nro_documento", sortable: false},
                {text: "Total Deuda", value: "total", sortable: false},
                {text: "Saldo Pendiente", value: "deuda_saldo", sortable: false},
                {text: "Total Abonado", value: "deuda_total_abonado", sortable: false},
                {text: 'Agregar Pago', value: 'add_payment', sortable: false, align: "center"},
                {text: 'Detalle', value: 'detail_payment', sortable: false, align: "center"},
            ],
            urlToReturn: '',
            selectedDebts: [],
            //--- End ---


            viewDialog: false,
            viewForm: {
            },
        };
    },
    created() {
        this.idProveedor = this.$route.params.proveedor_id;
        this.getProveedor();
    },
    methods: {
        //--- Datatable ---
        async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
            this.loadingTable = true;
            this.dataReg = [];
            this.selectedDebts = [];
            const myParams = new URLSearchParams(this.filter).toString();
            try {
                const response = await API.proveedores.cuenta_corriente(this.idProveedor);
                this.dataReg = response.data;
                this.currentPage = response.data.current_page;
                this.totalReg = this.dataReg.total;
                this.loadingTable = false;
                this.getExportData();

            } catch (e) {
                this.loadingTable = false;
                console.error(e);
            }
        },
        limpiarFiltros(){
            this.filter = {};
            this.getRegistros();
        },
        getExportData(){
            this.urlToReturn = '/api/exportProveedorCuenta/?idProveedor='+this.idProveedor;
        },

        handleDataRowClick(row){
            this.viewForm = Object.assign({}, row);
            this.viewDialog = true;
        },
        //--- End ---

        agregarPago(item){
            this.$root.$emit("cuentas_agregar_pago", item);
        },
        agregarPagoGrupal(){
            let data = this.dataReg.data.filter(item => {
                return this.selectedDebts.includes(item.id_compra);
            });
            this.$root.$emit("cuentas_pago_grupal", data);
        },
        verDetalleDeuda(item){
            this.$root.$emit("cuentas_pago_detalle", item);
        },

        //--- Additional Functions ---
        async getProveedor() {
            const response = await API.proveedores.show(this.idProveedor);
            this.proveedor = response.data;
        },
        compareDates(date, range=0){
            var today = new Date(this.todaysDateDefault());
            date = new Date(date);
            if(today >= date){ // Fecha Venc. es hoy o ya pasó
                return -1
            }

            today.setDate(today.getDate()+range);
            if(today >= date){ // Fecha Venc. se encuentra en los próximos "range" días
                return 1;
            }

            return 0; // Fecha Venc. es lejana
        },
        //--- End ---
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
        viewDialog() {
            if (!this.viewDialog) {
                this.$refs.viewForm.reset();
            }
        },
    },
};
</script>
