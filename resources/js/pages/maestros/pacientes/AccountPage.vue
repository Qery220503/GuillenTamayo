<template>
  <div class="d-flex flex-column flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="cliente.nombre_razon_social"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-card>
      <v-row dense class="pa-2 align-center">
        <v-data-table
          flat
          :headers="headers"
          :items="cuenta"
          class="flex-grow-1 scroll-me"
          item-key="id_comprobante"
          no-data-text="Sin Deudas"
          no-results-text="Sin Deudas"
        >
          <template v-slot:item.comprobante="{ item }">
            <div>
              {{ item.serie.serie }} -
              {{ formatCorrelativo(item.correlativo) }}
            </div>
          </template>
          <template v-slot:item.fecha="{ item }">
            <div>
              {{ item.created_at | formatDateGeneral }}
            </div>
          </template>

          <template v-slot:item.monto_deuda="{ item }">
            <div>
              {{ getMontoDeuda(item).toFixed(2) }}
            </div>
          </template>
          <template v-slot:item.monto_cancelado="{ item }">
            <div>
              {{ getMontoCancelado(item).toFixed(2) }}
            </div>
          </template>
          <template v-slot:item.monto_restante="{ item }">
            <div v-if="getMontoRestante(item) > 0">
              <span style="color: red;">{{
                getMontoRestante(item).toFixed(2)
              }}</span>
            </div>
            <div v-else>
              <span style="color: green;">{{
                getMontoRestante(item).toFixed(2)
              }}</span>
            </div>
          </template>

          <template v-slot:item.actions="{ item }">
            <v-btn color="primary" small @click="openCuotasDialog(item)">
              <v-icon left dark>
                mdi-eye
              </v-icon>
              Ver Cuotas
            </v-btn>
          </template>
        </v-data-table>
      </v-row>
    </v-card>

    <!-- Pagos -->
    <v-dialog v-model="cuotasDialog" max-width="70%">
      <v-card>
        <v-card-text>
          <v-simple-table>
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">
                    Nro. Cuota
                  </th>
                  <th class="text-left">
                    Fecha Pago
                  </th>
                  <th class="text-left">
                    Monto
                  </th>
                  <th>Estado</th>
                  <th class="text-center">Acciones</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="cuota in deudaSelected.credito">
                  <td style="text-align: center;">{{ cuota.cuota }}</td>
                  <td>{{ cuota.fecha_cuota }}</td>
                  <td>{{ cuota.monto }}</td>
                  <td>
                    <v-chip small :color="(getCuotaEstado(cuota).flag) ? 'success' : 'primary'">
                      {{ getCuotaEstado(cuota).label }}
                    </v-chip>
                  </td>
                  <td
                    style="display: flex; justify-content: space-evenly; align-items: center;"
                  >
                    <v-btn :disabled="getCuotaEstado(cuota).flag" small color="primary" @click="openPagoDialog(cuota)"
                      >Agregar Pago</v-btn
                    >
                    <v-btn small color="success" class="ml-2" @click="openPagosDialog(cuota)">Ver Pagos</v-btn>
                  </td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>
        </v-card-text>
      </v-card>
    </v-dialog>

    <!-- Agregar Pago -->
    <v-dialog v-model="pagoDialog" width="40%" height="auto">
      <v-card>
        <v-card-title class="d-flex justify-center">
          <span class="headline"><strong>Agregar un pago</strong></span>
        </v-card-title>
        <v-card-text>
          <v-form
          ref="monto"
          v-model="valid"
          lazy-validation
        >
          <v-row>
            <v-col sm="12" md="12">
              <v-text-field
                name="monto"
                label="Monto"
                type="number"
                id="id"
                filled
                dense
                hide-details
                v-model="pago.monto"
                min="0"
                step="0.01"
                :rules="[rules.required, rules.numeric, rules.min]"
              ></v-text-field>
            </v-col>
            <v-col sm="12" md="12">
              <v-select
                :items="medios_pago"
                v-model="pago.id_medio_pago"
                item-text="medio_pago"
                item-value="id_medio_pago"
                :rules="[rules.required]"
                label="Medio de pago"
                filled
                dense
                hide-details
              ></v-select>
            </v-col>

            <v-col sm="12" md="12">
              <v-textarea
                rows="2"
                label="Descripción"
                name="name"
                textarea
                v-model="pago.descripcion"
                :rules="[rules.required]"
                filled
                hide-details
              ></v-textarea>
            </v-col>
          </v-row>
        </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="pagar()">Guardar</v-btn>
          <v-btn color="red" @click="resetPago()">Cancelar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="pagosDialog"  width="60%" height="auto" @click:outside="resetPagos()">
      <v-card>
        <v-card-text>
          <v-simple-table>
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">
                    Fecha Pago
                  </th>
                  <th class="text-left">
                    Monto
                  </th>
                  <th class="text-left">
                    Descripción
                  </th>
                  <th class="text-left">
                    Medio P.
                  </th>
                  <th class="text-left">
                    Usuario
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="cuota in cuotaSelected.pagos">
                  <td style="text-align: center;">{{ cuota.created_at | formatDateGeneral }}</td>
                  <td>{{ Number(cuota.monto).toFixed(2) }}</td>
                  <td>{{ cuota.descripcion }}</td>
                  <td>
                    <v-chip
                      size="x-small"
                    >
                      {{ cuota.medio_pago.medio_pago }}
                    </v-chip>
                  </td>
                  <td>{{ cuota.user.name }}</td>
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
import API from "../../../api";
export default {
  data() {
    return {
      breadcrumbs_title: "Pacientes",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "/dashboard" },
        { text: "Maestros", disabled: false, href: "#" },
        { text: "Pacientes", disabled: false, href: "/pacientes" },
        { text: "Cuenta Corriente" }
      ],
      headers: [
        { text: "Comprobante", value: "comprobante", align: "left" },
        { text: "Fecha", value: "fecha", align: "center" },
        { text: "Monto Deuda", value: "monto_deuda", align: "center" },
        { text: "Monto Adelanto", value: "adelanto", align: "center" },
        { text: "Monto Cancelado", value: "monto_cancelado", align: "center" },
        { text: "Monto Restante", value: "monto_restante", align: "center" },
        { text: "Acciones", sortable: false, value: "actions", align: "center" }
      ],
      cuenta: [],
      pago: {
        id_cuota_credito: null,
        id_medio_pago: null,
        descripcion: null,
        monto: null
      },
      cliente: {
        nombre_razon_social: ""
      },
      valid: false,
      pagosDialog: false,
      cuotasSelected: [],
      cuotasDialog: false,
      pagoDialog: false,
      menu2: false,
      date: null,
      valid: false,
      rules: {
        required: (v) => !!v || 'Este campo es requerido',
        numeric: value => !isNaN(parseFloat(value)) || 'Debe ser un número',
        min: value => value > 0 || 'Debe ser mayor a cero',
      },

      deudaSelected: {},
      medios_pago: [],
      cuotaSelected: {},
    };
  },
  created() {
    this.getCliente();
    this.getAccount();
    this.mediosPago();
  },
  methods: {
    formatCorrelativo(ct) {
      let c = ct.toString().padStart(8, "0");
      return c;
    },
    async getAccount() {
      var response;
      if (this.$route.query.deudas) {
        response = await API.clientes.deudas(this.$route.params.id);
      } else {
        response = await API.clientes.cuenta(this.$route.params.id);
      }
      this.cuenta = response.data;
    },
    async mediosPago() {
      const response = await API.apis.medioPago();
      this.medios_pago = response.data;
    },
    async getCliente() {
      const response = await API.clientes.show(this.$route.params.id);
      this.cliente = response.data;
    },
    getMontoDeuda(item) {
      return Number(item.total) - Number(item.adelanto);
    },
    getMontoCancelado(item) {
      return item.credito.reduce((acum, elem) => {
        return acum + elem.pagos.reduce((a, e) => a + Number(e.monto), 0);
      }, 0);
    },
    getMontoRestante(item) {
      let cancelado = item.credito.reduce((acum, elem) => {
        return acum + elem.pagos.reduce((a, e) => a + Number(e.monto), 0);
      }, 0);

      return Number(item.total) - (Number(item.adelanto) + Number(cancelado));
    },
    openCuotasDialog(item) {
      console.log(item);
      this.deudaSelected = item;
      this.cuotasDialog = true;
    },
    openPagoDialog(item) {
      console.log(item);
      this.cuotaSelected = item;

      let pagoRestante = this.cuotaSelected.pagos.reduce((acum, elem) => {
        return acum + Number(elem.monto);
      },0);

      this.pago.monto = Number(this.cuotaSelected.monto - pagoRestante).toFixed(2);
      this.pagoDialog = true;
    },

    openPagosDialog(item) {
      console.log(item);
      this.cuotaSelected = item;
      this.pagosDialog = true;
    },
    async pagar() {
      if(!this.$refs.monto.validate()){
          return;
        }
      try {
        this.pago.id_cuota_credito = this.cuotaSelected.id_comprobantes_credito;
        const response = await API.credito.pagar(this.pago);
        if (response.data.success != true) {
          UTILS.toastr.info(response.data.msg, this);
          return;
        }

        this.cuotaSelected.pagos.push(response.data.pago);
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrio un error", this);
        console.error(e);
      } finally {
        this.getAccount();
        this.resetPago();
      }
    },
    getCuotaEstado(cuota) {
      let totalPagos = cuota.pagos.reduce((acum, elem) => {
        return acum + Number(elem.monto);
      }, 0);

      if (totalPagos == cuota.monto) {
        return {
          label: "PAGADO",
          flag: true
        };
      }
      return {
        label: "PENDIENTE",
        flag: false
      };
    },
    resetPago() {
      this.pago = {
        id_cuota_credito: null,
        id_medio_pago: null,
        descripcion: null,
        monto: null
      };
      this.$refs.monto.resetValidation();
      this.pagoDialog = false;
    },
    resetPagos(){
      this.cuotaSelected = {}
    }
  }
};
</script>
