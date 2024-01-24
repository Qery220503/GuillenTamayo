<template>
    <div class="d-flex flex-column flex-grow-1">
        <custom-breadcrumbs
            :breadcrumbs_title="breadcrumbs_title"
            :breadcrumbs="breadcrumbs"
        ></custom-breadcrumbs>
        <v-card class="mb-4" light style="padding: 15px">
            <v-row dense class="pa-2 align-center">
                <v-col class="text-right">
                    <v-btn color="#1D6F42" class="mr-2" dark @click="importDialog = true">
                        Importar<v-icon>mdi-file-excel</v-icon>
                    </v-btn>
                    <v-btn color="#1D6F42" class="mr-2" dark href="/api/exportProductos">
                        Exportar<v-icon>mdi-file-excel</v-icon>
                    </v-btn>
                    <v-btn color="#1D6F42" class="mr-2" dark href="/api/exportProductosStock">
                        Exportar con Stock<v-icon>mdi-file-excel</v-icon>
                    </v-btn>
                    <v-btn color="primary" class="mr-2" to="/producto/crear" link>
                        Añadir Productos <v-icon>mdi-plus</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
            <v-data-table
                light
                :headers="tableHeaders"
                :items="dataReg.data"
                :page="currentPage"
                :items-per-page="itemsPerPage"
                :server-items-length="totalReg"
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
                                v-model="filter.codigo_producto"
                                type="text"
                                outlined
                                dense
                                class="mt-1"
                                hide-details
                                @input="GetRecords()"
                            ></v-text-field>
                        </td>
                        <td>
                            <v-text-field
                                v-model="filter.nombre_producto"
                                type="text"
                                outlined
                                dense
                                class="mt-1"
                                hide-details
                                @input="GetRecords()"
                            ></v-text-field>
                        </td>
                        <td>
                            <v-text-field
                                v-model="filter.codigo_varilla"
                                type="text"
                                outlined
                                dense
                                class="mt-1"
                                hide-details
                                @input="GetRecords()"
                            ></v-text-field>
                        </td>
                        <td>
                            <v-text-field
                                v-model="filter.marca_producto"
                                type="text"
                                outlined
                                dense
                                class="mt-1"
                                hide-details
                                @input="GetRecords()"
                            ></v-text-field>
                        </td>
                        <td>
                            <v-text-field
                                v-model="filter.stock"
                                type="text"
                                outlined
                                dense
                                class="mt-1"
                                hide-details
                                @input="GetRecords()"
                            ></v-text-field>
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            <v-text-field
                                v-model="filter.precio_compra"
                                type="text"
                                outlined
                                dense
                                class="mt-1"
                                hide-details
                                @input="GetRecords()"
                            ></v-text-field>
                        </td>
                        <td>
                            <v-text-field
                                v-model="filter.precio_venta"
                                type="text"
                                outlined
                                dense
                                class="mt-1"
                                hide-details
                                @input="GetRecords()"
                            ></v-text-field>
                        </td>
                        <td>
                            <v-select
                                label="Producto Reto"
                                v-model="filter.producto_reto"
                                :items="filterBooleanOpts"
                                item-text="text"
                                item-value="value"
                                hide-details
                                outlined
                                @input="GetRecords()"
                                dense
                            ></v-select>
                        </td>
                        <td>
                            <v-select
                                label="Líquido"
                                v-model="filter.liquido"
                                :items="filterBooleanOpts"
                                item-text="text"
                                item-value="value"
                                hide-details
                                outlined
                                @input="GetRecords()"
                                dense
                            ></v-select>
                        </td>
                        <td></td>
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
                <template v-slot:[`item.codigo_producto`]="{ item }">
                    <div class="one-line">{{ item.codigo_producto }}</div>
                </template>
                <template v-slot:[`item.nombre_producto`]="{ item }">
                    <div class="one-line">{{ item.nombre_producto }}</div>
                </template>
                <template v-slot:[`item.precio_compra`]="{ item }">
                    S/. {{ item.precio_compra }}
                </template>
                <template v-slot:[`item.precio_venta`]="{ item }">
                    S/. {{ item.precio_venta }}
                </template>
                <template v-slot:[`item.margen_ganancia`]="{ item }">
                    {{ margenGanancia(item.precio_compra, item.precio_venta)}}%
                </template>
                <template v-slot:[`item.producto_reto`]="{ item }">
                    <template v-if="item.producto_reto!=1">No</template>
                    <template v-else>Si</template>
                </template>
                <template v-slot:[`item.liquido`]="{ item }">
                    <template v-if="item.liquido!=1">No</template>
                    <template v-else>Si</template>
                </template>

                <template v-slot:[`item.actions`]="{ item }">
                    <v-btn small icon :to="'/producto/editar/'+item.id_producto" @click.stop.prevent link>
                        <v-icon small>mdi-border-color</v-icon>
                    </v-btn>
                    <v-btn small icon @click.stop="deleteReg()">
                        <v-icon small>mdi-delete</v-icon>
                    </v-btn>
                    <v-btn small icon @click.stop="sincReg(item.id_producto)">
                        <v-icon small>mdi-cloud</v-icon>
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
                                    v-model="viewForm.nombre_producto"
                                    label="Producto"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.codigo_producto"
                                    label="Código"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.codigo_varilla"
                                    label="Código Varilla"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.marca_producto"
                                    label="Marca"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.stock"
                                    label="Stock"
                                    readonly
                                ></v-text-field>
                            </v-col>

                            <v-col cols="12" sm="6" md="6">
                                <v-text-field
                                    v-model="viewForm.precio_compra"
                                    label="Precio Compra"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.precio_venta"
                                    label="Precio Venta"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.producto_reto"
                                    label="Producto Reto"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.liquido"
                                    label="Líquido"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.margen_ganancia"
                                    label="Margen Ganancia"
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
        <v-dialog v-model="deleteDialog" max-width="500px">
            <v-card>
                <v-card-title class="d-flex justify-center">
                    <span class="headline">¿Estás seguro que deseas borrar este registro?</span>
                </v-card-title>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" @click="deleteRegConfirm">Aceptar</v-btn>
                    <v-btn color="error" text @click="deleteDialog = false">
                        Cancelar
                    </v-btn>
                    <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <!-- Fin -->
        <!-- Import Dialog -->
        <v-dialog v-model="importDialog" max-width="500px">
            <v-card>
                <v-card-title class="d-flex justify-center">
                    <span class="headline">Importar nuevos productos</span>
                </v-card-title>
                <v-card-text>
                    <div class="d-flex py-3">
                        <input
                            type="file"
                            v-on:change="addfile($event)"
                            placeholder="Cargar archivo"
                            accept=".csv,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"/>
                        <v-spacer></v-spacer>
                        <v-btn
                            color="#1D6F42"
                            dark
                            @click="importDialog = true"
                            href="/images/Plantilla_Productos.xlsx"
                            download>
                            Plantilla <v-icon class="ml-1">mdi-cloud-download-outline</v-icon>
                        </v-btn>
                    </div>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" @click="sendFileConfirm">Aceptar</v-btn>
                    <v-btn color="error" text @click="importDialog = false">
                        Cancelar
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <!-- Fin -->
    </div>
