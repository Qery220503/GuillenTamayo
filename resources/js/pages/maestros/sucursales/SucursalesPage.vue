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
                        v-model="filter.searchTerm"
                        append-icon="mdi-magnify"
                        class="flex-grow-1 mr-1"
                        single-line
                        hide-details
                        placeholder="Buscar por nombre …"
                        @keyup.enter.prevent="getRegistros()"
                    ></v-text-field>
                </v-col>
                <v-col>
                    <v-btn class="mr-2" color="deep-orange" dark @click="limpiarFiltros">
                        <v-icon>mdi-broom</v-icon> Limpiar Filtros
                    </v-btn>
                </v-col>
                <v-col class="text-right">
                    <v-btn small color="primary" class="mr-2" @click="addDialog=true">
                        Añadir Sucursal<v-icon>mdi-plus</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
            <br />
            <v-data-table
                :headers="headers"
                :items="itemsData.data"
                class="elevation-1"
                :server-items-length="itemsData.total"
                :page="page"
                :options.sync="options"
                :items-per-page="itemsperpage"
                :footer-props="{ itemsPerPageOptions: [25, 50, 100, 1000] }"
                :loading="loading"
                loading-text="Cargando... Por favor, espere"
                @click:row="handleDataRowClick">
                <template v-slot:[`item.actions`]="{ item }">
                    <v-btn small icon @click.stop="editSucursal(item)">
                        <v-icon small> mdi-pencil</v-icon>
                    </v-btn>
                    <v-btn small icon @click.stop="deleteSucursal(item)">
                        <v-icon small> mdi-delete</v-icon>
                    </v-btn>
                    <v-btn small icon @click.stop="loadSeries(item.id_sucursal)">
                        <v-icon small>mdi-counter</v-icon>
                    </v-btn>
                </template>
            </v-data-table>
        </v-card>
        <!-- Add/Edit Dialog -->
        <v-dialog v-model="addDialog" max-width="60%" persistent>
            <v-card>
                <v-card-title>
                    <span class="headline" v-show="!dialogEditar">Agregar Sucursal</span>
                    <span class="headline" v-show="dialogEditar">Editar Sucursal</span>
                </v-card-title>
                <v-card-text>
                    <v-form v-model="valid" ref="addForm">
                        <v-row>
                            <v-col cols="12" sm="6" md="6">
                                <v-text-field
                                    v-model="addForm.nro_ruc"
                                    label="RUC Sucursal"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.nombre_sucursal"
                                    label="Nombre Sucursal"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.departamento"
                                    label="Departamento"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.provincia"
                                    label="Provincia"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.distrito"
                                    label="Distrito"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.telefono"
                                    label="Teléfono"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.email"
                                    label="Correo Electrónico"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.url_api"
                                    label="URL Facturación"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.url_logo"
                                    label="Logo URL"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                                <v-text-field
                                    v-model="addForm.razon_social"
                                    label="Razon Social"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.codigo_sucursal"
                                    label="Código Sucursal"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.cod_domicilio_fiscal"
                                    label="Código domicilio fiscal"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.direccion_fiscal"
                                    label="Dirección fiscal"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.direccion_comercial"
                                    label="Dirección Comercial"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.direccion_web"
                                    label="Dirección WEB"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.nro_cuenta_bancario"
                                    label="Nro. Cuenta Bancaria"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.cci_bancario"
                                    label="CCI Bancario"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                                <v-text-field
                                    v-model="addForm.token_api"
                                    label="Token Facturación"
                                    :rules="requiredRules"
                                    autocomplete="off"
                                    filled
                                ></v-text-field>
                            </v-col>
                        </v-row>
                        <v-card-actions>
