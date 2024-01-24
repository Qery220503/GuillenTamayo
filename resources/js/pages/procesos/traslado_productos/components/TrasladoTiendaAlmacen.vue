<template>
    <div> 
        <v-row dense class="pa-2 align-center">
            <v-col v-if="$can('traslados_create', 'all')" class="text-right">
                <v-btn color="primary" class="mr-2" @click="addDialog=true;">
                    Traslado Tienda/Almacén<v-icon>mdi-swap-horizontal</v-icon>
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
            <template v-slot:[`item.ubicacion_origen`]="{ item }">
                <template v-if="item.ubicacion_origen === 1">Almacén</template>
                <template v-if="item.ubicacion_origen === 2">Tienda</template>
            </template>
            <template v-slot:[`item.ubicacion_destino`]="{ item }">
                <template v-if="item.ubicacion_destino === 1">Almacén</template>
                <template v-if="item.ubicacion_destino === 2">Tienda</template>
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
                                <v-text-field label="Sucursal" v-model="addForm.nombre_sucursal"
                                    readonly
                                ></v-text-field>
                                <v-autocomplete label="Producto" v-model="addForm.producto"
                                    :items="items_productos"
                                    :item-text="ProductItemText"
                                    :rules="[rules.required]"

                                    :search-input.sync="searchProduct"
                                    v-on:change="setUbicacionStock(addForm.switch_ubicacion)"
                                    :loading="isLoadingProduct"
                                    return-object
                                    clearable
                                    hide-no-data>
                                ></v-autocomplete>
                                <v-switch :label="labelSwitchUbicacion" v-model="addForm.switch_ubicacion"></v-switch>
                                <v-text-field label="Stock en Sucursal" v-model="addForm.stock_sucursal"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                    disabled
                                ></v-text-field>
                                <v-text-field label="Stock en Ubicación" v-model="addForm.stock_ubicacion"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                    disabled
                                ></v-text-field>
                                <v-text-field label="Cantidad Traslado" v-model="addForm.cantidad"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                    :max="addForm.stock_ubicacion"
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
                                <v-text-field
                                    v-model="viewForm.ubicacion_origen"
                                    label="Ubicación Origen"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.ubicacion_destino"
                                    label="Ubicación Destino"
                                    readonly
                                ></v-text-field>
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
                {text: 'Ubicación Origen', value: 'ubicacion_origen', sortable: false},
                {text: 'Ubicación Destino', value: 'ubicacion_destino', sortable: false, align: "center"},
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
            labelSwitchUbicacion: "Almacén -> Tienda",
            addForm:{
                producto: {},
                nombre_sucursal: "",
                id_sucursal: "",
                switch_ubicacion: true,
                stock_ubicacion: "",
            },
            defaultAddForm:{
                producto: {},
                nombre_sucursal: "",
                id_sucursal: "",
                switch_ubicacion: true,
                stock_ubicacion: "",
            },
            items_productos:[],
            searchProduct: null,
            isLoadingProduct: false,
            menuFechaTraslado: false,

            rules:{
                required: UTILS.nRules.required,
            },
        }
    },
    mounted(){
        this.getUserSucursal();
        this.addForm.fecha_traslado = this.todaysDateDefault();
    },
    methods:{
        //--- Datatable ---
        async GetRecords(page = 1, perPage = 25, sortDesc = 0, sortBy = ""){
            this.loadingTable = true;
            this.dataReg = [];
            const myParams = new URLSearchParams(this.searchTerm, this.fechaInicio, this.fechaFin).toString();
            try {
                const response = await axios.get("api/traslado-productos/indexTrasladoUbicacion?page="+page +"&perPage="+perPage
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
            this.viewForm.ubicacion_origen = row.ubicacion_origen === 1? "Almacén" : "Tienda";
            this.viewForm.ubicacion_destino = row.ubicacion_destino === 1? "Almacén" : "Tienda";
            this.viewDialog = true;
        },
        //--- End ---

        //--- CRUD Functions ---
        async CreateRec(){
            try{
                if(this.$refs.addForm.validate()){
                    this.loadingTable = true;

                    const response = await axios.post('api/traslado-productos/storeTrasladoUbicacion', this.addForm);
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
        setUbicacionStock(switch_ubicacion){
            // Asignamos la ubicacion de origen
            let ubicacionOrigen;
            if(switch_ubicacion){
                this.labelSwitchUbicacion = "Almacén -> Tienda";
                ubicacionOrigen = 1;

            }else{
                this.labelSwitchUbicacion = "Tienda -> Almacén";
                ubicacionOrigen = 2;
            }

            this.addForm.cantidad = "";
            this.addForm.stock_ubicacion = "";
            this.$refs.addForm.resetValidation();

            if(this.addForm.producto.stock_sucursal){
                // Filtramos el stock de producto por sucursal y ubicacion
                let stockSucursal = this.addForm.producto.stock_sucursal.filter((obj) => this.addForm.id_sucursal == obj.id_sucursal);
                let stockUbicacion = stockSucursal.filter((obj) => ubicacionOrigen == obj.ubicacion);
                
                let sumStockSucursal = stockSucursal.reduce((accumulator, value) => {
                    return accumulator + value.stock;
                }, 0);
                this.addForm.stock_sucursal = stockSucursal.length > 0 ? sumStockSucursal : 0;
                this.addForm.stock_ubicacion = stockUbicacion.length > 0 ? stockUbicacion[0].stock : 0;
            }
        },
        //--- End ---
        
        //--- Loading Data ---
        getUserSucursal(){
            let authUser = JSON.parse(localStorage.getItem('user_data'));
            this.addForm.id_sucursal = authUser.sucursal.id_sucursal;
            this.addForm.nombre_sucursal = authUser.sucursal.nombre_sucursal;
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
                this.getUserSucursal();
                this.items_productos = [];
            }
        },
        viewDialog() {
            if (!this.viewDialog) {
                this.$refs.viewForm.reset();
            }
        },

        "addForm.switch_ubicacion"(val){
            this.setUbicacionStock(val);
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
    }
}
</script>