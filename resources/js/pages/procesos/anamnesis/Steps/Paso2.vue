<template>
  <div class="overflow-y-auto pa-2" style="overflow-x: hidden !important;">
    <h2>Datos de montura & lentes</h2>
    <v-row class="mt-2">
      <v-col class="py-2 px-1" cols="12" md="6">
        <v-autocomplete
          return-object
          v-model="$form.montura"
          :items="items_monturas"
          filled
          dense
          item-text="description"
          label="Buscar Montura"
        ></v-autocomplete>
      </v-col>
      <v-col class="py-2 px-1" cols="12" md="6">
        <v-text-field
          filled
          dense
          label="Montura Cliente"
          v-model="$form.montura_cliente"
        ></v-text-field>
      </v-col>
    </v-row>
    <v-divider class="my-4"></v-divider>
    <v-row>
      <v-col class="py-2 px-1" cols="12" md="5">
        <h5>Tipo de montura</h5>
        <v-radio-group row v-model="$form.tipo_montura">
          <v-radio
            v-for="(item, index) in items_tipo_monturas"
            :key="'tm_' + index"
            :label="item.text"
            :value="item.value"
          ></v-radio>
        </v-radio-group>
      </v-col>
      <v-col class="py-2 px-1" cols="12" md="7">
        <h5>Montaje con</h5>
        <v-radio-group row v-model="$form.montaje">
          <v-radio
            v-for="(item, index) in items_montaje"
            :key="'tm_' + index"
            :label="item.text"
            :value="item.value"
          ></v-radio>
        </v-radio-group>
      </v-col>
    </v-row>
    <v-divider class="my-4"></v-divider>
    <v-row>
      <!-- PRECIO LENTES -->
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          label="Diseño"
          placeholder="Selecciona un diseño"
          v-model="$form.lente.disenio"
          :rules="[rules.required]"
          dense
          filled
          item-text="text"
          item-value="text"
          :items="items_disenio"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          label="Fabricación"
          placeholder="Selecciona una fabricación"
          v-model="$form.lente.fabricacion"
          :rules="[rules.required]"
          dense
          filled
          item-text="text"
          item-value="text"
          :items="items_fabricacion"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          label="Material"
          placeholder="Selecciona un material"
          v-model="$form.lente.material"
          :rules="[rules.required]"
          dense
          filled
          item-text="text"
          item-value="text"
          :items="items_material"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          label="Serie"
          placeholder="Selecciona una serie"
          v-model="$form.lente.serie"
          :rules="[rules.required]"
          dense
          filled
          item-text="text"
          item-value="text"
          :items="items_serie"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          label="Tratamiento"
          placeholder="Selecciona un tratamiento"
          v-model="$form.lente.tratamiento"
          :rules="[rules.required]"
          dense
          filled
          item-text="text"
          item-value="text"
          :items="items_tratamiento"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          label="Nombre"
          placeholder="Selecciona un nombre"
          v-model="$form.lente.nombre"
          :rules="[rules.required]"
          dense
          filled
          item-text="text"
          item-value="text"
          :items="items_nombre"
        ></v-select>
      </v-col>

      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          label="Fotocromat."
          v-model="$form.lente.fotocromatico"
          :rules="[rules.required]"
          dense
          filled
          item-text="text"
          item-value="text"
          :items="items_foto"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          label="Color Fotocromat"
          v-model="$form.lente.color_fotocromatico"
          placeholder="Selecciona un color"
          :rules="[rules.required]"
          dense
          filled
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
          autocomplete="off"
          readonly
          :value="items_precio.precio_venta"
        ></v-text-field>
      </v-col>
      <!-- PRECIO LENTES -->
    </v-row>
    <v-divider class="my-4"></v-divider>
    <!--<h5>Lensometría</h5>-->
    <!--Antecedentes-->
    <!--
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
                    v-model="$form.lensometria.od.esfera"
                  ></v-text-field>
                </td>
                <td>
                  <v-text-field
                    hide-details
                    outlined
                    dense
                    filled
                    v-model="$form.lensometria.od.cilindro"
                  ></v-text-field>
                </td>
                <td>
                  <v-text-field
                    hide-details
                    outlined
                    dense
                    filled
                    v-model="$form.lensometria.od.eje"
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
                    v-model="$form.lensometria.oi.esfera"
                  ></v-text-field>
                </td>
                <td>
                  <v-text-field
                    hide-details
                    outlined
                    dense
                    filled
                    v-model="$form.lensometria.oi.cilindro"
                  ></v-text-field>
                </td>
                <td>
                  <v-text-field
                    hide-details
                    outlined
                    dense
                    filled
                    v-model="$form.lensometria.oi.eje"
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
          class="mr-1"
          label="Ángulo panorámico"
          v-model="$form.angulo.panoramico"
        ></v-text-field>
        <v-text-field
          hide-details
          outlined
          dense
          filled
          class="mr-1"
          label="Ángulo pantoscópico"
          v-model="$form.angulo.pantoscopico"
        ></v-text-field>
        <v-text-field
          hide-details
          outlined
          dense
          filled
          label="Distancia Vértice"
          v-model="$form.angulo.vertice"
        ></v-text-field>
      </v-col>
    </v-row>
    -->
    <!--<v-divider class="my-4"></v-divider>-->
    <div class="d-flex">
      <h3>Receta</h3>
      <v-spacer></v-spacer>
      <v-btn depressed class="mr-3" color="info" @click="getHistorial">
        Buscar Receta
      </v-btn>
      <!--
      <v-btn dark class="mr-3" color="warning" @click="visionCerca">
        Visión Cerca
      </v-btn>
      <v-btn dark color="primary" @click="trasposicionCilindros">
        Trasposición de Cilindros
      </v-btn>
      -->
    </div>

    <!--Antecedentes-->

    <!-- Componente de medidas -->
    <br>
    <MeasuresComponent :recipes="$form.receta"></MeasuresComponent>

    <v-divider class="my-4"></v-divider>
    <v-row>
      <v-col cols="6">
        <v-textarea
          rows="3"
          v-model="$form.observaciones"
          label="Observaciones / Comentarios"
          filled
        ></v-textarea>
      </v-col>
      <v-col cols="3">
        <v-menu
          v-model="menu"
          :close-on-content-click="false"
          :nudge-right="40"
          transition="scale-transition"
          offset-y
          min-width="auto"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="dateFormatted"
              label="Fecha entrega"
              prepend-inner-icon="mdi-calendar"
              readonly
              filled
              dense
              v-bind="attrs"
              v-on="on"
              :rules="[rules.required]"
              @blur="$form.fecha_entrega = parseDate(dateFormatted)"
            ></v-text-field>
          </template>
          <v-date-picker
            v-model="$form.fecha_entrega"
            no-title
            @input="menu = false"
            :allowed-dates="allowedDates"
            :min="currentDate"
            @update:picker-date="pickerUpdate($event)"
          ></v-date-picker>
        </v-menu>
      </v-col>
      <v-col cols="3">
        <v-menu
          ref="menu"
          v-model="menu2"
          :close-on-content-click="false"
          :nudge-right="40"
          :return-value.sync="$form.hora_entrega"
          transition="scale-transition"
          offset-y
          max-width="290px"
          min-width="290px"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="$form.hora_entrega"
              label="Hora entrega"
              prepend-inner-icon="mdi-clock-time-four-outline"
              readonly
              filled
              dense
              v-bind="attrs"
              v-on="on"
              :rules="[rules.required]"
            ></v-text-field>
          </template>
          <v-time-picker
            v-if="menu2"
            v-model="$form.hora_entrega"
            full-width
            @click:minute="$refs.menu.save(form.hora_entrega)"
          ></v-time-picker>
        </v-menu>
      </v-col>
    </v-row>
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="error" text @click="cancel()">Cancelar</v-btn>
      <v-btn color="primary" @click="send()">
        Guardar
      </v-btn>
    </v-card-actions>
    <HistorialDialog />
  </div>
