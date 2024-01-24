<template>
  <v-dialog v-model="dialog" width="1000">
    <v-card>
      <v-card-title class="text-h5 grey lighten-2">
        Utilizar Recetas Anteriores
      </v-card-title>

      <v-card-text class="py-3">
        <v-expansion-panels>
          <v-expansion-panel
            v-for="(item, index) in history"
            :key="'historial_' + index"
          >
            <v-expansion-panel-header>
              Fecha de medida: {{ item.created_at | formatDateGeneral }}
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              <div class="d-flex">
                <v-spacer></v-spacer>
                <v-btn depressed color="info" @click="seleccionarReceta(index)">
                  Seleccionar Receta
                </v-btn>
              </div>
              <MeasuresComponent :recipes="item.receta" :noeditable="true"></MeasuresComponent>
              
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
<script>
import MeasuresComponent from '../../../../components/measures/MeasuresComponent.vue';

export default {
  components: {
    MeasuresComponent,
  },
  data() {
    return {
      dialog: false,
      history: []
    };
  },
  mounted() {
    let vm = this;
    vm.$root.$on("get_historial_cliente", id_clienet => {
      this.getHistorial(id_clienet);
    });
  },
  methods: {
    async getHistorial(id_cliente) {
      let vm = this;
      try {
        const response = await API.orden_laboratorio.historial(id_cliente);
        this.history = response.data;
        this.dialog = true;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    seleccionarReceta(index) {
      this.$root.$emit("seleccionar_receta", this.history[index]);
      this.dialog = false;
    }
  }
};
</script>
