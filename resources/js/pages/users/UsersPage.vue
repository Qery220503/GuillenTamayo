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
        <v-col v-if="$can('users_create', 'all')" class="text-right">
          <v-btn color="primary" class="mr-2" @click="addDialog = true">
            Añadir Usuario <v-icon>mdi-plus</v-icon>
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
        >
          <template v-slot:[`item.estado`]="{ item }">
            <v-chip small v-if="item.estado == 1" class="ma-2" color="success" dark>Habilitado</v-chip>
            <v-chip small v-if="item.estado == 0" class="ma-2" color="error">Deshabilitado</v-chip>
          </template>
          <template v-slot:[`item.actions`]="{ item }">
                <div v-if="$can('users_update', 'all')">
                    <v-btn small icon @click="editReg(item)">
                    <v-icon small>mdi-border-color</v-icon>
                    </v-btn>
                </div>
                <div v-if="$can('users_delete', 'all')">
                    <v-btn small icon @click="deleteReg(item)">
                    <v-icon small>mdi-delete</v-icon>
                    </v-btn>
                </div>
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
                  v-model="addForm.name"
                  label="Nombre"
                  :rules="rules.required"
                  autocomplete="off"
                ></v-text-field>
                <v-text-field
                  v-model="addForm.email"
                  label="Email"
                  :rules="rules.required_email"
                  autocomplete="off"
                ></v-text-field>
                <v-select
                  label="Rol"
                  v-model="addForm.id_role"
                  :items="roles_list"
                  item-text="title"
                  item-value="id"
                  :rules="rules.required"
                ></v-select>

                <!-- Password Fields -->
                <v-text-field
                  v-if="dialogEditar == true"
                  label="Nueva Contraseña (Opcional)"
                  v-model="addForm.password"
                  :append-icon="showPass ? 'mdi-eye' : 'mdi-eye-off'"
                  :type="showPass ? 'text' : 'password'"
                  @click:append="showPass = !showPass"
                  autocomplete="off"
                ></v-text-field>
                <v-text-field
                  v-else
                  label="Crear Contraseña"
                  v-model="addForm.password"
                  :append-icon="showPass ? 'mdi-eye' : 'mdi-eye-off'"
                  :type="showPass ? 'text' : 'password'"
                  @click:append="showPass = !showPass"
                  :rules="rules.required"
                  autocomplete="off"
                ></v-text-field>

                <v-text-field
                  label="Confirmar Contraseña"
                  v-model="addForm.confirmed_password"
                  :append-icon="showConfPass ? 'mdi-eye' : 'mdi-eye-off'"
                  :type="showConfPass ? 'text' : 'password'"
                  @click:append="showConfPass = !showConfPass"
                  :rules="[
                    addForm.password === addForm.confirmed_password ||
                      'La confirmación de contraseña no coinde'
                  ]"
                  autocomplete="off"
                ></v-text-field>
                <!-- Password Fields -->
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

    <!-- Delete Dialog -->
    <v-dialog v-model="deleteDialog" max-width="60%">
      <v-card>
        <v-card-title>
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
  data: () => ({
    breadcrumbs_title: "Usuarios",
    breadcrumbs: [
      {
        text: "Inicio",
        disabled: false,
        href: "#"
      },
      {
        text: "Usuarios"
      }
    ],

    //--- Datatable ---
    loadingTable: false,
    current_page: 1,
    itemsperpage: 25,
    total_reg: 0,
    dataTabOptions: {},
    data_reg: [],
    headers: [
      { text: "Nombre", value: "name", align: "left" },
      { text: "Email", value: "email", align: "left" },
      { text: "Rol", value: "role.title", sortable: false , align: "left" },
      { text: "Activo", value: "estado", sortable: false, align: "center" },
      { text: "Acciones", sortable: false, value: "actions", align: "right" }
    ],
    filter: {
      searchTerm: ""
    },
    //--- End ---

    //--- Ventana Emergente ---
    addDialog: false,
    dialogEditar: false,
    validAddForm: false,
    addFormTitle: "Agregar Usuario",
    addForm: {
      id: null,
      name: null
    },
    deleteDialog: false,

    roles_list: [],
    showPass: false,
    showConfPass: false,
    //--- End ---

    //--- Form Rules ---
    rules: {
      required: UTILS.rules.required,
      required_email: UTILS.rules.required_email,

      file_size_200kb: UTILS.rules.file_size_200kb
    }
    //--- End ---
  }),
  created() {
    this.getUserRolesList();
  },
  methods: {
    async getUserRolesList() {
      try {
        const response = await API.roles.combo();
        this.roles_list = response.data;
      } catch (e) {
        console.error(e);
      }
    },

    //--- Datatable ---
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];

      try {
        const response = await API.users.list(
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
    //--- End ---

    //--- Ventana Emergente ---
    // Add/Edit/Delete Functions
    editReg(item) {
      this.addFormTitle = "Editar Usuario";
      this.dialogEditar = true;
      this.addForm = Object.assign({}, item);
      this.addDialog = true;
    },
    async saveReg() {
      if (this.$refs.addForm.validate()) {
        try {
          this.loadingTable = true;
          this.$store.commit("loader", true);

          if (this.dialogEditar == false) {
            const response = await API.users.create(this.addForm);
            UTILS.toastr.success("Usuario creado correctamente", this);
          } else {
            const response = await API.users.update(
              this.addForm.id,
              this.addForm
            );
            UTILS.toastr.success("Usuario actualizado correctamente", this);
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

    deleteReg(item) {
      this.addForm = Object.assign({}, item);
      this.deleteDialog = true;
    },
    async deleteRegConfirm() {
      this.loadingTable = true;
      this.$store.commit("loader", true);

      try {
        const response = await API.users.remove(this.addForm.id);
        UTILS.toastr.success("Usuario eliminado correctamente", this);
        this.deleteDialog = false;
        this.getRegistros();
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      } finally {
        this.$store.commit("loader", false);
        this.loadingTable = false;
      }
    }
    //--- End ---
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
        this.addFormTitle = "Agregar Usuario";
      }
    }
  }
};
</script>
