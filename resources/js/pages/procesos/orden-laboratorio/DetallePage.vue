<template>
  <div class="flex-grow-1">
    <div class="d-flex align-end">
      <div class="py-3 min-w-0 pb-1 pt-1">
        <div class="d-flex justify-space-between">
          <div class="text-left">
            <h2>{{ breadcrumbs_title }}</h2>
            <slot></slot>
            <v-breadcrumbs
              :items="breadcrumbs"
              class="pa-0 py-2"
            ></v-breadcrumbs>
          </div>
        </div>
      </div>
      <v-spacer></v-spacer>

      <div class="d-flex">
        <!--<v-btn
          class="mb-2 mr-2"
          depressed
          color="info"
          :href="urlComprobante"
          target="_blank"
        >
          <v-icon>mdi-cart-outline</v-icon>Generar Compra
        </v-btn>-->
        <v-btn
          class="mb-2"
          depressed
          color="error"
          :href="urlComprobante"
          target="_blank"
        >
          <v-icon>mdi-file-pdf</v-icon>PDF
        </v-btn>
      </div>
    </div>
    <v-alert
      v-if="form.cliente.lista_negra == 1"
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

    <v-card class="mb-4 px-3">
      <div
        class="px-2"
        style="overflow-x: hidden !important; overflow-y: hidden !important"
      >
        <v-row class="mt-2 align-center">
          <v-col class="py-2 px-1" cols="12" md="4">
            <h2 class="mb-1">Orden de Laboratorio</h2>
            <h4>#{{ String(form.id_orden_laboratorio).padStart(8, "0") }}</h4>
          </v-col>
          <v-spacer></v-spacer>
          <v-col class="py-2 px-1" cols="12" md="4">
            <h4 class="mb-1">Estado de la Orden</h4>
            <v-select
              v-if="
                id_estado_orden_laboratorio != 3 &&
                id_estado_orden_laboratorio != 5
              "
              v-model="form.id_estado_orden_laboratorio"
              :items="items_estados"
              item-value="id_estado_orden_laboratorio"
              item-text="nombre_estado"
              placeholder=""
              outlined
              dense
              hide-details
            ></v-select>
            <v-chip
              v-else-if="id_estado_orden_laboratorio == 3"
              color="success"
            >
              Entregado
            </v-chip>
            <v-chip v-else-if="id_estado_orden_laboratorio == 5" color="error">
              Anulado
            </v-chip>
          </v-col>
          <v-col class="py-2 px-1" cols="12" md="2">
            <v-btn
              v-if="
                id_estado_orden_laboratorio != 3 &&
                id_estado_orden_laboratorio != 5
              "
              depressed
              color="primary"
              class="mt-3"
              @click="actualizarEstado()"
            >
              Actualizar
            </v-btn>
          </v-col>
        </v-row>
        <v-divider class="my-4"></v-divider>
        <v-row>
          <v-col class="py-2 px-1" cols="12" md="6">
            <h4>Cliente</h4>
            <h5 v-if="form.cliente">
              {{ form.cliente.nombre_razon_social }}
            </h5>
          </v-col>
          <v-col class="py-2 px-1" cols="12" md="6">
            <h4>Montura</h4>
            <h5 v-if="form.montura">
              {{
                form.montura
                  ? form.montura.nombre_producto
                  : form.montura_cliente
              }}
            </h5>
          </v-col>
        </v-row>
        <v-divider class="my-4"></v-divider>
        <v-row>
          <v-col class="py-2 px-1" cols="12" md="12">
            <h4>Historial de Estados</h4>
            <v-container style="width: 600px">
              <v-timeline dense clipped>
                <v-slide-x-transition group>
                  <v-timeline-item
                    v-for="(event, idx) in form.historial"
                    :key="idx"
                    class="mb-4"
                    color="primary"
                    small
                  >
                    <v-row>
                      <v-col cols="7">
                        <span>
                          <strong>{{
                            event.estado_orden.nombre_estado
                          }}</strong> </span
                        ><br />
                        <span> Por {{ event.usuario.name }} </span>
                      </v-col>
                      <v-col class="text-right" cols="5">
                        {{ event.created_at | formatDateGeneral }}
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
          <v-col class="py-2 px-1" cols="12" md="5">
            <h5>Tipo de montura</h5>
            {{ form.tipo_montura }}
            <!--
            <v-radio-group row v-model="form.tipo_montura" readonly>
              <v-radio
                v-for="(item, index) in items_tipo_monturas"
                :key="'tm_' + index"
                :label="item.text"
                :value="String().toUpperCase(item.value)"
              ></v-radio>
            </v-radio-group>
            -->
          </v-col>
          <v-col class="py-2 px-1" cols="12" md="7">
            <h5>Montaje con</h5>
            {{ form.montaje }}
            <!--
            <v-radio-group row v-model="form.montaje" readonly>
              <v-radio
                v-for="(item, index) in items_montaje"
                :key="'tm_' + index"
                :label="item.text"
                :value="String().toUpperCase(item.value)"
              ></v-radio>
            </v-radio-group>
            -->
          </v-col>
        </v-row>
        <v-divider class="my-4"></v-divider>
        <v-row>
          <!-- PRECIO LENTES -->
          <v-col class="py-1 px-1" cols="12" md="4">
            <v-select
              label="Diseño"
              placeholder="Selecciona un diseño"
              v-model="form.lente.modelo"
              :rules="[rules.required]"
              dense
              filled
              readonly
              item-text="text"
              item-value="text"
              :items="items_disenio"
            ></v-select>
          </v-col>
          <v-col class="py-1 px-1" cols="12" md="4">
            <v-select
              label="Fabricación"
              placeholder="Selecciona una fabricación"
              v-model="form.lente.fabricacion"
              :rules="[rules.required]"
              dense
              filled
              readonly
              item-text="text"
              item-value="text"
              :items="items_fabricacion"
            ></v-select>
          </v-col>
          <v-col class="py-1 px-1" cols="12" md="4">
            <v-select
              label="Material"
              placeholder="Selecciona un material"
              v-model="form.lente.material"
              :rules="[rules.required]"
              dense
              filled
              readonly
              item-text="text"
              item-value="text"
              :items="items_material"
            ></v-select>
          </v-col>
          <v-col class="py-1 px-1" cols="12" md="4">
            <v-select
              label="Serie"
              placeholder="Selecciona una serie"
              v-model="form.lente.serie"
              :rules="[rules.required]"
              dense
              filled
              readonly
              item-text="text"
              item-value="text"
              :items="items_serie"
            ></v-select>
          </v-col>
          <v-col class="py-1 px-1" cols="12" md="4">
            <v-select
              label="Tratamiento"
              placeholder="Selecciona un tratamiento"
              v-model="form.lente.tratamiento"
              :rules="[rules.required]"
              dense
              filled
              readonly
              item-text="text"
              item-value="text"
              :items="items_tratamiento"
            ></v-select>
          </v-col>
          <v-col class="py-1 px-1" cols="12" md="4">
            <v-select
              label="Nombre"
              placeholder="Selecciona un nombre"
              v-model="form.lente.nombre"
              :rules="[rules.required]"
              dense
              filled
              readonly
              item-text="text"
              item-value="text"
              :items="items_nombre"
            ></v-select>
          </v-col>

          <v-col class="py-1 px-1" cols="12" md="4">
            <v-select
              label="Fotocromat."
              v-model="form.lente.fotocromatico"
              :rules="[rules.required]"
              dense
              filled
              readonly
              item-text="text"
              item-value="text"
              :items="items_foto"
            ></v-select>
          </v-col>
          <v-col class="py-1 px-1" cols="12" md="4">
            <v-select
              label="Color Fotocromat"
              v-model="form.lente.color_fotocromatico"
              placeholder="Selecciona un color"
              :rules="[rules.required]"
              dense
              filled
              readonly
              item-text="text"
              item-value="text"
              :items="items_color"
            ></v-select>
          </v-col>
          <v-col class="py-1 px-1" cols="12" md="3">
            <v-text-field
              label="Precio"
              type="number"
              dense
              filled
              readonly
              autocomplete="off"
              :value="items_precio.precio_venta"
            ></v-text-field>
          </v-col>
          <!-- PRECIO LENTES -->
        </v-row>
        <!--
        <v-divider class="my-4"></v-divider>
        <h5>Lensometría</h5>

        <v-row class="mt-1">
          <v-col class="py-2 px-1" cols="12" md="6">
            <v-simple-table>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left"></th>
                    <th class="text-left">
                      <strong>ESF</strong>
                    </th>
                    <th class="text-left">
                      <strong>CYL</strong>
                    </th>
                    <th class="text-left">
                      <strong>EJE</strong>
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td><strong>O.D</strong></td>
                    <td>
                      <v-text-field
                        hide-details
                        outlined
                        dense
                        filled
                        readonly
                        v-model="form.lensometria.od.esfera"
                      ></v-text-field>
                    </td>
                    <td>
                      <v-text-field
                        hide-details
                        outlined
                        dense
                        filled
                        readonly
                        v-model="form.lensometria.od.cilindro"
                      ></v-text-field>
                    </td>
                    <td>
                      <v-text-field
                        hide-details
                        outlined
                        dense
                        filled
                        readonly
                        v-model="form.lensometria.od.eje"
                      ></v-text-field>
                    </td>
                  </tr>
                  <tr>
                    <td><strong>O.I</strong></td>
                    <td>
                      <v-text-field
                        hide-details
                        outlined
                        dense
                        filled
                        readonly
                        v-model="form.lensometria.oi.esfera"
                      ></v-text-field>
                    </td>
                    <td>
                      <v-text-field
                        hide-details
                        outlined
                        dense
                        filled
                        readonly
                        v-model="form.lensometria.oi.cilindro"
                      ></v-text-field>
                    </td>
                    <td>
                      <v-text-field
                        hide-details
                        outlined
                        dense
                        filled
                        readonly
                        v-model="form.lensometria.oi.eje"
                      ></v-text-field>
                    </td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
          </v-col>
          <v-col class="d-flex align-center">
            <v-text-field
              hide-details
              outlined
              dense
              filled
              readonly
              class="mr-1"
              label="Ángulo panorámico"
              v-model="form.angulo.panoramico"
            ></v-text-field>
            <v-text-field
              hide-details
              outlined
              dense
              filled
              readonly
              class="mr-1"
              label="Ángulo pantoscópico"
              v-model="form.angulo.pantoscopico"
            ></v-text-field>
            <v-text-field
              hide-details
              outlined
              dense
              filled
              readonly
              label="Distancia Vértice"
              v-model="form.angulo.vertice"
            ></v-text-field>
          </v-col>
        </v-row>
        -->

        <v-divider class="my-4"></v-divider>
        <h5>Receta</h5>

        <!-- Antecedentes Componente -->
        <MeasuresComponent
          :recipes="form.receta"
          :noeditable="true"
        ></MeasuresComponent>
        <v-divider class="my-4"></v-divider>
        <v-row>
          <v-col cols="6">
            <v-textarea
              rows="3"
              v-model="form.observaciones"
              label="Observaciones"
              filled
              readonly
            ></v-textarea>
          </v-col>
          <v-col cols="3">
            <v-text-field
              v-model="form.fecha_entrega"
              label="Fecha entrega"
              prepend-inner-icon="mdi-calendar"
              readonly
              filled
              dense
              :rules="[rules.required]"
            ></v-text-field>
          </v-col>
          <v-col cols="3">
            <v-text-field
              v-model="form.hora_entrega"
              label="Hora entrega"
              prepend-inner-icon="mdi-clock-time-four-outline"
              readonly
              filled
              dense
              :rules="[rules.required]"
            ></v-text-field>
          </v-col>
        </v-row>
      </div>
      <div v-if="verRecetaCard" style="text-align: center">
        <iframe
          class="mx-auto"
          :src="urlComprobante"
          frameborder="0"
          height="700px"
          width="90%"
        >
        </iframe>
      </div>
    </v-card>
  </div>
