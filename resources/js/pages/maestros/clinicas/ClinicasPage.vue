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
          <v-btn color="#1D6F42" class="mr-2" dark href="/api/exportClinica">
            Exportar<v-icon>mdi-file-excel</v-icon>
          </v-btn>
          <v-btn color="primary" class="mr-2" @click="addDialog = true">
            Añadir Clínica <v-icon>mdi-plus</v-icon>
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
                  v-model="filter.nombre_clinica"
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
                  v-model="filter.email_clinica"
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
                  v-model="filter.telefono_clinica"
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
                  v-model="filter.descuento"
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
                        v-model="filter.afiliacion"
                        :items="afiliaciones_list"
                        item-text="text"
                        item-value="value"
                        label="Afiliación"
                        hide-details
                        outlined
                        @input="getRegistros()"
                        dense
                    ></v-select>
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
          <template v-slot:[`item.descuento`]="{ item }">
                {{ item.descuento }}%
          </template>
          <template v-slot:[`item.afiliacion`]="{ item }">
            <v-chip
                small
                v-if="item.afiliacion == 1"
                class="ma-2"
                color="success">
                Afiliado
            </v-chip>
            <v-chip
                small
                v-if="item.afiliacion == 0"
                class="ma-2"
                color="error">
                No Afiliado
            </v-chip>
          </template>
          <template v-slot:[`item.enviar_correos`]="{ item }">
            <v-chip
                small
                v-if="item.enviar_correos == 1"
                class="ma-2"
                color="success">
                Autorizado
            </v-chip>
            <v-chip
                small
                v-if="item.enviar_correos == 0"
                class="ma-2"
                color="error">
                No Autorizado
            </v-chip>
          </template>
          <template v-slot:[`item.actions`]="{ item }">
                <v-btn small icon @click.stop="editReg(item)" :disabled="item.id_clinica == 1">
                    <v-icon small>mdi-border-color</v-icon>
                </v-btn>
                <v-btn small icon @click.stop="deleteReg(item)" :disabled="item.id_clinica == 1">
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
            lazy-validation>
            <v-row>
              <v-col>
                <v-text-field
                  v-model="addForm.nombre_clinica"
                  label="Razón Social"
                  :rules="[rules.required]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.email_clinica"
                  label="Email"
                  :rules="[rules.email, rules.required]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.telefono_clinica"
                  label="Teléfono"
                  :rules="[rules.required]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>
                <v-text-field
                  v-model="addForm.descuento"
                  label="Descuento %"
                  :rules="[rules.required]"
                  autocomplete="off"
                  filled
                  dense
                ></v-text-field>

                <v-radio-group v-model="addForm.afiliacion" row>
                  <template v-slot:label>
                    <div>Afiliación:</div>
                  </template>
                  <v-radio label="Si" :value="1"></v-radio>
                  <v-radio label="No" :value="0"></v-radio>
                </v-radio-group>

                <v-radio-group v-model="addForm.enviar_correos" row v-if="(addForm.afiliacion == 1)">
                  <template v-slot:label>
                    <div>Envio de correos:</div>
                  </template>
                  <v-radio label="Si" :value="1"></v-radio>
                  <v-radio label="No" :value="0"></v-radio>
                </v-radio-group>
              </v-col>
            </v-row>
            <br />
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="error" text @click="addDialog = false">Cancelar</v-btn>
                <v-btn type="submit" color="primary" :disabled="!validAddForm">Guardar</v-btn>
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
                                v-model="viewForm.nombre_clinica"
                                label="Razón Social"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.email_clinica"
                                label="Email"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.telefono_clinica"
                                label="Teléfono"
                                readonly
                            ></v-text-field>
                            <v-text-field
                                v-model="viewForm.descuento"
                                label="Descuento %"
                                readonly
                            ></v-text-field>
                            <v-radio-group v-model="viewForm.afiliacion" row readonly>
                                <template v-slot:label>
                                    <div>Afiliación:</div>
                                </template>
                                <v-radio label="Si" :value="1"></v-radio>
                                <v-radio label="No" :value="0"></v-radio>
                            </v-radio-group>
                            <v-radio-group v-if="(viewForm.afiliacion == 1)" v-model="viewForm.enviar_correos" row readonly>
                                <template v-slot:label>
                                    <div>Envío de correos:</div>
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
      breadcrumbs_title: "Clínicas",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Maestros", disabled: false, href: "#" },
        { text: "Clínicas" }
      ],
      headers: [
        { text: "#", value: "id_clinica", align: "left" },
        { text: "Razón Social", value: "nombre_clinica", align: "left" },
        { text: "Email", value: "email_clinica", align: "left" },
        { text: "Teléfono", value: "telefono_clinica", align: "left" },
        { text: "Descuento", value: "descuento", align: "left" },
        { text: "Afiliación", value: "afiliacion", align: "left" },
        {
          text: "Enviar Correos",
          value: "enviar_correos",
          align: "center"
        },
        {
          text: "Acciones",
          sortable: false,
          value: "actions",
          align: "right"
        }
      ],
        viewDialog: false,
        viewForm: {
        },

      addForm: {
        nombre_clinica: null,
        telefono_clinica: null,
        email_clinica: null,
        afiliacion: 0,
        descuento: 10,
        enviar_correos: 0,
      },
        defaultAddForm: {
            afiliacion: 0,
            descuento: 10,
            enviar_correos: 0,
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
        nombre_clinica: "",
        email_clinica: "",
        telefono_clinica: "",
        enviar_correos:"",
        afiliacion:"",
      },
      afiliaciones_list: [
        {value: "", text: "Todos"},
        {value: 0, text: "No"},
        {value: 1, text: "Si"},
      ],
      eviarcorreos_list: [
        {value: "", text: "Todos"},
        {value: 0, text: "No"},
        {value: 1, text: "Si"},
      ],

      addFormTitle: "Agregar Clínica",
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
        const response = await API.clinicas.list(
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
            afiliacion: "",
      };
      this.getRegistros();
    },
    handleDataRowClick(row){
        this.viewForm = Object.assign({}, row);
        this.viewDialog = true;
    },

    editReg(item) {
      this.addFormTitle = "Editar Clínica";
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
        const response = await API.clinicas.remove(this.addForm.id_clinica);
        UTILS.toastr.success("Clínica eliminada correctamente", this);
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

          if(this.addForm.afiliacion != 1 && this.addForm.enviar_correos != 0){
            this.addForm.enviar_correos = 0
          }

          if (this.dialogEditar == false) {
            const response = await API.clinicas.create(this.addForm);
            UTILS.toastr.success("Clínica creada correctamente", this);
          } else {
            const response = await API.clinicas.update(
              this.addForm.id_clinica,
              this.addForm
            );
            UTILS.toastr.success("Clínica actualizada correctamente", this);
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
                this.dialogEditar = false;
                this.addFormTitle = "Agregar Clínica";

                this.$refs.addForm.resetValidation();
                this.validAddForm = false;
                this.addForm = Object.assign({}, this.defaultAddForm);
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
