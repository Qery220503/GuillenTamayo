<template>
    <div class="d-flex flex-column flex-grow-1">
        <custom-breadcrumbs
        :breadcrumbs_title="breadcrumbs_title"
        :breadcrumbs="breadcrumbs"
        ></custom-breadcrumbs>
        <v-card>
            <v-row dense class="pa-2 align-center">
                <v-col class="text-right">
                    <v-btn color="#1D6F42" class="mr-2" dark :href="urlToReturn">
                        Exportar<v-icon>mdi-file-excel</v-icon>
                    </v-btn>
                    <v-btn color="primary" class="mr-2" @click="addDialog = true">
                        Añadir Proveedores <v-icon>mdi-plus</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
            <v-row dense class="pa-2 align-center">
                <v-data-table
                    light
                    :headers="headers"
                    :items="data_reg.data"
                    :page="current_page"
                    :items-per-page="itemsPerPage"
                    :server-items-length="total_reg"
                    :options.sync="dataTabOptions"
                    class="flex-grow-1 scroll-me"
                    :footer-props="{
                        itemsPerPageOptions: [25, 50, 100, 1000]
                    }"
                    :loading="loadingTable"
                    loading-text="Cargando... Por favor, espere"
                    @click:row="handleDataRowClick">
                    <template v-slot:body.prepend>
                        <tr>
                            <td></td>
                            <td>
                                <v-text-field
                                    v-model="filter.nombre"
                                    type="text"
                                    outlined
                                    dense
                                    class="mt-1"
                                    hide-details
                                    @input="getRegistros()"
                                ></v-text-field>
                            </td>
                            <td>
                                <v-text-field
                                    v-model="filter.nro_doc"
                                    type="text"
                                    outlined
                                    dense
                                    class="mt-1"
                                    hide-details
                                    @input="getRegistros()"
                                ></v-text-field>
                            </td>
                            <td>
                                <v-text-field
                                    v-model="filter.email"
                                    type="text"
                                    outlined
                                    dense
                                    class="mt-1"
                                    hide-details
                                    @input="getRegistros()"
                                ></v-text-field>
                            </td>
                            <td>
                                <v-text-field
                                    v-model="filter.telefono"
                                    type="text"
                                    outlined
                                    dense
                                    class="mt-1"
                                    hide-details
                                    @input="getRegistros()"
                                ></v-text-field>
                            </td>
                            <td>
                                <v-text-field
                                    v-model="filter.cod_proveedor"
                                    type="text"
                                    outlined
                                    dense
                                    class="mt-1"
                                    hide-details
                                    @input="getRegistros()"
                                ></v-text-field>
                            </td>
                            <td>
                                <v-select
                                    v-model="filter.deuda"
                                    :items="deudasEstados"
                                    item-text="label"
                                    item-value="value"
                                    label="Condición"
                                    hide-details
                                    outlined
                                    @input="getRegistros()"
                                    dense
                                ></v-select>
                            </td>
                            <td></td>
                            <td></td>
                            <td>
                                <v-btn small icon @click="limpiarFiltros">
                                    <v-icon small>mdi-broom</v-icon>
                                </v-btn>
                            </td>
                        </tr>
                    </template>
                    <template v-slot:[`item.has_deudas`]="{item}">
                        <v-chip class="ma-2" color="error" small v-if="item.has_deudas">
                            <span class="font-weight-medium">Con deudas</span>
                        </v-chip>
                        <v-chip class="ma-2" color="success" small v-else>
                            <span class="font-weight-medium">Sin deudas</span>
                        </v-chip>
                    </template>
                    <template v-slot:[`item.cuenta_corriente`]="{ item }">
                        <v-btn small color="info" link @click.stop.prevent
                            :to="'/proveedores/cuenta-corriente/'+item.id_proveedor">
                            <v-icon small class="mr-1">mdi-format-list-bulleted-square</v-icon>Cuenta Corriente
                        </v-btn>
                    </template>
                    <template v-slot:[`item.compras_realizadas`]="{ item }">
                        <v-btn small color="success" @click.stop.prevent :to="'/compras?id_proveedor='+item.id_proveedor">
                            <v-icon small class="mr-1">mdi-cart-outline</v-icon>Compras Realizadas
                        </v-btn>
                    </template>
                    <template v-slot:[`item.actions`]="{ item }">
                        <v-btn small icon @click.stop="editReg(item)">
                            <v-icon small>mdi-border-color</v-icon>
                        </v-btn>
                        <v-btn small icon @click.stop="deleteReg(item)">
                            <v-icon small>mdi-delete</v-icon>
                        </v-btn>
                    </template>
                </v-data-table>
            </v-row>
        </v-card>

        <!-- Add/Edit Dialog -->
        <v-dialog v-model="addDialog" max-width="40%" persistent>
            <v-card>
                <v-card-title>
                    <span class="headline">Agregar Proveedor</span>
                </v-card-title>
                <v-divider></v-divider>
                <br>
                <v-card-text>
                    <v-form
                        ref="addForm"
                        v-model="validAddForm"
                        @submit.prevent="saveReg()"
                        lazy-validation>
                        <v-row>
                            <v-col cols="12" sm="12" md="12">
                                <v-text-field
                                    label="Nombre o Razón Social *"
                                    v-model="addForm.nombre"
                                    :rules="[rules.required]"
                                    autocomplete="off"
                                ></v-text-field>
                                <v-select label="Tipo Documento" v-model="addForm.id_tipo_doc"
                                    :items="items_tipo_doc"
                                    item-text="nombre_tipo_documento"
                                    item-value="id_tipo_documento"
                                    @change="TipoDocChanged(addForm.id_tipo_doc)"
                                ></v-select>
                                <v-text-field
                                    :label="nrodoc_label"
                                    v-model="addForm.nro_doc"
                                    :rules="requiredDocRules"
                                    autocomplete="off">
                                    <template v-slot:append>
                                        <v-btn
                                            @click="obtenerDataDocumentos()"
                                            color="primary"
                                            class="ma-0">
                                            <v-icon>mdi-magnify</v-icon>
                                        </v-btn>
                                    </template>
                                </v-text-field>
                                <v-text-field
                                    label="Correo Electrónico *"
                                    v-model="addForm.email"
                                    :rules="[rules.required, rules.email]"
                                    autocomplete="off"
                                ></v-text-field>
                                <v-text-field
                                    label="Código del proveedor *"
                                    v-model="addForm.cod_proveedor"
                                    :rules="[rules.required]"
                                    autocomplete="off"
                                ></v-text-field>
                                <v-text-field
                                    label="Dirección *"
                                    v-model="addForm.direccion"
                                    :rules="[rules.required]"
                                    autocomplete="off"
                                ></v-text-field>
                                <v-text-field
                                    label="Teléfono *"
                                    v-model="addForm.telefono"
                                    :rules="[rules.required, (val) => (val.length == 9) || 'El telefono debe tener 9 digitos']"
                                    autocomplete="off"
                                ></v-text-field>
                                <v-text-field
                                    label="Encargado *"
                                    v-model="addForm.encargado"
                                    :rules="[rules.required]"
                                    autocomplete="off"
                                ></v-text-field>
                                <v-text-field
                                    label="Cuenta Bancaria"
                                    v-model="addForm.nro_cuenta"
                                    autocomplete="off"
                                ></v-text-field>
                                <v-text-field
                                    label="CCI Bancario"
                                    v-model="addForm.cci_bancario"
                                    autocomplete="off"
                                ></v-text-field>
                            </v-col>
                        </v-row>
                        <br />
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="error" text @click="addDialog = false;">Cancelar</v-btn>
                            <v-btn type="submit" color="primary" :disabled="!validAddForm">Guardar</v-btn>
                        </v-card-actions>
                    </v-form>
                </v-card-text>
            </v-card>
        </v-dialog>
        <!-- End -->
        <!-- View Dialog -->
        <v-dialog v-model="viewDialog" max-width="40%">
            <v-card>
                <v-card-title>
                    <span class="headline">Visualizar Registro</span>
                </v-card-title>
                <v-card-text>
                    <v-form ref="viewForm">
                        <v-row>
                            <v-col cols="12" sm="12" md="12">
                                <v-text-field
                                    v-model="viewForm.nombre"
                                    label="Nombre o Razón Social"
                                    readonly
                                ></v-text-field>
                                <v-select
                                    v-model="viewForm.id_tipo_doc"
                                    label="Tipo de documento"
                                    :items="items_tipo_doc"
                                    item-text="nombre_tipo_documento"
                                    item-value="id_tipo_documento"
                                    readonly>
                                </v-select>
                                <v-text-field
                                    v-model="viewForm.nro_doc"
                                    label="Nro. Documento"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.email"
                                    label="Correo Electrónico"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.cod_proveedor"
                                    label="Código del Proveedor"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.direccion"
                                    label="Dirección"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.telefono"
                                    label="Teléfono"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.encargado"
                                    label="Encargado"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.nro_cuenta"
                                    label="Cuenta Bancaria"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.cci_bancario"
                                    label="CCI Bancario"
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
        <v-dialog v-model="deleteDialog" max-width="290">
            <v-card>
                <v-card-title class="headline">Eliminar Proveedor</v-card-title>
                <v-card-text>¿Está seguro de que desea eliminar este permiso?</v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn @click="deleteDialog = false">Cancelar</v-btn>
                    <v-btn
                        color="error"
                        @click="deleteProveedor(); delete_loading = true;"
                        :loading="delete_loading">Eliminar
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <!-- End -->
    </div>
