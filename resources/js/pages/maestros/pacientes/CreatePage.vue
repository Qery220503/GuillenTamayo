<template>
    <div class="d-flex flex-column flex-grow-1">
        <custom-breadcrumbs
            :breadcrumbs_title="breadcrumbs_title"
            :breadcrumbs="breadcrumbs"
        ></custom-breadcrumbs>

        <v-tabs v-model="tab" color="primary" background-color="transparent">
            <v-tab>Información</v-tab>
        </v-tabs>

        <v-tabs-items class="mt-3" v-model="tab">
            <v-tab-item>
                <v-card class="px-5 py-2">
                    <v-card-title>
                        <span class="headline">Crear Paciente</span>
                    </v-card-title>
                    <v-card-text>
                        <v-form
                            ref="addForm"
                            v-model="validAddForm"
                            @submit.prevent="saveReg()"
                            lazy-validation>
                            <v-row class="mt-2">
                                <v-col class="py-1 px-1" cols="12" md="3">
                                    <v-select label="Tipo Documento" v-model="addForm.cod_tipo_doc"
                                        :items="items_tipo_doc"
                                        item-text="nombre_tipo_documento"
                                        item-value="id_tipo_documento"
                                        @change="TipoDocChanged(addForm.cod_tipo_doc)"
                                        filled
                                        dense
                                    ></v-select>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12" md="3">
                                    <v-text-field
                                        :label="nrodoc_label"
                                        v-model="addForm.nro_documento"
                                        :rules="requiredDocRules"
                                        autocomplete="off"
                                        filled
                                        dense>
                                        <template #append-outer>
                                            <v-btn
                                                color="primary"
                                                class="mb-1"
                                                @click="obtenerDataDocumentos()">
                                                <v-icon>mdi-magnify</v-icon>
                                            </v-btn>
                                        </template>
                                    </v-text-field>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12" md="3">
                                    <v-text-field
                                        v-model="addForm.nombre_razon_social"
                                        label="Nombre"
                                        :rules="[rules.required]"
                                        filled
                                        dense
                                        autocomplete="off"
                                    ></v-text-field>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12" md="3">
                                    <v-menu
                                        v-model="menu2"
                                        :close-on-content-click="false"
                                        transition="scale-transition"
                                        offset-y
                                        min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field
                                                v-model="addForm.fecha_nacimiento"
                                                label="Fecha Nacimiento"
                                                prepend-inner-icon="mdi-calendar"
                                                v-bind="attrs"
                                                v-on="on"
                                                :rules="[rules.required]"
                                                dense
                                                filled
                                            ></v-text-field>
                                        </template>
                                        <v-date-picker
                                            v-model="addForm.fecha_nacimiento"
                                            @input="menu2 = false"
                                            no-title
                                        ></v-date-picker>
                                    </v-menu>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12" md="3">
                                    <v-text-field
                                        v-model="addForm.telefono"
                                        label="Teléfono Principal"
                                        :rules="[rules.phone]"
                                        autocomplete="off"
                                        maxlength="9"
                                        minLength="9"
                                        filled
                                        dense
                                    ></v-text-field>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12" md="3">
                                    <v-text-field
                                        v-model="addForm.email"
                                        label="Correo Electrónico"
                                        :rules="[rules.email, rules.required]"
                                        autocomplete="off"
                                        type="email"
                                        filled
                                        dense
                                    ></v-text-field>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12" md="3">
                                    <v-select
                                        :items="items_ocupacion"
                                        label="Ocupación/Trabajo"
                                        placeholder="Selecciona una ocupación"
                                        v-model="addForm.id_ocupacion"
                                        item-text="nombre_ocupacion"
                                        item-value="id_ocupacion"
                                        filled
                                        dense
                                    ></v-select>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12" md="3">
                                    <v-select
                                        :items="items_departamento"
                                        label="Departamento"
                                        placeholder="Selecciona un departamento"
                                        v-model="addForm.id_departamento"
                                        required
                                        item-text="nombre_departamento"
                                        item-value="id_departamento"
                                        filled
                                        dense
                                    ></v-select>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12" md="3">
                                    <v-select
                                        :items="items_provincia"
                                        label="Provincia"
                                        placeholder="Selecciona una provincia"
                                        v-model="addForm.id_provincia"
                                        item-text="nombre_provincia"
                                        item-value="id_provincia"
                                        filled
                                        dense
                                    ></v-select>
                                </v-col>
                                <v-col class="py-1 px-1" cols="6" md="3">
                                    <v-select
                                        :items="items_distrito"
                                        label="Distrito"
                                        placeholder="Selecciona un distrito"
                                        v-model="addForm.id_distrito"
                                        item-text="nombre_distrito"
                                        item-value="id_distrito"
                                        filled
                                        dense
                                    ></v-select>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12">
                                    <v-text-field
                                        v-model="addForm.direccion"
                                        label="Dirección"
                                        :rules="[rules.required]"
                                        autocomplete="off"
                                        filled
                                        dense
                                    ></v-text-field>
                                </v-col>
                                <v-col class="py-1 px-1" cols="12">
                                    <v-radio-group v-model="addForm.lista_negra" row>
                                        <template v-slot:label>
                                            <div>¿Paciente en Lista Negra?</div>
                                        </template>
                                        <v-radio label="Si" :value="1"></v-radio>
                                        <v-radio label="No" :value="0"></v-radio>
                                    </v-radio-group>
                                </v-col>
                            </v-row>

                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn color="error" text to="/pacientes">Cancelar</v-btn>
                                <v-btn type="submit" color="primary" :disabled="!validAddForm">Guardar</v-btn>
                            </v-card-actions>
                        </v-form>
                    </v-card-text>
                </v-card>
            </v-tab-item>
        </v-tabs-items>
    </div>
