<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card>
      <v-row dense class="pa-2 align-center">
        <v-col class="text-right">
          <v-btn color="#1D6F42" class="mr-2" dark :href="urlToReturn">
            Exportar<v-icon>mdi-file-excel</v-icon>
          </v-btn>
          <v-btn color="primary" class="mr-2" to="/paciente/crear" link>
            Añadir Pacientes <v-icon>mdi-plus</v-icon>
          </v-btn>
        </v-col>
      </v-row>
      <v-row dense class="pa-2 align-center">
        <v-data-table
          light
          :headers="headers"
          :items="dataReg.data"
          :page="currentPage"
          :items-per-page="itemsPerPage"
          :server-items-length="totalReg"
          :options.sync="dataTabOptions"
          class="flex-grow-1 scroll-me"
          :footer-props="{
            itemsPerPageOptions: [25, 50, 100, 1000],
          }"
          :loading="loadingTable"
          loading-text="Cargando... Por favor, espere"
          @click:row="handleDataRowClick"
        >
          <template v-slot:[`body.prepend`]>
            <tr>
              <td></td>
              <td>
                <v-text-field
                  v-model="filter.nombre_razon_social"
                  type="text"
                  outlined
                  dense
                  class="mt-1 mb-1"
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
                  class="mt-1 mb-1"
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
                  class="mt-1 mb-1"
                  hide-details
                  @input="getRegistros()"
                ></v-text-field>
              </td>
              <td>
                <v-text-field
                  v-model="filter.telefono"
                  type="text"
                  outlined
                  dense
                  class="mt-1 mb-1"
                  hide-details
                  @input="getRegistros()"
                ></v-text-field>
              </td>
              <td>
                <v-select
                  :items="items_ocupacion"
                  v-model="filter.ocupacion"
                  item-text="nombre_ocupacion"
                  item-value="id_ocupacion"
                  label="Ocupación"
                  outlined
                  dense
                  class="mt-1 mb-1"
                  @change="getRegistros()"
                  hide-details
                ></v-select>
              </td>
              <td>
                <v-select
                  :items="deudasItems"
                  v-model="filter.debts"
                  item-text="label"
                  item-value="value"
                  label="Deuda"
                  outlined
                  dense
                  class="mt-1 mb-1"
                  @change="getRegistros()"
                  hide-details
                ></v-select>
              </td>
              <td></td>
              <td>
                <v-btn small icon @click="limpiarFiltros">
                  <v-icon small>mdi-broom</v-icon>
                </v-btn>
              </td>
            </tr>
          </template>
          <template #[`item.index`]="{ item }">
            {{ dataReg.data.indexOf(item) + 1 }}
          </template>
          <template v-slot:[`item.nombre_razon_social`]="{ item }">
            <div class="one-line">
              {{ item.nombre_razon_social }}
            </div>
          </template>
          <template v-slot:[`item.cuenta_corriente`]="{ item }">
            <v-btn
              color="info"
              :disabled="item.id_cliente == 1"
              :to="'/pacientes/cuenta-corriente/' + item.id_cliente"
              @click.stop.prevent
              small
              link
            >
              <v-icon small class="mr-1">mdi-format-list-bulleted-square</v-icon
              >Cuenta Corriente
            </v-btn>
          </template>
          <template v-slot:[`item.has_deudas`]="{ item }">
            <v-chip class="ma-2" color="error" small v-if="item.has_deudas">
              <span class="font-weight-medium">Con deudas</span>
            </v-chip>

            <v-chip class="ma-2" color="success" small v-else>
              <span class="font-weight-medium">Sin deudas</span>
            </v-chip>
          </template>
          <template v-slot:[`item.actions`]="{ item }">
            <v-btn
              v-if="item.id_cliente == 1"
              small
              icon
              :to="'/paciente/editar/' + item.id_cliente"
              :disabled="item.id_cliente == 1"
              @click.stop.prevent
              link
            >
              <v-icon small>mdi-eye</v-icon>
            </v-btn>
            <v-btn
              v-else
              small
              icon
              :to="'/paciente/editar/' + item.id_cliente"
              @click.stop.prevent
              link
            >
              <v-icon small>mdi-border-color</v-icon>
            </v-btn>
            
            <v-btn
              small
              icon
              @click.stop="deleteReg(item)"
              :disabled="item.id_cliente == 1"
            >
              <v-icon small>mdi-delete</v-icon>
            </v-btn>
          </template>
        </v-data-table>
      </v-row>
    </v-card>

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
                  v-model="viewForm.tipo_doc"
                  label="Tipo Documento"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.nombre_razon_social"
                  label="Nombre"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.email"
                  label="Correo Electrónico"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.ocupacion"
                  label="Ocupación"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.provincia"
                  label="Provincia"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.direccion"
                  label="Dirección"
                  readonly
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="6">
                <v-text-field
                  v-model="viewForm.nro_documento"
                  label="Nro. Documento"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.telefono"
                  label="Teléfono"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.fecha_nacimiento"
                  label="Fecha de Nacimiento"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.departamento"
                  label="Departamento"
                  readonly
                ></v-text-field>
                <v-text-field
                  v-model="viewForm.distrito"
                  label="Distrito"
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
import API from "../../../api";

