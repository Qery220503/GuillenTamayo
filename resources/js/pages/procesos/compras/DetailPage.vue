<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs
      v-if="form.serie"
      :breadcrumbs_title="
        breadcrumbs_title + form.serie.serie + '-' + form.correlativo
      "
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <div class="my-2">
      <v-card class="mb-4" light style="padding: 15px">
        <div class="py-1 d-flex">
          <v-spacer></v-spacer>
          <!-- Acciones Deuda -->
          <template v-if="form.condicion_pago != 1 && form.estado == 1">
            <v-btn
              color="deep-orange"
              dark
              class="mr-2"
              @click="verDetalleDeuda()"
            >
              <v-icon>mdi-order-bool-ascending-variant</v-icon>
              Ver Pagos
            </v-btn>
            <v-btn
              color="info"
              dark
              class="mr-2"
              v-if="$can('cuentaspagar_update', 'all') && form.deuda_saldo > 0"
              @click="agregarPago()"
            >
              <v-icon>mdi-cash</v-icon>
              Agregar Pago
            </v-btn>
            <v-btn
              color="info"
              dark
              class="mr-2"
              v-else-if="form.deuda_saldo > 0"
            >
              Deuda Pendiente
            </v-btn>
            <v-btn color="success" dark class="mr-2" v-else>
              Deuda Saldada
            </v-btn>
          </template>
          <!-- Fin -->
          <v-btn
            :href="'/compraPDF/' + form.id_compra"
            class="mr-2"
            color="error"
            target="_blank"
            depressed
          >
            <v-icon>mdi-file-pdf</v-icon>PDF
          </v-btn>
          <v-btn
            v-if="form.estado == 1"
            @click="deleteReg()"
            color="red lighten-1"
            dark
          >
            <v-icon>mdi-delete-outline</v-icon>
            Anular Compra
          </v-btn>
        </div>
        <v-row dense class="pa-2">
          <v-col cols="4">
            <v-text-field
              v-model="form.nombre_proveedor"
              label="Nombre Proveedor"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="4">
            <v-text-field
              v-model="form.nro_documento"
              label="Nro. Documento"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="4">
            <v-text-field
              v-model="form.direccion_proveedor"
              label="Dirección Proveedor"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="4">
            <v-text-field
              v-model="form.guia_factura"
              label="Guía de Remisión / Factura"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="4" v-if="form.origen_dinero">
            <v-text-field
              v-model="form.origen_dinero.nombre_origen"
              label="Origen del dinero"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="4" v-if="form.medio_pago">
            <v-text-field
              v-model="form.medio_pago.medio_pago"
              label="Medio Pago"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="4">
            <v-text-field
              v-model="form.fecha"
              label="Fecha de Emision"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="4">
            <v-text-field
              v-model="form.referencia"
              label="Referencia"
            ></v-text-field>
          </v-col>
        </v-row>
        <br />
        <v-divider></v-divider>
        <br />
        <v-simple-table>
          <template v-slot:default>
            <thead>
              <tr>
                <th style="width: 7%" class="text-left"></th>
                <th class="text-left">Código</th>
                <th class="text-left">Producto</th>
                <th style="width: 10%" class="text-left">CNT</th>
                <th style="width: 15%" class="text-left">P.U (S/.)</th>
                <th style="width: 15%" class="text-left">P.T (S/.)</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in form.detalle" :key="index">
                <td>{{ index + 1 }}</td>
                <td>{{ item.codigo_producto }}</td>
                <td>{{ item.nombre_producto }}</td>
                <td>{{ item.cantidad }}</td>
                <td>S/.{{ item.precio_compra }}</td>
                <td>S/.{{ item.precio_total }}</td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="5" style="text-align: right"><b>Subtotal: </b></td>
                <td colspan="2">
                  <v-text-field
                    v-model="form.subtotal"
                    readonly
                    hide-details="auto"
                    prefix="S/."
                  ></v-text-field>
                </td>
              </tr>
              <tr>
                <td colspan="5" style="text-align: right">
                  <b>IGV (18%): </b>
                </td>
                <td colspan="2">
                  <v-text-field
                    v-model="form.igv"
                    readonly
                    hide-details="auto"
                    prefix="S/."
                  ></v-text-field>
                </td>
              </tr>
              <tr>
                <td colspan="5" style="text-align: right"><b>Total: </b></td>
                <td colspan="2">
                  <v-text-field
                    v-model="form.total"
                    readonly
                    hide-details="auto"
                    prefix="S/."
                  ></v-text-field>
                </td>
              </tr>
            </tfoot>
          </template>
        </v-simple-table>
        <v-divider></v-divider>
        <br />

        <v-row dense class="pa-2 py-0">
          <v-col cols="3">
            <v-select
              v-model="form.condicion_pago"
              :items="condiciones_pago"
              label="Condición de Pago"
              item-text="text"
              item-value="value"
              readonly
            ></v-select>
          </v-col>
          <v-col cols="3" v-if="form.condicion_pago != 1">
            <v-text-field
              label="Fecha de Vencimiento"
              v-model="form.fecha_vencimiento"
              class="form-control"
              readonly
            ></v-text-field>
          </v-col>
        </v-row>
        <!-- Al Credito -->
        <v-row dense class="pa-2 py-0" v-if="form.condicion_pago == 2">
          <v-col cols="3">
            <v-select
              v-model="form.deuda_tipo"
              :items="tipos_deuda"
              label="Tipo de Deuda"
              item-text="text"
              item-value="value"
              readonly
            ></v-select>
          </v-col>
          <v-col cols="3">
            <v-text-field
              v-model="form.deuda_total_abonado"
              label="Abonado (S/.)"
              readonly
            ></v-text-field>
          </v-col>
          <v-col cols="3">
            <v-text-field
              v-model="form.deuda_saldo"
              label="Saldo (S/.)"
              readonly
            ></v-text-field>
          </v-col>
        </v-row>
        <!-- Fin -->
        <!-- Al Credito con Cuotas-->
        <template v-if="form.condicion_pago == 3">
          <v-row dense class="pa-2 py-0">
            <v-col cols="5">
              <v-simple-table>
                <thead>
                  <th class="text-center">Fecha</th>
                  <th class="text-center">Monto</th>
                </thead>
                <tbody>
                  <tr v-for="(item, i) in form.cuotas" :key="i">
                    <td style="text-align: left; vertical-align: middle">
                      <input
                        placeholder="Fecha"
                        v-model="item.fecha"
                        type="date"
                        class="form-control"
                        readonly
                      />
                    </td>
                    <td style="text-align: left; vertical-align: middle">
                      <v-text-field
                        v-model="item.monto"
                        type="number"
                        placeholder="0,00"
                        min="0"
                        autocomplete="off"
                        readonly
                      ></v-text-field>
                    </td>
                  </tr>
                </tbody>
              </v-simple-table>
            </v-col>
          </v-row>
        </template>
        <!-- Fin -->
      </v-card>
    </div>

    <!-- Delete Dialog -->
    <v-dialog v-model="deleteDialog" max-width="400">
      <v-card>
        <v-card-title class="d-flex justify-center">
          <span class="headline"
            >¿Estás seguro que deseas anular este registro?</span
          >
        </v-card-title>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="deleteRegConfirm">Aceptar</v-btn>
          <v-btn color="error" text @click="deleteDialog = false"
            >Cancelar</v-btn
          >
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Fin -->

    <PagoIndividualModal :cuentaRoute="'cuentas-pagar'" />
    <PagoDetailModal :cuentaRoute="'cuentas-pagar'" />
  </div>
