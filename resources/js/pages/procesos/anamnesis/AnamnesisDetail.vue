<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs :breadcrumbs_title="breadcrumbs_title" :breadcrumbs="breadcrumbs"></custom-breadcrumbs>
    <v-card class="mb-4 px-3 py-2">
      <div class="px-2" style="overflow-x: hidden !important; overflow-y: hidden !important">
        <v-row class="mt-2 align-center">
          <v-col class="px-1" cols="12" md="4">
            <h2 class="mb-1">Anamnesis</h2>
            <h4>#{{ String(anamnesis.id_anamnesis).padStart(8, "0") }}</h4>
          </v-col>
          <v-spacer></v-spacer>
          <v-col class="py-2 px-1" cols="12" md="4">
            <h4 class="mb-1">Estado de la anamnesis</h4>
            <v-text-field v-model="estado" name="name" label="Estado" id="id" readonly>
            </v-text-field>
          </v-col>
        </v-row>

        <v-divider class="my-4"></v-divider>

        <v-row class="mt-2 align-center">
          <v-col class="px-1" cols="12" md="4">
            <h4>Paciente</h4>
          </v-col>
          <v-spacer></v-spacer>
          <v-col class="py-2 px-1" cols="12" md="4">
            <v-text-field v-model="anamnesis.cliente.nombre_razon_social" name="name" label="Cliente" id="id" readonly>
              <template #append-outer>
                <v-btn color="info" :to="'/paciente/editar/' + anamnesis.cliente.id_cliente">Ver</v-btn>
              </template>
            </v-text-field>
          </v-col>
        </v-row>

        <v-divider class="my-4"></v-divider>
        <v-row>
          <v-col class="py-2 px-1" cols="12" md="12">
            <h4>Historial de Estados</h4>
            <v-container style="width: 600px">
              <v-timeline dense clipped>
                <v-slide-x-transition group>
                  <v-timeline-item v-for="(estado, idx) in anamnesis.historial" :key="idx" class="mb-4" color="primary"
                    small>
                    <v-row>
                      <v-col cols="7">
                        <span>
                          <strong>{{ estados[estado.estado] }}</strong> </span><br />
                        <span> Por {{ estado.user.name }} </span>
                        <br />
                        <small> {{ estado.user.email }} </small>
                      </v-col>
                      <v-col class="text-right" cols="5">
                        {{ estado.created_at | formatDateGeneral }}
                      </v-col>
                    </v-row>
                  </v-timeline-item>
                </v-slide-x-transition>
              </v-timeline>
            </v-container>
          </v-col>
        </v-row>
        <v-divider class="my-4"></v-divider>
        <v-row>
          <v-col class="py-2 px-1" cols="12" md="12">
            <h4>Antecedentes</h4>
          </v-col>
          <v-container>
            <v-row>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field label="Antecedentes Familiares" v-model="anamnesis.antecedentes_familiares" dense filled
                  readonly></v-text-field>
              </v-col>

              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field label="Medicamentos que actualmente utiliza" v-model="anamnesis.medicamentos" dense filled
                  readonly></v-text-field>
              </v-col>

              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field label="Frecuencia de visita al oculista" v-model="anamnesis.frecuencia_visita" dense filled
                  readonly></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-row>

        <v-row>
          <v-col class="py-2 px-1" cols="12" md="12">
            <h4>Referencia</h4>
          </v-col>
          <v-container>
            <v-row>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field label="Clinica Referente" v-model="anamnesis.clinica.nombre_clinica" dense filled
                  readonly></v-text-field>
              </v-col>

              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field label="Medicamentos que actualmente utiliza" v-model="anamnesis.doctor.nombres" dense filled
                  readonly></v-text-field>
              </v-col>

              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field label="Frecuencia de visita al oculista" v-model="anamnesis.empresa.nombre_empresa" dense filled
                  readonly></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-row>
      </div>
    </v-card>
  </div>
</template>
<script>
import API from "../../../api";

export default {
  data() {
    return {
      breadcrumbs_title: "Listado de Anamnesis",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Listado de Anamnesis" },
      ],
      anamnesis: {
        id_anamnesis: "",
        historial: [],
        estado: "",
        sintomas: "",
        medicamentos: "",
        frecuencia_visita: "",
        antecedentes_familiares: "",
        cliente: {
          id_cliente: '',
          nombre_razon_social: ''
        },
        clinica:{
          nombre_clinica: ''
        },
        empresa: {
          nombre_empresa: ''
        },
        doctor: {
          nombres: ''
        }
      },
      estados: {
        anamnesis_creada: "Anamnesis Iniciada",
        anamnesis_paso_1: "Paso 1 completado",
        anamnesis_paso_2: "Paso 2 completado",
        anamnesis_paso_3: "Paso 3 completado",
        anamnesis_cerrada: "Anamnesis Completada",
        anamnesis_archivada_usuario: "Anamnesis archivada por usuario",
        anamnesis_archivada_automaticamente: "Anamnesis archivada automáticamente",
        anamnesis_campana: 'Anamnesis archivada por campaña'
      },
      estado: "",
    };
  },
  methods: {
    async loadAnamnesis() {
      if (this.$route.params.id != null || this.$route.params.id != undefined) {
        const response = await API.anamnesis.search(this.$route.params.id);
        if (response.data == null) {
          this.$router.push("/dashboard");
        }

        this.anamnesis = response.data;
        this.estado = this.anamnesis.estado === 0 ? "Inactiva" : "Activa";
      }
    },
  },
  created() {
    this.loadAnamnesis();
  },
};
</script>