</template>
<script>
import MeasuresComponent from "../../../components/measures/MeasuresComponent.vue";

export default {
  components: {
    MeasuresComponent,
  },
  data() {
    return {
      breadcrumbs_title: "Orden de la Laboratorio",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Ordenes de laboratorio" },
      ],
      requiredRules: [(v) => !!v || "Campo obligatorio"],
      rules: {
        required: UTILS.nRules.required,
        dni: UTILS.nRules.min8,
        ruc: UTILS.nRules.min811,
        only_numbers: UTILS.nRules.only_numbers,
        email: UTILS.nRules.email,
      },
      validAddForm: false,
      items_monturas: [],
      items_tipo_monturas: [
        { text: "Aro Completo", value: "ARO COMPLETO" },
        { text: "Semi al aire", value: "SEMI AL AIRE" },
        { text: "Al aire", value: "AL AIRE" },
      ],
      items_montaje: [
        { text: "Bisell Brillante", value: "BISELL BRILLANTE" },
        { text: "Faceteado", value: "FACETEADO" },
        { text: "Pase de lunas", value: "PASE DE LUNAS" },
        { text: "Reducción de diámetro", value: "REDUCCIÓN DE DIÁMETRO" },
      ],
      items_disenio: [],
      items_fabricacion: [],
      items_material: [],
      items_serie: [],
      items_tratamiento: [],
      items_nombre: [],
      items_foto: [],
      items_color: [],
      items_precio: {},
      items_estados: [],

      menu: false,
      menu2: false,
      id_orden_lab: 0,
      form: {
        historial: [],
        tipo_montura: "Aro Completo",
        montaje: "Bisell Brillante",
        lente: {
          modelo: "",
          fabricacion: "",
          material: "",
          serie: "",
          tratamiento: "",
          nombre: "",
          fotocromatico: "",
          color_fotocromatico: "",
        },
        montura: {},
        montura_cliente: "",
        lensometria: {
          od: {
            esfera: "",
            cilindro: "",
            eje: "",
          },
          oi: {
            esfera: "",
            cilindro: "",
            eje: "",
          },
        },
        angulo: {
          panoramico: "",
          pantoscopico: "",
          vertice: "",
        },
        receta: {
          recipe_selection: "recipe",
          recipe: {
            dip: null,
            od: {
              esf: null,
              cyl: null,
              add_cerca: null,
              add_intermedio: null,
              alt: null,
              prismas: null,
              avcc: null,
            },
            oi: {
              esf: null,
              cyl: null,
              add_cerca: null,
              add_intermedio: null,
              alt: null,
              prismas: null,
              avcc: null,
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
                avcc: null,
              },
              od: {
                esf: null,
                cyl: null,
                dnp: null,
                alt: null,
                prismas: null,
                avcc: null,
              },
            },
            intermediate: {
              oi: {
                esf: null,
                cyl: null,
                dnp: null,
                alt: null,
                prismas: null,
                avcc: null,
              },
              od: {
                esf: null,
                cyl: null,
                dnp: null,
                alt: null,
                prismas: null,
                avcc: null,
              },
            },
            far: {
              oi: {
                esf: null,
                cyl: null,
                dnp: null,
                alt: null,
                prismas: null,
                avcc: null,
              },
              od: {
                esf: null,
                cyl: null,
                dnp: null,
                alt: null,
                prismas: null,
                avcc: null,
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
                avcc: null,
              },
              oi: {
                esf: null,
                cyl: null,
                eje: null,
                add: null,
                dnp: null,
                alt: null,
                prismas: null,
                avcc: null,
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
                avcc: null,
              },
              oi: {
                esf: null,
                cyl: null,
                eje: null,
                add: null,
                dnp: null,
                alt: null,
                prismas: null,
                avcc: null,
              },
              panoramic_angle: null,
              pantoscopic_angle: null,
              vertex_distance: null,
            },
          },
          contact_recipe: {
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
        cliente: {
          lista_negra: 0,
        },
        observaciones: "",
        fecha_entrega: "",
        hora_entrega: "",
        monto_compra_proyectado: "",
      },
      urlComprobante: null,
      verRecetaCard: false,
      id_estado_orden_laboratorio: -1,
    };
  },
  created() {
    let vm = this;
    vm.id_orden_lab = vm.$route.params.id;
    vm.getEstados();
    vm.getRegistro();
    vm.getDisenio();
    vm.getProductos();
    vm.verReceta();
  },
  watch: {
    "form.montura"(value) {
      console.log(value);
    },
    "form.lente.modelo"(value) {
      this.getFabricacion(value);
    },
    "form.lente.fabricacion"(value) {
      this.getMaterial(value);
    },
    "form.lente.material"(value) {
      this.getSerie(value);
    },
    "form.lente.serie"(value) {
      this.getTratamiento(value);
    },
    "form.lente.tratamiento"(value) {
      this.getNombre(value);
    },
    "form.lente.nombre"(value) {
      this.getFotocromatica(value);
    },
    "form.lente.fotocromatico"(value) {
      this.getColor(value);
    },
    "form.lente.color_fotocromatico"(value) {
      this.getLente(value);
    },
  },
  methods: {
    loadData() {
      const vm = this;
      vm.getEstados();
      vm.getRegistro();
      vm.getDisenio();
      vm.getProductos();
      vm.verReceta();
    },
    async getEstados() {
      let vm = this;
      try {
        const response = await API.orden_laboratorio.estados();
        vm.items_estados = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async verReceta() {
      this.urlComprobante = "/ordenLaboratorioPDF/" + this.id_orden_lab;
      this.verRecetaCard = true;
    },
    async getRegistro() {
      let vm = this;
      try {
        vm.$store.commit("loader", true);
        const response = await API.orden_laboratorio.show(vm.id_orden_lab);
        let form = response.data;
        console.log(form, "Formulario");

        form.lensometria = form.lensometria;
        form.angulo = form.angulos;
        form.refraccion_lejos = form.refraccion_lejos;
        form.refraccion_cerca = form.refraccion_cerca;

        console.log(form);
        vm.form = form;
        vm.id_estado_orden_laboratorio = vm.form.id_estado_orden_laboratorio;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      } finally {
        vm.$store.commit("loader", false);
        vm.loadingTable = false;
      }
    },
    async getProductos() {
      const vm = this;
      try {
        let response = await API.productos.combo();
        //vm.items_monturas = response.data
        vm.items_monturas = response.data.map((element) => ({
          description: `[${element.codigo_producto}] ${element.nombre_producto}`,
          codigo_producto: element.codigo_producto,
          id_producto: element.id_producto,
          nombre_producto: element.nombre_producto,
          precio_compra: element.precio_compra,
          precio_venta: element.precio_venta,
        }));
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getDisenio() {
      const vm = this;
      try {
        const response = await API.precioslentes.disenio();
        vm.items_disenio = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getFabricacion(value) {
      const vm = this;
      try {
        const response = await API.precioslentes.fabricacion({
          disenio: vm.form.lente.modelo,
        });
        vm.items_fabricacion = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getMaterial(value) {
      const vm = this;
      try {
        const response = await API.precioslentes.material({
          disenio: vm.form.lente.modelo,
          fabricacion: vm.form.lente.fabricacion,
        });
        vm.items_material = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getSerie(value) {
      const vm = this;
      try {
        const response = await API.precioslentes.serie({
          disenio: vm.form.lente.modelo,
          fabricacion: vm.form.lente.fabricacion,
          material: vm.form.lente.material,
        });
        vm.items_serie = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getTratamiento(value) {
      const vm = this;
      try {
        const response = await API.precioslentes.tratamiento({
          disenio: vm.form.lente.modelo,
          fabricacion: vm.form.lente.fabricacion,
          material: vm.form.lente.material,
          serie: vm.form.lente.serie,
        });
        vm.items_tratamiento = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getNombre(value) {
      const vm = this;
      try {
        const response = await API.precioslentes.nombre({
          disenio: vm.form.lente.modelo,
          fabricacion: vm.form.lente.fabricacion,
          material: vm.form.lente.material,
          serie: vm.form.lente.serie,
          tratamiento: vm.form.lente.tratamiento,
        });
        vm.items_nombre = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getFotocromatica(value) {
      const vm = this;
      try {
        const response = await API.precioslentes.foto({
          disenio: vm.form.lente.modelo,
          fabricacion: vm.form.lente.fabricacion,
          material: vm.form.lente.material,
          serie: vm.form.lente.serie,
          tratamiento: vm.form.lente.tratamiento,
          nombre: vm.form.lente.nombre,
        });
        vm.items_foto = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getColor(value) {
      const vm = this;
      try {
        const response = await API.precioslentes.color({
          disenio: vm.form.lente.modelo,
          fabricacion: vm.form.lente.fabricacion,
          material: vm.form.lente.material,
          serie: vm.form.lente.serie,
          tratamiento: vm.form.lente.tratamiento,
          nombre: vm.form.lente.nombre,
          fotocromatico: vm.form.lente.fotocromatico,
        });
        vm.items_color = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getLente(value) {
      const vm = this;
      try {
        const response = await API.precioslentes.precio({
          disenio: vm.form.lente.modelo,
          fabricacion: vm.form.lente.fabricacion,
          material: vm.form.lente.material,
          serie: vm.form.lente.serie,
          tratamiento: vm.form.lente.tratamiento,
          nombre: vm.form.lente.nombre,
          fotocromatico: vm.form.lente.fotocromatico,
          color_fotocromatico: vm.form.lente.color_fotocromatico,
        });
        vm.items_precio = response.data[0];
        vm.form.lente.monto_compra_proyectado = vm.items_precio.precio_compra;
        vm.form.lente.monto_compra_detallado = vm.items_precio.precio_compra;
        vm.form.lente.id_precio_lente = vm.items_precio.id_precio_lente;
        vm.form.lente.precio_venta = vm.items_precio.precio_venta;
        vm.form.lente.nombre_propio = vm.items_precio.nombre_propio;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async actualizarEstado() {
      const vm = this;
      vm.$store.commit("loader", true);
      try {
        const response = await API.orden_laboratorio.update(
          vm.form.id_orden_laboratorio,
          {
            id_estado_orden_laboratorio: vm.form.id_estado_orden_laboratorio,
          }
        );
        UTILS.toastr.success("Estado actualizado correctamente", this);
        vm.id_estado_orden_laboratorio = vm.form.id_estado_orden_laboratorio;
        vm.$store.commit("loader", false);
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
        vm.$store.commit("loader", false);
      } finally {
        vm.loadData();
      }
    },
  },
};
</script>