</template>
<script>
import API from "../../../api";

export default {
    data() {
        return {
            breadcrumbs_title: "Proveedores",
            breadcrumbs: [
                { text: "Inicio", disabled: false, href: "/dashboard" },
                { text: "Proveedores" }
            ],
            headers: [
                { text: "#", value: "id_proveedor", align: "left" },
                { text: "Nombre", value: "nombre", align: "left" },
                { text: "RUC", value: "nro_doc", align: "left" },
                { text: "Correo Electrónico", value: "email", align: "left" },
                { text: "Teléfono", value: "telefono", align: "left" },
                { text: "Código", value: "cod_proveedor", align: "left" },
                { text: "Deudas", value: "has_deudas", align: "left" },
                { text: "Cuenta Corriente", value: "cuenta_corriente", align: "left" },
                {
                    text: "Compras Realizadas",
                    value: "compras_realizadas",
                    align: "left"
                },
                { text: "Acciones", sortable: false, value: "actions", align: "right" }
            ],
            viewDialog: false,
            viewForm: {
            },
            urlToReturn: '',
            //--- Datatable ---
            delete_loading: false,
            loadingTable: false,
            current_page: 1,
            itemsPerPage: 25,
            total_reg: 0,
            dataTabOptions: {},
            data_reg: [],
            filter: {
                nombre: "",
                nro_doc: "",
                email: "",
                telefono: "",
                cod_proveedor: "",
                deuda: "all",
            },
            deudasEstados: [
                { value: "all", label: "Todos" },
                { value: "debt", label: "Con deudas" },
                { value: "no-debt", label: "Sin deudas" },
            ],
            addFormTitle: "Agregar Proveedor",
            dialogEditar: false,
            validAddForm: false,
            addDialog: false,
            deleteDialog: false,
            addForm: {
                nombre: '',
                nro_doc: '',
                id_tipo_doc: 2,
                direccion: '',
                email: '',
                telefono: '',
                encargado: '',
                nro_cuenta: '',
                cod_proveedor: '',
                cci_bancario: '',
                encargado: '',
            },
            nrodoc_label: "Nro. RUC *",
            requiredDocRules: [
                v => !!v || 'Campo obligatorio',
                (v) => (v && v.length == 11) || "RUC debe tener 11",
            ],
            defaultAddForm: {
                id_tipo_doc: 2,
                telefono: '',
            },
            items_tipo_doc: [],


            rules: {
                required: UTILS.nRules.required,
                only_numbers: UTILS.nRules.only_numbers,
                email: UTILS.nRules.email
            },
            datosBus: {
                tipoDoc: null,
                numDoc: null
            }
        };
    },
    created() {
        this.getTiposDoc();
    },
    methods: {
        //--- Datatable ---
        async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
            this.loadingTable = true;
            this.data_reg = [];
            const myParams = new URLSearchParams(this.filter).toString();
            try {
                const response = await API.proveedores.list("?page=" + page + "&itemsPerPage=" + per_page
                    + "&sortDesc=" + sortDesc
                    + "&sortBy=" + sortBy
                    + "&" + myParams
                );
                this.data_reg = response.data;
                this.current_page = response.data.current_page;
                this.total_reg = this.data_reg.total;
                this.loadingTable = false;
                this.getExportData();

            } catch (e) {
                this.loadingTable = false;
                console.error(e);
            }
        },
        limpiarFiltros() {
            this.filter = {
                deuda: "all",
            };
            this.getRegistros();
        },
        handleDataRowClick(row) {
            this.viewForm = Object.assign({}, row);
            this.viewDialog = true;
        },
        getExportData() {
            this.urlToReturn = '/api/exportProveedor/?' + new URLSearchParams(this.filter).toString();
        },
        //--- End ---

        async obtenerDataDocumentos() {
            try {
                this.$store.commit("loader", true);
                this.datosBus.tipoDoc = this.addForm.id_tipo_doc;
                this.datosBus.numDoc = this.addForm.nro_doc;

                const rpta = await API.apis.dniruc(this.datosBus);

                this.addForm.nombre = '';
                this.addForm.direccion = '';
                this.$refs.addForm.resetValidation();

                if (rpta.data.success === true) {
                    if (this.datosBus.tipoDoc === 2) {
                        this.addForm.nombre = rpta.data.nombre_o_razon_social;
                        this.addForm.direccion = rpta.data.direccion_completa;
                        if (rpta.data.estado == "ACTIVO" && rpta.data.condicion == "HABIDO") {
                            UTILS.toastr.success("El documento ingresado se encuentra ACTIVO y HABIDO", this);
                        } else {
                            UTILS.toastr.info("Cuidado, el documento ingresado se encuentra " + rpta.data.estado + " y " + rpta.data.condicion, this);
                        }
                        this.$store.commit("loader", false);
                    } else if (this.datosBus.tipoDoc === 1) {
                        this.addForm.nombre = rpta.data.result.Nombres + " " + rpta.data.result.Apellidos;
                        this.$store.commit("loader", false);
                    }
                } else {
                    this.$store.commit("loader", false);
                }
                this.$store.commit("loader", false);

            } catch (error) {
                this.$store.commit("loader", false);
            }
        },

        async deleteProveedor() {
            const vm = this;
            await API.proveedores.remove(this.addForm.id_proveedor);
            vm.deleteDialog = false;
            vm.getRegistros();
        },

        deleteReg(item) {
            const vm = this;
            vm.addForm = item;
            vm.deleteDialog = true;
        },
        editReg(item) {
            let vm = this;
            try {
                Object.assign(vm.addForm, item);
                vm.addDialog = true;
                vm.dialogEditar = true;
                vm.addFormTitle = 'Editar Proveedor'
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async getTiposDoc() {
            let vm = this;
            try {
                const response = await API.tipos_documentos.combo();
                vm.items_tipo_doc = response.data;
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async saveReg() {
            const vm = this;
            if (!this.$refs.addForm.validate()) return;
            try {
                if (this.dialogEditar) {
                    await API.proveedores.update(vm.addForm.id_proveedor, vm.addForm);
                } else {
                    await API.proveedores.create(vm.addForm);
                }
                await vm.getRegistros();
                vm.addDialog = false;

            } catch (e) {
                console.error(e);
            }
        },


        TipoDocChanged(tipo_doc) {
            this.addForm.nro_doc = null;

            switch (tipo_doc) {
                case 1:
                    this.nrodoc_label = "Nro. DNI *";
                    this.requiredDocRules = [
                        v => !!v || 'Campo obligatorio',
                        (v) => (v && v.length == 8) || "DNI debe tener 8 cifras",
                    ];
                    break;

                case 2:
                    this.nrodoc_label = "Nro. RUC *";
                    this.requiredDocRules = [
                        v => !!v || 'Campo obligatorio',
                        (v) => (v && v.length == 11) || "RUC debe tener 11 o menos cifras",
                    ];
                    break;

                default:
                    this.nrodoc_label = "Nro. Documento *";
                    this.requiredDocRules = [
                        v => !!v || 'Campo obligatorio',
                    ];
                    break;

            }
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
        addDialog() {
            if (!this.addDialog) {
                this.dialogEditar = false;
                this.addFormTitle = "Agregar Proveedor";

                this.$refs.addForm.resetValidation();
                this.validAddForm = false;
                this.addForm = Object.assign({}, this.defaultAddForm);

                this.addForm.id_tipo_doc = 2;
                this.nrodoc_label = "Nro. RUC *";
            }
        },
        viewDialog() {
            if (!this.viewDialog) {
                this.$refs.viewForm.reset();
            }
        }
    },
};
</script>
