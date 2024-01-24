<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs
      v-if="invoice"
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    >
    </custom-breadcrumbs>
    <v-alert
      v-if="invoice.cliente.lista_negra == 1"
      border="left"
      type="warning"
      icon="mdi-alert"
    >
      <div class="text-h6" style="color: black">Cliente en Lista Negra</div>
      <div style="color: black">
        Requiere atención especial. Procede con precaución y sigue los
        protocolos establecidos. Contacta al supervisor o departamento
        correspondiente para más información.
      </div>
    </v-alert>


    <v-card class="mb-4" v-if="invoice">
      <v-card-title class="headline">
        <v-row dense>
          <v-col class="text-right">
            <v-btn
              v-if="invoice.id_eps_discount"
              depressed
              dark
              :disabled="invoice.id_comprobante_eps == null"
              color="info"
              :href="
                '/comprobantes/ver/' +
                invoice.id_comprobante_eps
              "
            >
              <v-icon>mdi-file</v-icon>
              EPS - COMPROBANTE CLIENTE
            </v-btn>

            <v-btn
              v-if="invoice.orden_laboratorio"
              depressed
              dark
              :color="invoice.orden_laboratorio.status.color"
              :to="
                '/orden-laboratorio/detalle/' +
                invoice.orden_laboratorio.id_orden_laboratorio
              "
            >
              <v-icon>mdi-microscope</v-icon>
              {{ invoice.orden_laboratorio.codigo_orden_lab }} -
              {{ invoice.orden_laboratorio.status.nombre_estado }}
            </v-btn>
            <v-btn
              depressed
              dark
              color="grey"
              v-if="!invoice.external_id"
              @click="sendDocSunat"
            >
              <v-icon>mdi-send-lock</v-icon>Enviar SUNAT
            </v-btn>
            <v-btn
              depressed
              color="success"
              v-if="invoice.external_id"
              @click="viewXml"
            >
              <v-icon>mdi-xml</v-icon>XML
            </v-btn>
            <v-btn
              depressed
              color="error"
              v-if="invoice.external_id"
              @click="viewPdf"
            >
              <v-icon>mdi-file-pdf</v-icon>PDF
            </v-btn>
            <v-btn
              depressed
              color="secondary"
              :to="'/encuesta/' + invoice.id_comprobante"
              v-if="invoice.id_orden_lab != null"
            >
              <v-icon>mdi-emoticon</v-icon>ENCUESTA
            </v-btn>

            <!--<v-btn depressed dark color="red accent-2" v-if="invoice.external_id" @click="sendDocSunat">
                            <v-icon>mdi-close-octagon-outline</v-icon>Anular Comprobante
                        </v-btn>-->
          </v-col>
        </v-row>
      </v-card-title>
      <!-- Invoice Header -->
      <v-row dense class="pa-2">
        <v-col cols="2">
          <v-text-field
            v-if="invoice.tipo_documento"
            readonly
            v-model="invoice.tipo_documento.nombre_tipo_documento"
            label="Tipo Documento"
          ></v-text-field>
        </v-col>
        <v-col cols="2">
          <v-text-field
            readonly
            v-model="invoice.nro_documento"
            label="Nro.Documento"
          ></v-text-field>
        </v-col>
        <v-col cols="5">
          <v-text-field
            readonly
            v-model="invoice.nombre_cliente"
            label="Nombre Cliente"
          ></v-text-field>
        </v-col>
        <v-col cols="3">
          <v-text-field
            readonly
            v-model="invoice.fecha_emision"
            label="Fecha de Emisión"
          ></v-text-field>
        </v-col>
        <v-col cols="5">
          <v-text-field
            readonly
            v-model="invoice.direccion_cliente"
            label="Dirección"
          ></v-text-field>
        </v-col>
        <v-col cols="4">
          <v-text-field
            v-if="invoice.medio_pago"
            readonly
            v-model="invoice.medio_pago.medio_pago"
            label="Medio de Pago"
          ></v-text-field>
        </v-col>
        <v-col cols="3">
          <v-text-field
            readonly
            v-model="invoice.nro_operacion"
            label="Nro. Operación"
          ></v-text-field>
        </v-col>
      </v-row>
      <!-- Fin -->
      <!-- Invoice Detail -->
      <v-row dense class="pa-2">
        <v-col>
          <v-simple-table fixed-header>
            <thead>
              <tr>
                <th style="width: 5%">#</th>
                <th class="text-left">Producto</th>
                <th class="text-left">Código</th>
                <th class="text-right" style="width: 13%">CNT</th>
                <th class="text-right" style="width: 13%">P.U (S/.)</th>
                <th class="text-right" style="width: 13%">P.T (S/.)</th>
              </tr>
            </thead>
            <tbody>
              <tr v-if="invoice.detalle.length == 0">
                <td colspan="7" class="text-center">
                  <b
                    >Aún no se han agregado productos o servicios a este
                    comprobante.</b
                  >
                </td>
              </tr>
              <tr v-for="(item, k) in invoice.detalle" :key="k">
                <td>{{ k + 1 }}</td>
                <td>{{ item.detalle_item }}</td>
                <td v-if="item.item_type == 1">{{ item.id_producto }}</td>
                <td v-if="item.item_type == 2">{{ item.id_precio_lente }}</td>
                <td v-if="item.item_type == 3">{{ item.id_servicio }}</td>
                <td class="text-right">
                  {{ item.cantidad }}
                </td>
                <td class="text-right">
                  {{ item.precio_unitario }}
                </td>
                <td class="text-right">
                  {{ item.precio_total }}
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="7" style="text-align: right">
                  <b>Subtotal: </b> S/. {{ invoice.subtotal }}
                </td>
              </tr>
              <tr>
                <td colspan="7" style="text-align: right">
                  <b>Descuento (%): </b>{{ invoice.dscto_porcentaje }}
                </td>
              </tr>
              <tr>
                <td colspan="7" style="text-align: right">
                  <b>Descuento (S/.): </b>{{ invoice.dscto_fijo }}
                </td>
              </tr>
              <tr>
                <td colspan="7" style="text-align: right">
                  <b>IGV (18%): </b> S/. {{ invoice.igv }}
                </td>
              </tr>
              <tr>
                <td colspan="7" style="text-align: right">
                  <b>Total: </b> S/. {{ invoice.total }}
                </td>
              </tr>
            </tfoot>
          </v-simple-table>
        </v-col>
      </v-row>
      <!-- Fin -->

      <!-- Cuotas -->
      <v-row
        v-if="invoice.deuda && invoice.deuda.length > 0"
        dense
        class="pa-2 py-0"
      >
        <v-col cols="6" md="6">
          <v-simple-table>
            <template v-slot:default>
              <thead>
                <tr>
                  <th class="text-left">Fecha</th>
                  <th class="text-left">Monto</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(item, index) in invoice.deuda" :key="index">
                  <td>
                    <v-text-field
                      v-model="item.fecha"
                      prepend-inner-icon="mdi-calendar"
                      readonly
                      dense
                      hide-details
                    ></v-text-field>
                  </td>
                  <td>
                    <v-text-field
                      v-model="item.monto"
                      dense
                      readonly
                      prefix="S/."
                      type="number"
                      hide-details
                    ></v-text-field>
                  </td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>

          <v-divider class="mb-1"></v-divider>

        </v-col>
      </v-row>
    </v-card>
  </div>
