<template>
    <div>
        <v-row dense class="pa-2 align-center">
            <v-col v-if="$can('traslados_create', 'all')" class="text-right">
                <v-btn color="primary" class="mr-2" @click="addDialog=true;">
                    Traslado Sucursal<v-icon>mdi-swap-horizontal</v-icon>
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
            <template slot="no-data">
                Aún no se han agregado registros.
            </template>
            <template #[`item.index`]="{ item }">
                {{ dataReg.data.indexOf(item) + 1 }}
            </template>
            <template v-slot:[`item.fecha_traslado`]="{ item }">
                {{ item.fecha_traslado | formatDateGeneral }}
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

        <!-- Add/Edit Dialog -->
        <v-dialog v-model="addDialog" max-width="50%">
            <v-card>
                <v-card-title>
                    <span class="headline">Realizar Traslado</span>
                </v-card-title>
                <v-card-text>
                    <v-form ref="addForm"
                        v-model="validAddForm"
                        @submit.prevent="CreateRec()"
                        lazy-validation>
                        <v-row dense class="pa-2">
                            <v-col cols="12" sm="12" md="12">
                                <v-select label="Sucursal Origen" v-model="addForm.id_sucursal_origen"
                                    :items="items_sucursalesO"
                                    item-text="nombre_sucursal"
                                    item-value="id_sucursal"

                                    v-on:change="sucursalOrigenChanged()"
                                ></v-select>
                                <v-select label="Sucursal Destino" v-model="addForm.id_sucursal_destino"
                                    :items="items_sucursalesD"
                                    item-text="nombre_sucursal"
                                    item-value="id_sucursal"
                                    :disabled="!addForm.id_sucursal_origen"
                                ></v-select>
                                <v-autocomplete label="Producto" v-model="addForm.producto"
                                    :items="items_productos"
                                    :item-text="ProductItemText"
                                    :rules="[rules.required]"
                                    :disabled="!addForm.id_sucursal_origen"

                                    :search-input.sync="searchProduct"
                                    v-on:change="handleSubmitProduct(addForm.id_sucursal_origen)"
                                    :loading="isLoadingProduct"
                                    return-object
                                    clearable
                                    hide-no-data>
                                ></v-autocomplete>
                                <v-text-field label="Stock en Sucursal (Almacén)" v-model="addForm.stock_almacen"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                    disabled
                                ></v-text-field>
                                <v-text-field label="Cantidad Traslado" v-model="addForm.cantidad"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                    :max="addForm.stock_almacen"
                                    :rules="[rules.required]"
                                    :disabled="!addForm.producto.id_producto"
                                    autocomplete="off"
                                ></v-text-field>
                                <v-menu
                                    v-model="menuFechaTraslado"
                                    :close-on-content-click="false"
                                    :nudge-right="40"
                                    transition="scale-transition"
                                    offset-y
                                    min-width="auto">
                                    <template v-slot:activator="{ on, attrs }">
                                        <v-text-field
                                            label="Fecha de Traslado"
                                            v-model="formatFechaTraslado"
                                            prepend-icon="mdi-calendar"
                                            v-bind="attrs"
                                            v-on="on"
                                            readonly
                                        ></v-text-field>
                                    </template>
                                    <v-date-picker
                                        v-model="addForm.fecha_traslado"
                                        @input="menuFechaTraslado=false"
                                        :min="todaysDateDefault()"
                                        locale="es-ES"
                                        no-title
                                    ></v-date-picker>
                                </v-menu>
                            </v-col>
                        </v-row>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="error" text @click="addDialog = false">Cancelar</v-btn>
                            <v-btn type="submit" color="primary" :disabled="!validAddForm">Guardar</v-btn>
                        </v-card-actions>
                    </v-form>
                </v-card-text>
            </v-card>
        </v-dialog>
        <!-- End -->
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
                                <v-select label="Sucursal Origen" v-model="viewForm.id_sucursal_origen"
                                    :items="items_sucursalesO"
                                    item-text="nombre_sucursal"
                                    item-value="id_sucursal"
                                    readonly
                                ></v-select>
                                <v-select label="Sucursal Destino" v-model="viewForm.id_sucursal_destino"
                                    :items="items_sucursalesO"
                                    item-text="nombre_sucursal"
                                    item-value="id_sucursal"
                                    readonly
                                ></v-select>
                                <v-text-field
                                    v-model="viewForm.nombre_producto"
                                    label="Producto"
                                    readonly
                                ></v-text-field>
                                <v-text-field label="Cantidad Traslado" v-model="viewForm.cantidad"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.fecha_traslado"
                                    label="Fecha de Traslado"
                                    readonly
                                ></v-text-field>
                            </v-col>
                        </v-row>
                    </v-form>
                </v-card-text>
            </v-card>
        </v-dialog>
        <!-- End -->
    </div>
</template>

