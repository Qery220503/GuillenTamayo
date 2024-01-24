<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card class="px-5 py-2">
      <v-card-title>
        <span class="headline">
          <strong>
            Nota de
            {{ nota.id_tipo_comprobantes == 1 ? "Débito" : "Credito" }} 
            {{ formatSerie() }}
          </strong>
        </span>

        <v-spacer></v-spacer>

        <v-chip :color="nota.estado_nota.color">
              {{ nota.estado_nota.nombre_estado }}
            </v-chip>
      </v-card-title>
      <v-card-text>
        <v-form class="mt-2" ref="createForm" lazy-validation>
          <v-row>
            <v-col class="py-1" cols="12" md="3">
              <v-select
                :items="notas"
                v-model="nota.id_tipo_comprobantes"
                label="Tipo de Nota"
                item-text="nombre_tipo_documento"
                item-value="id_tipo_comprobantes"
                readonly
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1" cols="12" md="3">
              <v-text-field
                label="Serie"
                id="id"
                filled
                v-model="nota.serie.serie"
                readonly
              ></v-text-field>
            </v-col>
            <v-col class="py-1" cols="12" md="3">
              <v-text-field
                filled
                :label="noteTypeFieldTitle"
                v-model="nota.tipo.descripcion"
                readonly
              ></v-text-field>
            </v-col>
            <v-col class="py-1" cols="12" md="3">
              <v-text-field
                v-model="nota.fecha_emision"
                label="Fecha Emisión"
                filled
              ></v-text-field>
            </v-col>

            <v-col class="py-1" cols="12" md="3">
              <v-text-field
                filled
                label="Cliente"
                :readonly="comprobante != null"
                autocomplete="off"
                v-model="nota.cliente.nombre_razon_social"
              ></v-text-field>
            </v-col>
            <v-col class="py-1" cols="12" md="3">
              <v-text-field
                filled
                readonly
                v-model="comprobanteSerieNumber"
                label="Comprobante"
                autocomplete="off"
              ></v-text-field>
            </v-col>
            <v-col class="py-1" cols="12" md="6">
              <v-textarea
                name="description"
                filled
                label="Descripción"
                auto-grow
                v-model="nota.descripcion"
                rows="1"
                readonly
              ></v-textarea>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-simple-table fixed-header>
                <template v-slot:default>
                  <thead>
                    <tr>
                      <th>
                        #
                      </th>
                      <th class="text-left">
                        Descripción
                      </th>
                      <th class="text-left">
                        Unidad
                      </th>
                      <th class="text-left">
                        Cantidad
                      </th>
                      <th class="text-left">
                        Precio Unitario
                      </th>
                      <th class="text-left">
                        Total
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(d, idx) in nota.detalle" :key="idx">
                      <td>{{ idx + 1 }}</td>
                      <td>{{ d.descripcion }}</td>
                      <td>
                        <v-text-field
                          hide-details
                          outlined
                          dense
                          filled
                          v-model="d.unidad_medida.nombre_unidad_medida"
                        ></v-text-field>
                      </td>
                      <td>
                        <v-text-field
                          v-model="d.cantidad"
                          type="number"
                          step="0.01"
                          name="cantidad"
                          hide-details
                          outlined
                          dense
                          filled
                        ></v-text-field>
                      </td>
                      <td>
                        <v-text-field
                          v-model="d.precio_unitario"
                          type="number"
                          step="0.01"
                          name="precio unitario"
                          hide-details
                          outlined
                          dense
                          filled
                        ></v-text-field>
                      </td>
                      <td>
                        <v-text-field
                          v-model="d.total"
                          type="number"
                          step="0.01"
                          name="precio total"
                          hide-details
                          outlined
                          dense
                          filled
                          readonly
                        ></v-text-field>
                      </td>
                    </tr>
                  </tbody>
                  <tfoot>
                    <tr>
                      <td colspan="5" style="text-align: right">
                        <b>Subtotal: </b>
                      </td>
                      <td colspan="2">
                        <v-text-field
                          readonly
                          hide-details
                          outlined
                          dense
                          filled
                          prefix="S/."
                          v-model="nota.subtotal"
                        ></v-text-field>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="5" style="text-align: right">
                        <b>IGV (18%): </b>
                      </td>
                      <td colspan="2">
                        <v-text-field
                          readonly
                          hide-details
                          outlined
                          dense
                          filled
                          prefix="S/."
                          v-model="nota.igv"
                        ></v-text-field>
                      </td>
                    </tr>

                    <tr>
                      <td colspan="5" style="text-align: right">
                        <b>Total: </b>
                      </td>
                      <td colspan="2">
                        <v-text-field
                          hide-details
                          outlined
                          dense
                          filled
                          prefix="S/."
                          v-model="nota.total"
                        ></v-text-field>
                      </td>
                    </tr>
                  </tfoot>
                </template>
              </v-simple-table>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
    </v-card>
  </div>
</template>
<script>
import API from "../../../api";
export default {
  data() {
    return {
      breadcrumbs_title: "Notas Crédito/Débito",
      breadcrumbs: [
        { text: "Inicio", readonly: false, href: "#" },
        { text: "Procesos", readonly: false, href: "#" },
        { text: "Notas" }
      ],
      validAddForm: false,
      notas: [
        {
          id_tipo_comprobantes: 6,
          codigo_sunat: "07",
          nombre_tipo_documento: "NOTA DE CRÉDITO"
        },
        {
          id_tipo_comprobantes: 7,
          codigo_sunat: "08",
          nombre_tipo_documento: "NOTA DE DÉBITO"
        }
      ],
      notasTipos: [],
      series: [],
      nota: {
        id_nota: null,
        id_tipo_comprobantes: 6,
        id_comprobante: null,
        id_serie: null,
        id_tipo_nota: null,
        fecha_emision: "",
        detalle: [],
        total: 0,
        subtotal: 0,
        igv: 0,
        comprobante: {
          correlativo: "",
          serie: {
            serie: ""
          }
        }
      },
      menu: false,
      today: new Date().toISOString().substr(0, 10),
      comprobante: {
        cliente: {
          nombre_razon_social: ""
        }
      }
    };
  },
  created() {
    this.nota.id_nota = this.$route.params.id;
    this.loadNota();
    this.loadTipos();
  },
  methods: {
    async loadNota() {
      const response = await API.notas.show(this.nota.id_nota);
      this.nota = response.data;
      console.log(response.data, "Response");
    },
    async loadTipos() {
      const vm = this;
      const type = vm.nota.id_tipo_comprobantes;
      const response = await API.notas.tipos(type);
      vm.notasTipos = response.data;
      vm.nota.id_tipo_nota = null;
    },
    formatSerie() {
      return (
        " " + 
        this.nota.serie.serie +
        "-" +
        this.nota.correlativo.toString().padStart(8, "0")
      );
    },
  },
  computed: {
    noteTypeFieldTitle() {
      if (this.nota.id_tipo_comprobantes_nota == 1) return "Tipo de Nota de Débito";
      return "Tipo de Nota de Crédito";
    },
    comprobanteSerieNumber() {
        return (
            this.nota.comprobante.serie.serie + 
            "-" +
            this.nota.comprobante.correlativo.toString().padStart(8, "0")
        );
    },
    fechaEmision() {
      return new Date(this.nota.fecha_emision).substr(0, 10);
    }
  }
};
</script>
,
