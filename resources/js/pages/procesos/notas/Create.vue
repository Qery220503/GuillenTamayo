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
            Crear Nota de
            {{ nota.id_tipo_comprobantes == 1 ? "Débito" : "Credito" }}
          </strong>
        </span>
      </v-card-title>
      <v-card-text>
        <v-form
          class="mt-2"
          ref="createForm"
          v-model="validAddForm"
          @submit.prevent="saveReg()"
          lazy-validation
        >
          <v-row>
            <v-col class="py-1" cols="12" md="3">
              <v-select
                :items="notas"
                v-model="nota.id_tipo_comprobantes"
                label="Tipo de Nota"
                item-text="nombre_tipo_documento"
                item-value="id_tipo_comprobantes"
                @change="
                  loadSerie();
                  loadTipos();
                "
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1" cols="12" md="3">
              <v-select
                :items="series"
                v-model="nota.id_serie"
                label="Serie"
                item-text="serie"
                item-value="id_serie"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1" cols="12" md="3">
              <v-select
                :items="notasTipos"
                v-model="nota.id_tipo_nota"
                :label="noteTypeFieldTitle"
                item-text="descripcion"
                item-value="id_tipo_nota"
                :rules="rules.required"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1" cols="12" md="3">
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
                    v-model="nota.fecha_emision"
                    :rules="rules.required"
                    label="Fecha Emisión"
                    filled
                    v-bind="attrs"
                    v-on="on"
                  ></v-text-field>
                </template>
                <v-date-picker
                  v-model="nota.fecha_emision"
                  :rules="rules.required"
                  @input="menu = false"
                  :max="today"
                ></v-date-picker>
              </v-menu>
            </v-col>

            <v-col class="py-1" cols="12" md="3">
              <v-text-field
                filled
                label="Cliente"
                :disabled="comprobante != null"
                autocomplete="off"
                v-model="comprobante.cliente.nombre_razon_social"
              ></v-text-field>
            </v-col>
            <v-col class="py-1" cols="12" md="3">
              <v-text-field
                filled
                disabled
                v-model="noteSerieNumber"
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
                :rules="rules.required"
              ></v-textarea>
            </v-col>
          </v-row>
          <v-row dense class="pa-2">
            <v-col cols="12">
              <v-autocomplete
                v-model="get_producto"
                :items="items_producto"
                :search-input.sync="search_productos"
                hide-no-data
                hide-selected
                dense
                item-text="Description"
                item-value="API"
                label="Buscar Producto"
                placeholder="Buscar Producto"
                return-object
                clearable
              ></v-autocomplete>
            </v-col>
            <v-spacer></v-spacer>
            <!--
            <v-col cols="auto">
              <v-btn depressed @click="addGrid()">
                <v-icon class="ma-2">mdi-plus</v-icon>
                Añadir Fila
              </v-btn>
            </v-col>
            -->
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
                        <v-select
                          :items="unidades_medida"
                          v-model="d.id_unidad_medida"
                          item-text="nombre_unidad_medida"
                          item-value="id_unidad_medida"
                          hide-details
                          outlined
                          dense
                          filled
                        ></v-select>
                      </td>
                      <td>
                        <v-text-field
                          @change="calcularTotal(idx)"
                          v-model="d.cantidad"
                          type="number"
                          step="0.01"
                          name="cantidad"
                          hide-details
                          outlined
                          :rules="rules.required"
                          dense
                          filled
                        ></v-text-field>
                      </td>
                      <td>
                        <v-text-field
                          @change="calcularTotal(idx)"
                          v-model="d.precio_unitario"
                          type="number"
                          step="0.01"
                          name="precio unitario"
                          :rules="rules.required"
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
                          :rules="rules.required"
                          hide-details
                          outlined
                          dense
                          filled
                          readonly
                        ></v-text-field>
                      </td>
                      <td>
                        <v-btn icon color="red" @click="deleteItem(idx)">
                          <v-icon>mdi-delete</v-icon>
                        </v-btn>
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
          <v-row class="d-flex justify-end">
            <v-col>
              <v-divider></v-divider>
              <div class="d-flex justify-end">
                <v-btn color="primary" type="submit" :loading="loading"
                  >Generar</v-btn
                >
                <v-btn color="secondary" class="ml-2">Cancelar</v-btn>
              </div>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import M from "minimatch";
import API from "../../../api";

