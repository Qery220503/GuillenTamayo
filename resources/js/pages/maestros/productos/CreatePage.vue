<template>
    <div class="d-flex flex-column flex-grow-1">
        <custom-breadcrumbs :breadcrumbs_title="breadcrumbs_title" :breadcrumbs="breadcrumbs"></custom-breadcrumbs>
        <v-card class="px-5 py-2">
            <v-card-title>
                <span class="headline">Crear Producto</span>
            </v-card-title>
            <v-card-text>
                <v-form ref="addForm" v-model="validAddForm" @submit.prevent="saveReg()" lazy-validation>
                    <v-row>
                        <v-col class="py-1" cols="12" md="3">
                            <v-text-field 
                                label="Código"
                                v-model="addForm.codigo_producto"
                                autocomplete="off"
                                disabled
                            ></v-text-field>
                        </v-col>
                        <v-col class="py-1" cols="12" md="3">
                            <v-text-field
                                label="Nombre"
                                v-model="addForm.nombre_producto"
                                :rules="requiredRules"
                                autocomplete="off"
                            ></v-text-field>
                        </v-col>
                        <v-col class="py-1" cols="12" md="3">
                            <v-autocomplete label="Marca *" v-model="addForm.marca"
                                :items="items_marca"
                                item-text="marca_producto"
                                item-value="id_marca_producto"
                                return-object
                                :rules="requiredRules">
                            </v-autocomplete>
                        </v-col>
                        <v-col class="py-1" cols="12" md="3">
                            <v-text-field
                                label="Código Varilla"
                                v-model="addForm.codigo_varilla"
                                autocomplete="off"
                            ></v-text-field>
                        </v-col>
                        <v-col class="py-1" cols="12" md="3">
                            <v-select label="Cód. Afectación IGV" v-model="addForm.cod_afectacion_igv"
                                :items="items_codigo_afectacion"
                                item-text="descripcion"
                                item-value="cod_afectacion">
                                <template v-slot:item="data">
                                    <template>
                                        <v-list-item-content>
                                            <v-list-item-title>Código {{data.item.cod_afectacion}}</v-list-item-title>
                                            <v-list-item-subtitle>{{ data.item.descripcion }}</v-list-item-subtitle>
                                        </v-list-item-content>
                                    </template>
                                </template>
                            </v-select>
                        </v-col>

                        <v-col class="py-1" cols="12" md="3">
                            <v-text-field
                                label="Código Sunat *"
                                v-model="addForm.codigo_sunat"
                                :rules="requiredRules"
                                autocomplete="off"
                            ></v-text-field>
                        </v-col>
                        <v-col class="py-1" cols="12" md="3">
                            <v-text-field
                                label="Stock Inicial *"
                                v-model="addForm.stock"
                                :rules="requiredRules"
                                autocomplete="off"
                                type="number"
                            ></v-text-field>
                        </v-col>
                        <v-col class="py-1" cols="12" md="3">
                            <v-text-field
                                label="Precio Compra *"
                                v-model="addForm.precio_compra"
                                :rules="requiredRules"
                                autocomplete="off"
                                type="number"
                                min="0"
                                step="0.01"
                            ></v-text-field>
                        </v-col>
                        <v-col class="py-1" cols="12" md="3">
                            <v-text-field
                                label="Precio Venta *"
                                v-model="addForm.precio_venta"
                                :rules="requiredRules"
                                autocomplete="off"
                                type="number"
                                min="0"
                                step="0.01"
                            ></v-text-field>
                        </v-col>

                        <v-col class="py-1" cols="12" md="3">
                            <v-select label="Categoría *" v-model="addForm.id_categoria"
                                :items="items_categoria"
                                item-text="nombre_categoria"
                                item-value="id_producto_categoria"
                                :rules="requiredRules">
                            </v-select>
                        </v-col>
                        <v-col class="py-1" cols="12" md="3">
                            <v-select label="Rango *" v-model="addForm.rango"
                                :items="items_rango"
                                :rules="requiredRules">
                            </v-select>
                        </v-col>
                        <v-col class="py-1" cols="12" md="3">
                            <v-select label="Material" v-model="addForm.id_material"
                                :items="items_material"
                                item-text="nombre_material"
                                item-value="id_material">
                            </v-select>
                        </v-col>
                        <v-col class="py-1" cols="6" md="3">
                            <v-select label="Tipo de Aro" v-model="addForm.id_tipo_aro"
                                :items="items_tipo_aro"
                                item-text="tipo_aro"
                                item-value="id_tipo_aro">
                            </v-select>
                        </v-col>

                        <v-col class="py-1" cols="6" md="3">
                            <v-select label="Forma Montura" v-model="addForm.id_forma_montura"
                                :items="items_forma_montura"
                                item-text="forma_montura"
                                item-value="id_forma_montura"
                                @change="formaMonturaChanged(addForm.id_forma_montura)">
                            </v-select>
                        </v-col>
                        <v-col class="py-1" cols="6" md="3">
                            <v-select label="Tipo Rostro *" v-model="addForm.tipo_rostro"
                                :items="items_tipo_rostro"
                                :rules="requiredRules"
                                small-chips
                                multiple>
                            </v-select>
                        </v-col>
                        <v-col class="py-1" cols="6" md="3">
                            <v-select label="Género *" v-model="addForm.genero"
                                :items="items_genero"
                                :rules="requiredRules">
                            </v-select>
                        </v-col>
                        <v-col class="py-1" cols="6" md="3">
                            <v-select label="Características Adicionales *" v-model="addForm.adicionales"
                                :items="items_adicionales"
                                :rules="requiredRules">
                            </v-select>
                        </v-col>
                        <v-col class="py-1" cols="6" md="3">
                            <v-text-field
                                label="Descripción"
                                v-model="addForm.descripcion"
                                autocomplete="off"
                            ></v-text-field>
                        </v-col>
                        <v-col class="py-1" cols="6" md="3">
                            <v-select label="Producto Reto" v-model="addForm.producto_reto"
                                :items="items_reto">
                            </v-select>
                        </v-col>
                        <v-col class="py-1" cols="12" md="4">
                            <v-radio-group v-model="addForm.sobrelentes">
                                <template v-slot:label>
                                    <div>Sobrelentes</div>
                                </template>
                                <v-radio label="Si" :value="1"></v-radio>
                                <v-radio label="No" :value="0"></v-radio>
                            </v-radio-group>
                        </v-col>
                        <v-col class="py-1" cols="12" md="4">
                            <v-radio-group v-model="addForm.liquido">
                                <template v-slot:label>
                                    <div>¿Es líquido?</div>
                                </template>
                                <v-radio label="Si" :value="1"></v-radio>
                                <v-radio label="No" :value="0"></v-radio>
                            </v-radio-group>
                        </v-col>
                    </v-row>
                    <br />
                    <v-divider></v-divider>

                    <v-card-title>Talla</v-card-title>
                    <v-row>
                        <v-col class="py-1" cols="3" md="4">
                                <v-text-field
                                    label="Diagonal"
                                    v-model="addForm.diagonal"
                                    autocomplete="off"
                                ></v-text-field>
                        </v-col>
                        <v-col class="py-1" cols="3" md="4">
                                <v-text-field
                                    label="Puente"
                                    v-model="addForm.puente"
                                    autocomplete="off"
                                ></v-text-field>
                        </v-col>
                        <v-col class="py-1" cols="3" md="4">
                                <v-text-field
                                    label="Varilla"
                                    v-model="addForm.varilla"
                                    autocomplete="off"
                                ></v-text-field>
                        </v-col>
                    </v-row>
                    <br />
                    <v-divider></v-divider>
                    <br />

                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn color="error" text to="/producto">Cancelar</v-btn>
                        <v-btn type="submit" color="primary" :disabled="!validAddForm">Guardar</v-btn>
                    </v-card-actions>
                </v-form>
            </v-card-text>
        </v-card>
    </div>
