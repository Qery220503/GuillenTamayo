<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-row>
      <v-col cols="12">
        <v-card class="mx-auto my-0 mx-1">
          <v-card-title class="d-flex justify-space-between"
            ><div>Monto Inicial</div>
            <div>s/.{{ caja.monto_inicial }}</div></v-card-title
          >
          <v-card-text class="d-flex justify-space-between text-h6"
            ><div>Monto Actual</div>
            <div>
              s/.{{
                (Number(caja.monto_inicial) + Number(diferencia)).toFixed(2)
              }}
            </div></v-card-text
          >
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" md="6">
        <v-card class="mx-auto my-0 mx-1">
          <v-card-title>Egresos</v-card-title>
          <v-card-text>
            <v-simple-table dense>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">Concepto</th>
                    <th class="text-right">Caja Chica</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="font-weight-bold">Egresos</td>
                    <td class="text-right">
                      S/. {{ Number(egresos.egresos | 0.0).toFixed(2) }}
                    </td>
                  </tr>
                  <tr>
                    <td class="font-weight-bold">Cancelaciones</td>
                    <td class="text-right">
                      S/. {{ Number(egresos.cancelaciones | 0.0).toFixed(2) }}
                    </td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
            <v-divider class="my-1"></v-divider>
            <div class="d-flex">
              <div class="red--text font-weight-bold text-h6">
                Total Egresos:
              </div>
              <v-spacer></v-spacer>
              <div class="font-weight-bold text-h6 text-right">
                S/. {{ total_egresos }}
              </div>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
      <v-col cols="12" md="6">
        <v-card class="mx-auto my-0 mx-1">
          <v-card-title>Ingresos</v-card-title>
          <v-card-text>
            <v-simple-table dense>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">Concepto</th>
                    <th v-for="titulo in ingresos.ventas" class="text-left">
                      {{ titulo.medio }}
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="font-weight-bold">Abonados</td>
                    <td v-for="venta in ingresos.ventas">{{ venta.total }}</td>
                  </tr>

                  <tr>
                    <td class="font-weight-bold">Deudas</td>
                    <td
                      class="red--text"
                      v-for="venta in ingresos.deudas_clientes"
                    >
                      {{ venta.total }}
                    </td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
            <v-divider class="my-1"></v-divider>
            <div class="d-flex">
              <div class="success--text font-weight-bold text-h6">
                Total Ingresos:
              </div>
              <v-spacer></v-spacer>
              <div class="font-weight-bold text-h6 text-right">
                S/. {{ total_ingresos }}
              </div>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <v-card class="mx-auto my-0 mx-1">
          <v-card-title class="d-flex justify-space-between"
            ><div>
              <div @click="dDiferencia = true">
                <v-icon size="x-large">mdi-eye-outline</v-icon> Diferencia
              </div>
            </div>
            <div class="red--text" v-if="diferencia < 0">
              <v-icon size="large" color="red">mdi-minus</v-icon> s/.
              {{ (diferencia | 0.0) * -1 }}
            </div>
            <div v-else class="success--text">
              <v-icon size="large" color="success">mdi-plus</v-icon> s/.
              {{ diferencia }}
            </div></v-card-title
          >
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <v-card class="mx-auto mx-1">
          <v-card-title class="d-flex justify-space-between">
            <div>Cuadres de Caja</div>
            <v-btn small color="primary" @click="dialog = true"
              ><v-icon>mdi-plus</v-icon> Añadir</v-btn
            >
          </v-card-title>
          <v-divider class="my-1"></v-divider>
          <div dense class="pa-2 align-center overflow-x-auto">
            <v-data-table
              light
              :headers="headers"
              :items="data_reg.data"
              :page="current_page"
              :items-per-page="itemsperpage"
              :server-items-length="total_reg"
              :options.sync="dataTabOptions"
              class="flex-grow-1 scroll-me"
              :footer-props="{
                itemsPerPageOptions: [25, 50, 100, 1000],
              }"
              :loading="loadingTable"
              loading-text="Cargando... Por favor, espere"
            >
              <template v-slot:[`item.estado_cuadre`]="{ item }">
                <v-chip :color="item.estado_cuadre.color" small>{{
                  item.estado_cuadre.nombre_estado
                }}</v-chip>
              </template>
              <template v-slot:[`item.estado`]="{ item }">
                <v-chip color="error" small v-if="item.estado == 0">
                  ELIMINADO
                </v-chip>
                <v-chip color="success" small v-else> ACTIVO </v-chip>
              </template>
              <template v-slot:[`item.actions`]="{ item }">
                <v-btn small icon @click="viewCuadre(item)">
                  <v-icon small>mdi-eye-outline</v-icon>
                </v-btn>
                <v-btn
                  v-if="item.estado != 0"
                  small
                  icon
                  @click="deleteCuadre(item)"
                >
                  <v-icon small>mdi-delete</v-icon>
                </v-btn>
              </template>
            </v-data-table>
          </div>
        </v-card>
      </v-col>
    </v-row>
    <v-dialog v-model="dlgDelete" persistent max-width="400px">
      <v-card>
        <form @submit.prevent="sendDeleteCuadre">
          <v-card-title class="d-flex justify-space-between">
            <span class="handline">Eliminar Cuadre</span>
            <v-btn icon @click="dlgDelete = false">
              <v-icon>mdi-close</v-icon>
            </v-btn></v-card-title
          >
          <v-card-text>
            Para poder eliminar el cuadre {{ defaultForm.id_cuadre }}, es
            necesario ingresar un motivo:
            <v-text-field
              label="Motivo"
              v-model="defaultForm.motivo_eliminacion"
              :rules="[rules.required]"
            ></v-text-field>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" type="submit" variant="text">
              Eliminar
            </v-btn>
          </v-card-actions>
        </form>
      </v-card>
    </v-dialog>
    <v-dialog
      v-model="dialog"
      persistent
      max-width="1000px"
      @click:outside="reset()"
    >
      <form @submit.prevent="saveConteoCaja">
        <v-card>
          <v-card-title>
            <span class="headline">Cuadre de Caja</span>
          </v-card-title>
          <v-card-text>
            <div class="d-flex">
              <v-row dense>
                <v-col cols="12" sm="12" md="12">
                  <v-simple-table dense :hover="false">
                    <template v-slot:default>
                      <thead>
                        <tr>
                          <th class="text-left">Denominación</th>
                          <th class="text-left">Cantidad</th>
                          <th class="text-left">Denominación</th>
                          <th class="text-left">Cantidad</th>
                          <th class="text-left">Denominación</th>
                          <th class="text-left">Cantidad</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td class="font-weight-bold">S/ 0.10</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.centimos10"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            />
                          </td>

                          <td class="font-weight-bold">S/ 2.00</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.soles2"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>

                          <td class="font-weight-bold">S/ 50.00</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.soles50"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>
                        </tr>
                        <tr>
                          <td class="font-weight-bold">S/ 0.20</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.centimos20"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>

                          <td class="font-weight-bold">S/ 5.00</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.soles5"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>

                          <td class="font-weight-bold">S/ 100.00</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.soles100"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>
                        </tr>
                        <tr>
                          <td class="font-weight-bold">S/ 0.50</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.centimos50"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>

                          <td class="font-weight-bold">S/ 10.00</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.soles10"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>
                          <td class="font-weight-bold">S/ 200.00</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.soles200"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>
                        </tr>
                        <tr>
                          <td class="font-weight-bold">S/ 1.00</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.soles1"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>

                          <td class="font-weight-bold">S/ 20.00</td>
                          <td class="font-weight-bold">
                            <v-text-field
                              :disabled="dlgEdit"
                              label="Cantidad"
                              v-model="nuevo_cuadre.soles20"
                              v-on:keyup="calcularTotal()"
                              :rules="[rules.required, rules.number]"
                            ></v-text-field>
                          </td>

                          <td class="font-weight-bold text-right">
                            <b>Total: </b>
                          </td>
                          <td class="font-weight-bold">
                            s/. {{ nuevo_cuadre.total }}
                          </td>
                        </tr>
                      </tbody>
                    </template>
                  </v-simple-table>
                </v-col>
                <v-col cols="12" sm="12" md="12">
                  <v-text-field
                    :disabled="dlgEdit"
                    class="px-1"
                    v-model="observacion"
                    :rules="[rules.required]"
                    filled
                    dense
                    label="Observación"
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="12" md="12" v-if="dlgEdit">
                  <v-text-field
                    :disabled="dlgEdit"
                    class="px-1"
                    v-model="motivo_eliminacion"
                    filled
                    dense
                    label="Motivo Eliminacion"
                  ></v-text-field>
                </v-col>
              </v-row>
            </div>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              v-show="!dlgEdit"
              color="primary"
              type="submit"
              variant="text"
            >
              Guardar
            </v-btn>
            <v-btn v-if="dlgEdit" color="primary" @click="reset()">
              Aceptar
            </v-btn>
          </v-card-actions>
        </v-card>
      </form>
    </v-dialog>
  </div>
