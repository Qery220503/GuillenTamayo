<template>
  <v-card class="px-5 py-2">
    <v-card-text>
      <v-data-table
        light
        :headers="headersTable"
        :items="tableData"
        :page="currentPage"
        :items-per-page="itemsPerPage"
        :options.sync="dataTabOptions"
        class="flex-grow-1 scroll-me"
        :footer-props="{
          itemsPerPageOptions: [25, 50, 100, 1000],
        }"
        :loading="loadingTable"
        loading-text="Cargando... Por favor, espere"
      >
        <template v-slot:[`item.estado`]="{ item }">
          <v-chip class="ma-2" :color="item.status.color" small>
            <span class="font-weight-medium">{{
              item.status.nombre_estado
            }}</span>
          </v-chip>
        </template>
        <template v-slot:[`item.acciones`]="{ item }">
          <v-btn
            icon
            :disabled="item.id_cliente == 1"
            @click="handleDataRowClick(item)"
          >
            <v-icon>mdi-eye-outline</v-icon>
          </v-btn>
        </template>
      </v-data-table>
    </v-card-text>
    <!-- View Dialog -->
    <v-dialog v-model="viewDialog" max-width="60%">
      <v-card>
        <v-card-title>
          <span class="headline">Detalles de la receta</span>
        </v-card-title>
        <measures-component :recipes="receta" :noeditable="true" />
      </v-card>
    </v-dialog>
  </v-card>
</template>

<script>
import MeasuresComponent from "../../../../components/measures/MeasuresComponent.vue";
import { getRecetasService } from "../services/paciente.services";
export default {
  components: { MeasuresComponent },
  props: {
    id_cliente: {
      required: true,
      default: 0,
    },
  },
  data() {
    return {
      headersTable: [
        { text: "Nº", value: "id", align: "left" },
        { text: "Comprobante", value: "comprobante", align: "left" },
        { text: "Fecha", value: "fecha", align: "left" },
        { text: "Doctor", value: "doctor", align: "left" },
        { text: "Montura", value: "montura", align: "left" },
        { text: "Estado", value: "estado", align: "left" },
        { text: "Acciones", value: "acciones", align: "left" },
      ],
      tableData: [],
      currentPage: 1,
      pageCount: 1,
      itemsPerPage: 25,
      totalReg: 0,
      dataTabOptions: {},
      loadingTable: false,

      viewDialog: false,

      receta: {
        panoramic_angle: null,
        pantoscopic_angle: null,
        vertex_distance: null,
        dip: null,
        od: {
          esf: null,
          cyl: null,
          add_cerca: null,
          add_intermedio: null,
          alt: null,
          prismas: null,
          avcc: null,
          eje: null,
        },
        oi: {
          esf: null,
          cyl: null,
          add_cerca: null,
          add_intermedio: null,
          alt: null,
          prismas: null,
          avcc: null,
          eje: null,
        },
        selection: "far",
        /* Specific recipes */
        near: {
          oi: {
            esf: null,
            cyl: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
            eje: null,
          },
          od: {
            esf: null,
            cyl: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
            eje: null,
          },
        },
        intermediate: {
          oi: {
            esf: null,
            cyl: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
            eje: null,
          },
          od: {
            esf: null,
            cyl: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
            eje: null,
          },
        },
        far: {
          oi: {
            esf: null,
            cyl: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
            eje: null,
          },
          od: {
            esf: null,
            cyl: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
            eje: null,
          },
        },
        multifocal: {
          od: {
            esf: null,
            cyl: null,
            eje: null,
            add: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
          },
          oi: {
            esf: null,
            cyl: null,
            eje: null,
            add: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
          },
          panoramic_angle: null,
          pantoscopic_angle: null,
          vertex_distance: null,
        },
        bifocal: {
          od: {
            esf: null,
            cyl: null,
            eje: null,
            add: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
          },
          oi: {
            esf: null,
            cyl: null,
            eje: null,
            add: null,
            dnp: null,
            alt: null,
            prismas: null,
            //avcc: null,
          },
          panoramic_angle: null,
          pantoscopic_angle: null,
          vertex_distance: null,
        },
        contact: {
          od: {
            esf: null,
            cyl: null,
            eje: null,
            k1: null,
            k2: null,
            cb: null,
            diametro: null,
            dhiv: null,
            sag: null,
          },
          oi: {
            esf: null,
            cyl: null,
            eje: null,
            k1: null,
            k2: null,
            cb: null,
            diametro: null,
            dhiv: null,
            sag: null,
          },
          material: null,
          color: null,
          geometry: null,
          replacement: null,
        },
      },
    };
  },
  created() {
    this.getDataRecetas();
  },
  methods: {
    async getDataRecetas() {
      const data = await getRecetasService(this.id_cliente);
      this.tableData = data.map((e) => ({
        ...e,
        id: e.id_orden_laboratorio,
        comprobante: e.codigo_orden_lab,
        fecha: e.fecha_emision,
        doctor: e.doctor_nombre,
        montura: e.tipo_montura,
        estado: e.status.nombre_estado,
      }));
    },
    handleDataRowClick(row) {
      this.viewDialog = true;
      this.receta = row.receta;
    },
  },
};
</script>

<style></style>