c
                            <v-btn color="error" dark @click="addDialog=false">Cancelar</v-btn>
                            <v-btn color="primary" @click="saveReg()">Guardar</v-btn>
                        </v-card-actions>
                    </v-form>
                </v-card-text>
            </v-card>
        </v-dialog>
        <!-- Fin -->
        <!-- View Dialog -->
        <v-dialog v-model="viewDialog" max-width="60%">
            <v-card>
                <v-card-title>
                    <span class="headline">Visualizar Registro</span>
                </v-card-title>
                <v-card-text>
                    <v-form ref="viewForm">
                        <v-row>
                            <v-col cols="12" sm="6" md="6">
                                <v-text-field
                                    v-model="viewForm.nombre_sucursal"
                                    label="Nombre Sucursal"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.nro_ruc"
                                    label="RUC Sucursal"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.departamento"
                                    label="Departamento"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.provincia"
                                    label="Provincia"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.distrito"
                                    label="Distrito"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.telefono"
                                    label="Teléfono"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.email"
                                    label="Correo Electrónico"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.url_api"
                                    label="URL Facturación"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.url_logo"
                                    label="Logo URL"
                                    readonly
                                ></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                                <v-text-field
                                    v-model="viewForm.razon_social"
                                    label="Razón Social"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.codigo_sucursal"
                                    label="Código Sucursal"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.cod_domicilio_fiscal"
                                    label="Código Domicilio Fiscal"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.direccion_fiscal"
                                    label="Dirección fiscal"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.direccion_comercial"
                                    label="Dirección Comercial"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.direccion_web"
                                    label="Dirección WEBl"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.nro_cuenta_bancario"
                                    label="Nro. Cuenta Bancaria"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.cci_bancario"
                                    label="CCI Bancario"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.token_api"
                                    label="Token Facturación"
                                    readonly
                                ></v-text-field>
                            </v-col>
                        </v-row>
                    </v-form>
                </v-card-text>
            </v-card>
        </v-dialog>
        <!-- Fin -->
        <!-- Delete Dialog -->
        <v-dialog v-model="deleteDialog" max-width="60%">
            <v-card>
                <v-card-title class="d-flex justify-center">
                    <span class="headline">¿Estás seguro que deseas borrar este registro?</span>
                </v-card-title>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" @click="deleteSucursalConfirm">Aceptar</v-btn>
                    <v-btn color="blue darken-1" text @click="deleteDialog=false">Cancelar</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <!-- Fin -->

        <!-- Series Dialog -->
        <v-dialog v-model="dialogSeries" max-width="50%">
            <v-card>
                <v-form @submit.prevent="saveSerie()" ref="formSerie" v-model="validSerie">
                    <v-simple-table>
                        <template v-slot:default>
                            <thead>
                                <tr>
                                    <th class="text-left">Tipo de Documento</th>
                                    <th class="text-left">Número</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="serie in series" :key="serie.id_serie">
                                    <td>{{ serie.documento.nombre_tipo_documento }}</td>
                                    <td>{{ serie.serie }}</td>
                                    <td>
                                        <v-btn color="secondary" small @click="deleteSerie(serie)">Eliminar</v-btn>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <v-select
                                            :items="documentos"
                                            item-text="nombre_tipo_documento"
                                            item-value="id_tipo_comprobantes"
                                            label="Tipo de documento"
                                            v-model="serie.id_serie_documento"
                                            :rules="rules.required"
                                        ></v-select>
                                    </td>
                                    <td>
                                        <v-text-field
                                            name="serie"
                                            label="Numero"
                                            v-model="serie.serie"
                                            :rules="rules.serie"
                                            autocomplete="off"
                                        ></v-text-field>
                                    </td>
                                    <td>
                                        <v-btn color="primary" small type="submit">Crear</v-btn>
                                    </td>
                                </tr>
                            </tbody>
                        </template>
                    </v-simple-table>
                </v-form>
            </v-card>
        </v-dialog>
        <!-- Fin -->
    </div>
