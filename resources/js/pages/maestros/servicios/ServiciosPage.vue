<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card>
      <v-row dense class="pa-2 align-center">
        <v-spacer></v-spacer>
        <v-col class="text-right">
          <v-btn color="#1D6F42" class="mr-2" dark href="/api/exportServicios">
            Exportar<v-icon>mdi-file-excel</v-icon>
          </v-btn>
          <v-btn color="primary" class="mr-2" @click="addDialog = true">
            Añadir Servicio <v-icon>mdi-plus</v-icon>
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
                  v-model="filter.nombre_servicio"
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
                  v-model="filter.precio_compra"
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
                  v-model="filter.precio_venta"
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
                  v-model="filter.cod_afectacion_igv"
                  type="text"
                  outlined
                  dense
                  class="mt-1"
                  hide-details
                  @input="getRegistros()"
                ></v-text-field>
              </td>
                <td>
                    <v-btn small icon @click="limpiarFiltros">
                        <v-icon small>mdi-broom</v-icon>
                    </v-btn>
                </td>
            </tr>
          </template>
          <template v-slot:[`item.actions`]="{ item }">
            <v-btn small icon @click.stop="editReg(item)">
              <v-icon small>mdi-border-color</v-icon>
            </v-btn>
            <v-btn small icon @click.stop="deleteReg(item)">
              <v-icon small>mdi-delete</v-icon>
            </v-btn>
          </template>
          <template v-slot:[`item.cod_afectacion_igv`]="{ item }">
            {{ item.cod_afectacion_igv }} - {{ item.afectacion.descripcion }}
          </template>
        </v-data-table>
      </v-row>
    </v-card>

    <!-- Add/Edit Dialog -->
    <v-dialog v-model="addDialog" max-width="40%" persistent>
      <v-card>
        <v-card-title>
          <span class="headline">{{ addFormTitle }}</span>
        </v-card-title>
        <v-card-text>
          <v-form
            ref="addForm"
            v-model="validAddForm"
            @submit.prevent="saveReg()"
            lazy-validation
          >
            <v-row class="mt-2">
              <v-col class="py-1" cols="12" md="6">
                <v-text-field
                  v-model="addForm.nombre_servicio"
                  label="Nombre del servicio"
                  autocomplete="off"
                  :rules="[rules.required]"
                  filled
                  dense
                ></v-text-field>
              </v-col>
              <v-col class="py-1" cols="12" md="6">
                <!---<v-select
                  v-model="addForm.cod_afectacion_igv"
                  :items="afectaciones"
                  label="Afectación"
                  item-text="descripcion"
                  item-value="cod_afectacion"
                  :rules="[rules.required]"
                  filled
                  dense
                ></v-select>-->

                <v-autocomplete
                  v-model="addForm.cod_afectacion_igv"
                  :items="afectaciones"
                  color="blue-grey lighten-2"
                  label="Cód. Afectación IGV"
                  item-text="descripcion"
                  item-value="cod_afectacion"
                  filled
                  dense
                >
                  <template v-slot:item="data">
                    <template v-if="typeof data.item !== 'object'">
                      <v-list-item-content
                        v-text="data.item"
                      ></v-list-item-content>
                    </template>
                    <template v-else>
                      <v-list-item-content>
                        <v-list-item-title
                          v-html="'Código ' + data.item.cod_afectacion"
                        ></v-list-item-title>
                        <v-list-item-subtitle
                          v-html="data.item.descripcion"
                        ></v-list-item-subtitle>
                      </v-list-item-content>
                    </template>
                  </template>
                </v-autocomplete>
              </v-col>
              <v-col class="py-1" cols="12" md="6">
                <v-text-field
                  v-model="addForm.precio_compra"
                  label="Precio compra"
                  :rules="[rules.required]"
                  filled
                  dense
                ></v-text-field>
              </v-col>
              <v-col class="py-1" cols="12" md="6">
                <v-text-field
                  v-model="addForm.precio_venta"
                  label="Precio Venta"
                  :rules="[rules.required]"
                  filled
                  dense
                ></v-text-field>
              </v-col>
            </v-row>
            <br />
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="error" text @click="addDialog = false"
                >Cancelar</v-btn
              >
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
                            <v-text-field
                                v-model="viewForm.nombre_servicio"
                                label="Servicio"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.precio_compra"
                                label="Precio Compra"
                                readonly
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                            <v-text-field
                                v-model="viewForm.cod_afectacion"
                                label="Cód. Afectación IGV"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.precio_venta"
                                label="Precio Venta"
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
    <v-dialog v-model="deleteDialog" max-width="60%">
      <v-card>
        <v-card-title class="d-flex justify-center">
          <span class="headline"
            >¿Estás seguro que deseas borrar este registro?</span
          >
        </v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="deleteRegConfirm">Aceptar</v-btn>
          <v-btn color="error" text @click="deleteDialog = false"
            >Cancelar</v-btn
          >
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Fin -->
  </div>