export default {
  data() {
    return {
      breadcrumbs_title: "Pacientes",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Maestros", disabled: false, href: "#" },
        { text: "Pacientes" },
      ],
      viewDialog: false,
      viewForm: {},

      deudasItems: [
        { label: "Todos", value: "all" },
        { label: "Con Deudas", value: "debt" },
        { label: "Sin Deudas", value: "no-debt" },
      ],
      addForm: {
        id_cliente: null,
        nombre_categoria: null,
      },
      //--- Datatable ---
      loadingTable: false,
      currentPage: 1,
      pageCount: 1,
      itemsPerPage: 25,
      totalReg: 0,
      dataTabOptions: {},
      dataReg: {},
      headers: [
        { text: "Nº", value: "index", align: "left" },
        { text: "Paciente", value: "nombre_razon_social", align: "left" },
        { text: "Nro. Documento", value: "nro_documento", align: "left" },
        { text: "Correo Electrónico", value: "email", align: "left" },
        { text: "Teléfono", value: "telefono", align: "left" },
        {
          text: "Ocupación",
          value: "ocupacion.nombre_ocupacion",
          align: "left",
        },
        { text: "Deudas", value: "has_deudas", align: "left" },
        { text: "Cuenta Corriente", value: "cuenta_corriente", align: "left" },
        { text: "Acciones", sortable: false, value: "actions", align: "right" },
      ],

      filter: {
        searchTerm: "",
        nombre_razon_social: "",
        nro_documento: "",
        email: "",
        telefono: "",
        debts: "all",
        ocupacion: "",
      },
      items_ocupacion: [],
      addFormTitle: "Agregar Paciente",
      dialogEditar: true,
      validAddForm: false,
      addDialog: false,
      deleteDialog: false,
      urlToReturn: "",
      rules: {
        required: UTILS.rules.required,
      },
    };
  },

  created() {
    this.getOcupaciones();
    const idOcupacion = this.$route.query.ocupacion;
    if (idOcupacion != undefined && idOcupacion != null) {
      this.filter.ocupacion = idOcupacion;
    }
  },
  methods: {
    //--- Datatable ---
    async getRegistros(page = 1, perPage = 25, sortDesc = 0, sortBy = "") {
      this.loadingTable = true;
      this.dataReg = [];
      const myParams = new URLSearchParams(this.filter).toString();
      try {
        const response = await API.clientes.list(
          "?page=" +
            page +
            "&perPage=" +
            perPage +
            "&sortDesc=" +
            sortDesc +
            "&sortBy=" +
            sortBy +
            "&" +
            myParams
        );
        this.dataReg = response.data;
        this.currentPage = this.dataReg.current_page;
        this.pageCount = this.dataReg.last_page;
        this.totalReg = this.dataReg.total;
        this.getExportData();
      } catch (e) {
        console.error(e);
      } finally {
        this.loadingTable = false;
      }
    },
    limpiarFiltros() {
      this.filter = {
        debts: "all",
      };
      this.getRegistros();
    },
    handleDataRowClick(row) {
      this.viewForm = Object.assign({}, row);
      this.viewForm.tipo_doc = row.tipo_documento.nombre_tipo_documento;
      this.viewForm.ocupacion = row.ocupacion
        ? row.ocupacion.nombre_ocupacion
        : null;
      this.viewForm.departamento = row.departamento
        ? row.departamento.nombre_departamento
        : null;
      this.viewForm.provincia = row.provincia
        ? row.provincia.nombre_provincia
        : null;
      this.viewForm.distrito = row.distrito
        ? row.distrito.nombre_distrito
        : null;
      this.viewDialog = true;
    },
    getExportData() {
      this.urlToReturn =
        "/api/exportPacientes/?" + new URLSearchParams(this.filter).toString();
    },
    //--- End ---

    deleteReg(item) {
      this.addForm = Object.assign({}, item);
      this.deleteDialog = true;
    },
    async deleteRegConfirm() {
      this.loadingTable = true;
      this.$store.commit("loader", true);

      try {
        const response = await API.clientes.remove(this.addForm.id_producto);
        UTILS.toastr.success("Paciente eliminado correctamente", this);
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

    async getOcupaciones() {
      try {
        const response = await API.clientes.ocupacion();
        this.items_ocupacion = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
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
        this.dialogEditar = false;
        this.$refs.addForm.reset();
        this.validAddForm = false;
        this.addFormTitle = "Agregar Paciente";
      }
    },
    viewDialog() {
      if (!this.viewDialog) {
        this.$refs.viewForm.reset();
      }
    },
  },
};
</script>
