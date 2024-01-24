<template>
    <div class="d-flex flex-column flex-grow-1">
        <custom-breadcrumbs :breadcrumbs_title="breadcrumbs_title" :breadcrumbs="breadcrumbs"></custom-breadcrumbs>
        <v-card class="mb-4" light style="padding: 15px">
            <v-row dense class="pa-2 align-center">
                <v-spacer></v-spacer>
                <v-col cols="auto" class="text-right">
                    <v-btn color="#1D6F42" class="mr-2" dark href="/api/exportPrecioLentes">
                        Exportar Activos<v-icon>mdi-file-excel</v-icon>
                    </v-btn>
                    <v-btn color="#1D6F42" class="mr-2" dark href="/api/exportPrecioLentesInactivo">
                        Exportar Inactivos<v-icon>mdi-file-excel</v-icon>
                    </v-btn>
                    <v-btn color="primary" class="mr-2" @click="addDialog = true">
                        Añadir Lente <v-icon>mdi-plus</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
            <v-data-table
                :headers="tableHeaders"
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
                <template v-slot:body.prepend>
                    <tr>
                        <td></td>
                        <td>
                            <v-text-field v-model="filter.modelo" type="text" outlined dense class="mt-1"
                                hide-details @input="GetRecords()"></v-text-field>
                        </td>
                        <td>
                            <v-text-field v-model="filter.fabricacion" type="text" outlined dense class="mt-01"
                                hide-details @input="GetRecords()"></v-text-field>
                        </td>
                        <td>
                            <v-text-field v-model="filter.material" type="text" outlined dense class="mt-1"
                                hide-details @input="GetRecords()"></v-text-field>
                        </td>
                        <td>
                            <v-text-field v-model="filter.serie" type="text" outlined dense class="mt-1"
                                hide-details @input="GetRecords()"></v-text-field>
                        </td>
                        <td>
                            <v-text-field v-model="filter.tratamiento" type="text" outlined dense class="mt-1"
                                hide-details @input="GetRecords()"></v-text-field>
                        </td>
                        <td>
                            <v-text-field v-model="filter.fotocromatico" type="text" outlined dense class="mt-1"
                                hide-details @input="GetRecords()"></v-text-field>
                        </td>
                        <td>
                            <v-text-field v-model="filter.nombre_propio" type="text" outlined dense class="mt-1"
                                hide-details @input="GetRecords()"></v-text-field>
                        </td>
                        <td>
                            <v-select v-model="filter.estado" :items="preciosEstados" item-text="label"
                                item-value="value" label="Estado" hide-details outlined @input="GetRecords()"
                                dense></v-select>
                        </td>
                        <td>
                            <v-btn small icon @click="limpiarFiltros">
                                <v-icon small>mdi-broom</v-icon>
                            </v-btn>
                        </td>
                    </tr>
                </template>
                <template #[`item.index`]="{ item }">
                    {{ dataReg.data.indexOf(item) + 1 }}
                </template>
                <template v-slot:[`item.nombre_propio`]="{ item }">
                    <div style="width: 400px;">
                        {{ item.nombre_propio }}
                    </div>
                </template>

                <template v-slot:[`item.estado`]="{ item }">
                    <v-chip small v-if="item.estado == 1" class="ma-2" color="success">Habilitado</v-chip>
                    <v-chip small v-if="item.estado == 0" class="ma-2" color="error">Deshabilitado</v-chip>
                </template>
                <template v-slot:[`item.actions`]="{ item }">
                    <v-btn small icon @click.stop="editReg(item)">
                        <v-icon small>mdi-border-color</v-icon>
                    </v-btn>
                    <v-btn small icon @click.stop="deleteReg(item)" v-if="item.estado == 1">
                        <v-icon small>mdi-delete</v-icon>
                    </v-btn>
                    <v-btn small icon @click.stop="restore(item)" v-if="item.estado == 0">
                        <v-icon small>mdi-restore</v-icon>
                    </v-btn>
                </template>
            </v-data-table>
            <div class="text-center pt-2">
                <v-pagination
                    v-model="currentPage"
                    :length="pageCount"
                    :total-visible="16"
                    :disabled="totalReg<=0"
                    circle
                ></v-pagination>
            </div>
        </v-card>

        <!-- Add/Edit Dialog -->
        <v-dialog v-model="addDialog" max-width="40%" persistent>
            <v-card>
                <v-card-title>
                    <span class="headline">{{ addFormTitle }}</span>
                </v-card-title>
                <v-card-text>
                    <v-form ref="addForm" v-model="validAddForm" @submit.prevent="saveReg()" lazy-validation>
                        <v-row>
                            <v-col>
                                <v-text-field v-model="addForm.modelo" label="Modelo" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.material" label="Material" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.tratamiento" label="Tratamiento" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.fotocromatico" label="Fotocromático" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.laboratorio" label="Laboratorio" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.nombre_laboratorio" label="Nombre Laboratorio"
                                    :rules="rules.required" autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.precio_compra" label="Precio Compra" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                            </v-col>

                            <v-col>
                                <v-text-field v-model="addForm.fabricacion" label="Fabricación" :rules="rules.required"
                                    autocomplete="off"></v-text-field>

                                <v-text-field v-model="addForm.serie" label="Serie" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.nombre" label="Nombre" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.color_fotocromatico" label="Color Fotocromático"
                                    :rules="rules.required" autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.nombre_propio" label="Nombre Propio" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.precio_venta" label="Precio Venta" :rules="rules.required"
                                    autocomplete="off"></v-text-field>
                                <v-text-field v-model="addForm.tiempo_espera" label="Tiempo de espera (n° días)"
                                    :rules="rules.required" autocomplete="off" type="number"></v-text-field>
                            </v-col>
                        </v-row>
                        <br />
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="error" text @click="addDialog = false">Cancelar</v-btn>
                            <v-btn type="submit" color="primary" :disabled="!validAddForm">
                                Guardar
                            </v-btn>
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
                                <v-text-field v-model="viewForm.modelo" label="Modelo" readonly></v-text-field>
                                <v-text-field v-model="viewForm.material" label="Material" readonly></v-text-field>
                                <v-text-field v-model="viewForm.tratamiento" label="Tratamiento" readonly></v-text-field>
                                <v-text-field v-model="viewForm.fotocromatico" label="Fotocromático"
                                    readonly></v-text-field>
                                <v-text-field v-model="viewForm.laboratorio" label="Laboratorio" readonly></v-text-field>
                                <v-text-field v-model="viewForm.nombre_laboratorio" label="Nombre Laboratorio"
                                    readonly></v-text-field>
                                <v-text-field v-model="viewForm.precio_compra" label="Precio Compra"
                                    readonly></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                                <v-text-field v-model="viewForm.fabricacion" label="Fabricación" readonly></v-text-field>
                                <v-text-field v-model="viewForm.serie" label="Serie" readonly></v-text-field>
                                <v-text-field v-model="viewForm.nombre" label="Nombre" readonly></v-text-field>
                                <v-text-field v-model="viewForm.color_fotocromatico" label="Color Fotocromático"
                                    readonly></v-text-field>
                                <v-text-field v-model="viewForm.nombre_propio" label="Nombre Propio"
                                    readonly></v-text-field>
                                <v-text-field v-model="viewForm.precio_venta" label="Precio Venta" readonly></v-text-field>
                                <v-text-field v-model="viewForm.tiempo_espera" label="Tiempo de espera (n° días)"
                                    readonly></v-text-field>
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
                    <v-btn color="primary" @click="deleteRegConfirm">Aceptar</v-btn>
                    <v-btn color="error" text @click="deleteDialog = false">Cancelar</v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <!-- Fin -->
    </div>
