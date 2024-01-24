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
          :items-per-page="50"
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
      breadcrumbs_title: "Mantenimiento Precios Productos",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Mantenimiento", disabled: false, href: "#" },
        { text: "Precios Productos" }
      ],
      headers: [
        { text: "Codigo", sortable: false, value: "codigo_producto" },
        { text: "Producto", sortable: false, value: "nombre_producto" },
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
        const response = await API.almacen_movimientos.stock();
        const info = response.data.map(entry => {
          return {
            id_producto: entry.id_producto,
            codigo_producto: entry.codigo_producto,
            nombre_producto: entry.nombre_producto,
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
          field: "mantenimiento_productos",
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
        const response = await API.productos.update_precios({
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
  }
};
</script>