</template>
<script>
import axios from "axios";
import API from "../../../api";

export default {
  data() {
    return {
      breadcrumbs_title: "Ver Caja",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Ver Caja" },
      ],
      headers: [
        { text: "N° Cuadre", sortable: false, value: "id_cuadre" },
        { text: "Total", sortable: false, value: "total" },
        { text: "Descuadre", sortable: false, value: "sobrante_faltante" },
        {
          text: "Condicion",
          sortable: false,
          value: "estado_cuadre",
          align: "center",
        },
        { text: "Estado", sortable: false, value: "estado", align: "center" },
        {
          text: "Acciones",
          value: "actions",
          align: "center",
          sortable: false,
          align: "right",
        },
      ],
      //--- Datatable ---
      loadingTable: false,
      current_page: 1,
      itemsperpage: 25,
      total_reg: 0,
      dataTabOptions: {},
      data_reg: [],
      filter: {
        estado: 1,
        id_caja: 0,
        estado_cuadre: 0,
      },
      caja: {
        id_caja: null,
      },
      egresos: {},
      ingresos: {},
      ingresos_totales: [],
      total_ingresos: 0,
      total_egresos: 0,
      diferencia: 0,
      dialog: false,
      dlgDelete: false,
      observacion: "",
      motivo_eliminacion: "",
      nuevo_cuadre: {
        centimos10: "0",
        centimos20: "0",
        centimos50: "0",
        soles1: "0",
        soles2: "0",
        soles5: "0",
        soles10: "0",
        soles20: "0",
        soles50: "0",
        soles100: "0",
        soles200: "0",
        total: "0",
      },
      valores: {
        centimos10: 0.1,
        centimos20: 0.2,
        centimos50: 0.5,
        soles1: 1,
        soles2: 2,
        soles5: 5,
        soles10: 10,
        soles20: 20,
        soles50: 50,
        soles100: 100,
        soles200: 200,
      },
      dlgEdit: false,
      defaultForm: {},
      rules: {
        required: UTILS.nRules.required,
        number: UTILS.nRules.only_numbers,
      },
    };
  },
  mounted() {
    this.searchCaja();
  },
  methods: {
    reset() {
      const defaultCuadre = {
        centimos10: "0",
        centimos20: "0",
        centimos50: "0",
        soles1: "0",
        soles2: "0",
        soles5: "0",
        soles10: "0",
        soles20: "0",
        soles50: "0",
        soles100: "0",
        soles200: "0",
        total: "0",
      };
      const vm = this;
      vm.dialog = false;
      vm.dlgEdit = false;
      vm.observacion = "";
      vm.motivo_eliminacion = "";
      vm.nuevo_cuadre = {};
      vm.nuevo_cuadre = defaultCuadre;
    },
    viewCuadre(item) {
      this.dlgEdit = true;
      this.dialog = true;
      this.nuevo_cuadre = {
        centimos10: String(item.centimos10),
        centimos20: String(item.centimos20),
        centimos50: String(item.centimos50),
        soles1: String(item.soles1),
        soles2: String(item.soles2),
        soles5: String(item.soles5),
        soles10: String(item.soles10),
        soles20: String(item.soles20),
        soles50: String(item.soles50),
        soles100: String(item.soles100),
        soles200: String(item.soles200),
        total: String(item.total),
      };
      this.motivo_eliminacion = item.motivo_eliminacion;
      this.observacion = item.observacion;
    },
    deleteCuadre(item) {
      Object.assign(this.defaultForm, item);
      this.dlgDelete = true;
      console.log(item);
    },
    calcularTotal() {
      const vm = this;
      vm.nuevo_cuadre.total = Object.entries(vm.nuevo_cuadre).reduce(
        (acc, [key, value]) => {
          if (key !== "total") {
            return Number(acc) + Number(value) * vm.valores[key];
          }
          return acc;
        },
        0
      );
    },
    async searchCaja() {
      const vm = this;
      const res = await API.caja.buscar();
      vm.caja = res.data.data;
      vm.loadDetails();
      vm.getCuadres();
    },
    async sendDeleteCuadre() {
      const vm = this;
      try {
        const res = await API.cuadre.remove(
          vm.defaultForm.id_cuadre,
          "?motivo_eliminacion=" + vm.defaultForm.motivo_eliminacion
        );
        UTILS.toastr.success("Cuadre elminado correctamente", this);
        vm.dlgDelete = false;
        vm.getCuadres();
      } catch (error) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(error);
      }
    },
    async saveConteoCaja() {
      const vm = this;

      const montoActual = (
        Number(vm.caja.monto_inicial) + vm.diferencia
      ).toFixed(2);
      const parms = {
        ...vm.nuevo_cuadre,
        idCaja: vm.caja.id_caja,
        observacion: vm.observacion,
        montoActual: montoActual,
      };
      try {
        const res = await API.cuadre.create(parms);
        if (res.status == 200) {
          UTILS.toastr.success("Cuadre creado correctamente", this);
          vm.reset();
          await vm.loadDetails();
          await vm.getCuadres();
        }
      } catch (error) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(error);
      }
    },
    async getCuadres(page = 1, per_page = 25, sortDesc = 0, sortBy = "") {
      try {
        const vm = this;
        const response = await API.cuadre.list(
          `?page=${page}&itemsPerPage=${per_page}&sortDesc=${sortDesc}` +
            `&sortBy=${sortBy}&estadoCuadre=${vm.filter.estado_cuadre}` +
            `&estado=${vm.filter.estado}&idCaja=${vm.caja.id_caja}`
        );
        this.data_reg = response.data;
        this.current_page = response.data.current_page;
        this.total_reg = this.data_reg.total;
      } catch (error) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(error);
      } finally {
        this.loadingTable = false;
      }
    },
    async loadDetails() {
      const vm = this;
      const { data } = await axios.get("api/caja/detalles/" + vm.caja.id_caja);

      vm.ingresos = data.data.ingresos;
      vm.egresos = data.data.egresos;

      for (let index = 0; index < vm.ingresos.ventas.length; index++) {
        let totalIngreso = {
          medio: vm.ingresos.ventas[index].medio,
          total: Number(vm.ingresos.ventas[index].total),
        };
        vm.ingresos_totales.push(totalIngreso);
      }
      vm.ingresos_totales.forEach((e) => {
        vm.total_ingresos += e.total;
      });

      vm.total_ingresos = Number(vm.total_ingresos).toFixed(2);
      vm.total_egresos = Number(
        vm.egresos.egresos + vm.egresos.cancelaciones
      ).toFixed(2);
      vm.diferencia = vm.total_ingresos - vm.total_egresos;
    },
  },
};
</script>