export default {
  data() {
    return {
      breadcrumbs_title: "Notas Crédito/Débito",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
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
      series: [],
      nota: {
        id_tipo_comprobantes: 6,
        id_comprobante: null,
        id_serie: null,
        id_tipo_nota: null,
        fecha_emision: new Date().toISOString().substr(0, 10),
        detalle: [],
        total: 0,
        subtotal: 0,
        igv: 0
      },

      nota_detalle: {
        id_precio_lente: null,
        id_servicio: null,
        id_producto: null,

        item_type: null, //1 => Producto, 2 => Precio Lentes, 3 => Servicios,
        descripcion: null,
        cantidad: 0,
        precio_unitario: 0,
        total: 0
      },
      today: new Date().toISOString().substr(0, 10),
      notasTipos: [],
      comprobante: {
        id_comprobante: null,
        serie: {
          serie: ""
        },
        correlativo: "",
        cliente: {
          nombre_razon_social: ""
        },
        detalle: []
      },

      get_producto: null,
      search_productos: null,
      menu: false,

      entries_servicios: [],
      entries_productos: [],
      entries: [],
      count: 0,

      unidades_medida: [],
      rules: {
        required: UTILS.rules.required,
        required_email: UTILS.rules.required_email,

        file_size_200kb: UTILS.rules.file_size_200kb
      },
      loading: false
    };
  },
  created() {
    this.comprobante.id_comprobante = this.$route.params.id;
    this.loadComprobante();
    this.loadSerie();
    this.loadTipos();
    this.loadUnidades();
  },
  methods: {
    async saveReg() {
      try {
        if (this.nota.detalle.length == 0) {
          UTILS.toastr.info("Se debe de agregar al menos un item.", this);
          return;
        }
        if (!this.$refs.createForm.validate()) {
          return;
        }

        //Verificamos si es una nota de credito de tipo anilación de operación
        /**/

        this.loading = true;
        const response = await API.notas.create(this.nota);
        if (!response.data.success) {
          UTILS.toastr.error(response.data.message, this);
          return;
        }


        if (
          this.nota.id_tipo_comprobantes == 6 &&
          this.nota.id_tipo_nota == 1
        ) {
          const result = await this.$swal({
            icon: "question",
            title:
              "¿Desea anular cualquier deuda relacionada a este comprobante y devolver el stock?",
            text:
              "Debe de estar seguro que no se haya realizado esta acción antes.",
            showCancelButton: true,
            confirmButtonText: "Confirmar",
            cancelButtonText: "Cancelar"
          });
          if(result.isConfirmed){
            const res = await API.notas.anulacionOperacion(response.data.id_nota);
          }

        }
        let url =
          response.data.facturador +
          "/print/document/" +
          response.data.external_id +
          "/ticket";
        window.open(url, "Nota", "width=500,height=600");
        this.$router.push("/notas");
        //this.$router.push("/notas");
      } catch (e) {
        let tipo = this.nota.id_tipo_comprobantes == 6 ? "débito" : "crédito";
        console.error(e);
        UTILS.toastr.error("Error creando la nota de " + tipo, this);
      } finally {
        this.loading = false;
      }
    },
    deleteItem(index) {
      const vm = this;
      vm.nota.detalle.splice(index, 1);
    },
    async loadComprobante() {
      const response = await API.comprobante.show(
        this.comprobante.id_comprobante
      );
      this.comprobante = response.data;
      this.nota.id_comprobante = this.comprobante.id_comprobante;
      this.nota.id_cliente = this.comprobante.cliente.id_cliente;
      this.nota.detalle = this.comprobante.detalle.map(e => {
        return {
          id_precio_lente: e.item_type == 2 ? e.id_precio_lente : null,
          id_servicio: e.item_type == 3 ? e.id_servicio : null,
          id_producto: e.item_type == 1 ? e.id_producto : null,
          id_unidad_medida: e.unidad.id_unidad_medida,
          item_type: e.item_type, //1 => Producto, 2 => Precio Lentes, 3 => Servicios,
          descripcion: e.detalle_item,
          cantidad: parseFloat(e.cantidad).toFixed(2),
          precio_unitario: parseFloat(e.precio_unitario).toFixed(2),
          total: parseFloat(e.precio_total).toFixed(2)
        };
      });
      this.calcularTotales();
    },
    async loadSerie() {
      try {
        const vm = this;
        const response = await API.notas.series(vm.nota.id_tipo_comprobantes);
        vm.series = response.data;
        if (vm.series.length > 0) {
          vm.nota.id_serie = vm.series[0].id_serie;
          return;
        }
        vm.nota.id_serie = null;
      } catch (e) {
        console.error(e);
      }
    },
    async loadTipos() {
      const vm = this;
      const type = vm.nota.id_tipo_comprobantes;
      const response = await API.notas.tipos(type);
      vm.notasTipos = response.data;
      vm.nota.id_tipo_nota = null;
    },
    async loadUnidades() {
      const vm = this;
      const response = await API.unidad_medida.list();
      vm.unidades_medida = response.data;
    },
    async calcularTotales() {
      const vm = this;
      const totalNota = parseFloat(
        vm.nota.detalle.reduce((acc, obj) => {
          return acc + Number(obj.cantidad) * Number(obj.precio_unitario);
        }, 0)
      ).toFixed(2);
      const subtotal = parseFloat(totalNota / 1.18).toFixed(2);
      const igv = parseFloat(totalNota - subtotal).toFixed(2);

      vm.nota.total = totalNota;
      vm.nota.subtotal = subtotal;
      vm.nota.igv = igv;

    },
    calcularTotal(index) {
      let detail = this.nota.detalle[index];
      detail.cantidad =
        detail.cantidad != null || detail.cantidad != ""
          ? parseFloat(detail.cantidad).toFixed(2)
          : parseFloat(0).toFixed(2);
      detail.precio_unitario =
        detail.precio_unitario != null || detail.precio_unitario != ""
          ? parseFloat(detail.precio_unitario).toFixed(2)
          : parseFloat(0).toFixed(2);
      detail.total = parseFloat(
        detail.precio_unitario * detail.cantidad
      ).toFixed(2);
      this.$set(this.nota.detalle, index, { ...detail });
    }
  },
  computed: {
    noteTypeFieldTitle() {
      if (this.nota.id_tipo_comprobantes_nota == 1)
        return "Tipo de Nota de Débito";
      return "Tipo de Nota de Credito";
    },
    noteSerieNumber() {
      return (
        this.comprobante.serie.serie +
        "-" +
        this.comprobante.correlativo.toString().padStart(8, "0")
      );
    },
    items_producto() {
      const products = this.entries_productos.map(entry => {
        let Description = "";
        let item_type = 1;
        /*
          null => Ninguno
          1 => Producto
          2 => Precio Lentes
          3 => Servicios
        */
        Description =
          "[" + entry.codigo_producto + "] " + entry.nombre_producto + ` | ${entry.codigo_varilla}`;
        return Object.assign({}, entry, { Description, item_type });
      });
      const servicios = this.entries_servicios.map(entry => {
        let Description = "";
        let item_type = 3;
        Description = "[Servicio] " + entry.nombre_servicio;
        return Object.assign({}, entry, { Description, item_type });
      });
      return [...products, ...servicios];
    }
  },
  watch: {
    "nota.detalle": {
      handler(newValue, oldValue) {
        this.calcularTotales();
        //this.fixValues();
      },
      deep: true
    },
    get_producto(val) {
      if (val == null) return;

      let detail = {
        id_precio_lente: null,
        id_servicio: val.item_type == 3 ? val.id_servicio : null,
        id_producto: val.item_type == 1 ? val.id_producto : null,
        id_unidad_medida: val.item_type == 3 ? 3 : 1,
        item_type: val.item_type, //1 => Producto, 2 => Precio Lentes, 3 => Servicios,
        descripcion:
          val.item_type == 3 ? val.nombre_servicio : val.nombre_producto,
        cantidad: parseFloat(0).toFixed(2),
        precio_unitario: parseFloat(0).toFixed(2),
        total: parseFloat(0).toFixed(2)
      };

      console.log(detail, "Detail");

      this.nota.detalle.push(detail);
    },
    search_productos(val) {
      if (this.items_producto.length > 0) return;
      fetch("/api/list/productos")
        .then(res => res.json())
        .then(res => {
          this.count = res.length;
          this.entries_productos = res;
        })
        .catch(err => {
          console.log(err);
        })
        .finally(() => (this.isLoading = false));

      fetch("/api/combo/servicios")
        .then(res => res.json())
        .then(res => {
          this.count = res.length;
          this.entries_servicios = res;
        })
        .catch(err => {
          console.log(err);
        })
        .finally(() => (this.isLoading = false));
    }
  }
};
</script>