</template>
<script>
export default {
  data() {
    return {
      breadcrumbs_title: "Servicios",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Maestros", disabled: false, href: "#" },
        { text: "Servicios" }
      ],
      headers: [
        { text: "#", value: "id_servicio", align: "left" },
        {
          text: "Nombre del Servicio",
          value: "nombre_servicio",
          align: "left"
        },
        { text: "Precio de compra", value: "precio_compra", align: "left" },
        { text: "Precio de venta", value: "precio_venta", align: "left" },
        { text: "Afectación", value: "cod_afectacion_igv", align: "left" },
        { text: "Acciones", sortable: false, value: "actions", align: "right" }
      ],
        viewDialog: false,
        viewForm: {
        },

      afectaciones: [],
      addForm: {
        id_servicio: null,
        nombre_servicio: null,
        precio_compra: null,
        precio_venta: null,
        cod_afectacion_igv: 10
      },

      //--- Datatable ---
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
      total_reg: 0,
      dataTabOptions: {},
      data_reg: [],
      filter: {
        searchTerm: ""
      },
      addFormTitle: "Agregar Servicio",
      dialogEditar: false,
      validAddForm: false,
      addDialog: false,
      deleteDialog: false,
      rules: {
        required: UTILS.nRules.required
      }
    };
  },
  created() {
    //this.getRegistros();
    this.getAfectaciones();
  },
  methods: {
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      const myParams = new URLSearchParams(this.filter).toString();
      try {
        const response = await API.servicios.list(
          "?page=" +
            page +
            "&itemsPerPage=" +
            per_page +
            "&sortDesc=" +
            sortDesc +
            "&sortBy=" +
            sortBy +
            "&searchTerm=" +
            this.filter.searchTerm +
            "&" +
            myParams
        );
        this.data_reg = response.data;
        this.current_page = response.data.current_page;
        this.total_reg = this.data_reg.total;
        this.loadingTable = false;
      } catch (e) {
        this.loadingTable = false;
        console.error(e);
      }
    },
    limpiarFiltros() {
      this.filter = {};
      this.getRegistros();
    },
    handleDataRowClick(row){
        this.viewForm = Object.assign({}, row);
        this.viewForm.cod_afectacion = this.viewForm.afectacion.descripcion;
        this.viewDialog = true;
    },
    
    async getAfectaciones() {
      const response = await API.afectacion_igv.combo();
      this.afectaciones = response.data;
    }, 
    editReg(item) {
      this.addFormTitle = "Editar Servicio";
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
        const response = await API.servicios.remove(this.addForm.id_servicio);
        UTILS.toastr.success("Servicio eliminado correctamente", this);
        this.deleteDialog = false;
        this.getRegistros();
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
            const response = await API.servicios.create(this.addForm);
            UTILS.toastr.success("Servicio creado correctamente", this);
          } else {
            const response = await API.servicios.update(
              this.addForm.id_servicio,
              this.addForm
            );
            UTILS.toastr.success("Servicio actualizado correctamente", this);
          }
          this.getRegistros();
          this.addDialog = false;
        } catch (e) {
          UTILS.toastr.error("Ups! Ocurrió un error", this);
          console.error(e);
        } finally {
          this.$store.commit("loader", false);
          this.loadingTable = false;
        }
      }
    }
  },
  watch: {
    dataTabOptions(event) {
      this.itemsperpage = event.itemsPerPage;
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
        this.$refs.addForm.reset();
        this.validAddForm = false;
        this.addFormTitle = "Agregar Servicios";
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
