<template>
  <v-container>
    <v-container>
      <v-row dense>
        <v-col cols="12">
          <v-card v-for="(etapa, idx) in etapas" style="margin-top: 15px;" :key="idx">
            <v-card-title class="text-h5">
              <strong>{{ etapa }}</strong>
            </v-card-title>

            <v-card-text>
              <div  v-for="(pregunta, indice) in preguntas" :key="indice" v-if="pregunta.etapa.etapa == etapa" style="display:flex; justify-content: space-between; align-items: center;">
                <div style="width: 70%;">
                 {{ pregunta.pregunta }}
                </div>
                <div
                  style="width: 30%;  display:flex; justify-content: center;"
                >
                  <v-radio-group v-if="pregunta.alternativas == 3" row v-model="respuestas[pregunta.id_encuesta_pregunta]">
                    <v-radio label="SI" :value="1"></v-radio>
                    <v-radio label="NO" :value="2"></v-radio>
                    <v-radio label="N/A" :value="0"></v-radio>
                  </v-radio-group>
                  <v-radio-group v-else row v-model="respuestas[pregunta.id_encuesta_pregunta]">
                    <v-radio label="SI" :value="1"></v-radio>
                    <v-radio label="NO" :value="2"></v-radio>
                  </v-radio-group>
                </div>
              </div>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <!-- Segunda Parte -->
    <v-container v-if="parte == 2">

      <v-row dense>
        <v-col cols="12">
          <v-card>
            <v-card-title class="text-h5">
              <strong>Satisfacción General</strong>
            </v-card-title>

            <v-card-text>
              <div
                style="display:flex; justify-content: space-between; align-items: center;"
              >
                <div style="width: 70%;">
                  ¿Comó calificaria la atención recibida?
                </div>
                <div
                  style="width: 30%;  display:flex; justify-content: center;"
                >
                  <v-rating hover length="5" size="28" v-model="encuesta.nivel_satisfaccion"></v-rating>
                </div>
              </div>

              <div
                style="display:flex; justify-content: space-between; align-items: center;"
              >
                <div
                  style="width: 100%;  display:flex; justify-content: center;"
                >
                  <v-text-field
                    v-model="encuesta.sugerencias"
                    label="Sugerencias"
                    name="name"
                    textarea
                    filled
                  ></v-text-field>
                </div>
              </div>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <v-container class="d-flex justify-end align-center">
      <v-btn color="success" @click="save">Guardar</v-btn>
    </v-container>
  </v-container>
</template>
<script>
export default {
  data() {
    return {
      parte: 1,
      encuesta: {
        id_encuesta: null,
      },
      preguntas: [],
      respuestas: {},
      etapas: [],
    };
  },
  created() {
    const vm = this;
    vm.getPreguntas();
  },
  watch: {
    respuestas(val){
      console.log(val)
    }
  },
  methods: {

    async save(){
      const vm = this;
        if(vm.preguntas.length != Object.keys(vm.respuestas).length){
          return;
        }
        let mappedObject = Object.keys(vm.respuestas).map(key => {
          return { id_encuesta: vm.encuesta.id_encuesta, id_encuesta_pregunta: key, respuesta: vm.respuestas[key] };
        });
        vm.encuesta.respuestas = mappedObject;
        const response = await API.encuestas.responder(vm.encuesta.id_encuesta, vm.encuesta);
        this.$root.$router.push({
          path: '/comprobantes', 
        });
    },
    async getPreguntas(){
      const vm = this;
      const comprobante = vm.$route.params.comprobante;
      const res = await API.encuestas.preguntas(comprobante);
      vm.parte = res.data.parte;
      if(vm.parte == 3){
        this.$root.$router.push({
          path: '/comprobantes', 
        });
        return; 
      }
      vm.encuesta = res.data.encuesta;
      vm.preguntas = res.data.preguntas;
      vm.etapas = vm.preguntas.filter((item, index) => {
        return (
          index === vm.preguntas.findIndex(obj => {
            return obj.id_etapa_encuesta === item.id_etapa_encuesta;
          })
        );
      }).map((e) => e.etapa.etapa);
    }
  }
};
</script>
<style lang=""></style>
