<template>
    <div class="d-flex flex-column flex-grow-1">
        <custom-breadcrumbs :breadcrumbs_title="breadcrumbs_title" :breadcrumbs="breadcrumbs"></custom-breadcrumbs>
        <v-card class="mb-4">
            <v-row dense class="pa-2 align-center">
                <v-col cols="4">
                    <v-text-field label="Nombre de proveedor o nro. de documento" v-model="filter.searchTerm"
                        append-icon="mdi-magnify" class="flex-grow-1 mr-1" hide-details dense outlined></v-text-field>
                </v-col>
                <v-col cols="2">
                    <v-menu v-model="menuFechaInicio" :close-on-content-click="false" :nudge-right="40" transition="scale-transition"
                        offset-y min-width="auto">
                        <template v-slot:activator="{ on, attrs }">
                            <v-text-field v-model="dateFormatted" @blur="filter.fechaInicio = parseDate(dateFormatted)"
                                label="Fecha Inicio" prepend-inner-icon="mdi-calendar" readonly hide-details dense outlined
                                v-bind="attrs" v-on="on"></v-text-field>
                        </template>
                        <v-date-picker v-model="filter.fechaInicio" @input="menuFechaInicio = false" no-title></v-date-picker>
                    </v-menu>
                </v-col>
                <v-col cols="2">
                    <v-menu v-model="menuFechaFin" :close-on-content-click="false" :nudge-right="40" transition="scale-transition"
                        offset-y min-width="auto">
                        <template v-slot:activator="{ on, attrs }">
                            <v-text-field @blur="filter.fechaFin = parseDate(dateFormattedEnd)" v-model="dateFormattedEnd"
                                label="Fecha Fin" prepend-inner-icon="mdi-calendar" readonly hide-details dense outlined
                                v-bind="attrs" v-on="on"></v-text-field>
                        </template>
                        <v-date-picker v-model="filter.fechaFin" @input="menuFechaFin = false" no-title></v-date-picker>
                    </v-menu>
                </v-col>
                <v-col cols="2">
                    <v-select label="Condición Pago" v-model="filter.condicionPago"
                        :items="filter_condicion"
                        hide-details
                        dense
                        outlined
                    ></v-select>
                </v-col>
                <v-col cols="2">
                    <v-select v-model="filter.saldoPendiente" label="Saldo"
                        :items="filter_saldo"
                        hide-details
                        dense
                        outlined
                    ></v-select>
                </v-col>
                <v-col cols="2">
                    <v-select v-model="filter.estado" label="Estado"
                        :items="filter_estado"
                        hide-details
                        dense
                        outlined
                    ></v-select>
                </v-col>
                <v-col class="text-right">
                    <v-btn color="primary" class="mr-2" @click="getRegistros()">
                        Filtrar <v-icon>mdi-filter</v-icon>
                    </v-btn>
                    <v-btn color="deep-orange" class="mr-2" @click="limpiarFiltros()" dark>
                        Limpiar <v-icon>mdi-broom</v-icon>
                    </v-btn>
                    <v-btn color="#1D6F42" class="mr-2" :href="urlToReturn" dark>
                        Exportar<v-icon>mdi-file-excel</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
        </v-card>

        <v-card>
            <v-row dense class="pa-2 align-center">
                <v-spacer></v-spacer>
                <v-col class="text-right">
                    <v-btn
                        @click="agregarPagoGrupal()"
                        color="info"
                        class="mr-2"
                        :disabled="selectedCompras.length <= 0">
                        <v-icon>mdi-cash-multiple</v-icon>Pago Grupal
                    </v-btn>
                    <v-btn color="primary" to="/compras/crear" link>
                        <v-icon>mdi-plus</v-icon>Añadir Compras
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
                    itemsPerPageOptions: [15, 25,50,100,250,500],
                    'items-per-page-text':'Registros por página',
                }"
                :loading="loadingTable" loading-text="Cargando... Por favor, espere">
                <template v-slot:[`item.select`]="{ item }">
                    <v-checkbox
                        v-model="selectedCompras"
                        :disabled="(item.deuda_saldo <= 0) || (item.condicion_pago == 1) || (item.estado == 0)"
                        :value="item.id_compra"
                    ></v-checkbox>
                </template>
                <template #[`item.index`]="{ item }">
                    {{ dataReg.data.indexOf(item) + 1 }}
                </template>
                <template v-slot:[`item.compra`]="{ item }">
                    <span>{{ item.serie.serie + "-" + item.correlativo }}</span>
                </template>
                <template v-slot:[`item.actions`]="{ item }">
                    <div class="one-line">
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-btn small icon v-bind="attrs" v-on="on" :href="'/compraPDF/' + item.id_compra"
                                    target="_blank">
                                    <v-icon small>mdi-file-pdf</v-icon>
                                </v-btn>
                            </template>
                            <span>Ver PDF</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-btn v-if="$can('cuentaspagar_update', 'all')"
                                    @click="agregarPago(item)"
                                    :disabled="(item.deuda_saldo <= 0)||
                                        (item.condicion_pago == 1)||
                                        (item.estado == 0)"
                                    v-bind="attrs"
                                    v-on="on"
                                    icon
                                    small
                                    link>
                                    <v-icon small>mdi-cash</v-icon>
                                </v-btn>
                            </template>
                            <span>Agregar pago</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-btn small icon :to="'/compras/ver/' + item.id_compra" v-bind="attrs" v-on="on">
                                    <v-icon small>mdi-eye-outline</v-icon>
                                </v-btn>
                            </template>
                            <span>Ver Compra</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on, attrs }">
                                <v-btn v-if="item.estado == 1" small icon @click="deleteReg(item)" v-bind="attrs"
                                    v-on="on">
                                    <v-icon small>mdi-delete</v-icon>
                                </v-btn>
                            </template>
                            <span>Anular Compra</span>
                        </v-tooltip>
                    </div>
                </template>
                <template v-slot:[`item.correlativo`]="{ item }">
                    <div class="one-line">
                        {{ item.correlativo }}
                    </div>
                </template>
                <template v-slot:[`item.nombre_proveedor`]="{ item }">
                    <div class="one-line">
                        {{ item.nombre_proveedor }}
                    </div>
                </template>
                <template v-slot:[`item.fecha`]="{ item }">
                    <div class="one-line">
                        {{ item.fecha | formatDateGeneral }}
                    </div>
                </template>
                <template v-slot:[`item.total`]="{ item }">
                    S/ {{ item.total }}
                </template>
                <template v-slot:[`item.deuda_total_abonado`]="{ item }">
                    S/ {{ item.deuda_total_abonado }}
                </template>
                <template v-slot:[`item.deuda_saldo`]="{ item }">
                    S/ {{ item.deuda_saldo }}
                </template>
                <template v-slot:[`item.estado`]="{ item }">
                    <v-chip v-if="item.estado == 1" class="ma-2" color="primary" small>
                        Aprobada
                    </v-chip>
                    <v-chip v-if="item.estado == 0" class="ma-2" color="error" small>
                        Anulada
                    </v-chip>
                </template>
                <template v-slot:[`item.estado_deuda`]="{ item }">
                    <v-chip v-if="item.condicion_pago == 1" class="ma-2" color="gray" small>
                        Al contado
                    </v-chip>
                    <template v-else>
                        <v-chip v-if="item.deuda_saldo > 0 && item.estado == 1" class="ma-2" color="error" small>
                            Con deuda
                        </v-chip>
                        <v-chip v-if="item.deuda_saldo == 0 && item.estado == 1" class="ma-2" color="success" small>
                            Deuda pagada
                        </v-chip>
                        <v-chip v-if="item.estado == 0" class="ma-2" color="warning" small>
                            Deuda anulada
                        </v-chip>
                    </template>
                </template>
            </v-data-table>
        </v-card>

        <!-- Delete Dialog -->
        <v-dialog v-model="deleteDialog" max-width="400">
            <v-card>
                <v-card-title class="d-flex justify-center">
                    <span class="headline">¿Estás seguro que deseas anular este registro?</span>
                </v-card-title>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" @click="deleteRegConfirm">Aceptar</v-btn>
                    <v-btn color="error" text @click="deleteDialog = false">Cancelar</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <!-- Fin -->

        <PagoIndividualModal :cuentaRoute="'cuentas-pagar'" :getRegistros="getRegistros"/>
        <PagoGrupalModal :cuentaRoute="'cuentas-pagar'"/>
    </div>
