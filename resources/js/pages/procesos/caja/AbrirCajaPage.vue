<template>
  <div class="flex-grow-1 text-center">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-alert
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
    </v-alert>
    <v-card class="pa-2 text-left mx-auto" width="400">
      <h3 class="mb-2">Abrir Caja</h3>
      <div>
        Último cierre de caja: <br />
        <strong>
          {{ caja.updated_at | formatDateGeneral }} {{ caja.updated_at | formatTime }}
        </strong>
      </div>
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
          <v-simple-table>
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">
                    ID
                  </th>
                  <th class="text-left">
                    Monto Inicial
                  </th>
                  <th>
                    Fecha
                  </th>
                  <th>
                    Acciones
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="item in pendientes" :key="item.name">
                  <td>{{ item.id_caja }}</td>
                  <td>{{ item.monto_inicial }}</td>
                  <td>{{ new Date(item.created_at).toLocaleDateString() }}</td>
                  <td>
                    <v-btn color="red" dark @click="cerrarCaja(item.id_caja)"
                      >Cerrar</v-btn
                    >
                  </td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import axios from "axios";
import API from "../../../api";

export default {
  data() {
    return {
      dialog: false,
      breadcrumbs_title: "Abrir Caja",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Abrir Caja" }
      ],
      form: {},
      rules: {
        required: UTILS.nRules.required
      },
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