</template>
<script>
export default {
    data: () => ({
        breadcrumbs_title: "Sucursales",
        breadcrumbs: [
            { text: "Inicio", disabled: false, href: "/dashboard" },
            { text: "Maestros", disabled: false, href: "#" },
            { text: "Sucursales" }
        ],
        //--- Datatable ---
        page: 1,
        itemsperpage: 25,
        options: {},
        loading: false,
        headers: [
            { text: "Nombre", value: "nombre_sucursal", sortable: false },
            { text: "Código Sucursal", value: "codigo_sucursal", sortable: false },
            { text: "RUC", value: "nro_ruc", sortable: false },
            { text: "Razón Social", value: "razon_social", sortable: false },
            { text: "Distrito", value: "distrito", sortable: false },
            { text: "Correo Electrónico", value: "email", sortable: false },
            { text: "Acciones", value: "actions", align: "center", sortable: false }
        ],
        viewDialog: false,
        viewForm: {
        },

        filter: {
            searchTerm: ""
        },
        itemsData: {
            data: [],
            total: 0
        },
        searchQuery: "",
        searchData: {},
        valid: true,
        validSerie: true,
        addDialog: false,
        dialogEditar: false,
        dialogDelete: false,
        dialogSeries: false,
        serie: {
            serie: "",
            id_serie_documento: "",
            id_sucursal: ""
        },
        addForm: {
            id_sucursal: "",
            nombre_sucursal: "",
            cod_domicilio_fiscal: "",
            direccion_fiscal: "",
            departamento: "",
            provincia: "",
            distrito: "",
            telefono: "",
            direccion_comercial: "",
            email: "",
            direccion_web: "",
            nro_cuenta_bancario: "",
            cci_bancario: "",
            impresion_automatica: 1
        },
        defaultAddForm: {
            id_sucursal: "",
            nombre_sucursal: "",
            cod_domicilio_fiscal: "",
            direccion_fiscal: "",
            departamento: "",
            provincia: "",
            distrito: "",
            telefono: "",
            direccion_comercial: "",
            email: "",
            direccion_web: "",
            nro_cuenta_bancario: "",
            cci_bancario: "",
            impresion_automatica: 1
        },
        requiredRules: [v => !!v || "Campo obligatorio"],
        emailRules: [
            v => !!v || "Campo obligatorio",
            v => /.+@.+\..+/.test(v) || "Correo Electrónico debe ser válido"
        ],
        deleteDialog: false,
        documentos: [],
        series: [],
        rules: {
            required: UTILS.rules.required,
            serie: [
                value => !!value || "La serie es requerida",
                value => value.length == 4 || "La serie debe de contener 4 digitos"
            ]
        }
    }),
    mounted() {
        this.loadDocumentoSeries();
    },
    methods: {
        async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
            this.loadingTable = true;
            this.itemsData.data = [];
            try {
                const response = await API.sucursales.list("?page="+page +"&itemsPerPage="+per_page
                    +"&sortDesc="+sortDesc
                    +"&sortBy="+sortBy
                    +"&searchTerm="+this.filter.searchTerm
                );
                this.itemsData.data = response.data.data;
                this.itemsData.total = response.data.total;
                this.current_page = response.data.current_page;
                this.total_reg = response.data.total;

            } catch (e) {
                console.error(e);

            } finally {
                this.loadingTable = false;
            }
        },
        limpiarFiltros() {
            this.filter.searchTerm = "";
            this.getRegistros();
        },
        handleDataRowClick(row){
            this.viewForm = Object.assign({}, row);
            this.viewDialog = true;
        },
        //--- Series ---
        async loadDocumentoSeries() {
            const response = await API.documento_serie.list();
            this.documentos = response.data;
        },
        async loadSeries(id_sucursal) {
            const response = await API.series.sucursal(id_sucursal);
            this.serie.id_sucursal = id_sucursal;
            this.series = response.data;
            this.dialogSeries = true;
        },
        async saveSerie() {
            try {
                if (!this.$refs.formSerie.validate()) return;

                const response = await API.series.create(this.serie);
                this.loadSeries(this.serie.id_sucursal);
                UTILS.toastr.success("Serie creada correctamente", this);
                this.dialogSeries = false;

            } catch (e) {
                if (e.response && e.response.status == 422) {
                    UTILS.toastr.error(e.response.data.msg, this);

                } else {
                    console.error(e);
                    UTILS.toastr.error("Ups! Ocurrió un error", this);
                }
            }
        },
        async deleteSerie(serie) {
            try {
                const res = await API.series.delete(serie.id_serie);
                this.loadSeries(serie.id_sucursal);
                UTILS.toastr.success("Eliminado correctamente", this);
            } catch (e) {
                console.error(e);
                UTILS.toastr.error("Ups! Ocurrió un error", this);
            }
        },
        //--- Fin ---

        //--- Sucursales ---
        async saveReg() {
            if (this.$refs.addForm.validate()) {
                try {
                    this.loadingTable = true;
                    this.$store.commit("loader", true);
                    if (this.dialogEditar == false) {
                        const response = await API.sucursales.create(this.addForm);
                        UTILS.toastr.success("Sucursal creado correctamente", this);

                    } else {
                        const response = await API.sucursales.update(
                        this.addForm.id_sucursal,
                        this.addForm
                        );
                        UTILS.toastr.success("Sucursal actualizado correctamente", this);
                    }
                    this.getRegistros();
                    this.addDialog = false;

                } catch (e) {
                    UTILS.toastr.error("Ups! Ocurrió un error", this);
                    console.error(e);

                } finally {
                    this.$store.commit("loader", false);
                    this.loadingTable = false;
                }
            }
        },
        editSucursal(item) {
            this.dialogEditar = true;
            this.addDialog = true;
            Object.assign(this.addForm, item);
        },
        deleteSucursal(item) {
            this.addForm = Object.assign({}, item);
            this.deleteDialog = true;
        },
        async deleteSucursalConfirm() {
            this.loadingTable = true;
            this.$store.commit("loader", true);

            try {
                const response = await API.sucursales.remove(this.addForm.id_sucursal);
                UTILS.toastr.success("Sucursal eliminado correctamente", this);
                this.deleteDialog = false;
                this.getRegistros();

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);

            } finally {
                this.$store.commit("loader", false);
                this.loadingTable = false;
            }
        }
        //--- Fin ---
    },
    watch: {
        options(event) {
            this.itemsperpage = event.itemsPerPage;
            this.getRegistros(event.page, event.itemsPerPage);
        },

        addDialog(){
            if(!this.addDialog){
                this.dialogEditar = false;
                this.$refs.addForm.resetValidation();
                this.addForm = Object.assign({}, this.defaultAddForm);

            }
        },
        viewDialog() {
            if (!this.viewDialog) {
                this.$refs.viewForm.reset();
            }
        },
        dialogSeries(){
            if (!this.dialogSeries) {
                this.$refs.formSerie.resetValidation();
                Object.assign(this.serie, {
                    serie: "",
                    id_serie_documento: "",
                    id_sucursal: ""
                });
            }
        },
    }
};
</script>
