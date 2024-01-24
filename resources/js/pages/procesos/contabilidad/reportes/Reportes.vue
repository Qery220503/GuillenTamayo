<template>
  <div class="flex-grow-1 text-center">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <!---<v-alert
      border="right"
      color="blue"
      v-if="pendientes.length > 0"
      class="pa-2 text-left mx-auto"
      width="400"
      dense
      type="info"
    >
      <div
        style="width: 100%; display: flex; justify-content: center; align-items: center;"
      >
        <span>
          Existen cajas sin cerrar
        </span>
        <v-spacer></v-spacer>
        <v-btn color="primary" @click="cajasPendientes">
          Ver Cajas
        </v-btn>
      </div>
    </v-alert>-->
    <v-card class="pa-2 text-left mx-auto" width="800">
      <h3 class="mb-2">Generar Reporte</h3>
      <v-divider class="my-2"></v-divider>
      <v-form ref="addForm" lazy-validation>
        <v-text-field
          v-model="form.monto_inicial"
          label="Monto en Caja"
          outlined
          clearable
          type="number"
          min="0"
          prefix="S/."
          :rules="[rules.required]"
          :disabled="cajaOpen || pendientes.length > 0"
        ></v-text-field>
      </v-form>
      <v-card-actions v-if="cajaOpen">
        <v-spacer></v-spacer>
        <v-btn color="red" dark @click="cerrarCaja(caja.id_caja)">Cerrar</v-btn>
      </v-card-actions>
      <v-card-actions v-if="!cajaOpen">
        <v-spacer></v-spacer>
        <v-btn
          color="primary"
          @click="abrirCaja()"
          :disabled="pendientes.length > 0"
        >
          Guardar
        </v-btn>
      </v-card-actions>
    </v-card>

    <!-- Cajas pendientes -->
    <v-dialog v-model="dialog" max-width="450px">
      <v-card>
        <v-card-title>
          Cajas pendientes de cierre
        </v-card-title>
        <v-card-text>
          <v-row>
            <v-col> </v-col>
          </v-row>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import axios from "axios";
import API from "../../../../api";

export default {
  data() {
    return {
      dialog: false,
      breadcrumbs_title: "Reportes",
      breadcrumbs: [
        { text: "Contabilidad", disabled: false, href: "#" },
        { text: "Reportes", disabled: false, href: "#" },
        { text: "Exportar Reporte" }
      ],
      form: {},
      rules: {
        required: UTILS.nRules.required
      },
      tipo_reporte: [
        { text: "Compras", value: "compras" },
        { text: "Ventas", value: "ventas" }
      ],
      cajaOpen: false,
      caja: {},
      pendientes: []
    };
  },
  created() {
    let vm = this;
    vm.buscarCaja();
    vm.cajasSinCerrar();
  },
  methods: {
    async buscarCaja() {
      let vm = this;
      try {
        const response = await API.caja.buscar();
        vm.cajaOpen = response.data.success;
        vm.caja = response.data.data;
        console.log(vm.caja);
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async cajasSinCerrar() {
      const vm = this;
      const response = await axios.get("api/cajas-pendientes");
      vm.pendientes = [];
      vm.pendientes = response.data;
      if (vm.pendientes.length == 0) {
        vm.dialog = false;
      }
    },
    async abrirCaja() {
      if (this.$refs.addForm.validate()) {
        let vm = this;
        try {
          const response = await API.caja.abrir(vm.form);
          vm.buscarCaja();
          UTILS.toastr.success("Caja abierta correctamente", vm);
          if (this.$route.query.redirect) {
            vm.$router.push(this.$route.query.redirect);
          }
        } catch (e) {
          UTILS.toastr.error("Ups! Ocurrió un error", this);
          console.error(e);
        }
      }
    },
    async cerrarCaja(id) {
      const vm = this;
      const response = await API.caja.cerrar(id);
      this.reset();
    },
    async reset() {
      const vm = this;
      vm.caja = {};
      vm.form = {};
      vm.$refs.addForm.resetValidation();
      vm.buscarCaja();
      vm.cajasSinCerrar();
    },
    cajasPendientes() {
      this.dialog = true;
    }
  }
};
</script>