</template>
<script>
import API from "../../../api";
import * as XLSX from "xlsx";

export default {
    data() {
        return {
            breadcrumbs_title: "Productos",
            breadcrumbs: [
                { text: "Inicio", disabled: false, href: "/dashboard" },
                { text: "Maestros", disabled: false, href: "#" },
                { text: "Productos" }
            ],
            tableHeaders: [
                { text: 'Nº', value: 'index',  sortable: false },
                { text: "Código", value: "codigo_producto", align: "left" },
                { text: "Producto", value: "nombre_producto", align: "left" },
                { text: "Código Varilla", value: "codigo_varilla", align: "left" },
                { text: "Marca", value: "marca.marca_producto", align: "left" },
                { text: "Stock Total", value: "stock", align: "left" },
                { text: "Stock Sucursal", value: "st_sucursal", align: "left" },
                { text: "Stock Almacén", value: "st_almacen", align: "left" },
                { text: "Stock Tienda", value: "st_tienda", align: "left" },
                { text: "Precio Compra", value: "precio_compra", align: "left" },
                { text: "Precio Venta", value: "precio_venta", align: "left" },
                { text: "Producto Reto", value: "producto_reto", align: "left" },
                { text: "Líquido", value: "liquido", align: "left" },
                { text: "Margen de Ganancia", value: "margen_ganancia", align: "left" },
                // { text: "Estado", value: "estado", sortable: false, align: 'center' },
                { text: "Acciones", sortable: false, value: "actions", align: "right" }
            ],
            viewDialog: false,
            viewForm: {
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
                codigo_producto: "",
                nombre_producto: "",
                codigo_varilla: "",
                marca_producto: "",
                stock: "",
                precio_compra: "",
                precio_venta: "",
                producto_reto: "",
                liquido: "",
            },
            filterBooleanOpts: [
                {value: "", text: "Todos"},
                {value: 0, text: "No"},
                {value: 1, text: "Si"},
            ],

            importDialog: false,
            deleteDialog: false,
            rules: {
                required: UTILS.rules.required
            },
            file: File,
            arrayBuffer: null,
            filelist: null
        };
    },
    created() {
        //
    },
    methods: {
        async GetRecords(page = 1, perPage = 25, sortDesc = 0, sortBy = ""){
            this.loadingTable = true;
            this.dataReg = [];
            const myParams = new URLSearchParams(this.filter).toString();
            try {
                const response = await API.productos.list("?page="+page +"&perPage="+perPage
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
            this.filter = {};
            this.GetRecords();
        },
        handleDataRowClick(row){
            this.viewForm = Object.assign({}, row);
            this.viewForm.marca_producto = row.marca.marca_producto;
            this.viewForm.margen_ganancia = row.precio_venta - row.precio_compra;
            this.viewDialog = true;
        },

        deleteReg() {
            this.deleteDialog = true;
        },
        async deleteRegConfirm() {
            this.loadingTable = true;
            this.$store.commit("loader", true);

            try {
                const response = await API.productos.remove(this.addForm.id_producto);
                UTILS.toastr.success("Producto eliminado correctamente", this);
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
        async sincReg(id) {
            this.loadingTable = true;
            this.$store.commit("loader", true);
            try {
                const response = await API.productos.sync(id);
                let nombreprod = response.data.nombre_producto;
                let status = response.status;
                let salida = `Producto: ${nombreprod}, sincronizado correctamente.`;
                UTILS.toastr.success(salida, this);

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);

            } finally {
                this.$store.commit("loader", false);
                this.loadingTable = false;
            }
        },
        addfile(event) {
            this.file = event.target.files[0];
            let fileReader = new FileReader();
            fileReader.readAsArrayBuffer(this.file);
            fileReader.onload = e => {
                this.arrayBuffer = fileReader.result;
                var data = new Uint8Array(this.arrayBuffer);
                var arr = new Array();
                for (var i = 0; i != data.length; ++i) {
                    arr[i] = String.fromCharCode(data[i]);
                }
                var bstr = arr.join("");
                var workbook = XLSX.read(bstr, { type: "binary" });
                var first_sheet_name = workbook.SheetNames[0];
                var worksheet = workbook.Sheets[first_sheet_name];
                var arraylist = XLSX.utils.sheet_to_json(worksheet, { raw: true });
                this.filelist = arraylist;
            };
        },
        async sendFileConfirm() {
            try {
                this.loadingTable = true;
                this.$store.commit("loader", true);
                const response = await API.productos.file({ data: this.filelist });
                this.GetRecords();

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            } finally {
                this.$store.commit("loader", false);
                this.loadingTable = false;
            }
        },

        margenGanancia(pc, pv){
            var margen = 100
            if (pc!=0){
                margen = (pv - pc) / pc * 100
            }
            margen = Number(margen).toFixed(2);

            return Math.round(margen*2)/2;
        }
    },
    watch: {
        dataTabOptions(event) {
            this.itemsPerPage = event.itemsPerPage;
            this.GetRecords(event.page, event.itemsPerPage);
        },
        viewDialog() {
            if (!this.viewDialog) {
                this.$refs.viewForm.reset();
            }
        }
    },
};
</script>