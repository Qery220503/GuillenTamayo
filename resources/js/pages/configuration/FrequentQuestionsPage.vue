<template>
    <div class="flex-grow-1">
        <custom-breadcrumbs
            :breadcrumbs_title="breadcrumbs_title"
            :breadcrumbs="breadcrumbs"
        ></custom-breadcrumbs>
        <v-card>
            <v-row dense class="pa-2 align-center">
                <v-col cols="4">
                    <v-text-field
                        v-model="filter.searchTerm"
                        append-icon="mdi-magnify"
                        class="flex-grow-1 mr-1"
                        hide-details
                        dense
                        light
                        solo
                        placeholder="Buscar por nombre..."
                        @keyup.enter.prevent="getRegistros()"
                    ></v-text-field>
                </v-col>
                <v-col>
                    <v-btn class="mr-2" color="deep-orange" dark @click="limpiarFiltros">
                        <v-icon>mdi-broom</v-icon> Limpiar Filtros
                    </v-btn>
                </v-col>
                <v-col class="text-right">
                    <v-btn color="primary" class="mr-2" @click="addDialog=true;">
                        Añadir Preguntas Frecuentes <v-icon>mdi-plus</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
            <v-row dense class="pa-2 align-center">
                <v-data-table
                    light
                    :headers="headers"
                    :items="data_reg.data"
                    :page="current_page"
                    :items-per-page="itemsperpage"
                    :server-items-length="total_reg"
                    :options.sync="dataTabOptions"
                    class="flex-grow-1 scroll-me"
                    :footer-props="{
                        itemsPerPageOptions: [25,50,100,1000],
                    }"
                    :loading="loadingTable" loading-text="Cargando... Por favor, espere">
                    <template v-slot:[`item.active`]="{ item }">
                        <v-chip small v-if="item.active == 1" class="ma-2" color="success" @click="disenableReg(item)">Habilitado</v-chip>
                        <v-chip small v-if="item.active == 0" class="ma-2" color="error"   @click="disenableReg(item)">Deshabilitado</v-chip>
                    </template>
                    <template v-slot:[`item.actions`]="{ item }">
                        <v-btn small icon @click="editReg(item)">
                            <v-icon small>mdi-border-color</v-icon>
                        </v-btn>
                        <v-btn small icon @click="deleteReg(item)">
                            <v-icon small>mdi-delete</v-icon>
                        </v-btn>
                    </template>
                </v-data-table>
            </v-row>
        </v-card>

        <!-- Add/Edit Dialog -->
        <v-dialog v-model="addDialog" max-width="60%" persistent>
            <v-card>
                <v-card-title>
                    <span class="headline">{{addFormTitle}}</span>
                </v-card-title>
                <v-card-text>
                    <v-form ref="addForm" v-model="validAddForm" @submit.prevent="saveReg()" lazy-validation>
                        <v-row>
                            <v-col>
                                <v-text-field v-model="addForm.question" label="Pregunta" :rules="rules.required" autocomplete="off"></v-text-field>
                                <v-textarea v-model="addForm.answer" label="Respuesta" :rules="rules.required" autocomplete="off"></v-textarea>
                            </v-col>
                        </v-row>
                        <br>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="error" text @click="addDialog = false">Cancelar</v-btn>
                            <v-btn type="submit" color="primary" :disabled="!validAddForm"> Guardar </v-btn>
                        </v-card-actions>
                    </v-form>
                </v-card-text>
            </v-card>
        </v-dialog>
        <!-- Fin -->

        <!-- Delete Dialog -->
        <v-dialog v-model="deleteDialog" max-width="60%">
            <v-card>
                <v-card-title>
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
import axios from "axios";

