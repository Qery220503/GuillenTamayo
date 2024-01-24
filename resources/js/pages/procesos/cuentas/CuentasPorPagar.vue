<template>
    <div class="d-flex flex-column flex-grow-1">
        <custom-breadcrumbs
            :breadcrumbs_title="breadcrumbs_title"
            :breadcrumbs="breadcrumbs"
        ></custom-breadcrumbs>
        <v-card class="mb-4" light style="padding: 15px">
            <v-row dense class="pa-2 align-center">
                <v-col cols="4">
                    <v-text-field
                        label="Nombre de cliente o número de documento"
                        v-model="filter.searchTerm"
                        append-icon="mdi-magnify"
                        class="flex-grow-1 mr-1"
                        dense
                        outlined
                        hide-details
                    ></v-text-field>
                </v-col>
                <v-col cols="2">
                    <v-menu
                        v-model="menuStartDate"
                        :close-on-content-click="false"
                        :nudge-right="40"
                        transition="scale-transition"
                        offset-y
                        min-width="auto">
                        <template v-slot:activator="{ on, attrs }">
                            <v-text-field
                                label="Fecha de Inicio"
                                v-model="formatStartDate"
                                prepend-inner-icon="mdi-calendar"

                                v-bind="attrs"
                                v-on="on"
                                readonly
                                dense
                                outlined
                                hide-details
                            ></v-text-field>
                        </template>
                        <v-date-picker
                            v-model="filter.fechaInicio"
                            @input="menuStartDate=false"
                            locale="es-ES"
                            no-title
                        ></v-date-picker>
                    </v-menu>
                </v-col>
                <v-col cols="2">
                    <v-menu
                        v-model="menuEndDate"
                        :close-on-content-click="false"
                        :nudge-right="40"
                        transition="scale-transition"
                        offset-y
                        min-width="auto">
                        <template v-slot:activator="{ on, attrs }">
                            <v-text-field
                                label="Fecha de Fin"
                                v-model="formatEndDate"
                                prepend-inner-icon="mdi-calendar"

                                v-bind="attrs"
                                v-on="on"
                                readonly
                                dense
                                outlined
                                hide-details
                            ></v-text-field>
                        </template>
                        <v-date-picker
                            v-model="filter.fechaFin"
                            @input="menuEndDate=false"
                            locale="es-ES"
                            no-title
                        ></v-date-picker>
                    </v-menu>
                </v-col>
                <v-col class="text-right">
                    <v-btn color="primary" class="mr-2" @click="getRegistros">
                        Filtrar <v-icon>mdi-filter</v-icon>
                    </v-btn>
                    <v-btn color="deep-orange" class="mr-2" @click="limpiarFiltros" dark>
                        Limpiar <v-icon>mdi-broom</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
        </v-card>
        <v-card class="mb-4" light style="padding: 15px">
            <v-row v-if="$can('cuentaspagar_update', 'all')" class="pa-2 align-center" dense>
                <v-col class="text-right">
                    <v-btn
                        @click="agregarPagoGrupal()"
                        color="info"
                        class="mr-2"
                        :disabled="selectedDebts.length <= 0">
                        <v-icon>mdi-cash-multiple</v-icon>Pago Grupal
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
                :loading="loadingTable" loading-text="Cargando... Por favor, espere">
                <template slot="no-data">
                    Aún no se han agregado registros.
                </template>
                <template v-slot:[`item.select`]="{ item }">
                    <v-checkbox
                        v-model="selectedDebts"
                        :disabled="item.deuda_saldo <= 0"
                        :value="item.id_compra"
                    ></v-checkbox>
                </template>
                <template #[`item.index`]="{ item }">
                    {{ dataReg.data.indexOf(item) + 1 }}
                </template>
                <template v-slot:[`item.fecha_vencimiento`]="{ item }">
                    <div v-if="(item.deuda_saldo > 0) && compareDates(item.fecha_vencimiento) < 0" class="font-weight-bold error--text">
                        {{ item.fecha_vencimiento | formatDateGeneral}}
                    </div>
                    <div v-else-if="(item.deuda_saldo > 0) && compareDates(item.fecha_vencimiento, 15) > 0" class="font-weight-bold amber--text">
                        {{ item.fecha_vencimiento | formatDateGeneral}}
                    </div>
                    <div v-else>
                        {{ item.fecha_vencimiento | formatDateGeneral}}
                    </div>
                </template>
                <template v-slot:[`item.add_payment`]="{ item }">
                    <v-btn v-if="$can('cuentaspagar_update', 'all') && item.deuda_saldo > 0"
                        @click="agregarPago(item)"
                        color="primary"
                        small>
                        <v-icon>mdi-plus</v-icon>Agregar Pago
                    </v-btn>
                    <v-chip small v-else-if="item.deuda_saldo > 0" class="ma-2" color="error">Deuda Pendiente</v-chip>
                    <v-chip small v-else class="ma-2" color="success">Deuda Saldada</v-chip>
                </template>
                <template v-slot:[`item.detail_payment`]="{ item }">
                    <v-btn small color="deep-orange" @click="verDetalleDeuda(item)" dark>
                        <v-icon>mdi-magnify</v-icon>Ver Detalle
                    </v-btn>
                </template>
            </v-data-table>
            <div class="text-center pt-2">
                <v-pagination
                    v-model="currentPage"
                    :length="pageCount"
                    :disabled="totalReg<=0"
                    circle
                ></v-pagination>
            </div>
        </v-card>

        <PagoIndividualModal :cuentaRoute="'cuentas-pagar'" :getRegistros="getRegistros"/>
        <PagoGrupalModal :cuentaRoute="'cuentas-pagar'"/>
        <PagoDetailModal :cuentaRoute="'cuentas-pagar'"/>
    </div>
