<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card>
      <v-row dense class="pa-2 align-center overflow-x-auto ">
        <v-data-table
          light
          :headers="headers"
          :items="data_reg"
          :items-per-page="50"
          class="flex-grow-1 scroll-me"
        >
        </v-data-table>
      </v-row>
    </v-card>
  </div>
</template>
<script>
import API from "../../../api";

export default {
  components: {},
  data() {
    return {
      breadcrumbs_title: "Stock de productos",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Stock de productos" }
      ],
      headers: [
        { text: "Codigo", sortable: false, value: "codigo_producto" },
        { text: "Producto", sortable: false, value: "nombre_producto" },
        { text: "Precio Compra", sortable: false, value: "precio_compra" },
        { text: "Precio Venta", sortable: false, value: "precio_venta" },
        { text: "Stock", sortable: false, value: "stock" }
        // { text: "Acciones", sortable: false, value: "stock" }
      ],
      //--- Datatable ---
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
      total_reg: 0,
      dataTabOptions: {},
      data_reg: {}
    };
  },
  methods: {
    async getRegistros() {
      this.loadingTable = true;
      this.data_reg = [];
      try {
        const response = await API.almacen_movimientos.stock();
        this.data_reg = response.data;
        this.loadingTable = false;
      } catch (e) {
        this.loadingTable = false;
        console.error(e);
      }
    }
  },
  watch: {},
  created() {
    this.getRegistros();
  }
};
</script>
