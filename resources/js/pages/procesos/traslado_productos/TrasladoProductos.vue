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
                        label="Nombre de productos"
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
                    <v-btn color="primary" class="mr-2" @click="GetAllRecords()">
                        Filtrar <v-icon>mdi-filter</v-icon>
                    </v-btn>
                    <v-btn color="deep-orange" class="mr-2" @click="ClearFilters" dark>
                        Limpiar <v-icon>mdi-broom</v-icon>
                    </v-btn>
                </v-col>
            </v-row>
        </v-card>
        <v-card class="mb-4" light style="padding: 15px">
            <v-tabs v-model="trasladosTab" class="my-tabs mb-2" :show-arrows="false" background-color="transparent">
                <v-tab to="#tabs-sucursales"><b>ENTRE SUCURSALES</b></v-tab>
                <v-tab to="#tabs-ubicaciones"><b>TIENDA/ALMACÉN</b></v-tab>
            </v-tabs>
            <v-tabs-items v-model="trasladosTab" id="custom-tab-items">
                <v-tab-item value="tabs-sucursales">
                    <TrasladoSucursal ref="traslado_sucursal"
                        :searchTerm="filter.searchTerm"
                        :fechaInicio="filter.fechaInicio"
                        :fechaFin="filter.fechaFin">
                    </TrasladoSucursal>
                </v-tab-item>
                <v-tab-item value="tabs-ubicaciones">
                    <TrasladoTiendaAlmacen ref="traslado_tienda"
                        :searchTerm="filter.searchTerm"
                        :fechaInicio="filter.fechaInicio"
                        :fechaFin="filter.fechaFin">
                    </TrasladoTiendaAlmacen>
                </v-tab-item>
            </v-tabs-items>
        </v-card>
    </div>
</template>

<script>
import TrasladoSucursal from "./components/TrasladoSucursal.vue";
import TrasladoTiendaAlmacen from "./components/TrasladoTiendaAlmacen.vue";

export default {
    components: {
        TrasladoSucursal,
        TrasladoTiendaAlmacen
    },
    data() {
        return {
            breadcrumbs_title: "Traslado Productos",
            breadcrumbs: [
                { text: "Inicio", disabled: false, href: "/dashboard" },
                { text: "Maestros", disabled: false, href: "#" },
                { text: "Traslado Productos" }
            ],
            trasladosTab: 0,

            menuStartDate: false,
            menuEndDate: false,
            filter: {
                searchTerm: "",
                fechaInicio: "",
                fechaFin: "",
            },
        }
    },
    mounted(){
        this.tables_references = [this.$refs.traslado_sucursal, this.$refs.traslado_tienda];
    },
    methods: {
        GetAllRecords(){
            this.forceRerender();
            const loop = async () => {
                for (let i = 0; i < this.tables_references.length; i++) {
                    this.tables_references[i].GetRecords();
                }
            }
            loop();
        },
        ClearFilters(){
            this.filter = {};
            this.$refs.searchForm.resetValidation();
            this.forceRerender();
        },
        forceRerender() {
            this.componentKey += 1;
        },
    },
    watch: {
        //
    },
    computed: {
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
    },
}
</script>