</template>
<script>
import API from "../../../api";

export default {
    data() {
        return {
            breadcrumbs_title: "Precios de Lentes",
            breadcrumbs: [
                { text: "Inicio", disabled: false, href: "/dashboard" },
                { text: "Maestros", disabled: false, href: "#" },
                { text: "Precios de Lentes" }
            ],
            tableHeaders: [
                { text: "Nº", value: "index", align: "left" },
                { text: "Modelo", value: "modelo", align: "left" },
                { text: "Fabricación", value: "fabricacion", align: "left" },
                { text: "Material", value: "material", align: "left" },
                { text: "Serie", value: "serie", align: "left" },
                { text: "Tratamiento", value: "tratamiento", align: "left" },
                { text: "Fotocromatico", value: "fotocromatico", align: "left" },
                { text: "Nombre Prop.", value: "nombre_propio", align: "left" },
                { text: "Estado", value: "estado", align: "center" },
                { text: "Acciones", sortable: false, value: "actions", align: "right" }
            ],

            viewDialog: false,
            viewForm: {
            },

            addForm: {
                nombre_clinica: null,
                telefono_clinica: null,
                email_clinica: null
            },
            //--- Datatable ---
            loadingTable: false,
            currentPage: 1,
            pageCount: 1,
            itemsPerPage: 25,
            totalReg: 0,
            dataTabOptions: {},
            dataReg: [],
            filter: {
                searchTerm: "",
                modelo: "",
                fabricacion: "",
                material: "",
                serie: "",
                tratamiento: "",
                fotocromatico: "",
                nombre_propio: "",
                estado: 1,
            },
            preciosEstados: [
                {label: 'Habilitados', value: 1,},
                {label: 'Deshabilitados', value: 2,},
                {label: 'Todos', value: 3}
            ],
            addFormTitle: "Agregar Precio de Lente",
            dialogEditar: true,
            validAddForm: false,
            addDialog: false,
            deleteDialog: false,
            rules: {
                required: UTILS.rules.required
            },
            activePicker: null,
            date: null,
            menu: false
        };
    },
    created() {
        //
    },
    methods: {
        async GetRecords(page = 1, perPage = 25, sortDesc = 0, sortBy = ""){
            this.loadingTable = true;
            this.data_reg = [];
            const myParams = new URLSearchParams(this.filter).toString();
            try {
                const response = await API.precioslentes.list("?page="+page +"&perPage="+perPage
                    +"&sortDesc="+sortDesc
                    +"&sortBy="+sortBy
                    +"&searchTerm="+this.filter.searchTerm
                    +"&"+myParams
                );

                this.dataReg     = response.data;
                this.currentPage = this.dataReg.current_page;
                this.pageCount   = this.dataReg.last_page;
                this.totalReg    = this.dataReg.total;
                this.loadingTable = false;

            } catch (e) {
                this.loadingTable = false;
                console.error(e);
            }
        },
        limpiarFiltros() {
            this.filter = {
                estado: 1,
            };
            this.GetRecords();
        },
        handleDataRowClick(row) {
            this.viewForm = Object.assign({}, row);
            this.viewDialog = true;
        },

        editReg(item) {
            this.addFormTitle = "Editar Precio Lente";
            this.dialogEditar = true;
            this.addForm = Object.assign({}, item);
            this.addDialog = true;
        },
        deleteReg(item) {
            this.addForm = Object.assign({}, item);
            this.deleteDialog = true;
        },
        async deleteRegConfirm() {
            this.loadingTable = true;
            this.$store.commit("loader", true);
            try {
                const response = await API.precioslentes.remove(
                    this.addForm.id_precio_lente
                );
                UTILS.toastr.success("Precio eliminada correctamente", this);
                this.deleteDialog = false;
                this.GetRecords();

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);

            } finally {
                this.$store.commit("loader", false);
                this.loadingTable = false;
            }
        },
        async saveReg() {
            if (this.$refs.addForm.validate()) {
                try {
                    this.loadingTable = true;
                    this.$store.commit("loader", true);

                    if (this.dialogEditar == false) {
                        const response = await API.precioslentes.create(this.addForm);
                        UTILS.toastr.success("Precio creado correctamente", this);
                    } else {
                        const response = await API.precioslentes.update(
                            this.addForm.id_precio_lente,
                            this.addForm
                        );
                        UTILS.toastr.success("Precio actualizado correctamente", this);
                    }
                    this.GetRecords();
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
        async restore(item) {
            this.loadingTable = true;
            try {
                this.loadingTable = true;
                const response = await API.precioslentes.update(item.id_precio_lente, { estado: 1 });
                this.GetRecords(this.current_page, this.itemsperpage);

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);

            } finally {
                this.$store.commit("loader", false);
                this.loadingTable = false;
            }
        },
    },
    watch: {
        dataTabOptions(event) {
            this.itemsPerPage = event.itemsPerPage;
            this.GetRecords(event.page, event.itemsPerPage);
        },
        menu(val) {
            val && setTimeout(() => (this.activePicker = "YEAR"));
        },
        addDialog() {
            if (!this.addDialog) {
                // console.log('Dialog is closing');
                this.dialogEditar = false;
                this.$refs.addForm.reset();
                this.validAddForm = false;
                this.addFormTitle = "Agregar Marca";
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
