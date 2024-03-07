<template>
  <div>
    <v-tooltip bottom>
      <template v-slot:activator="{ on, attrs }">
        <v-btn text icon v-bind="attrs" v-on="on" small @click="paymentDetailDialog = !paymentDetailDialog">
          <v-icon>mdi-list-status</v-icon>
        </v-btn>
      </template>
      <span>Listado de pagos</span>
    </v-tooltip>
    <v-dialog v-model="paymentDetailDialog" max-width="60%">

      <v-card>
        <v-card-title>
          <span class="headline">Detalle Pagos</span>
        </v-card-title>
        <v-divider></v-divider>
        <br />
        <v-card-text>
          <v-row>
            <v-col>
              <h4>
                Venta:
                {{ receipt.serie.serie + "-" + receipt.correlativo }}
              </h4>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                label="Total Deuda"
                v-model="receipt.total"
                readonly
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                label="Total Abonado"
                v-model="receipt.total_abonado"
                readonly
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                label="Saldo Pendiente"
                v-model="receipt.saldo"
                readonly
              ></v-text-field>
            </v-col>
          </v-row>
          <v-simple-table>
            <tbody>
              <tr>
                <th>Fecha</th>
                <th>Usuario</th>
                <th>Monto Abonado</th>
                <th>Monto Restante</th>
                <th>Metodo de Pago</th>
                <th>Descripción</th>
              </tr>
              <tr v-if="deudaPagos.length <= 0">
                <td colspan="7" class="text-center">
                  <b>Aún no se han agregado pagos a esta deuda</b>
                </td>
              </tr>
              <tr v-for="pago in deudaPagos">
                <td>
                  {{ pago.fecha }}
                </td>

                <td>
                  <strong>{{ pago.usuario.name }}</strong>
                </td>

                <td>
                  {{ pago.monto }}
                </td>

                <td>
                  {{ pago.saldo }}
                </td>

                <td>
                  {{ pago.medio_pago.medio_pago }}
                </td>

                <td>
                  {{
                    pago.observacion ? pago.observacion : "Sin Observaciones"
                  }}
                </td>
              </tr>
            </tbody>
          </v-simple-table>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import API from "../../../../api";

export default {
  name: "PaymentsList",
  props: {
    short: {
      type: Boolean,
      default: false,
    },
    receipt: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      paymentDetailDialog: false,
      deudaPagos: [],
    };
  },
  methods: {
    async loadPagos() {
      const response = await API.credito.pagos(this.receipt.id_comprobante);
      this.deudaPagos = response.data.pagos;
    },
  },
  mounted() {
    this.loadPagos();
  },
};
</script>
