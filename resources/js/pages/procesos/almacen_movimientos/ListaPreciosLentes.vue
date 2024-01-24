<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card class="mb-2">
      <div class="d-flex pa-2 ">
        <div style="width: 80%">
          <p class="ma-0">
            Esta sección es unicamente para realizar cambios en la lista de
            precios, al momento de habilitar el mantenimiento se deshabilitara
            temporalmente el proceso de venta y cotizaciones
          </p>
        </div>
        <v-spacer></v-spacer>
        <v-switch
          v-model="switch1"
          @change="habilitar()"
          :label="switch1 ? 'En mantenimiento' : 'No mantenimiento'"
        ></v-switch>
      </div>
    </v-card>
    <v-card>
      <v-row dense class="pa-2 align-center overflow-x-auto ">
        <v-overlay :absolute="absolute" :value="!switch1"> </v-overlay>
        <v-data-table
          light
          :headers="headers"
          :items="data_reg"
          :items-per-page="100"
          class="flex-grow-1 scroll-me"
        >
          <template v-slot:item.precio_venta_update="{ item }">
            <div class="actions d-flex justify-content-between">
              <v-text-field
                v-model="item.precio_venta_update"
                hide-details
                dense
                light
                solo
              ></v-text-field>
            </div>
          </template>
        </v-data-table>
      </v-row>
      <v-divider></v-divider>
      <br />
      <v-card-actions class="justify-end">
        <v-btn @click="showAlertConfirm()" color="primary">Guardar</v-btn>
      </v-card-actions>
    </v-card>
  </div>
</template>
<script>
import API from "../../../api";

export default {
  components: {},
  data() {
    return {
      breadcrumbs_title: "Mantenimiento Precios Lentes",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Mantenimiento", disabled: false, href: "#" },
        { text: "Precios Lentes" }
      ],
      headers: [
        { text: "Nombre Lab.", sortable: false, value: "nombre_laboratorio" },
        { text: "Nombre", sortable: false, value: "nombre_propio" },
        { text: "Laboratorio", sortable: false, value: "laboratorio" },
        { text: "Precio Compra", sortable: false, value: "precio_compra" },
        { text: "Precio Venta Actual", sortable: false, value: "precio_venta" },
        {
          text: "Nuevo Precio Venta",
          sortable: false,
          value: "precio_venta_update"
        }
        // { text: "Acciones", sortable: false, value: "stock" }
      ],
      //--- Datatable ---
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
      total_reg: 0,
      dataTabOptions: {},
      data_reg: {},
      switch1: false,
      absolute: true
    };
  },
  watch: {},
  methods: {
    showAlertConfirm() {
      this.$swal({
        title: "¿Estas seguro de actualizar la lista de precios?",
        text:
          "Esto realizara cambios en los futuros procesos de ventas y cotizaciones",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Aceptar",
        cancelButtonText: "Cancelar"
      }).then(result => {
        if (result.value) {
          this.actualizarLista();
          //this.$swal("Actual!", "Your file has been deleted.", "success");
        }
      });
    },
    async getRegistros() {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.precioslentes.stock();
        const info = response.data.map(entry => {
          return {
            id_precio_lente: entry.id_precio_lente,
            nombre_propio: entry.nombre_propio,
            nombre_laboratorio: entry.nombre_laboratorio,
            precio_compra: entry.precio_compra,
            precio_venta: entry.precio_venta,
            precio_venta_update: entry.precio_venta
          };
        });
        this.data_reg = info;
        this.loadingTable = false;
      } catch (e) {
        this.loadingTable = false;
        console.error(e);
      }
    },
    async mantenimiento() {
      let vm = this;
      try {
        const response = await API.sucursales.mantenimiento();
        vm.switch1 = response.data.mantenimiento_lentes;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async habilitar() {
      let vm = this;
      this.$store.commit("loader", true);
      try {
        const response = await API.sucursales.mantenimiento_update({
          field: "mantenimiento_lentes",
          status: this.switch1
        });
        this.$store.commit("loader", false);
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
        this.$store.commit("loader", false);
      }
    },
    async actualizarLista() {
      let vm = this;
      this.$store.commit("loader", true);
      try {
        const response = await API.precioslentes.update_precios({
          data: this.data_reg
        });
        this.switch1 = false;
        this.getRegistros();
        this.habilitar();
        this.$store.commit("loader", false);
        this.$swal("Actualizado!", "Lista de precios Actualizada", "success");
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
        this.$store.commit("loader", false);
      }
    }
  },
  watch: {},
  created() {
    this.getRegistros();
    this.mantenimiento();
  }
};
</script>