export default {
    components:{
        axios,
    },
    data: () => ({
        breadcrumbs_title: "Preguntas Frecuentes",
        breadcrumbs: [{
            text: "Configuración",
            disabled: false,
            href: "#",
        }, {
            text: "Preguntas Frecuentes",
        },],

        //--- Datatable ---
        loadingTable: false,
        current_page: 1,
        itemsperpage: 25,
        total_reg: 0,
        dataTabOptions: {},
        data_reg: [],
        headers: [
            {text: "Pregunta", value: "question", align: "left"},
            {text: "Respuesta", value: "answer", align: "left"},
            {text: 'Activo', value: 'active', sortable: false, align:'center'},
            {text: "Acciones", sortable: false, value: "actions", align: "right"},
        ],
        filter: {
            searchTerm: '',
        },
        //--- End ---

        //--- Ventana Emergente ---
        addDialog: false,
        dialogEditar: false,
        validAddForm: false,
        addFormTitle: "Agregar Preguntas Frecuentes",
        addForm: {
            id: '',
            name: '',
            img_file: null,
        },
        deleteDialog: false,
        //--- End ---

        //--- Form Rules ---
        rules: {
            required: UTILS.rules.required,
            file_size_200kb: UTILS.rules.file_size_200kb,
        },
        //--- End ---
    }),
    methods:{
        //--- Datatable ---
        async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = '',){
            this.loadingTable = true;
            this.data_reg = [];

            try{
                const response = await API.frequentquestions.list('?page='+page+'&itemsPerPage='+per_page+'&sortDesc='+sortDesc+'&sortBy='+sortBy+'&searchTerm='+this.filter.searchTerm);
                this.data_reg     = response.data;
                this.current_page = response.data.current_page;
                this.total_reg    = this.data_reg.total;
                this.loadingTable = false;

            } catch(e){
                this.loadingTable = false;
                console.error(e);
            }
        },
        limpiarFiltros(){
            this.filter.searchTerm = '';
            this.getRegistros();
        },
        //--- End ---

        //--- Ventana Emergente ---
        // Add/Edit/Delete Functions
        editReg(item) {
            this.addFormTitle = "Editar Preguntas Frecuentes";
            this.dialogEditar = true;
            this.addForm = Object.assign({}, item);
            this.addDialog = true;
        },
        async saveReg(){
            if(this.$refs.addForm.validate()){
                try {
                    this.loadingTable = true;
                    this.$store.commit('loader',true);

                    if(this.dialogEditar == false){
                        const response = await API.frequentquestions.create(this.addForm);
                        UTILS.toastr.success("Preguntas Frecuentes creado correctamente", this);
                    }else{
                        const response = await API.frequentquestions.update(this.addForm.id, this.addForm);
                        UTILS.toastr.success("Preguntas Frecuentes actualizado correctamente", this);
                    }
                    setTimeout(()=>{
                        this.getRegistros();
                        this.addDialog = false;
                    }, 2000);

                } catch (e) {
                    UTILS.toastr.error("Ups! Ocurrió un error", this);
                    console.error(e);

                } finally {
                    this.$store.commit('loader', false);
                    this.loadingTable = false;
                }
            }

        },
        async disenableReg(item){
            if(item.active != 1){
                item.active = 1;
                var msg = "habilitado";
            }else{
                item.active = 0;
                var msg = "deshabilitado";
            }
            const response = await API.frequentquestions.update(item.id, item);
            UTILS.toastr.success("El registro ha sido "+ msg, this);
        },

        deleteReg(item){
            this.addForm = Object.assign({}, item)
            this.deleteDialog = true;
        },
        async deleteRegConfirm () {
            this.loadingTable = true;
            this.$store.commit('loader',true);

            try {
                const response = await API.frequentquestions.remove(this.addForm.id);
                UTILS.toastr.success("Preguntas Frecuentes eliminado correctamente", this);
                this.deleteDialog = false;
                this.getRegistros();

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);

            } finally {
                this.$store.commit('loader', false);
                this.loadingTable = false;
            }
        },
        //--- End ---

    },
    watch: {
        dataTabOptions(event) {
            this.itemsperpage = event.itemsPerPage;
            this.getRegistros(event.page, event.itemsPerPage, event.sortDesc, event.sortBy[0]);
        },
        addDialog(){
            if(!this.addDialog){
                // console.log('Dialog is closing');
                this.dialogEditar = false;
                this.$refs.addForm.reset();
                this.validAddForm = false;
                this.addFormTitle = "Agregar Preguntas Frecuentes";
            }
        },
    },
}
</script>
