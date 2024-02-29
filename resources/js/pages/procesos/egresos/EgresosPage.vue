<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card>
      <v-row dense class="pa-2 align-center">
        <v-spacer></v-spacer>
        <v-col class="text-right">
          <v-btn color="primary" class="mr-2" @click="addDialog = true">
            Añadir Egreso <v-icon>mdi-plus</v-icon>
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
        <template v-slot:[`item.origen`]="{ item }">
            <v-chip color="primary" small>
              {{ getOrigen(item.origen) }}
            </v-chip>
          </template>


          <template v-slot:[`item.actions`]="{ item }">
            <v-btn small icon @click="editReg(item)">
              <v-icon small>mdi-border-color</v-icon>
            </v-btn>
            <v-btn small icon @click="eliminarEgreso(item)">
              <v-icon small>mdi-delete</v-icon>
            </v-btn>
          </template>
        </v-data-table>
      </v-row>
    </v-card>

    <!-- Add/Edit Dialog -->
    <v-dialog
      v-model="addDialog"
      max-width="40%"
      @click:outside="addDialog = false"
    >
      <v-card>
        <v-card-title>
          <span class="headline">
            <strong>
              {{ addFormTitle }}
            </strong>
          </span>
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
                <v-text-field label="Monto *" v-model="addForm.monto" type="number"
                    min="0"
                    placeholder="0,00"
                    :rules="rules.required"
                    autocomplete="off"
                    filled
                ></v-text-field>
                <v-text-field
                  v-model="addForm.descripcion"
                  label="Descripción"
                  :rules="rules.required"
                  autocomplete="off"
                  filled
                ></v-text-field>
                <v-select
                  :rules="rules.required"
                  :items="items_origen_dinero"
                  label="Origen Dinero"
                  placeholder="Selecciona el origen de dinero"
                  v-model="addForm.origen"
                  required
                  filled
                ></v-select>
                <v-select
                  :rules="rules.required"
                  :items="medios_pago"
                  item-text="medio_pago"
                  item-value="id_medio_pago"
                  label="Medio de pago"
                  placeholder="Selecciona el medio de pago"
                  v-model="addForm.id_medio_pago"
                  required
                  filled
                ></v-select>
                <v-select
                  :rules="rules.required"
                  :items="proveedores"
                  item-text="nombre"
                  item-value="id_proveedor"
                  label="Proveedor"
                  placeholder="Selecciona el medio de pago"
                  v-model="addForm.id_proveedor"
                  required
                  filled
                ></v-select>
                <v-text-field
                  v-model="addForm.observaciones"
                  label="Observaciones"
                  :rules="rules.required"
                  autocomplete="off"
                  filled
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
  </div>
</template>
<script>
export default {
  data() {
    return {
      breadcrumbs_title: "Egresos",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Maestros", disabled: false, href: "#" },
        { text: "Egresos" }
      ],
      headers: [
        { text: "#", value: "id_egreso", align: "left" },
        { text: "Descripción", value: "descripcion", align: "left" },
        { text: "Monto", value: "monto", align: "left" },
        { text: "Origen", value: "origen", align: "left" },
        { text: "Usuario", value: "usuario.email", align: "left"},
        { text: "Acciones", sortable: false, value: "actions", align: "right" }
      ],

      addForm: {
        monto: 0,
        descripcion: null,
        origen: 1,
        id_medio_pago: 1,
        id_proveedor:1,
        observaciones: null,
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
      addFormTitle: "Agregar Egreso",
      dialogEditar: false,
      validAddForm: false,
      addDialog: false,
      deleteDialog: false,
      rules: {
        required: UTILS.rules.required
      },
      items_origen_dinero: [
        { text: "Caja chica", value: 1 },
        { text: "Cuenta Bancaria", value: 2 },
        { text: "Caja Fuerte", value: 3 }
      ],
      medios_pago: [],
      proveedores: []
    };
  },
    mounted(){
        this.checkIfCashIsOpen("/egresos");
    },
    created() {
        this.getRegistros();
        this.getMediosPago();
        this.getProveedor();
    },
  methods: {
    getOrigen(id) {
      let item = this.items_origen_dinero.find(e => e.value == id);
      return item.text;
    },
    limpiarFiltros() {
      this.filter.searchTerm = "";
      this.getRegistros();
    },
    async getRegistros(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.egresos.list(
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
    editReg(item) {
      this.addFormTitle = "Editar Egreso";
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
            const response = await API.egresos.create(this.addForm);
            UTILS.toastr.success("Egreso creado correctamente", this);
          } else {
            const response = await API.egresos.update(
              this.addForm.id_egreso,
              this.addForm
            );
            UTILS.toastr.success("Egreso actualizado correctamente", this);
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
    async eliminarEgreso(item) {
      try {
        const response = await API.egresos.delete(item.id_egreso);
        this.getRegistros();
        UTILS.toastr.success("Egreso eliminado correctamente!", this);
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getMediosPago() {
      let vm = this;
      try {
        const response = await API.apis.medioPago();
        vm.medios_pago = response.data;
      } catch (e) {
        UTILS.toastrr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getProveedor() {
      let vm = this;
      try {
        const response = await API.proveedores.combo();
        vm.proveedores = response.data;
      } catch (e) {
        UTILS.toastrr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

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
        this.addFormTitle = "Agregar Egreso";
      }
    }
  },
};
</script>