<script>
export default {
    props: {
        searchTerm: String,
        fechaInicio: String,
        fechaFin: String,
    },
    data() {
        return {
            //--- Datatable ---
            loadingTable: false,
            currentPage: 1,
            pageCount: 1,
            itemsPerPage: 25,
            totalReg: 0,
            dataTabOptions: {},
            dataReg: {},
            tableHeaders: [
                {text: '', value: 'select'},
                {text: 'Nº', value: 'index',  sortable: false},
                {text: 'Sucursal Origen', value: 'sucursal_origen.nombre_sucursal', sortable: false},
                {text: 'Sucursal Destino', value: 'sucursal_destino.nombre_sucursal', sortable: false, align: "center"},
                {text: 'Producto', value: 'producto.nombre_producto', sortable: false},
                {text: 'Cantidad', value: 'cantidad', sortable: false},
                {text: 'Fecha Traslado', value: 'fecha_traslado', sortable: false, align: "center"},
            ],
            //--- End ---

            //--- Dialog Properties ---
            viewDialog: false,
            viewForm: {
            },
            
            addDialog: false,
            validAddForm: false,
            addForm: {
                producto: {},
                fecha_traslado: null,
            },
            defaultAddForm: {
                producto: {},
                fecha_traslado: null,
            },
            items_productos:[],
            searchProduct: null,
            isLoadingProduct: false,

            items_sucursalesO:[],
            items_sucursalesD:[],
            items_sucursalesBK:[], //backup

            menuFechaTraslado: false,
            //--- End ---

            rules:{
                required: UTILS.nRules.required,
            },
        }
    },
    mounted(){
        this.getSucursalesOrigen();
        this.addForm.fecha_traslado = this.todaysDateDefault();
    },
    methods:{
        //--- Datatable ---
        async GetRecords(page = 1, perPage = 25, sortDesc = 0, sortBy = ""){
            this.loadingTable = true;
            this.dataReg = [];
            const myParams = new URLSearchParams(this.searchTerm, this.fechaInicio, this.fechaFin).toString();
            try {
                const response = await axios.get("api/traslado-productos/indexTrasladoSucursal?page="+page +"&perPage="+perPage
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
        handleDataRowClick(row){
            this.viewForm = Object.assign({}, row);
            this.viewForm.nombre_producto = row.producto.nombre_producto;
            this.viewDialog = true;
        },
        //--- End ---

        
        //--- CRUD Functions ---
        async CreateRec(){
            try{
                if(this.$refs.addForm.validate()){
                    this.loadingTable = true;

                    const response = await axios.post('api/traslado-productos/storeTrasladoSucursal', this.addForm);
                    this.addDialog = false;
                    this.GetRecords();

                    UTILS.toastr.success(response.data.message, this);
                }

            }catch(e){
                console.error(e);
                UTILS.toastr.error("Advertencia! Ocurrió un error inesperado", this);

            }finally{
                this.loadingTable = false
            }
        },

        ProductItemText(item){
            return `${item.nombre_producto} | ${item.codigo_varilla}`;
        },
        handleSubmitProduct(id_sucursal){
            let stockSucursal = this.addForm.producto.stock_sucursal.filter((obj) => id_sucursal == obj.id_sucursal);
            let stockAlmacen = stockSucursal.filter((obj) => 1 == obj.ubicacion);
            
            this.addForm.stock_almacen = stockAlmacen.length > 0 ? stockAlmacen[0].stock : 0;
        },
        //--- End ---

        
        //--- Loading Data ---
        async getSucursalesOrigen(){
            try{
                const response = await API.sucursales.combo();
                this.items_sucursalesO = response.data.filter((obj) => obj.codigo_sucursal !== 'I' ||
                                        obj.nombre_sucursal !== "GAFITAS");
                 
                this.items_sucursalesBK = response.data.filter((obj) => obj.codigo_sucursal !== 'I' ||
                                        obj.nombre_sucursal !== "GAFITAS");

            } catch (e) {
                console.error(e);
            }
        },
        sucursalOrigenChanged(){
            this.items_sucursalesD = this.items_sucursalesBK.filter((obj) => obj.id_sucursal !== this.addForm.id_sucursal_origen);
            this.addForm.producto = {};
            this.addForm.stock_almacen = "";
            this.addForm.cantidad = "";
            this.$refs.addForm.resetValidation();
        },
        //--- End ---
    },
    watch:{
        dataTabOptions(event) {
            this.itemsPerPage = event.itemsPerPage;
            this.GetRecords(event.page, event.itemsPerPage);
        },

        addDialog(){
            if(!this.addDialog){
                this.$refs.addForm.resetValidation();
                this.validAddForm = false;

                this.addForm = Object.assign({}, this.defaultAddForm);
                this.addForm.fecha_traslado = this.todaysDateDefault();
                this.items_productos = [];
            }
        },
        viewDialog() {
            if (!this.viewDialog) {
                this.$refs.viewForm.reset();
            }
        },
        
        searchProduct(val){
            if(val != null){
                if (val.length < 3) return;
                
                this.isLoadingProduct = true
                fetch("/api/list/productos")
                    .then(res => res.json())
                    .then(res => {
                        this.items_productos = res;
                    })
                    .catch(e => {
                        console.error(e);

                    }).finally(() => (this.isLoadingProduct = false));
            }
        },
    },
    computed:{
        formatFechaTraslado: {
            get: function () {
                return this.formatDate(this.addForm.fecha_traslado)
            },
            set: function (newValue) {
                return this.formatDate(newValue);
            }
        },
    },
}
</script>