</template>

<script>
export default {
    data() {
        return {
            breadcrumbs_title: "Cuentas por Pagar",
            breadcrumbs: [
                { text: "Inicio", disabled: false, href: "/dashboard" },
                { text: "Procesos", disabled: false, href: "#" },
                { text: "Cuentas por Pagar" }
            ],
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
                {text: 'Fecha V.', value: 'fecha_vencimiento', sortable: false},
                {text: 'Guía/Factura', value: 'guia_factura', sortable: false},
                {text: 'Proveedor', value: 'proveedor.nombre', sortable: false},
                {text: 'Monto Deuda Pendiente', value: 'deuda_saldo', sortable: false, align: "center"},
                {text: 'Agregar Pago', value: 'add_payment', sortable: false, align: "center"},
                {text: 'Detalle', value: 'detail_payment', sortable: false, align: "center"},
            ],
            menuStartDate: false,
            menuEndDate: false,
            filter: {
                searchTerm: "",
                fechaInicio: "",
                fechaFin: "",
            },
            selectedDebts: [],
            //--- End ---
        }
    },
    mounted(){
        //
    },
    methods: {
        //--- Datatable ---
        async getRegistros(page = 1, perPage = 25, sortDesc = 0, sortBy = ""){
            this.loadingTable = true;
            this.dataReg = [];
            this.selectedDebts = [];
            const myParams = new URLSearchParams(this.filter).toString();
            try {
                const response = await API.cuentas_pagar.list("?page="+page +"&perPage="+perPage
                    +"&sortDesc="+sortDesc
                    +"&sortBy="+sortBy
                    +"&"+myParams
                );
                this.dataReg     = response.data;
                this.currentPage = this.dataReg.current_page;
                this.pageCount    = this.dataReg.last_page;
                this.totalReg    = this.dataReg.total;

            } catch(e){
                console.error(e);

            } finally{
                this.loadingTable = false;
            }
        },
        limpiarFiltros(){
            this.filter = {};
            this.getRegistros();
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

    computed: {
        formatStartDate: {
            get: function () {
                return this.formatDate(this.filter.fechaInicio)
            },
            set: function (newValue) {
                return this.formatDate(newValue);
            }
        },
        formatEndDate: {
            get: function () {
                return this.formatDate(this.filter.fechaFin)
            },
            set: function (newValue) {
                return this.formatDate(newValue);
            }
        },
    },
    watch: {
        dataTabOptions(event) {
            this.itemsPerPage = event.itemsPerPage;
            this.getRegistros(event.page, event.itemsPerPage);
        },
    },
}
</script>
