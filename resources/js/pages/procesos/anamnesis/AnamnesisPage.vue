<template>
  <div class="flex-grow-1">
    <div class="py-3 min-w-0 w-full pb-1 pt-1">
      <div class="d-flex justify-space-between">
        <div class="text-left d-flex justify-content-between align-center">
          <h2>{{ breadcrumbs_title }}</h2>
          <div :class="{ indicador: true, indicador_rojo: blackList }"></div>
        </div>
      </div>
    </div>
    <!-- Anamnesis Pendientes -->
    <div class="my-2" v-if="anamnesis_pendientes.length > 0 && e1 == 1">
      <v-alert v-for="(anamnesis, idx) in anamnesis_pendientes" :key="idx" dense prominent text type="info">
        <div class="d-flex justify-space-between align-center">
          <span>
            Anamnesis pendiente del <strong>{{ anamnesis.created_at }}</strong>
          </span>
          <div class="d-flex align-center">
            <v-btn color="success" icon @click="retomarAnamnesis(anamnesis)">
              <v-icon>mdi-restart</v-icon>
            </v-btn>
            <v-btn v-if="anamnesis.orden == null" color="red" @click="descartarAnamnesis(anamnesis.id_anamnesis)" icon>
              <v-icon>mdi-close</v-icon>
            </v-btn>
          </div>
        </div>
      </v-alert>
    </div>
    <!-- Cotizaciones Pendientes -->
    <div class="my-2" v-if="cotizaciones_paciente.length > 0 && e1 == 2">
      <v-alert dense prominent text type="info">
        <div class="d-flex justify-space-between align-center">
          <span> Cotizaciones encontradas </span>
          <div class="d-flex align-center">
            <v-btn color="primary" icon @click="openCotizaciones()">
              <v-icon>mdi-eye</v-icon>
            </v-btn>
          </div>
        </div>
      </v-alert>
    </div>
    <div class="my-2">
      <v-stepper v-model="e1">
        <v-stepper-header>
          <v-stepper-step :complete="e1 > 1" step="1">
            Paso 1
            <small>Datos del cliente y Anamnesis</small>
          </v-stepper-step>

          <v-divider></v-divider>

          <v-stepper-step :complete="e1 > 2" step="2">
            Paso 2
            <small>Orden de Laboratorio</small>
          </v-stepper-step>

          <v-divider></v-divider>

          <v-stepper-step step="3">
            Paso 3
            <small>Emisión de Comprobante</small>
          </v-stepper-step>
        </v-stepper-header>

        <v-stepper-items>
          <v-stepper-content step="1" class="py-5">
            <v-form ref="formstep1" v-model="validAddFormStep1" lazy-validation>
              <Paso1 :form.sync="formStep1" :send="nextStep" v-on:formReset="resetStep1" />
            </v-form>
          </v-stepper-content>

          <v-stepper-content step="2">
            <v-form ref="formstep2" v-model="validAddFormStep2" lazy-validation>
              <Paso2 :form.sync="formStep2" :send="nextStep" :id_cliente="cliente.id_cliente" v-on:formReset="resetStep2"
                :cancel="cancelarAnamnesis" :anamnesis="anamnesis" :validation="validateStep2"
                :store_campaign="saveStep2" />
            </v-form>
          </v-stepper-content>

          <v-stepper-content step="3">
            <v-form ref="formstep3" v-model="validAddFormStep3" lazy-validation>
              <Paso3 :form.sync="formStep3" :send="nextStep" :convenio="anamnesis.id_empresa_convenio" />
            </v-form>
          </v-stepper-content>
        </v-stepper-items>
      </v-stepper>
    </div>

    <!-- Listado de Cotizaciones -->
    <v-dialog v-model="cotizacionDialog" scrollable :overlay="false" width="85%">
      <v-card>
        <v-card-title primary-title> Cotizaciones </v-card-title>
        <v-card-text>
          <v-data-table :headers="headers" :items="cotizaciones_paciente">
            <template v-slot:[`item.cotizacion`]="{ item }">
              {{ item.serie }}-{{ item.correlativo }}
            </template>
            <template v-slot:[`item.date`]="{ item }">
              {{ new Date(item.created_at).toISOString().slice(0, 10) }}
            </template>
            <template v-slot:[`item.actions`]="{ item }">
              <v-btn @click="verCotizacion(item.id_cotizacion)" small color="blue darken-4" icon>
                <v-icon>mdi-file-pdf-box</v-icon>
              </v-btn>

              <v-btn icon small color="blue darken-4" class="ml-1" @click="usarCotizacion(item)">
                <v-icon>mdi-check</v-icon>
              </v-btn>
            </template>
          </v-data-table>
        </v-card-text>
      </v-card>
    </v-dialog>

    <!-- Recibos -->

    <v-dialog v-model="receiptDialog" style="width: 80%" @click:outside="exitReceipt">
      <v-card>
        <v-toolbar flat color="primary" dark >
          <v-toolbar-title>Recibo</v-toolbar-title>
        </v-toolbar>
        <v-tabs>
          <v-tab v-if="comandaURL != ''">
            <v-icon left> mdi-receipt </v-icon>
            Comanda
          </v-tab>
          <v-tab v-if="reciboURL != ''">
            <v-icon left> mdi-receipt </v-icon>
            Recibo
          </v-tab>
          <v-tab v-if="epsFormato != ''">
            <v-icon left> mdi-receipt </v-icon>
            Eps
          </v-tab>
          <v-tab v-if="showCupon">
            <v-icon left> mdi-ticket-percent </v-icon>
            Cupon
          </v-tab>

          <v-tab-item v-if="comandaURL != ''">
            <v-card flat>
              <v-card-text>
                <iframe :src="comandaURL" frameborder="0" style="width: 100%; height: 450px"></iframe>
              </v-card-text>
            </v-card>
          </v-tab-item>

          <v-tab-item v-if="reciboURL != ''">
            <v-card flat>
              <v-card-text v-if="showFormats">
                <v-select :items="['a4', 'a5', 'ticket']" v-model="reciboFormato" outlined hide-details
                  label="Formato comprobante"></v-select>
              </v-card-text>
              <v-card-text>
                <iframe :src="reciboURLFormated" frameborder="0" style="width: 100%; height: 450px"></iframe>
              </v-card-text>
            </v-card>
          </v-tab-item>

          <v-tab-item v-if="epsFormato != ''">
            <v-card flat>
              <v-card-text>
                <v-select :items="['a4', 'a5', 'ticket']" v-model="epsFormato" outlined hide-details
                  label="Formato comprobante"></v-select>
              </v-card-text>
              <v-card-text>
                <iframe :src="epsURLFormated" frameborder="0" style="width: 100%; height: 450px"></iframe>
              </v-card-text>
            </v-card>
          </v-tab-item>

          <v-tab-item v-if="showCupon">
            <v-card flat>
              <v-card-text>
                <CouponTicket :coupon="cupon" />
              </v-card-text>
            </v-card>
          </v-tab-item>
        </v-tabs>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" to="/comprobantes">Salir</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import API from "../../../api";