</template>

<script>
export default {
  data: () => ({
    breadcrumbs_title: "Comprobante #",
    breadcrumbs: [
      {
        text: "Inicio",
        disabled: false,
        href: "#",
      },
      {
        text: "Comprobantes",
        href: "/comprobantes",
      },
      {
        text: "Visualizar Comprobante",
      },
    ],

    id_invoice: null,
    invoice: {
      tipo_documentos: "",
      detalle: "",
      cliente:{
        lista_negra: 0
      }
    },
    correlative: null,
    label_nrodoc: null,
  }),
  mounted() {
    this.id_invoice = this.$route.params.id;
    this.getInvoiceVisualize();
  },
  methods: {
    async getInvoiceVisualize() {
      this.$store.commit("loader", true);
      try {
        const response = await API.comprobante.show(this.id_invoice);
        this.invoice = response.data;

        this.breadcrumbs_title =
          this.breadcrumbs_title +
          this.invoice.serie.serie +
          "-" +
          String(this.invoice.correlativo).padStart(8, "0");
        this.invoice.issue_date = this.formatDate(this.invoice.issue_date);
      } catch (e) {
        console.error(e);
      } finally {
        this.$store.commit("loader", false);
      }
    },

    //--- External Documents ---
    viewPdf() {
      window.open(
        this.invoice.sucursal.url_api + "/print/document/" + this.invoice.external_id + "/a4"
      );
    },
    viewXml() {
      window.open(
        this.invoice.sucursal.url_api + "/downloads/document/xml/" + this.invoice.external_id
      );
    },
    async sendDocSunat() {
      this.$store.commit("loader", true);
      try {
        const response = await API.invoices.update(
          this.id_invoice,
          this.invoice
        );
        for (let i in response.data.messages) {
          UTILS.toastr.success(response.data.messages[i], this);
        }
        this.dialogConfirm = false;
        this.$router.go();
      } catch (e) {
        console.error(e);
      } finally {
        this.$store.commit("loader", false);
      }
    },
    toSurvey() {
      console.log(this.invoice);
    },
    //--- End ---

    //--- Date Formatting ---
    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    //--- Fin ---
  },
};
</script>