</template>
<script>
import API from "../../../api";

export default {
    data() {
        return {
            breadcrumbs_title: "Pacientes",
            breadcrumbs: [
                { text: "Inicio", disabled: false, href: "/dashboard" },
                { text: "Maestros", disabled: false, href: "#" },
                { text: "Pacientes", disabled: false, href: "/pacientes" },
                { text: "Crear Pacientes" }
            ],
            requiredRules: [v => !!v || "Campo obligatorio"],
            isEdit: false,
            items_tipo_doc: [],
            items_ocupacion: [],
            items_departamento: [],
            items_provincia: [],
            items_distrito: [],
            validAddForm: false,
            addForm: {
                cod_tipo_doc: 1,
                nombre_razon_social: null,
                nro_documento: '',
                direccion: null,
                id_departamento: 4,
                id_provincia: 401,
                id_distrito: 40101,
                lista_negra: 0
            },
            nrodoc_label: "Nro. DNI",
            requiredDocRules: [
                v => !!v || 'Campo obligatorio',
                (v) => (v && v.length == 8) || "DNI debe tener 8 cifras",
            ],
            datosBus: {
                tipoDoc: null,
                numDoc: null
            },
            tab: null,

            rules: {
                required: UTILS.nRules.required,
                only_numbers: UTILS.nRules.only_numbers,
                email: UTILS.nRules.email,
                phone: UTILS.rules.phoneNumberOptional,
            },
            menu2: false
        };
    },
    created() {
        let vm = this;
        vm.getTiposDoc();
        vm.getOcupacion();
        vm.getDepartamento();
        vm.getProvincia(4);
        vm.getDistrito(401);
    },
    methods: {
        async saveReg() {
            if (this.$refs.addForm.validate()) {
                try {
                    this.$store.commit("loader", true);
                    const response = await API.clientes.create(this.addForm);
                    UTILS.toastr.success("Paciente creado correctamente", this);
                    this.$router.push("/pacientes");

                } catch (e) {
                    UTILS.toastr.error("Ups! Ocurrió un error", this);
                    console.error(e);

                } finally {
                    this.$store.commit("loader", false);
                    this.loadingTable = false;
                }
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
        async getOcupacion() {
            let vm = this;
            try {
                const response = await API.clientes.ocupacion();
                vm.items_ocupacion = response.data;
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },

        async getDepartamento() {
            let vm = this;
            try {
                const response = await API.ubigeo.departamentos();
                vm.items_departamento = response.data;
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async getProvincia(id_departamento) {
            let vm = this;
            try {
                const response = await API.ubigeo.provincias(id_departamento);
                vm.items_provincia = response.data;
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async getDistrito(id_provincia) {
            let vm = this;
            try {
                const response = await API.ubigeo.distritos(id_provincia);
                vm.items_distrito = response.data;
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async obtenerDataDocumentos() {
            try {
                this.$store.commit("loader", true);
                this.datosBus.tipoDoc = this.addForm.cod_tipo_doc;
                this.datosBus.numDoc = this.addForm.nro_documento;
                const rpta = await API.apis.dniruc(this.datosBus);
                if (rpta.data.success === true) {
                    if (this.datosBus.tipoDoc === 2) {
                        this.addForm.nombre_razon_social = rpta.data.nombre_o_razon_social;
                        this.addForm.direccion = rpta.data.direccion_completa;
                        if(rpta.data.estado == "ACTIVO" && rpta.data.condicion == "HABIDO"){
                            UTILS.toastr.success("El documento ingresado se encuentra ACTIVO y HABIDO", this);
                        }else{
                            UTILS.toastr.info("Cuidado, el documento ingresado se encuentra " + rpta.data.estado + " y " + rpta.data.condicion, this);
                        }
                        this.$store.commit("loader", false);

                    } else if (this.datosBus.tipoDoc === 1) {
                        this.addForm.nombre_razon_social =
                        rpta.data.result.Nombres + " " + rpta.data.result.Apellidos;
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

        
        TipoDocChanged(tipo_doc){
            this.addForm.nro_documento = null;

            switch (tipo_doc) {
                case 1:
                    this.nrodoc_label = "Nro. DNI";
                    this.requiredDocRules = [
                        v => !!v || 'Campo obligatorio',
                        (v) => (v && v.length == 8) || "DNI debe tener 8 cifras",
                    ];
                    break;

                case 2:
                    this.nrodoc_label = "Nro. RUC";
                    this.requiredDocRules = [
                        v => !!v || 'Campo obligatorio',
                        (v) => (v && v.length == 11) || "RUC debe tener 11 cifras",
                    ];
                    break;

                default:
                    this.nrodoc_label = "Nro. Documento";
                    this.requiredDocRules = [
                        v => !!v || 'Campo obligatorio',
                    ];
                    break;

            }
        },
    },
    watch: {
        "addForm.id_departamento"(value) {
            this.getProvincia(value);
        },
        "addForm.id_provincia"(value) {
            this.getDistrito(value);
        }
    },
    computed: {
        computedDateFormatted() {
            return this.formatDate(this.date);
        }
    },
};
</script>
