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
          <v-btn color="#1D6F42" class="mr-2" dark href="/api/exportEmpresas">
            Exportar<v-icon>mdi-file-excel</v-icon>
          </v-btn>
          <v-btn color="primary" class="mr-2" @click="addDialog = true">
            Añadir Empresa Convenios <v-icon>mdi-plus</v-icon>
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
          :footer-props="{ itemsPerPageOptions: [25, 50, 100, 1000] }"
          :loading="loadingTable"
          loading-text="Cargando... Por favor, espere"
          @click:row="handleDataRowClick">
          <template v-slot:body.prepend>
            <tr>
              <td></td>
              <td>
                <v-text-field
                  v-model="filter.nombre_empresa"
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
                  v-model="filter.email_empresa"
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
                  v-model="filter.telefono_empresa"
                  type="text"
                  outlined
                  dense
                  class="mt-1"
                  hide-details
                  @input="getRegistros()"
                ></v-text-field>
              </td>
                <td>
                    <v-select
                        v-model="filter.enviar_correos"
                        :items="eviarcorreos_list"
                        item-text="text"
                        item-value="value"
                        label="Enviar Correos"
                        hide-details
                        outlined
                        @input="getRegistros()"
                        dense
                    ></v-select>
                </td>
                <td>
                    <v-select
                        v-model="filter.cobertura"
                        :items="cobertura_list"
                        item-text="text"
                        item-value="value"
                        label="Cobertura"
                        hide-details
                        outlined
                        @input="getRegistros()"
                        dense
                    ></v-select>
                </td>
                <td>
                    <v-btn small icon @click="limpiarFiltros">
                        <v-icon small>mdi-broom</v-icon>
                    </v-btn>
                </td>
            </tr>
          </template>
          <template v-slot:[`item.enviar_correos`]="{ item }">
            <v-chip
              small
              v-if="item.enviar_correos == 1"
              class="ma-2"
              color="success"
              >Autorizado</v-chip
            >
            <v-chip
              small
              v-if="item.enviar_correos == 0"
              class="ma-2"
              color="error"
              >No Autorizado</v-chip
            >
          </template>

          <template v-slot:[`item.cobertura`]="{ item }">
            <v-chip
              small
              v-if="item.cobertura == 1"
              class="ma-2"
              color="success"
              >Cobertura</v-chip
            >
            <v-chip small v-if="item.cobertura == 0" class="ma-2" color="error"
              >Sin cobertura</v-chip
            >
          </template>
          <template v-slot:[`item.actions`]="{ item }">
            <v-btn small icon @click.stop="editReg(item)" :disabled="item.id_empresa_convenio == 1">
              <v-icon small>mdi-border-color</v-icon>
            </v-btn>
            <v-btn small icon @click.stop="deleteReg(item)" :disabled="item.id_empresa_convenio == 1">
              <v-icon small>mdi-delete</v-icon>
            </v-btn>
          </template>
        </v-data-table>
      </v-row>
    </v-card>

    <!-- Add/Edit Dialog -->
    <v-dialog v-model="addDialog" max-width="650" persistent>
      <v-card>
        <v-card-title>
          <span class="headline">{{ addFormTitle }}</span>
        </v-card-title>
        <v-card-text>
          <v-form
            ref="addForm"
            v-model="validAddForm"
            @submit.prevent="saveReg()"
            lazy-validation>
            <v-row>
              <v-col cols="12" sm="6" md="6">
                <v-text-field
                  v-model="addForm.nombre_empresa"
                  label="Razón Social"
                  :rules="[rules.required]"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.ruc_empresa"
                  label="RUC"
                  :rules="[rules.required, rules.ruc]"
                  filled
                  dense>
                    <template #append-outer>
                        <v-btn
                            color="primary"
                            @click="obtenerDataDocumentos()">
                            <v-icon>mdi-magnify</v-icon>
                        </v-btn>
                    </template>
                </v-text-field>
                <v-text-field
                  v-model="addForm.direccion_empresa"
                  label="Dirección"
                  :rules="[rules.required]"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.descuento_cobertura"
                  label="Cobertura"
                  filled
                  dense
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="6">
                <v-text-field
                  v-model="addForm.email_empresa"
                  label="Correo Electrónico"
                  :rules="[rules.email, rules.required]"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.telefono_empresa"
                  label="Teléfono"
                  :rules="[rules.required]"
                  filled
                  dense
                ></v-text-field>
                <v-radio-group v-model="addForm.enviar_correos" row>
                  <template v-slot:label>
                    <div>Enviar Correos</div>
                  </template>
                  <v-radio label="Si" :value="1"></v-radio>
                  <v-radio label="No" :value="0"></v-radio>
                </v-radio-group>
                <v-radio-group v-model="addForm.cobertura" row>
                  <template v-slot:label>
                    <div>Validar Cobertura</div>
                  </template>
                  <v-radio label="Si" :value="1"></v-radio>
                  <v-radio label="No" :value="0"></v-radio>
                </v-radio-group>
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
                                v-model="viewForm.nombre_empresa"
                                label="Razón Social"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.ruc_empresa"
                                label="RUC"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.direccion_empresa"
                                label="Dirección"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.telefono_empresa"
                                label="Cobertura"
                                readonly
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                            <v-text-field
                                v-model="viewForm.email_empresa"
                                label="Correo Electrónico"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.telefono_empresa"
                                label="Teléfono"
                                readonly
                            ></v-text-field>
                            <v-radio-group v-model="viewForm.enviar_correos" row readonly>
                                <template v-slot:label>
                                    <div>Enviar Correos</div>
                                </template>
                                <v-radio label="Si" :value="1"></v-radio>
                                <v-radio label="No" :value="0"></v-radio>
                            </v-radio-group>
                            <v-radio-group v-model="viewForm.cobertura" row readonly>
                                <template v-slot:label>
                                    <div>Validar Cobertura</div>
                                </template>
                                <v-radio label="Si" :value="1"></v-radio>
                                <v-radio label="No" :value="0"></v-radio>
                            </v-radio-group>
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
import API from "../../../api";

