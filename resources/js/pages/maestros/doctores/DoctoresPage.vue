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
          <v-btn color="#1D6F42" class="mr-2" dark href="/api/exportDoctores">
            Exportar<v-icon>mdi-file-excel</v-icon>
          </v-btn>
          <v-btn color="primary" class="mr-2" @click="addDialog = true">
            Añadir Doctor <v-icon>mdi-plus</v-icon>
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
                  v-model="filter.nombres"
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
                  v-model="filter.nro_documento"
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
                  v-model="filter.email"
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
                  v-model="filter.nro_telefono"
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
                  v-model="filter.porcentaje_comision"
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
          <template v-slot:[`item.porcentaje_comision`]="{ item }">
            <div>{{ item.porcentaje_comision + "%" }}</div>
          </template>
          <template v-slot:[`item.nombres`]="{ item }">
            <div>{{ item.nombres + " " + item.apellidos }}</div>
          </template>
          <template v-slot:[`item.actions`]="{ item }">
            <v-btn small icon @click.stop="editReg(item)" :disabled="item.id_doctor == 1">
              <v-icon small>mdi-border-color</v-icon>
            </v-btn>
            <v-btn small icon @click.stop="deleteReg(item)" :disabled="item.id_doctor == 1">
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
            <v-row dense>
              <v-col>
                <v-text-field
                  v-model="addForm.nombres"
                  label="Nombres"
                  :rules="[rules.required]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.apellidos"
                  label="Apellidos"
                  :rules="[rules.required]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.nro_documento"
                  label="Nro. Documento"
                  :rules="[rules.required, rules.dni]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.email"
                  label="Correo Electrónico"
                  :rules="[rules.email, rules.required]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.nro_telefono"
                  label="Nro. Teléfono"
                  :rules="[rules.required, rules.only_numbers]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.porcentaje_comision"
                  label="Porcentaje de Comisión"
                  type="number"
                  step="5"
                  :rules="[rules.required]"
                  min="0.00"
                  max="100.00"
                  suffix="%"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
                <v-radio-group v-model="addForm.enviar_correos" row>
                  <template v-slot:label>
                    <div>Enviar Correos:</div>
                  </template>
                  <v-radio label="Si" :value="1"></v-radio>
                  <v-radio label="No" :value="0"></v-radio>
                </v-radio-group>
                <v-radio-group v-model="addForm.convenio" row>
                  <template v-slot:label>
                    <div>Afiliado a Convenio:</div>
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
                        <v-col cols="12" sm="12" md="12">
                            <v-text-field
                                v-model="viewForm.nombres"
                                label="Nombres"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.apellidos"
                                label="Apellidos"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.nro_documento"
                                label="Nro. Documento"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.email"
                                label="Correo Electrónico"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.nro_telefono"
                                label="Nro. Teléfono"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.porcentaje_comision"
                                label="Porcentaje de Comisión"
                                suffix="%"
                                readonly
                            ></v-text-field>
                            <v-radio-group v-model="viewForm.enviar_correos" row readonly>
                                <template v-slot:label>
                                    <div>Enviar Correos:</div>
                                </template>
                                <v-radio label="Si" :value="1"></v-radio>
                                <v-radio label="No" :value="0"></v-radio>
                            </v-radio-group>
                            <v-radio-group v-model="viewForm.convenio" row readonly>
                                <template v-slot:label>
                                    <div>Afiliado a Convenio:</div>
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
      breadcrumbs_title: "Doctores",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Maestros", disabled: false, href: "#" },
        { text: "Doctores" }
      ],
      headers: [
        { text: "#", value: "id_doctor", align: "left" },
        { text: "Nombre", value: "nombres", align: "left" },
        {
          text: "Nro. Documento",
          value: "nro_documento",
          align: "left"
        },
        { text: "Email", value: "email", align: "left" },
        { text: "Teléfono", value: "nro_telefono", align: "left" },
        { text: "% de comisión", value: "porcentaje_comision", align: "left" },
        {
          text: "Enviar Correos",
          value: "enviar_correos",
          align: "center"
        },
        {
          text: "Acciones",
          sortable: false,
          value: "actions",
          align: "center"
        }
      ],
        viewDialog: false,
        viewForm: {
        },

      addForm: {
        nombres: null,
        apellidos: null,
        nro_documento: null,
        fecha_nacimiento: null,
        enviar_correos: 1,
        convenio: 1,
        porcentaje_comision: 0.0
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
        nombres: "",
        nro_documento: "",
        email: "",
        nro_telefono: "",
        porcentaje_comision: "",
        enviar_correos:"",
      },
      eviarcorreos_list: [
        {value: "", text: "Todos"},
        {value: 0, text: "No"},
        {value: 1, text: "Si"},
      ],

      addFormTitle: "Agregar Doctor",
      dialogEditar: false,
      validAddForm: false,
      addDialog: false,
      deleteDialog: false,
      rules: {
        required: UTILS.rules.required
      },
      activePicker: null,
      date: null,
      menu: false,

      rules: {
        required: UTILS.nRules.required,
        dni: UTILS.nRules.min8,
        only_numbers: UTILS.nRules.only_numbers,
        email: UTILS.nRules.email
      }
    };
  },
  created() {
    //
  },
  methods: {
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      const myParams = new URLSearchParams(this.filter).toString();
      try {
        const response = await API.doctores.list(
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
        };
        this.getRegistros();
    },
    handleDataRowClick(row){
        this.viewForm = Object.assign({}, row);
        this.viewDialog = true;
    },

    editReg(item) {
      this.addFormTitle = "Editar Doctor";
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
        const response = await API.doctores.remove(this.addForm.id_doctor);
        UTILS.toastr.success("Doctor eliminado correctamente", this);
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
            const response = await API.doctores.create(this.addForm);
            UTILS.toastr.success("Doctor creado correctamente", this);
          } else {
            const response = await API.doctores.update(
              this.addForm.id_doctor,
              this.addForm
            );
            UTILS.toastr.success("Doctor actualizado correctamente", this);
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
    },
    saveBirthDate(date) {
      this.addForm.fecha_nacimiento = date;
      this.$refs.menu.save(date);
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
    menu(val) {
      val && setTimeout(() => (this.activePicker = "YEAR"));
    },
    addDialog() {
      if (!this.addDialog) {
        // console.log('Dialog is closing');
        this.dialogEditar = false;
        this.$refs.addForm.reset();
        this.validAddForm = false;
        this.addFormTitle = "Agregar Doctor";
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