</template>
<script>
import API from "../../../api";
export default {
    data() {
        return {
            breadcrumbs_title: "Productos",
            breadcrumbs: [
                { text: "Inicio", disabled: false, href: "/dashboard" },
                { text: "Productos", disabled: false, href: "/producto" },
                { text: "Crear Productos" }
            ],
            items_marca: [],
            items_categoria: [],
            items_material: [],
            items_tipo_aro: [],
            items_forma_montura: [],
            items_codigo_afectacion: [],
            items_tipo_rostro: [
                "N/A",
                "REDONDO",
                "CUADRADO",
                "ALARGADO",
                "TRIANGULAR",
                "OVALADO",
            ],
            items_rango: [
                { value: 1, text: "N/A", from: null, to: null },
                { value: 2, text: "ECONÓMICO", from: 1, to: 100 },
                { value: 3, text: "ECONÓMICO INTERMEDIO", from: 101, to: 180 },
                { value: 4, text: "INTERMEDIO", from: 181, to: 220 },
                { value: 5, text: "INTERMEDIO CARA", from: 221, to: 300 },
                { value: 6, text: "CARA", from: 301, to: 450 },
                { value: 7, text: "LUJO", from: 451, to: null },
            ],
            items_genero: [
                { value: 6, text: "N/A" },
                { value: 1, text: "VARÓN" },
                { value: 2, text: "DAMA" },
                { value: 3, text: "NIÑO" },
                { value: 4, text: "NIÑA" },
                { value: 5, text: "UNISEX" },
            ],
            items_reto: [
                { value: 0, text: "No" },
                { value: 1, text: "Si" },
            ],
            items_adicionales: [
                "N/A",
                "POLARIZADA",
                "ESPEJADA",
                "CON PLAQUETAS",
                "POLARIZADA CON PLAQUETAS",
                "POLARIZADA SIN PLAQUETAS",
            ],
            validAddForm: false,
            addForm: {
                cod_afectacion_igv: 10,
                rango: 1,
                tipo_rostro: ['N/A'],
                adicionales: 'N/A',
                genero: 6,

                producto_reto: 0,
                sobrelentes: 0,
                liquido: 0,
            },
            correlativo: '000',

            requiredRules: [v => !!v || "Campo obligatorio"],
        };
    },
    created() {
        this.getProductCode();
        this.getMarcas();
        this.getCategorias();
        this.getMateriales();
        this.getTiposAro();
        this.getFormasMontura();
        this.afectacionIGV();
    },
    methods: {
        async saveReg() {
            if (this.$refs.addForm.validate()) {
                try {
                    this.$store.commit("loader", true);
                    this.addForm.tipo_rostro = this.addForm.tipo_rostro.filter(
                        e => e != null && e != ""
                    );
                    const response = await API.productos.create(this.addForm);
                    UTILS.toastr.success("Producto creado correctamente", this);
                    this.$router.push("/producto");

                } catch (e) {
                    UTILS.toastr.error("Ups! Ocurrió un error", this);
                    console.error(e);

                } finally {
                    this.$store.commit("loader", false);
                    this.loadingTable = false;
                }
            }
        },
        formaMonturaChanged(val){
            let index = this.items_forma_montura.findIndex(item => {
                return item.id_forma_montura == val;
            });
            this.addForm.tipo_rostro = this.items_forma_montura[index].rostros.split(",");
        },

        //--- Loading Data---
        async getMarcas() {
            let vm = this;
            try {
                const response = await API.producto_marca.combo();
                vm.items_marca = response.data;
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async getCategorias() {
            let vm = this;
            try {
                const response = await API.producto_categoria.combo();
                vm.items_categoria = response.data;
                
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async getMateriales() {
            try {
                const response = await API.producto_material.combo();
                this.items_material = response.data;
                this.items_material.unshift({id_material: null, nombre_material: 'N/A'});
                this.addForm.id_material = null;

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async getTiposAro() {
            try {
                const response = await API.producto_aro.combo();
                this.items_tipo_aro = response.data;
                this.items_tipo_aro.unshift({id_tipo_aro: null, tipo_aro: 'N/A'});
                this.addForm.id_tipo_aro = null;

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async getFormasMontura() {
            try {
                const response = await API.producto_formas_montura.combo();
                this.items_forma_montura = response.data;
                this.items_forma_montura.unshift({id_forma_montura: null, forma_montura: 'N/A', rostros:'N/A'});
                this.addForm.id_forma_montura = null;

            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        async getProductCode(){
            const response = await API.productos.generate_code('000');
            this.addForm.codigo_producto = response.data;
            this.addForm.nombre_producto = '000 '+response.data;
        },
        async afectacionIGV() {
            let vm = this;
            try {
                const response = await API.afectacion_igv.combo();
                vm.items_codigo_afectacion = response.data;
            } catch (e) {
                UTILS.toastr.error("Ups! Ocurrió un error", this);
                console.error(e);
            }
        },
        //--- End ---
    },
    computed: {
        //
    },
    watch: {
        "addForm.marca"() {
            let marca = this.addForm.marca.marca_producto;
            let codigo = this.addForm.codigo_producto.substring(0, 7)
                        + marca.substring(0,3)
                        + this.addForm.codigo_producto.substring(10, 12);
            
            this.addForm.codigo_producto = codigo;
            this.addForm.nombre_producto = marca+' '+ codigo;
        },
        "addForm.precio_venta"(precio) {
            const etiqueta = this.items_rango.find((rango) => {
                if (rango.from && rango.to) {
                    return precio >= rango.from && precio <= rango.to;
                } else if (rango.from) {
                    return precio >= rango.from;
                } else if (rango.to) {
                    return precio <= rango.to;
                }
            });
            this.addForm.rango = etiqueta ? etiqueta.value : 1;
        }
    }
};
</script>
