<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs :breadcrumbs_title="breadcrumbs_title" :breadcrumbs="breadcrumbs"></custom-breadcrumbs>
    <MeasuresComponent :recipes="recipes" :editable="true"></MeasuresComponent>

    <br />
    <div>
      <div class="d-flex flex-row justify-end align-center mb-2">
        <v-btn color="primary" @click="addCotizacion()">
          <v-icon left>
            mdi-plus
          </v-icon>
          Nuevo
        </v-btn>
      </div>
      <v-card flat v-for="(c, idx) in cotizaciones" :key="idx" class="mb-2">
        <v-card-text>
          <div class="d-flex justify-space-between align-center ">
            <h2 class="mb-1">
              Montura
            </h2>
            <v-btn icon color="red" @click="deleteCotizacion(c, idx)">
              <v-icon>mdi-close</v-icon>
            </v-btn>
          </div>
          <v-row no-gutters>
            <v-col>
              <v-autocomplete v-model="c.id_producto" :items="items_monturas" filled dense item-text="description"
                item-value="id_producto" label="Buscar Montura"></v-autocomplete>
            </v-col>
          </v-row>
          <v-row no-gutters>
            <v-col>
              <strong>
                <span> Tipo de montura </span>
              </strong>
              <v-radio-group row v-model="c.montura.tipo_montura">
                <v-radio v-for="(m, idx) in items_tipo_monturas" :label="m.text" :value="m.value" :key="idx"></v-radio>
              </v-radio-group>
            </v-col>
            <v-col>
              <strong>
                <span> Montaje </span>
              </strong>
              <v-radio-group row v-model="c.montura.montaje">
                <v-radio v-for="(m, idx) in items_montaje" :label="m.text" :value="m.value" :key="idx"></v-radio>
              </v-radio-group>
            </v-col>
          </v-row>
          <v-divider class="my-4"></v-divider>
          <h2 class="mb-1">
            Lunas
          </h2>
          <v-row no-gutters>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select v-model="c.lunas.disenio" :items="items.disenio" filled label="1. Diseño"
                @change="getFabricacion(idx)"></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select v-model="c.lunas.fabricacion" :items="c.items.fabricacion" filled label="2. Fabricación"
                @change="getMaterial(idx)"></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4"><v-select v-model="c.lunas.material" :items="c.items.material"
                filled label="3. Material" @change="getSerie(idx)"></v-select></v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select v-model="c.lunas.serie" :items="c.items.serie" filled label="4. Serie"
                @change="getTratamiento(idx)"></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select v-model="c.lunas.tratamiento" :items="c.items.tratamiento" filled label="5. Tratamiento"
                @change="getNombre(idx)"></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4"><v-select v-model="c.lunas.nombre" :items="c.items.nombre" filled
                label="6. Nombre" @change="getFotocromatico(idx)"></v-select></v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select v-model="c.lunas.fotocromatico" :items="c.items.fotocromatico" filled label="7. Fotocromatico"
                @change="getColorFotocromatico(idx)"></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select v-model="c.lunas.color_fotocromatico" :items="c.items.color_fotocromatico" filled
                label="8. Color Fotocromatico" @change="getLente(idx)"></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-text-field readonly label="Precio" filled v-model="c.precio"></v-text-field>
            </v-col>
          </v-row>
        </v-card-text>
      </v-card>
    </div>

    <div class="d-flex justify-end align-center mb-2">
      <v-btn color="primary" class="ml-2" @click="guardarCotizacion()" :loading="loadingBtn">
        <v-icon left>
          mdi-sd
        </v-icon>
        Guardar
      </v-btn>
      <v-btn color="red" class="ml-2" @click="cancelCotizacion()">
        <v-icon left>
          mdi-cancel
        </v-icon>
        Cancelar
      </v-btn>
    </div>

    <v-dialog v-model="cotizacionDialog" :overlay="false" width="50%" transition="dialog-transition">
      <div style="width:100%; height: 550px;">
        <iframe :src="urlCotizacion" frameborder="0" height="100%" width="100%"></iframe>
      </div>
    </v-dialog>
  </div>
