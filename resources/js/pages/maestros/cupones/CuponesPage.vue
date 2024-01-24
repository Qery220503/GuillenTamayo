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
                        label="Código de cupón"
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
                    <v-btn color="primary" class="mr-2" @click="GetRecords">
                        Filtrar <v-icon>mdi-filter</v-icon>
                    </v-btn>
                    <v-btn color="deep-orange" class="mr-2" @click="limpiarFiltros" dark>
                        Limpiar <v-icon>mdi-broom</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
        </v-card>
        <v-card class="mb-4" light style="padding: 15px">
            <v-row dense class="pa-2 align-center">
                <v-col v-if="$can('cupones_create', 'all')" class="text-right">
                    <v-btn color="primary" class="mr-2" @click="addDialog=true;">
                        Agregar Registro<v-icon>mdi-plus</v-icon>
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
                <template v-slot:[`item.tipo_descuento`]="{ item }">
                    <div v-if="item.tipo_descuento==1">S/.</div>
                    <div v-else>%</div>
                </template>
                <template v-slot:[`item.fecha_vencimiento`]="{ item }">
                    {{ item.fecha_vencimiento | formatDateGeneral }}
                </template>

                <template v-slot:[`item.status`]="{ item }">
                    <div v-if="$can('cupones_delete', 'all')">
                        <v-chip small v-if="item.status == 1" class="ma-2" color="success" @click.stop="DisEnableReg(item)" dark>Habilitado</v-chip>
                        <v-chip small v-if="item.status == 0" class="ma-2" color="error"   @click.stop="DisEnableReg(item)">Deshabilitado</v-chip>
                    </div>
                    <div v-else>
                        <v-chip small v-if="item.status == 1" class="ma-2" color="success" dark>Habilitado</v-chip>
                        <v-chip small v-if="item.status == 0" class="ma-2" color="error">Deshabilitado</v-chip>
                    </div>
                </template>
                <template v-slot:[`item.actions`]="{ item }">
                    <div v-if="$can('cupones_update', 'all')">
                        <v-btn small icon @click.stop="EditRec(item)">
                            <v-icon small> mdi-pencil</v-icon>
                        </v-btn>
                    </div>
                    
                    <div v-if="$can('cupones_delete', 'all')">
                        <v-btn small icon @click.stop="DeleteRec(item)">
                            <v-icon small> mdi-delete</v-icon>
                        </v-btn>
                    </div>
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

        <!-- Add/Edit Dialog -->
        <v-dialog v-model="addDialog" max-width="50%">
            <v-card>
                <v-card-title>
                    <span class="headline">{{dialogTitle}}</span>
                </v-card-title>
                <v-card-text>
                    <v-form ref="addForm"
                        v-model="validAddForm"
                        @submit.prevent="dialogEdit ? UpdateRec() : CreateRec()"
                        lazy-validation>
                        <v-row>
                            <v-col cols="12" sm="12" md="12">
                                <v-text-field
                                    label="Código Cupon"
                                    v-model="addForm.codigo_cupon"
                                    :rules="[rules.required]"
                                    autocomplete="off">
                                    <template v-slot:append>
                                        <v-btn
                                            @click="addForm.codigo_cupon = GenerateRandomCode(8);"
                                            color="primary"
                                            class="ma-0">
                                            <v-icon>mdi-cached</v-icon>
                                        </v-btn>
                                    </template>
                                </v-text-field>
                                <v-select label="Tipo Descuento" v-model="addForm.tipo_descuento"
                                    :items="tipos_desc"
                                ></v-select>
                                <v-text-field
                                    label="Descuento"
                                    v-model="addForm.descuento"
                                    type="number"
                                    placeholder="0,00"
                                    min="0"
                                    :rules="[rules.required]"
                                    autocomplete="off"
                                ></v-text-field>
                                <v-menu
                                    v-model="menuFechaVencimiento"
                                    :close-on-content-click="false"
                                    :nudge-right="40"
                                    transition="scale-transition"
                                    offset-y
                                    min-width="auto">
                                    <template v-slot:activator="{ on, attrs }">
                                        <v-text-field
                                            label="Fecha de Vencimiento"
                                            v-model="formatFechaVencimiento"
                                            prepend-icon="mdi-calendar"
                                            v-bind="attrs"
                                            v-on="on"
                                            readonly
                                        ></v-text-field>
                                    </template>
                                    <v-date-picker
                                        v-model="addForm.fecha_vencimiento"
                                        @input="menuFechaVencimiento=false"
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
                                    v-model="viewForm.codigo_cupon"
                                    label="Código Cupon"
                                    readonly
                                ></v-text-field>
                                <v-select label="Tipo Descuento" v-model="viewForm.tipo_descuento"
                                    :items="tipos_desc"
                                    readonly
                                ></v-select>
                                <v-text-field
                                    v-model="viewForm.descuento"
                                    label="Descuento"
                                    readonly
                                ></v-text-field>
                                <v-text-field
                                    v-model="viewForm.fecha_vencimiento"
                                    label="Fecha de Vencimiento"
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
    data() {
        return {
            breadcrumbs_title: "Cupones",
            breadcrumbs: [
                { text: "Inicio", disabled: false, href: "/dashboard" },
                { text: "Maestros", disabled: false, href: "#" },
                { text: "Cupones" }
            ],
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
                {text: 'Código Cupón', value: 'codigo_cupon', sortable: false},
                {text: 'Tipo Descuento', value: 'tipo_descuento', sortable: false, align: "center"},
                {text: 'Descuento', value: 'descuento', sortable: false, align: "center"},
                {text: 'Fecha V.', value: 'fecha_vencimiento', sortable: false},

                {text: 'Estado', value: 'status', sortable: false, align: "center"},
                {text: 'Acciones', value: 'actions', sortable: false, align: "center"},
            ],
            menuStartDate: false,
            menuEndDate: false,
            filter: {
                searchTerm: "",
                fechaInicio: "",
                fechaFin: "",
            },
            //--- End ---

            //--- Dialog Properties ---
            viewDialog: false,
            viewForm: {
            },
            
            addDialog: false,
            dialogEdit: false,
            dialogTitle: "Agregar Registro",
            validAddForm: false,
            addForm: {
                tipo_descuento: 1,
                fecha_vencimiento: null,
                codigo_cupon: null,
            },
            defaultAddForm: {
                tipo_descuento: 1,
                fecha_vencimiento: null,
                codigo_cupon: null,
            },
            menuFechaVencimiento: false,
            tipos_desc:[
                {value: 1, text: 'S/.'},
                {value: 2, text: '%'},
            ],
            //--- End ---

            rules:{
                required: UTILS.nRules.required,
            }
        }
    },
    mounted(){
        this.addForm.fecha_vencimiento = this.todaysDateDefault();
    },
    methods: {
        //--- Datatable ---
        async GetRecords(page = 1, perPage = 25, sortDesc = 0, sortBy = ""){
            this.loadingTable = true;
            this.dataReg = [];
            const myParams = new URLSearchParams(this.filter).toString();
            try {
                const response = await API.cupones.list("?page="+page +"&perPage="+perPage
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
            this.GetRecords();
        },
        handleDataRowClick(row){
            this.viewForm = Object.assign({}, row);
            this.viewDialog = true;
        },
        //--- End ---

        
        //--- CRUD Functions ---
        async CreateRec(){
            try{
                if(this.$refs.addForm.validate()){
                    this.$store.commit("LOADER", true);
                    this.loadingTable = true;

                    const response = await axios.post('api/cupones', this.addForm);
                    this.addDialog = false;
                    this.GetRecords();

                    UTILS.toastr.success(response.data.message, this);
                }

            }catch(e){
                console.error(e);
                UTILS.toastr.error("Advertencia! Ocurrió un error inesperado", this);

            }finally{
                this.$store.commit("LOADER", false);
                this.loadingTable = false
            }
        },
        EditRec(item) {
            this.dialogEdit = true;
            this.dialogTitle = "Editar Registro";
            
            this.addForm = Object.assign({}, item);

            this.addDialog = true;
        },
        async UpdateRec(){
            try{
                if(this.$refs.addForm.validate()){
                    this.$store.commit("LOADER", true);
                    this.loadingTable = true;

                    const response = await axios.put('api/cupones/'+this.addForm.id, this.addForm);
                    this.addDialog = false;
                    this.GetRecords();

                    UTILS.toastr.success(response.data.message, this);
                }

            }catch(e){
                console.error(e);
                UTILS.toastr.error("Advertencia! Ocurrió un error inesperado", this);

            }finally{
                this.$store.commit("LOADER", false);
                this.loadingTable = false
            }
        },
        DisEnableReg(item){
            this.loadingTable = true;
            if(item.status != 0){
                var title ='Deshabilitar Registro';
                var text = "¿Está seguro que desea deshabilitar este registro?";
                var swal_title = 'Deshabilitado!';
                var swal_text = 'El registro ha sido deshabilitado.';
                
            }else{
                var title ='Habilitar Registro';
                var text = "¿Está seguro que desea habilitar este registro?";
                var swal_title = 'Habilitado!';
                var swal_text = 'El registro ha sido habilitado.';
            }
            this.$swal.fire({
                title: title,
                text: text,
                icon: 'info',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Confirmar',
                cancelButtonText: 'Cancelar',

            }).then((result) => {
                if (result.isConfirmed) {
                    item.status = item.status != 1? 1 : 0;
                    axios.put('api/cupones/'+item.id, item).then((response) => {;
                        this.$swal.fire(
                            swal_title,
                            swal_text,
                            'success'
                        );
                        
                    }).catch(e => {
                        console.error(e);
                        UTILS.toastr.error("Advertencia! Ocurrió un error inesperado", this);

                    }).finally(()=>(this.loadingTable = false));
                }
            });
        },
        DeleteRec(item){
            this.loadingTable = true;
            this.$swal.fire({
                title: "Eliminar Registro",
                text: "¿Está seguro que desea eliminar este registro?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Confirmar',
                cancelButtonText: 'Cancelar',
                
            }).then((result) => {
                if (result.isConfirmed) {
                    axios.delete('api/cupones/'+item.id).then((response)=>{
                        this.$swal.fire(
                            "Eliminado!",
                            "El registro ha sido eliminado.",
                            'success'
                        );
                        this.GetRecords();
                        
                    }).catch(e => {
                        console.error(e);
                        UTILS.toastr.error("Advertencia! Ocurrió un error inesperado", this);
                        
                    }).finally(()=>(this.loadingTable = false));
                }
            });
        },
        //--- End ---

        //--- Additional Functions ---
        GenerateRandomCode(length){
            let result = '';
            const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
            const charactersLength = characters.length;
            for (let i = 0; i < length; i++) {
                result += characters.charAt(Math.floor(Math.random() * charactersLength));
            }
            
            return result;
        },  
        //--- End ---
    },
    computed: {
        randomCode:{
            get: function () {
                return this.formatDate(this.filter.fechaInicio)
            },
            set: function (newValue) {
                return this.formatDate(newValue);
            }
        },

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

        formatFechaVencimiento: {
            get: function () {
                return this.formatDate(this.addForm.fecha_vencimiento)
            },
            set: function (newValue) {
                return this.formatDate(newValue);
            }
        },
    },
    watch: {
        dataTabOptions(event) {
            this.itemsPerPage = event.itemsPerPage;
            this.GetRecords(event.page, event.itemsPerPage);
        },
        
        addDialog(){
            if(!this.addDialog){
                this.$refs.addForm.resetValidation();
                this.validAddForm = false;
                this.addForm = Object.assign({}, this.defaultAddForm);
                this.addForm.fecha_vencimiento = this.todaysDateDefault();
            }
        },
        viewDialog() {
            if (!this.viewDialog) {
                this.$refs.viewForm.reset();
            }
        }
    },
}
</script>