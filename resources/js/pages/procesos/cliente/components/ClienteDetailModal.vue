<template>
  <!-- Ver Detalle Deuda -->
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
              Compra:
              {{ formDetail.serie.serie + "-" + formDetail.correlativo }}
            </h4>
            <h4>Emitido por: {{ formDetail.nombre_cliente }}</h4>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="12" sm="6" md="6">
            <v-text-field
              label="Total Deuda"
              v-model="formDetail.total"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="12" sm="6" md="6">
            <v-text-field
              label="Total Abonado"
              v-model="formDetail.total_abonado"
              readonly
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row
          ><v-col cols="12" sm="6" md="6">
            <v-text-field
              label="Adelanto"
              v-model="formDetail.adelanto"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="12" sm="6" md="6">
            <v-text-field
              label="Saldo Pendiente"
              v-model="formDetail.saldo"
              readonly
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-simple-table>
            <tbody>
              <tr>
                <th>Fecha</th>
                <th>Usuario</th>
                <th>Monto Abonado</th>
                <th>Monto Restante</th>
                <th>Tipo de Operación</th>
                <th>Observaciones</th>
              </tr>
              <tr v-if="deudaPagos.length <= 0">
                <td colspan="5" class="text-center">
                  <b>Aún no se han agregado pagos a esta deuda</b>
                </td>
              </tr>
              <tr v-for="(item, i) in deudaPagos" :key="i">
                <td>{{ item.fecha | formatDateGeneral }}</td>
                <td>
                  <strong>{{ item.usuario.name }}</strong>
                </td>
                <td>{{ item.monto }}</td>
                <td>{{ item.saldo }}</td>
                <td>{{ item.medio_pago.medio_pago }}</td>
                <td>{{ item.observacion }}</td>
              </tr>
            </tbody></v-simple-table
          >
        </v-row></v-card-text
      >
    </v-card>
  </v-dialog>
  <!-- Fin -->
</template>

<script>
export default {
  data() {
    return {
      paymentDetailDialog: false,
      formDetail: {
        serie: {},
      },
      deudaPagos: [],
    };
  },
  mounted() {
    this.$root.$on("cliente_pago_detalle", (data) => {
      this.formDetail = Object.assign({}, data);
      this.formDetail.total_abonado = (
        parseFloat(this.formDetail.total_abonado) +
        parseFloat(this.formDetail.adelanto)
      ).toFixed(2);
      this.getDetallePagos(data);
    });
  },
  methods: {
    getDetallePagos(item) {
      axios
        .get("/api/cliente/deudas-pagos/" + item.id_comprobante)
        .then((response) => {
          this.deudaPagos = response.data.pagos;
          this.paymentDetailDialog = true;
        })
        .catch((e) => {
          console.error(e);
          UTILS.toastr.error("Ups! Ocurrió un error", this);
        });
    },
  },
  watch: {
    paymentDialog() {
      if (!this.paymentDetailDialog) {
        this.deudaPagos = [];
      }
    },
  },
};
</script>