</template>
<script>
import API from "../../../api";

export default {
    data: vm => ({
        breadcrumbs_title: "Compras",
        breadcrumbs: [
            { text: "Inicio", disabled: false, href: "#" },
            { text: "Procesos", disabled: false, href: "#" },
            { text: "Compras" }
        ],
        //--- Datatable ---
        loadingTable: false,
        currentPage: 1,
        itemsPerPage: 15,
        totalReg: 0,
        dataTabOptions: {},
        dataReg: [],
        headers: [
            { text: "", sortable: false, value: "select" },
            {text: 'Nº', value: 'index',  sortable: false},
            { text: "Compra", sortable: false, value: "compra" },
            { text: "Comprobante", sortable: false, value: "guia_factura" },
            { text: "Proveedor", sortable: false, value: "nombre_proveedor" },
            { text: "Monto Total", sortable: false, value: "total" },
            { text: "Monto Cancelado", sortable: false, value: "deuda_total_abonado" },
            { text: "Monto Saldo", sortable: false, value: "deuda_saldo" },
            { text: "Fecha", sortable: false, value: "fecha" },
            { text: "Estado", sortable: false, value: "estado", align: "center"},
            { text: "Estado Deuda", sortable: false, value: "estado_deuda", align: "center"},
            { text: "Acciones", value: "actions", align: "center", sortable: false, align: "right" }
        ],
        urlToReturn: '',
        filter: {
            searchTerm: "",
            fechaInicio: "",
            fechaFin: "",
            condicionPago: "",
            saldoPendiente: "",
            estado: "",
        },
        filter_condicion: [
            { text: "Al Contado", value: 1 },
            { text: "Al Crédito", value: 2 },
            { text: "Al Crédito con Cuotas", value: 3 },
        ],
        filter_saldo: [
            { text: "Saldo Pendiente", value: 1 },
            { text: "Sin Saldo", value: 0 }
        ],
        filter_estado: [
            { text: "Aprobado", value: 1 },
            { text: "Anulado", value: 0 }
        ],
        menuFechaInicio: false,
        menuFechaFin: false,
        selectedCompras: [],

        addForm: {
            id_cliente: null,
            nombre_categoria: null
        },
        deleteDialog: false,
        dateFormatted: vm.formatDate(null),
        dateFormattedEnd: vm.formatDate(null)
    }),
    created() {
        if (this.$route.query.id_proveedor) {
            this.breadcrumbs_title = "Compras Proveedor #"+this.$route.query.id_proveedor
            this.filter.id_proveedor = this.$route.query.id_proveedor;
        }
    },
    mounted() {
        //
    },
    methods: {
        async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
            this.loadingTable = true;
            this.dataReg = [];
            this.selectedCompras = [];
            const myParams = new URLSearchParams(this.filter).toString();

            try {
                const response = await API.compras.list("?page=" + page + "&itemsPerPage=" + per_page
                    + "&sortDesc=" + sortDesc
                    + "&sortBy=" + sortBy
                    +"&"+myParams
                );
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
        limpiarFiltros() {
            this.filter = {
              searchTerm: "",
              fechaInicio: "",
              fechaFin: "",
              condicionPago: "",
              saldoPendiente: "",
              estado: "",
            };
            this.getRegistros();

            this.breadcrumbs_title = "Compras";
        },
        getExportData(){
            this.urlToReturn = '/api/exportCompras/?'+ new URLSearchParams(this.filter).toString();
        },
        deleteReg(item) {
            this.addForm = Object.assign({}, item);
            this.deleteDialog = true;
        },
        async deleteRegConfirm() {
            this.loadingTable = true;
            this.$store.commit("loader", true);
            try {
                const response = await API.compras.remove(this.addForm.id_compra);
                UTILS.toastr.success("Compra anulada correctamente", this);
                this.deleteDialog = false;
                this.getRegistros();

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);

            } finally {
                this.$store.commit("loader", false);
                this.loadingTable = false;
            }
        },
        //--- Debts Functions ---
        agregarPago(item){
            this.$root.$emit("cuentas_agregar_pago", item);
        },
        agregarPagoGrupal(){
            let data = this.dataReg.data.filter(item => {
                return this.selectedCompras.includes(item.id_compra);
            });
            this.$root.$emit("cuentas_pago_grupal", data);
        },
        //--- End ---

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
    },
    watch: {
        dataTabOptions(event) {
            this.itemsPerPage = event.itemsPerPage;
            this.getRegistros(
                event.page,
                event.itemsPerPage,
                event.sortDesc,
                event.sortBy[0]
            );
        },
        "filter.fechaInicio"(val) {
            this.dateFormatted = this.formatDate(this.filter.fechaInicio);
        },
        "filter.fechaFin"(val) {
            this.dateFormattedEnd = this.formatDate(this.filter.fechaFin);
        }
    },
};
</script>