import Paso1 from "./Steps/Paso1";
import Paso2 from "./Steps/Paso2";
import Paso3 from "./Steps/Paso3";
import CouponTicket from '../ventas/components/CouponTicket.vue';
import { RecipeService } from "../../../services/RecipeService";

export default {
  data() {
    return {
      showCupon: true,
      showFormats: true,
      comandaURL: "",
      reciboURL: "",
      reciboFormato: "",
      epsURL: "",
      epsFormato: "",
      cupon: null,
      breadcrumbs_title: "Anamnesis",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Compras" },
      ],
      e1: 1,
      validAddFormStep1: false,
      validAddFormStep2: false,
      validAddFormStep3: false,
      blackList: false,
      receiptDialog: false,
      formStep1: {
        cliente: {
          cod_tipo_doc: 1,
          nro_documento: "",
          nombre_razon_social: null,
          direccion: null,
          id_departamento: 4,
          id_provincia: 401,
          id_distrito: 40101,
          lista_negra: null,
        },
        anamnesis: {
          antecedentes_familia: [],
          antecedentes_familiares: "",
          enfermedades: [],
          medicamentos: "",
          frecuencia_visita: "",
          id_clinica: 1,
          id_doctor: 1,
          id_empresa_convenio: 1,
        },
      },
      formStep2: {
        tipo_montura: "Aro Completo",
        montaje: "Bisell Brillante",
        id_campana: '',
        lente: {
          disenio: "",
          fabricacion: "",
          material: "",
          serie: "",
          tratamiento: "",
          nombre: "",
          fotocromatico: "",
          color_fotocromatico: "",
        },
        montura: {
          precio_venta: "",
          precio_compra: "",
        },
        montura_cliente: "",
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
        observaciones: "",
        fecha_entrega: "",
        hora_entrega: "",
        monto_compra_proyectado: "",
        productos: [],
      },
      formStep3: {
        header: {
          observaciones: "",
          nota_credito_referencia: "",
          id_cliente: "",
          id_tipo_comprobante: 2,
          id_tipo_documento: 1,
          id_estado_comprobante: "",
          id_medio_pago: "1",
          id_serie: "",
          condicion_pago: 1,
          nombre_cliente: "",
          nro_documento: "",
          direccion_cliente: "",
          fecha_emision: new Date(
            new Date().getTime() - new Date().getTimezoneOffset() * 60 * 1000
          )
            .toISOString()
            .substring(0, 10),
          nro_operacion: "",
          igv: "",
          subtotal: "",
          total: "",
          adelanto: 0.0,
          saldo: 0.0,
          dscto_porcentaje: "",
          descuento_porcentaje: "",
          dscto_fijo: "",
          comentario: "",
          deuda_generada: false,
          id_eps_discount: null,
          eps_discount: 0.0,
          fecha_vencimiento: new Date(
            new Date().getTime() - new Date().getTimezoneOffset() * 60 * 1000
          )
            .toISOString()
            .substring(0, 10),
          total_abonado: 0.0,
          deuda_tipo: "",
        },
        detail: [],
        cuotas: [],
      },
      isOpenCash: false,
      cliente: {},
      anamnesis: {},
      anamnesis_pendientes: [],
      cotizaciones_paciente: [],
      cotizacionDialog: false,
      headers: [
        {
          text: "Nro Comprobante",
          align: "start",
          sortable: false,
          value: "cotizacion",
        },
        { text: "Lente", value: "nombre_propio" },
        { text: "Precio Lente.", value: "precio_venta" },
        { text: "Montura", value: "nombre_producto" },
        { text: "Precio Montura.", value: "precio_producto" },
        { text: "Fecha", value: "created_at", align: "center" },
        { text: "Acciones", value: "actions", align: "center" },
      ],
    };
  },
  components: {
    Paso1,
    Paso2,
    Paso3,
    CouponTicket
  },
  mounted() {
    let route = "/anamnesis";
    const anamnesisId = this.$route.query.anamnesis;
    console.log("Parametro: " + anamnesisId)
    if (anamnesisId) {
      route = `/anamnesis?anamnesis=${anamnesisId}`;
    }
    this.checkIfCashIsOpen(route);
    if (anamnesisId) {
      this.processAnamnesis(anamnesisId);
    }
  },
  watch: {
    "formStep1.cliente.lista_negra"(value) {
      this.blackList = value == 1 ? true : false;
    },
    "formStep1.cliente.nro_documento"(v) {
      if (v == null || v == undefined) return;
      if (v.length >= 8) this.buscarAnamnesis();
    },
    e1(val) {
      if (val == 2) {
        this.buscarCotizaciones(this.anamnesis.id_cliente);
      }
    },
  },
  methods: {
    async processAnamnesis(anamnesisId) {
      const anamnesis = await this.searchAnamnesis(anamnesisId);
      this.retomarAnamnesis(anamnesis);
    },
    async searchAnamnesis(id_anamnesis) {
      const response = await API.anamnesis.search(id_anamnesis);
      return response.data;
    },
    validateStep2() {
      const vm = this;
      const monturaCliente = vm.formStep2.montura_cliente ?? "";
      const montura = Object.keys(vm.formStep2.montura).length;
      if (monturaCliente == "" && montura == 0) {
        UTILS.toastr.info("No se ha definido una montura!", vm);
        return false;
      }
      if (!vm.$refs.formstep2.validate()) {
        return false;
      }
      return true;
    },
    async saveStep2() {
      const vm = this;
      vm.recalculateRecipe();
      const element = vm.formStep2;
      const data = {
        id_campana: element.id_campana,
        tipo_montura: element.tipo_montura,
        montaje: element.montaje,
        id_cliente: vm.cliente.id_cliente,
        id_anamnesis: vm.anamnesis.id_anamnesis,
        id_precio_lentes: element.lente.id_precio_lente,
        id_montura: element.montura.id_producto,
        montura_cliente: element.montura_cliente,
        lensometria: element.lensometria,
        angulos: element.angulo,
        receta: element.receta,
        observaciones: element.observaciones,
        fecha_entrega:
          element.fecha_entrega == ""
            ? new Date().toISOString().slice(0, 10)
            : element.fecha_entrega,
        hora_entrega: element.hora_entrega,
        monto_compra_proyectado: element.lente.monto_compra_proyectado,
        monto_compra_detallado: element.lente.monto_compra_detallado,
        seleccion_medidas: element.seleccion_medidas,
      };
      const response = await API.anamnesis.paso2(
        vm.anamnesis.id_anamnesis,
        data
      );
      return response;
    },
    nextStep(isCotizacion = false) {
      const vm = this;
      let caller = null;

      if (isCotizacion) {
        if (vm.$refs.formstep1.validate()) {
          vm.sendCotizacion();
          return;
        }
      }

      switch (vm.e1) {
        case 1:
          if (vm.$refs.formstep1.validate()) caller = vm.saveStepOne;
          break;
        case 2:
          const monturaCliente = vm.formStep2.montura_cliente ?? "";
          const montura = Object.keys(vm.formStep2.montura).length;
          if (monturaCliente == "" && montura == 0) {
            UTILS.toastr.info("No se ha definido una montura!", vm);
            break;
          }
          if (vm.$refs.formstep2.validate()) caller = vm.saveStepOTwo;
          break;
        case 3:
          const tipoComprobante = vm.formStep3.header.id_tipo_comprobante;
          const tipoDocumento = vm.formStep3.header.id_tipo_documento;
          const condicion = vm.formStep3.header.condicion_pago;

          if (!vm.$refs.formstep3.validate()) return;
          if (tipoComprobante === 1 && tipoDocumento !== 2) {
            UTILS.toastr.error("Tipo de documento inválido", this);
            break;
          }
          if (condicion === 3) {
            const totalCuotas = vm.formStep3.cuotas.reduce(
              (accumulator, currentValue) =>
                Number(accumulator) + Number(currentValue.monto),
              0
            );

            let totalComprobante =
              vm.formStep3.header.total - vm.formStep3.header.adelanto;
            if (vm.formStep3.header.id_eps_discount !== null) {
              totalComprobante -= vm.formStep3.header.eps_discount;
            }

            const total = Number(vm.formStep3.header.total);

            if (totalCuotas !== totalComprobante) {
              console.log(total);
              console.log(totalComprobante);
              UTILS.toastr.info("¡Verifique el total de las cuotas!", vm);
              break;
            }
          }

          caller = vm.saveStepThree;
          break;
        default:
          break;
      }

      if (caller) caller();
    },
    resetStep1() {
      const vm = this;
      vm.$refs.formstep1.resetValidation();
    },
    resetStep2() {
      const vm = this;
      vm.$refs.formstep2.resetValidation();
    },
    retomarAnamnesis(anamnesis) {
      const vm = this;
      vm.anamnesis = anamnesis;
      vm.cliente = anamnesis.cliente;
      if (anamnesis.orden != null) {
        vm.formStep2.montura = anamnesis.orden.montura;
        vm.formStep2.lente = anamnesis.orden.lente;
        vm.completeComprobante();
        vm.e1 = 3;
        return;
      }
      vm.e1 = 2;
    },
    async buscarAnamnesis() {
      const vm = this;
      const res = await API.anamnesis.paciente(
        vm.formStep1.cliente.nro_documento
      );
      vm.anamnesis_pendientes = res.data;
    },
    async buscarCotizaciones(id) {
      const vm = this;
      const res = await API.cotizaciones.paciente(id);
      let data = res.data;
      vm.cotizaciones_paciente = data.map((e) => {
        e.refraccion_cerca = e.refraccion_cerca;
        e.refraccion_lejos = e.refraccion_lejos;
        return e;
      });
    },
    exitReceipt() {
      this.$router.push('/comprobantes');
    },
    async descartarAnamnesis(id) {
      const vm = this;
      try {
        const res = await API.anamnesis.descartar(id);
        vm.buscarAnamnesis();
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
      }
    },
    async sendCotizacion() {
      let vm = this;
      try {
        vm.formStep1.anamnesis.sintomas =
          vm.formStep1.anamnesis.enfermedades.join(",");
        const response = await API.anamnesis.paso1(vm.formStep1);
        vm.cliente = response.data.cliente;
        vm.anamnesis = response.data.anamnesis;
        let routeString =
          "/cotizaciones/" +
          vm.cliente.id_cliente +
          "/anamnesis/" +
          vm.anamnesis.id_anamnesis;
        this.$router.push(routeString);
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async cancelarAnamnesis() {
      let vm = this;
      try {
        const response = await API.anamnesis.descartar(
          vm.anamnesis.id_anamnesis
        );
        this.$router.push("/dashboard");
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async saveStepOne() {
      let vm = this;
      try {
        vm.formStep1.anamnesis.antecedentes_familiares =
          vm.formStep1.anamnesis.antecedentes_familia.join(",");
        vm.formStep1.anamnesis.sintomas =
          vm.formStep1.anamnesis.enfermedades.join(",");
        const response = await API.anamnesis.paso1(vm.formStep1);
        vm.cliente = response.data.cliente;
        vm.anamnesis = response.data.anamnesis;
        vm.e1++;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async saveStepOTwo() {
      let vm = this;
      try {
        vm.recalculateRecipe();
        const element = vm.formStep2;
        const data = {
          tipo_montura: element.tipo_montura,
          montaje: element.montaje,
          id_cliente: vm.cliente.id_cliente,
          id_anamnesis: vm.anamnesis.id_anamnesis,
          id_precio_lentes: element.lente.id_precio_lente,
          id_montura: element.montura.id_producto,
          montura_cliente: element.montura_cliente,
          lensometria: element.lensometria,
          angulos: element.angulo,
          receta: element.receta,
          observaciones: element.observaciones,
          fecha_entrega:
            element.fecha_entrega == ""
              ? new Date().toISOString().slice(0, 10)
              : element.fecha_entrega,
          hora_entrega: element.hora_entrega,
          monto_compra_proyectado: element.lente.monto_compra_proyectado,
          monto_compra_detallado: element.lente.monto_compra_detallado,
          seleccion_medidas: element.seleccion_medidas,
        };
        const response = await API.anamnesis.paso2(
          vm.anamnesis.id_anamnesis,
          data
        );
        vm.e1++;
        vm.completeComprobante();
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async saveStepThree() {
      this.$swal({
        title: "Cargando...",
        allowOutsideClick: false,
        showCancelButton: false,
        showConfirmButton: false,
        icon: "warning",
        text: "Generando comprobantes, espere un momento!",
        willOpen: () => {
          this.$swal.showLoading();
        },
      });
      let vm = this;
      try {
        const condicion = vm.formStep3.header.condicion_pago;
        const eps = vm.formStep3.header.id_eps_discount;
        const epsDiscount = vm.formStep3.header.eps_discount;
        if (condicion != 1) {
          let saldo = vm.formStep3.header.total - vm.formStep3.header.adelanto;
          if (eps != null) saldo -= epsDiscount;
          vm.formStep3.header.saldo = Number(saldo).toFixed(2);
        } else {
          vm.formStep3.header.saldo = 0.0;
        }
        const response = await API.anamnesis.paso3(
          vm.anamnesis.id_anamnesis,
          vm.formStep3
        );

        const data = response.data;
        if (data.success) {
          if ("comprobante" in data && data.comprobante != null) {

            const comprobante = data.comprobante;
            this.comandaURL = "/comandaPDF/" + comprobante.id_comprobante;

          }else{
            this.comandaURL = "/comandaPDF/" + eps.id_comprobante;
          }
          const extra = data.extra;
          if ("client" in extra && extra.client != null && Object.keys(extra).length > 0) {
            const recibo = response.data.extra.client;
            this.reciboURL = recibo.facturador + "/print/document/" + recibo.external_id;
            this.reciboFormato = 'ticket';
            this.showFormats = true;
          }
          if ("eps" in extra && extra.eps != null) {
            const eps = response.data.extra.eps;
            this.epsURL = eps.facturador + "/print/document/" + eps.external_id;
            this.epsFormato = 'ticket';
          }
          if ("cupon" in data && data.cupon != null) {
            this.cupon = data.cupon;
          }
        }

        this.receiptDialog = true;
        this.$swal.close();
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async completeComprobante() {
      let vm = this;
      vm.formStep3.header.id_cliente = vm.cliente.id_cliente;
      vm.formStep3.header.nombre_cliente = vm.cliente.nombre_razon_social;
      vm.formStep3.header.nro_documento = vm.cliente.nro_documento;
      vm.formStep3.header.id_tipo_documento = vm.cliente.cod_tipo_doc;

      if (
        vm.formStep3.header.id_tipo_documento == 2 ||
        vm.formStep3.header.id_tipo_documento == 1
      ) {
        vm.formStep3.header.id_tipo_comprobante =
          vm.cliente.cod_tipo_doc == 1 ? 2 : 1;
      }

      vm.formStep3.header.direccion_cliente = vm.cliente.direccion;
      if (vm.formStep2.montura && vm.formStep2.montura.nombre_producto) {
        vm.formStep3.detail.push({
          is_invoice_item: true,
          id_producto: vm.formStep2.montura.id_producto,
          id_precio_lente: null,
          id_servicio: null,
          detalle_item: vm.formStep2.montura.nombre_producto,
          cantidad: 1,
          id_unidad_medida: 1,
          precio_unitario: vm.formStep2.montura.precio_venta,
          precio_total: vm.formStep2.montura.precio_venta,
          item_type: 1,
          disabled: true,
        });
      }
      vm.formStep3.detail.push({
        id_producto: null,
        id_precio_lente: vm.formStep2.lente.id_precio_lente,
        id_servicio: null,
        is_invoice_item: true,
        detalle_item: vm.formStep2.lente.nombre_propio,
        cantidad: 1,
        id_unidad_medida: 2,
        precio_unitario: vm.formStep2.lente.precio_venta,
        precio_total: vm.formStep2.lente.precio_venta,
        item_type: 2,
        disabled: true,
      });

      const response = await API.empresas_convenio.show(
        vm.anamnesis.id_empresa_convenio
      );
      const empresa = response.data;

      if (Number(empresa.descuento_cobertura).toFixed(2) > Number(0)) {
        vm.formStep3.header.dscto_fijo = Number(
          empresa.descuento_cobertura
        ).toFixed(2);
        UTILS.toastr.info("Descuento aplicado!", vm);
      }
      if (empresa.cobertura == 1) {
        this.$swal({
          title: "Empresa convenio con cobertura",
          showConfirmButton: true,
          icon: "info",
          text: "Se ha aplicado descuento por empresa convenio, verificar en la casilla inferior!",
        });
      }

      this.$root.$emit("form_anamnesis_change");
    },
    openCotizaciones() {
      const vm = this;
      vm.cotizacionDialog = true;
    },
    verCotizacion(id) {
      let urlCotizacion = "/cotizacionPDf/" + id;
      window.open(urlCotizacion, "Cotizacion #" + id, "width=500,height=600");
    },
    async usarCotizacion(item) {
      try {
        const vm = this;
        vm.cotizacionDialog = false;
        if (item.id_precio_lente != null) {
          //vm.resetLente();

          const { data } = await API.precioslentes.show(item.id_precio_lente);

          vm.formStep2.montaje = item.montaje;
          vm.formStep2.tipo_montura = item.montura;
          vm.formStep2.receta = JSON.parse(item.receta);

          vm.formStep2.lente.disenio = data.modelo;
          vm.formStep2.lente.fabricacion = data.fabricacion;
          vm.formStep2.lente.material = data.material;
          vm.formStep2.lente.serie = data.serie;
          vm.formStep2.lente.tratamiento = data.tratamiento;
          vm.formStep2.lente.nombre = data.nombre;
          vm.formStep2.lente.fotocromatico = data.fotocromatico;
          vm.formStep2.lente.color_fotocromatico = data.color_fotocromatico;
        }
        if (item.id_producto != null) {
          const element = vm.formStep2.productos.find(
            (e) => e.id_producto == item.id_producto
          );
          vm.formStep2.montura = element;
        }
      } catch (e) {
        console.error(e);
      }
    },
    resetLente() {
      const vm = this;
      vm.formStep2.lente.disenio = "";
      vm.formStep2.lente.fabricacion = "";
      vm.formStep2.lente.material = "";
      vm.formStep2.lente.serie = "";
      vm.formStep2.lente.tratamiento = "";
      vm.formStep2.lente.nombre = "";
      vm.formStep2.lente.fotocromatico = "";
      vm.formStep2.lente.color_fotocromatico = "";
    },
    allPropertiesEmpty(obj) {
      if (typeof obj !== "object") {
        return obj === null || obj === "";
      }
      for (const key in obj) {
        if (!this.allPropertiesEmpty(obj[key])) {
          return false;
        }
      }

      return true;
    },
    recalculateRecipe() {
      console.log("Here")
      const recipe = this.formStep2.receta;
      if (recipe.recipe_selection !== "recipe") return;
      switch (recipe.recipe.selection) {
        case "near":
          if (!this.allPropertiesEmpty(recipe.recipe.near)) return;
          RecipeService.calculateNear(this.formStep2.receta);
          break;
        case "far":
          if (!this.allPropertiesEmpty(recipe.recipe.far)) return;
          RecipeService.calculateFar(this.formStep2.receta);
          break;
        case "intermediate":
          if (!this.allPropertiesEmpty(recipe.recipe.intermediate)) return;
          RecipeService.calculateIntermediate(this.formStep2.receta);
          break;
        case "bifocal":
          if (!this.allPropertiesEmpty(recipe.recipe.bifocal)) return;
          RecipeService.calculateBifocal(this.formStep2.receta);
          break;
        case "multifocal":
          if (!this.allPropertiesEmpty(recipe.recipe.multifocal)) return;
          RecipeService.calculateMultifocal(this.formStep2.receta);
          break;
        default:
          break;
      }
    },
  },
  computed: {
    reciboURLFormated() {
      return this.reciboURL + '/' + this.reciboFormato;
    },
    epsURLFormated() {
      return this.epsURL + '/' + this.epsFormato
    }
  }
};
</script>
<style scoped>
.indicador {
  width: 15px;
  height: 15px;
  border-radius: 100%;
  margin-left: 10px;
  background-color: gainsboro;
}

.indicador_rojo {
  background-color: red;
}
</style>