</template>
<script>
import API from "../../../api";
import MeasuresComponent from "../../../components/measures/MeasuresComponent.vue";
export default {
  components: {
    MeasuresComponent
  },
  data() {
    return {
      loadingBtn: false,
      breadcrumbs_title: "Cotizaciones",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Cotizaciones" }
      ],
      items: {
        disenio: []
      },
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
      cotizaciones: [],
      cotizacion: {
        id_precio_lente: "",
        id_producto: "",
        montura: {
          tipo_montura: "Aro Completo",
          montaje: "Bisell Brillante"
        },
        lunas: {
          disenio: "",
          fabricacion: "",
          material: "",
          serie: "",
          tratamiento: "",
          nombre: "",
          fotocromatico: "",
          color_fotocromatico: ""
        },
        precio: null,
        items: {
          fabricacion: [],
          material: [],
          serie: [],
          tratamiento: [],
          nombre: [],
          fotocromatico: [],
          color_fotocromatico: []
        }
      },
      urlCotizacion: "",
      cotizacionDialog: false,
      recipes: {
          // recipe_selection: "recipe",
          // recipe: {
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
      anamnesis: {
        id_anamnesis: null
      },
      items_monturas: [],
      montura_seleccionada: null,
      cliente: {
        id_cliente: null
      }
    };
  },
  methods: {
    addCotizacion() {
      const vm = this;
      let c = JSON.parse(JSON.stringify(Object.assign({}, vm.cotizacion)));
      vm.cotizaciones.push(c);
      console.log(c);
    },
    deleteCotizacion(elem, pos) {
      const vm = this;
      if (vm.cotizaciones.length == 1)
        return;
      vm.cotizaciones.splice(pos, 1);
    },
    async getProductos() {
      const vm = this;
      try {
        let response = await API.productos.combo();
        vm.items_monturas = response.data.map(element => ({
          description: `[${element.codigo_producto}] ${element.nombre_producto}`,
          codigo_producto: element.codigo_producto,
          id_producto: element.id_producto,
          nombre_producto: element.nombre_producto,
          precio_compra: element.precio_compra,
          precio_venta: element.precio_venta
        }));
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async guardarCotizacion() {
      const vm = this;
      try {
        vm.loadingBtn = true;
        let detalle = vm.cotizaciones
          .filter(e => e.id_precio_lente != null)
          .map(e => {
            return {
              id_precio_lente: e.id_precio_lente,
              id_producto: e.id_producto,
              montura: e.montura.tipo_montura,
              montaje: e.montura.montaje
            };
          });
        let toSend = {
          id_cliente: vm.cliente.id_cliente,
          receta: vm.recipes,
          detalle: detalle
        };
        if (vm.anamnesis.id_anamnesis != null)
          toSend.id_anamnesis = vm.anamnesis.id_anamnesis;
        const { data } = await API.cotizaciones.create(toSend);
        vm.urlCotizacion = "/cotizacionPDf/" + data.cotizacion.id_cotizacion;
        //vm.cotizacionDialog = true;
        window.open(vm.urlCotizacion, "Cotizacion #" + data.cotizacion.id_cotizacion, "width=500,height=600");
        this.$router.push("/cotizaciones");
      }
      catch (e) {
        console.error(e);
      }
      finally {
        vm.loadingBtn = false;
      }
    },
    cancelCotizacion() {
      this.$router.push("/");
    },
    async getDisenio() {
      const vm = this;
      try {
        const response = await API.precioslentes.disenio();
        vm.items.disenio = response.data;
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getFabricacion(idx) {
      const vm = this;
      try {
        vm.cotizaciones[idx].items.fabricacion = [];
        vm.cotizaciones[idx].items.material = [];
        vm.cotizaciones[idx].items.serie = [];
        vm.cotizaciones[idx].items.tratamiento = [];
        vm.cotizaciones[idx].items.nombre = [];
        vm.cotizaciones[idx].items.fotocromatico = [];
        vm.cotizaciones[idx].items.color_fotocromatico = [];
        vm.cotizaciones[idx].precio = null;
        vm.cotizaciones[idx].lunas.fabricacion = "";
        vm.cotizaciones[idx].lunas.material = "";
        vm.cotizaciones[idx].lunas.serie = "";
        vm.cotizaciones[idx].lunas.tratamiento = "";
        vm.cotizaciones[idx].lunas.nombre = "";
        vm.cotizaciones[idx].lunas.fotocromatico = "";
        vm.cotizaciones[idx].lunas.color_fotocromatico = "";
        const response = await API.precioslentes.fabricacion({
          disenio: vm.cotizaciones[idx].lunas.disenio
        });
        vm.cotizaciones[idx].items.fabricacion = response.data;
        if (vm.cotizaciones[idx].items.fabricacion.length === 1) {
          vm.cotizaciones[idx].lunas.fabricacion =
            vm.cotizaciones[idx].items.fabricacion[0];
          vm.getMaterial(idx);
        }
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getMaterial(idx) {
      const vm = this;
      try {
        this.cotizaciones[idx].items.material = [];
        this.cotizaciones[idx].items.serie = [];
        this.cotizaciones[idx].items.tratamiento = [];
        this.cotizaciones[idx].items.nombre = [];
        this.cotizaciones[idx].items.fotocromatico = [];
        this.cotizaciones[idx].items.color_fotocromatico = [];
        this.cotizaciones[idx].precio = null;
        this.cotizaciones[idx].lunas.material = "";
        this.cotizaciones[idx].lunas.serie = "";
        this.cotizaciones[idx].lunas.tratamiento = "";
        this.cotizaciones[idx].lunas.nombre = "";
        this.cotizaciones[idx].lunas.fotocromatico = "";
        this.cotizaciones[idx].lunas.color_fotocromatico = "";
        const response = await API.precioslentes.material({
          disenio: vm.cotizaciones[idx].lunas.disenio,
          fabricacion: vm.cotizaciones[idx].lunas.fabricacion
        });
        vm.cotizaciones[idx].items.material = response.data;
        if (vm.cotizaciones[idx].items.material.length === 1) {
          vm.cotizaciones[idx].lunas.material =
            vm.cotizaciones[idx].items.material[0];
          vm.getSerie(idx);
        }
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getSerie(idx) {
      const vm = this;
      try {
        this.cotizaciones[idx].items.serie = [];
        this.cotizaciones[idx].items.tratamiento = [];
        this.cotizaciones[idx].items.nombre = [];
        this.cotizaciones[idx].items.fotocromatico = [];
        this.cotizaciones[idx].items.color_fotocromatico = [];
        this.cotizaciones[idx].precio = null;
        this.cotizaciones[idx].lunas.serie = "";
        this.cotizaciones[idx].lunas.tratamiento = "";
        this.cotizaciones[idx].lunas.nombre = "";
        this.cotizaciones[idx].lunas.fotocromatico = "";
        this.cotizaciones[idx].lunas.color_fotocromatico = "";
        const response = await API.precioslentes.serie({
          disenio: vm.cotizaciones[idx].lunas.disenio,
          fabricacion: vm.cotizaciones[idx].lunas.fabricacion,
          material: vm.cotizaciones[idx].lunas.material
        });
        vm.cotizaciones[idx].items.serie = response.data;
        if (vm.cotizaciones[idx].items.serie.length === 1) {
          vm.cotizaciones[idx].lunas.serie =
            vm.cotizaciones[idx].items.serie[0];
          vm.getTratamiento(idx);
        }
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getTratamiento(idx) {
      const vm = this;
      try {
        this.cotizaciones[idx].items.tratamiento = [];
        this.cotizaciones[idx].items.nombre = [];
        this.cotizaciones[idx].items.fotocromatico = [];
        this.cotizaciones[idx].items.color_fotocromatico = [];
        this.cotizaciones[idx].precio = null;
        this.cotizaciones[idx].lunas.tratamiento = "";
        this.cotizaciones[idx].lunas.nombre = "";
        this.cotizaciones[idx].lunas.fotocromatico = "";
        this.cotizaciones[idx].lunas.color_fotocromatico = "";
        const response = await API.precioslentes.tratamiento({
          disenio: vm.cotizaciones[idx].lunas.disenio,
          fabricacion: vm.cotizaciones[idx].lunas.fabricacion,
          material: vm.cotizaciones[idx].lunas.material,
          serie: vm.cotizaciones[idx].lunas.serie
        });
        vm.cotizaciones[idx].items.tratamiento = response.data;
        if (vm.cotizaciones[idx].items.tratamiento.length === 1) {
          vm.cotizaciones[idx].lunas.tratamiento =
            vm.cotizaciones[idx].items.tratamiento[0];
          vm.getNombre(idx);
        }
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getNombre(idx) {
      const vm = this;
      try {
        this.cotizaciones[idx].nombre = [];
        this.cotizaciones[idx].fotocromatico = [];
        this.cotizaciones[idx].color_fotocromatico = [];
        this.cotizaciones[idx].precio = null;
        this.cotizaciones[idx].lunas.color_fotocromatico = "";
        this.cotizaciones[idx].lunas.nombre = "";
        this.cotizaciones[idx].lunas.fotocromatico = "";
        const response = await API.precioslentes.nombre({
          disenio: vm.cotizaciones[idx].lunas.disenio,
          fabricacion: vm.cotizaciones[idx].lunas.fabricacion,
          material: vm.cotizaciones[idx].lunas.material,
          serie: vm.cotizaciones[idx].lunas.serie,
          tratamiento: vm.cotizaciones[idx].lunas.tratamiento
        });
        vm.cotizaciones[idx].items.nombre = response.data;
        if (vm.cotizaciones[idx].items.nombre.length === 1) {
          vm.cotizaciones[idx].lunas.nombre =
            vm.cotizaciones[idx].items.nombre[0];
          vm.getFotocromatico(idx);
        }
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getFotocromatico(idx) {
      const vm = this;
      try {
        this.cotizaciones[idx].items.color_fotocromatico = [];
        this.cotizaciones[idx].precio = null;
        this.cotizaciones[idx].lunas.color_fotocromatico = "";
        const response = await API.precioslentes.foto({
          disenio: vm.cotizaciones[idx].lunas.disenio,
          fabricacion: vm.cotizaciones[idx].lunas.fabricacion,
          material: vm.cotizaciones[idx].lunas.material,
          serie: vm.cotizaciones[idx].lunas.serie,
          tratamiento: vm.cotizaciones[idx].lunas.tratamiento,
          nombre: vm.cotizaciones[idx].lunas.nombre
        });
        vm.cotizaciones[idx].items.fotocromatico = response.data;
        if (vm.cotizaciones[idx].items.fotocromatico.length === 1) {
          vm.cotizaciones[idx].lunas.fotocromatico =
            vm.cotizaciones[idx].items.fotocromatico[0];
          vm.getColorFotocromatico(idx);
        }
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getColorFotocromatico(idx) {
      const vm = this;
      try {
        vm.cotizaciones[idx].precio = null;
        const response = await API.precioslentes.color({
          disenio: vm.cotizaciones[idx].lunas.disenio,
          fabricacion: vm.cotizaciones[idx].lunas.fabricacion,
          material: vm.cotizaciones[idx].lunas.material,
          serie: vm.cotizaciones[idx].lunas.serie,
          tratamiento: vm.cotizaciones[idx].lunas.tratamiento,
          nombre: vm.cotizaciones[idx].lunas.nombre,
          fotocromatico: vm.cotizaciones[idx].lunas.fotocromatico
        });
        vm.cotizaciones[idx].items.color_fotocromatico = response.data;
        if (vm.cotizaciones[idx].items.color_fotocromatico.length === 1) {
          vm.cotizaciones[idx].lunas.color_fotocromatico =
            vm.cotizaciones[idx].items.color_fotocromatico[0];
          vm.getLente(idx);
        }
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async getLente(idx) {
      const vm = this;
      try {
        const response = await API.precioslentes.precio({
          disenio: vm.cotizaciones[idx].lunas.disenio,
          fabricacion: vm.cotizaciones[idx].lunas.fabricacion,
          material: vm.cotizaciones[idx].lunas.material,
          serie: vm.cotizaciones[idx].lunas.serie,
          tratamiento: vm.cotizaciones[idx].lunas.tratamiento,
          nombre: vm.cotizaciones[idx].lunas.nombre,
          fotocromatico: vm.cotizaciones[idx].lunas.fotocromatico,
          color_fotocromatico: vm.cotizaciones[idx].lunas.color_fotocromatico
        });
        let item = response.data[0];
        vm.cotizaciones[idx].precio = item.precio_venta;
        vm.cotizaciones[idx].id_precio_lente = item.id_precio_lente;
      }
      catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    async generatePDF() {
      const vm = this;
      vm.urlCotizacion = "/cotizacionPDf";
      vm.cotizacionDialog = true;
      console.log(vm.refraccion_lejos, vm.refraccion_cerca, "REFRACIONES");
    },
    async searchAnamnesis() {
      try {
        const vm = this;
        const id_anamnesis = vm.$route.params.id_anamnesis;
        const response = await API.anamnesis.search(id_anamnesis);
        vm.anamnesis = response.data;
      }
      catch (e) {
        //console.error(e);
        this.$router.push("/error/not-found");
      }
    },
    async searchCliente() {
      try {
        const vm = this;
        const id_cliente = vm.$route.params.id_cliente;
        const response = await API.clientes.show(id_cliente);
        vm.cliente = response.data;
      }
      catch (e) {
        this.$router.push("/error/not-found");
      }
    }
  },
  created() {
    const vm = this;
    vm.getProductos();
  },
  mounted() {
    const vm = this;
    const params = vm.$route.params;
    let c = JSON.parse(JSON.stringify(Object.assign({}, vm.cotizacion)));
    vm.cotizaciones.push(c);
    vm.getDisenio();
    vm.searchCliente();
    if (params.id_anamnesis != undefined) {
      vm.searchAnamnesis();
    }
  },
  computed: {},
  components: { MeasuresComponent }
};
</script>
