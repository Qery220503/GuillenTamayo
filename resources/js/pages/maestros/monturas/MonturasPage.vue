<template>
  <div class="d-flex flex-column flex-grow-1">
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
          <v-btn color="primary" class="mr-2" @click="addDialog = true">
            Añadir Forma <v-icon>mdi-plus</v-icon>
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
          <!--
          <template v-slot:[`item.estado`]="{ item }">
            <v-chip small v-if="item.estado == 1" class="ma-2" color="success"
              >Habilitado</v-chip
            >
            <v-chip small v-if="item.estado == 0" class="ma-2" color="error"
              >Deshabilitado</v-chip
            >
          </template>
        -->
          <template v-slot:[`item.actions`]="{ item }">
            <v-btn small icon @click.stop="editReg(item)">
              <v-icon small>mdi-border-color</v-icon>
            </v-btn>
            <v-btn small icon @click.stop="deleteReg(item)">
              <v-icon small>mdi-delete</v-icon>
            </v-btn>
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
            <v-row>
              <v-col>
                <v-text-field
                  v-model="addForm.forma_montura"
                  label="Nombre"
                  :rules="rules.required"
                  autocomplete="off"
                ></v-text-field>
                <v-select
                  :items="items_tipo_rostro"
                  label="Tipo rostro"
                  placeholder="Selecciona los tipos de rostro"
                  v-model="addForm.rostros"
                  required
                  multiple
                  small-chips
                ></v-select>
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
                        <v-col cols="12" sm="12" md="12">
                            <v-text-field
                                v-model="viewForm.forma_montura"
                                label="Nombre"
                                readonly
                            ></v-text-field>
                            <v-select
                                :items="items_tipo_rostro"
                                label="Tipo rostro"
                                placeholder="Tipos de rostro"
                                v-model="viewForm.rostros"
                                required
                                multiple
                                small-chips
                                readonly
                            ></v-select>
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
      breadcrumbs_title: "Formas Montura",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Maestros", disabled: false, href: "#" },
        { text: "Formas Montura" }
      ],
      headers: [
        { text: "#", value: "id_forma_montura", align: "left" },
        { text: "Forma de Montura", value: "forma_montura", align: "center" },
        //{ text: "Estado", value: "estado", sortable: false, align: "center" },
        { text: "Acciones", sortable: false, value: "actions", align: "right" }
      ],
        viewDialog: false,
        viewForm: {
        },

      addForm: {
        id_forma_montura: null,
        forma_montura: null,
        rostros: []
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
      addFormTitle: "Agregar Forma",
      dialogEditar: false,
      validAddForm: false,
      addDialog: false,
      deleteDialog: false,
      rules: {
        required: UTILS.rules.required
      },
      items_tipo_rostro: [
        "REDONDO",
        "CUADRADO",
        "ALARGADO",
        "TRIANGULAR",
        "OVALADO"
      ]
    };
  },
  created() {
    //
  },
  methods: {
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.producto_formas_montura.list(
          "?page=" +
            page +
            "&itemsPerPage=" +
            per_page +
            "&sortDesc=" +
            sortDesc +
            "&sortBy=" +
            sortBy +
            "&searchTerm=" +
            this.filter.searchTerm
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
      this.filter.searchTerm = "";
      this.getRegistros();
    },
    handleDataRowClick(row){
        this.viewForm = Object.assign({}, row);
        this.viewForm.rostros = this.viewForm.rostros.split(",");
        this.viewDialog = true;
    },

    editReg(item) {
      this.addFormTitle = "Editar Montura";
      this.dialogEditar = true;
      this.addForm = Object.assign({}, item);
      this.addForm.rostros = this.addForm.rostros.split(",");
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
        const response = await API.producto_formas_montura.remove(
          this.addForm.id_forma_montura
        );
        UTILS.toastr.success("Montura eliminada correctamente", this);
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
          console.log(this.dialogEditar);
          this.addForm.rostros = this.addForm.rostros.join(",");
          if (this.dialogEditar == false) {
            const response = await API.producto_formas_montura.create(
              this.addForm
            );
            UTILS.toastr.success("Forma creado correctamente", this);
          } else {
            const response = await API.producto_formas_montura.update(
              this.addForm.id_forma_montura,
              this.addForm
            );
            UTILS.toastr.success("Forma actualizado correctamente", this);
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
        // console.log('Dialog is closing');
        this.dialogEditar = false;
        this.$refs.addForm.reset();
        this.validAddForm = false;
        this.addFormTitle = "Agregar Forma";
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