</template>

<script>
import axios from "axios";

export default {
  data: () => ({
    breadcrumbs_title: "Compra #",
    breadcrumbs: [
      { text: "Inicio", disabled: false, href: "#" },
      { text: "Compras", disabled: false, href: "/compras" },
      { text: "Visualizar Compra" },
    ],
    form: {
      detail: [],
    },
    id_compra: null,
    isLoading: false,
    deleteDialog: false,
    condiciones_pago: [
      { text: "Al Contado", value: 1 },
      { text: "Al Crédito", value: 2 },
      { text: "Al Crédito con Cuotas", value: 3 },
    ],
    tipos_deuda: [
      { text: "Total", value: "total" },
      { text: "Saldo", value: "saldo" },
    ],
  }),

  mounted() {
    let vm = this;
    vm.$root.$on("compra_reload", () => {
      vm.getPurchase();
    });
  },
  created() {
    this.id_compra = this.$route.params.id;
    this.getPurchase();
  },

  methods: {
    getPurchase() {
      this.$store.commit("loader", true);
      axios
        .get("/api/compras/" + this.id_compra)
        .then((response) => {
          response.data.created_at = response.data.created_at.split("T")[0];
          this.form = response.data;
          this.form.fecha = this.formatDate(this.form.fecha);
          this.form.fecha_vencimiento = this.formatDate(
            this.form.fecha_vencimiento
          );

          this.$store.commit("loader", false);
        })
        .catch((error) => {
          console.error(error);
        });
    },
    agregarPago() {
      this.$root.$emit("cuentas_agregar_pago", this.form);
    },
    verDetalleDeuda() {
      this.$root.$emit("cuentas_pago_detalle", this.form);
    },
    deleteReg() {
      this.deleteDialog = true;
    },
    async deleteRegConfirm() {
      this.loadingTable = true;
      this.$store.commit("loader", true);

      try {
        const response = await API.compras.remove(this.id_compra);
        UTILS.toastr.success("Compra anulada correctamente", this);
        this.deleteDialog = false;
        this.getPurchase();
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      } finally {
        this.$store.commit("loader", false);
      }
    },
  },
};
</script>
<style lang="scss" scoped>
.btn-actions {
  background-color: #fff !important;
  color: #121212;
}
</style>