</template>
<script>
import MeasuresComponent from "../../../../components/measures/MeasuresComponent.vue";
import moment from "moment";
import API from "../../../../api";
import HistorialDialog from "../components/HistorialDialog";
export default {
  props: {
    form: {
      type: Object,
      default: () => {}
    },
    id_cliente: {
      type: Number,
      default: 0
    },
    send: {
      type: Function
    },
    cancel: {
      type: Function
    }
  },
  components: {
    HistorialDialog,
    MeasuresComponent,
  },
  data: vm => ({
    requiredRules: [v => !!v || "Campo obligatorio"],
    rules: {
      required: UTILS.nRules.required,
      dni: UTILS.nRules.min8,
      ruc: UTILS.nRules.min811,
      only_numbers: UTILS.nRules.only_numbers,
      email: UTILS.nRules.email
    },
    validAddForm: false,
    items_monturas: [],
    notAllowdDates: [],
    items_tipo_monturas: [
      { text: "Aro Completo", value: "Aro Completo" },
      { text: "Semi al aire", value: "Semi al aire" },
      { text: "Al aire", value: "Al aire" }
    ],
    items_montaje: [
      { text: "Bisell Brillante", value: "Bisell Brillante" },
      { text: "Faceteado", value: "Faceteado" },
      { text: "Pase de lunas", value: "Pase de lunas" },
      {
        text: "Reducción de diametro",
        value: "Reducción de diametro"
      }
    ],
    items_disenio: [],
    items_fabricacion: [],
    items_material: [],
    items_serie: [],
    items_tratamiento: [],
    items_nombre: [],
    items_foto: [],
    items_color: [],
    items_precio: {
      precio_compra: null,
      precio_venta: null,
    },
    menu: false,
    menu2: false,

    // DatePicker
    date: moment().format("YYYY-MM-DD"),
    currentDate: moment().format("YYYY-MM-DD"),
    availableDates: [],
    dateFormatted: vm.formatDate(
      new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10)
    )
  }),
  computed: {
    $form: {
      get() {
        return this.form;
      },
      set(value) {
        props.set(this, "$form", value);
      }
    }
  },
  created() {
    let vm = this;
    vm.getDisenio();
    vm.getProductos();
    vm.getNotAllowedDates();
  },
  watch: {
    "$form.lente.disenio"(value) {
      this.getFabricacion(value);
    },
    "$form.lente.fabricacion"(value) {
      if(value == null || value == "") return;
      this.getMaterial(value);
    },
    "$form.lente.material"(value) {
      if(value == null || value == "") return;
      this.getSerie(value);
    },
    "$form.lente.serie"(value) {
      if(value == null || value == "") return;
      this.getTratamiento(value);
    },
    "$form.lente.tratamiento"(value) {
      if(value == null || value == "") return;
      this.getNombre(value);
    },
    "$form.lente.nombre"(value) {
      if(value == null || value == "") return;
      this.getFotocromatica(value);
    },
    "$form.lente.fotocromatico"(value) {
      if(value == null || value == "") return;
      this.getColor(value);
    },
    "$form.lente.color_fotocromatico"(value) {
      if(value == null || value == ""){
        this.$emit("formReset", true);
        return;
      }
      this.getLente(value);
    },
    "$form.fecha_entrega"(val) {
      this.dateFormatted = this.formatDate(this.$form.fecha_entrega);
    }
  },
  mounted() {
    let vm = this;
    vm.$root.$on("seleccionar_receta", data => {
      vm.$form.receta = data.receta;
    });

  },
  methods: {
    formatDate(date) {
      if (!date) return null;
      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    parseDate(date) {
      if (!date) return null;
      const [day, month, year] = date.split("/");
      return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
    },
    getHistorial() {
      this.$root.$emit("get_historial_cliente", this.id_cliente);
    },
    async getProductos() {
      const vm = this;
      try {
        let response = await API.productos.combo();
        //vm.items_monturas = response.data
        vm.items_monturas = response.data.map(element => ({
          description: `[${element.codigo_producto}] ${element.nombre_producto}`,
          codigo_producto: element.codigo_producto,
          id_producto: element.id_producto,
          nombre_producto: element.nombre_producto,
          precio_compra: element.precio_compra || null,
          precio_venta: element.precio_venta || null
        }));
        vm.$form.productos = vm.items_monturas;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getNotAllowedDates() {
      const vm = this;
      try {
        const response = await API.apis.diasNoLaborales();
        vm.notAllowdDates = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    allowedDates(a) {
      return this.availableDates.includes(a);
    },

    pickerUpdate: function(val) {
      let totalDay = moment(val, "YYYY-MM").daysInMonth();
      let availableDates = [];

      let monthNow = moment().format("M");
      let monthSelected = moment(val).format("M");
      let day;
      day = 1;

      for (let i = day; i <= totalDay; i++) {
        let date = val + "-" + String(i).padStart(2, "0");
        if (moment(date).day() !== 0) {
          if (!this.notAllowdDates.includes(date)) {
            availableDates.push(date);
          }
        }
      }
      this.availableDates = [...availableDates];
      this.allowedDates();
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
          disenio: vm.$form.lente.disenio
        });
        vm.items_fabricacion = response.data;

        if (vm.items_fabricacion.length == 1) {
          vm.$form.lente.fabricacion = vm.items_fabricacion[0].text;
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getMaterial(value) {
      const vm = this;
      try {

        const response = await API.precioslentes.material({
          disenio: vm.$form.lente.disenio,
          fabricacion: vm.$form.lente.fabricacion
        });
        vm.items_material = response.data;

        if (vm.items_material.length == 1) {
          vm.$form.lente.material = vm.items_material[0].text;
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getSerie(value) {
      const vm = this;
      try {


        const response = await API.precioslentes.serie({
          disenio: vm.$form.lente.disenio,
          fabricacion: vm.$form.lente.fabricacion,
          material: vm.$form.lente.material
        });
        vm.items_serie = response.data;

        if (vm.items_serie.length == 1) {
          vm.$form.lente.serie = vm.items_serie[0].text;
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getTratamiento(value) {
      const vm = this;
      try {

        const response = await API.precioslentes.tratamiento({
          disenio: vm.$form.lente.disenio,
          fabricacion: vm.$form.lente.fabricacion,
          material: vm.$form.lente.material,
          serie: vm.$form.lente.serie
        });
        vm.items_tratamiento = response.data;

        if (vm.items_tratamiento.length == 1) {
          vm.$form.lente.tratamiento = vm.items_tratamiento[0].text;
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getNombre(value) {
      const vm = this;
      try {


        const response = await API.precioslentes.nombre({
          disenio: vm.$form.lente.disenio,
          fabricacion: vm.$form.lente.fabricacion,
          material: vm.$form.lente.material,
          serie: vm.$form.lente.serie,
          tratamiento: vm.$form.lente.tratamiento
        });
        vm.items_nombre = response.data;

        if (vm.items_nombre.length == 1) {
          vm.$form.lente.nombre = vm.items_nombre[0].text;
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getFotocromatica(value) {
      const vm = this;
      try {

        const response = await API.precioslentes.foto({
          disenio: vm.$form.lente.disenio,
          fabricacion: vm.$form.lente.fabricacion,
          material: vm.$form.lente.material,
          serie: vm.$form.lente.serie,
          tratamiento: vm.$form.lente.tratamiento,
          nombre: vm.$form.lente.nombre
        });
        vm.items_foto = response.data;

        if (vm.items_foto.length == 1) {
          vm.$form.lente.fotocromatico = vm.items_foto[0].text;
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getColor(value) {
      const vm = this;
      try {

        const response = await API.precioslentes.color({
          disenio: vm.$form.lente.disenio,
          fabricacion: vm.$form.lente.fabricacion,
          material: vm.$form.lente.material,
          serie: vm.$form.lente.serie,
          tratamiento: vm.$form.lente.tratamiento,
          nombre: vm.$form.lente.nombre,
          fotocromatico: vm.$form.lente.fotocromatico
        });

        vm.items_color = response.data;

        if (vm.items_color.length == 1) {
          vm.$form.lente.color_fotocromatico = vm.items_color[0].text;
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getLente(value) {
      const vm = this;
      try {
        const response = await API.precioslentes.precio({
          disenio: vm.$form.lente.disenio,
          fabricacion: vm.$form.lente.fabricacion,
          material: vm.$form.lente.material,
          serie: vm.$form.lente.serie,
          tratamiento: vm.$form.lente.tratamiento,
          nombre: vm.$form.lente.nombre,
          fotocromatico: vm.$form.lente.fotocromatico,
          color_fotocromatico: vm.$form.lente.color_fotocromatico
        });
        if(response.data.length == 0) return;
        vm.items_precio = response.data[0];
        vm.$form.lente.monto_compra_proyectado = vm.items_precio.precio_compra;
        vm.$form.lente.monto_compra_detallado = vm.items_precio.precio_compra;
        vm.$form.lente.id_precio_lente = vm.items_precio.id_precio_lente;
        vm.$form.lente.precio_venta = vm.items_precio.precio_venta;
        vm.$form.lente.nombre_propio = vm.items_precio.nombre_propio;
      } catch (e) {
        //UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async visionCerca() {
      var od_esf = this.form.refraccion_lejos.od.esfera;
      var od_adicion = this.form.refraccion_lejos.od.adicion;

      var oi_esf = this.form.refraccion_lejos.oi.esfera;
      var oi_adicion = this.form.refraccion_lejos.oi.adicion;

      var lejos_refra_od_cyl = this.form.refraccion_lejos.od.cilindro;
      var lejos_refra_od_eje = this.form.refraccion_lejos.od.eje;

      var lejos_refra_oi_cyl = this.form.refraccion_lejos.oi.cilindro;
      var lejos_refra_oi_eje = this.form.refraccion_lejos.oi.eje;

      if (od_adicion != "0" && od_adicion != "") {
        var sum = parseFloat(od_esf) + parseFloat(od_adicion);
        var sum2 = parseFloat(oi_esf) + parseFloat(oi_adicion);

        this.form.refraccion_cerca.od.esfera = (sum < 0 ? "" : "+") + sum;
        this.form.refraccion_cerca.oi.esfera = (sum < 0 ? "" : "+") + sum2;

        this.form.refraccion_cerca.od.cilindro = lejos_refra_od_cyl;
        this.form.refraccion_cerca.od.eje = lejos_refra_od_eje;

        this.form.refraccion_cerca.oi.cilindro = lejos_refra_oi_cyl;
        this.form.refraccion_cerca.oi.eje = lejos_refra_oi_eje;
      }
    },
    async trasposicionCilindros() {
      var lejos_refra_od_cyl = parseFloat(
        this.form.refraccion_lejos.od.cilindro
      );

      if (lejos_refra_od_cyl < 0) {
        var lejos_refra_od_esf = this.form.refraccion_lejos.od.esfera;
        this.form.refraccion_cerca.od.esfera = lejos_refra_od_esf;

        var lejos_refra_od_cyl = this.form.refraccion_lejos.od.cyl;
        this.form.refraccion_lejos.od.cilindro = lejos_refra_od_cyl;

        var lejos_refra_od_eje = parseFloat(this.form.refraccion_lejos.od.eje);
        this.form.refraccion_lejos.od.eje = lejos_refra_od_eje;
      } else {
        var lejos_refra_od_esf = this.form.refraccion_lejos.od.esfera;
        var lejos_refra_od_cyl = this.form.refraccion_lejos.od.cilindro;
        var sum =
          parseFloat(lejos_refra_od_esf) + parseFloat(lejos_refra_od_cyl);
        this.form.refraccion_lejos.od.esfera = (sum < 0 ? "" : "+") + sum;

        var lejos_refra_od_cyl_parsed = parseFloat(lejos_refra_od_cyl);
        var sum2 =
          Math.abs(lejos_refra_od_cyl_parsed) - lejos_refra_od_cyl_parsed * 2;

        this.form.refraccion_lejos.od.cilindro = (sum2 < 0 ? "" : "+") + sum2;
        var lejos_refra_od_eje = parseFloat(this.form.refraccion_lejos.od.eje);

        if (lejos_refra_od_eje <= 90) {
          var valor = lejos_refra_od_eje + 90;
        } else if (lejos_refra_od_eje > 90) {
          var valor = lejos_refra_od_eje - 90;
        } else {
          var valor = 0;
        }

        this.form.refraccion_lejos.od.eje = valor;
      }

      //OI
      var lejos_refra_oi_cyl = this.form.refraccion_lejos.oi.cilindro;

      if (lejos_refra_oi_cyl < 0) {
        var lejos_refra_oi_esf = this.form.refraccion_lejos.oi.esfera;
        this.form.refraccion_cerca.oi.esfera = lejos_refra_oi_esf;

        var lejos_refra_oi_cyl = this.form.refraccion_cerca.oi.cilindro;
        this.form.refraccion_cerca.oi.cilindro = lejos_refra_oi_cyl;

        var lejos_refra_oi_eje = parseFloat(this.form.refraccion_cerca.oi.eje);
        this.form.refraccion_cerca.oi.eje = lejos_refra_oi_eje;
      } else {
        var lejos_refra_oi_esf = this.form.refraccion_cerca.oi.esfera;
        var lejos_refra_oi_cyl = this.form.refraccion_cerca.oi.cilindro;
        var sum3 =
          parseFloat(lejos_refra_oi_esf) + parseFloat(lejos_refra_oi_cyl);
        this.form.refraccion_cerca.oi.esfera = (sum3 < 0 ? "" : "+") + sum3;

        var lejos_refra_oi_cyl_parsed = parseFloat(lejos_refra_oi_cyl);
        var sum4 =
          Math.abs(lejos_refra_oi_cyl_parsed) - lejos_refra_oi_cyl_parsed * 2;

        this.form.refraccion_cerca.oi.cilindro = (sum4 < 0 ? "" : "+") + sum4;

        var lejos_refra_oi_eje = this.form.refraccion_lejos.oi.eje;

        if (lejos_refra_oi_eje <= 90) {
          var valor2 = lejos_refra_oi_eje + 90;
        } else if (lejos_refra_oi_eje > 90) {
          var valor2 = lejos_refra_oi_eje - 90;
        } else {
          var valor2 = 0;
        }

        this.form.refraccion_cerca.oi.eje = valor2;
      }
    },
    async cancelAnamnesis() {
      const response = await API.anamnesis.descartar(this);
    }
  }
};
</script>