export default {
  data() {
    return {
      breadcrumbs_title: "Empresa Convenios",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Maestros", disabled: false, href: "#" },
        { text: "Empresa Convenios" }
      ],
      headers: [
        { text: "#", value: "id_empresa_convenio", align: "left" },
        { text: "Razón Social", value: "nombre_empresa", align: "left" },
        { text: "Correo Electrónico", value: "email_empresa", align: "left" },
        { text: "Teléfono", value: "telefono_empresa", align: "left" },
        { text: "Enviar Correos", value: "enviar_correos", align: "center" },
        { text: "Cobertura", value: "cobertura", align: "center" },
        { text: "Acciones", sortable: false, value: "actions", align: "right" }
      ],
        viewDialog: false,
        viewForm: {
        },

      addForm: {
        id_empresa_convenio: null,
        ruc_empresa: "",
        nombre_empresa: '',
        direccion_empresa: '',
        enviar_correos: 1,
        cobertura: 0,
        descuento_cobertura: Number(0).toFixed(2),
      },
      //--- Datatable ---
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
      total_reg: 0,
      dataTabOptions: {},
      data_reg: [],
        filter: {
            searchTerm: "",
            nombre_empresa: "",
            email_empresa: "",
            telefono_empresa: "",
            enviar_correos: "",
            cobertura: "",
        },
        eviarcorreos_list: [
            {value: "", text: "Todos"},
            {value: 0, text: "No"},
            {value: 1, text: "Si"},
        ],
        cobertura_list: [
            {value: "", text: "Todos"},
            {value: 0, text: "No"},
            {value: 1, text: "Si"},
        ],

      addFormTitle: "Agregar Empresa Convenio",
      dialogEditar: false,
      validAddForm: false,
      addDialog: false,
      deleteDialog: false,
      rules: {
        required: UTILS.nRules.required,
        dni: UTILS.nRules.min8,
        ruc: UTILS.nRules.min811,
        only_numbers: UTILS.nRules.only_numbers,
        email: UTILS.nRules.email
      },
      items_tipo_doc: []
    };
  },
  created() {
    this.getTipos();
  },
  methods: {
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      const myParams = new URLSearchParams(this.filter).toString();
      try {
        const response = await API.empresas_convenio.list(
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
        this.filter = {
            enviar_correos: "",
            cobertura: "",
        };
        this.getRegistros();
    },
    handleDataRowClick(row){
        this.viewForm = Object.assign({}, row);
        this.viewDialog = true;
    },


    async obtenerDataDocumentos() {
      try {

        this.addForm.nombre_empresa = '';
        this.addForm.direccion_empresa = '';

        const data = {
          tipoDoc: 2,
          numDoc: this.addForm.ruc_empresa.trim()
        };

        const rpta = await API.apis.dniruc(data);
        if (rpta.data.success === true) {
          this.addForm.nombre_empresa = rpta.data.nombre_o_razon_social;
          this.addForm.direccion_empresa = rpta.data.direccion_completa;


          if (rpta.data.estado == "ACTIVO" && rpta.data.condicion == "HABIDO") {
            UTILS.toastr.success(
              "El documento ingresado se encuentra ACTIVO y HABIDO",
              this
            );
          } else {
            UTILS.toastr.info(
              "Cuidado, el documento ingresado se encuentra " +
                rpta.data.estado +
                " y " +
                rpta.data.condicion,
              this
            );
          }
          this.$store.commit("loader", false);
        } else {
          this.$store.commit("loader", false);
        }
        this.$store.commit("loader", false);
      } catch (error) {
        this.$store.commit("loader", false);
        console.error(error, "ERROR");
      }
    },

    editReg(item) {
      this.addFormTitle = "Editar Empresa Convenio";
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
        const response = await API.empresas_convenio.remove(
          this.addForm.id_empresa_convenio
        );
        UTILS.toastr.success("Empresa Convenio eliminado correctamente", this);
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
            const response = await API.empresas_convenio.create(this.addForm);
            UTILS.toastr.success("Empresa Convenio creado correctamente", this);
          } else {
            const response = await API.empresas_convenio.update(
              this.addForm.id_empresa_convenio,
              this.addForm
            );
            UTILS.toastr.success(
              "Empresa Convenio actualizado correctamente",
              this
            );
          }
          this.getRegistros();
          this.addDialog = false;
        } catch (e) {
          UTILS.toastr.error(error.response.data, this);
          console.error(e);
        } finally {
          this.$store.commit("loader", false);
          this.loadingTable = false;
        }
      }
    },
    async getTipos() {
      let vm = this;
      try {
        const response = await API.tipos_documentos.combo();
        vm.items_tipo_doc = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
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
        this.addFormTitle = "Agregar Empresa Convenio";
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
