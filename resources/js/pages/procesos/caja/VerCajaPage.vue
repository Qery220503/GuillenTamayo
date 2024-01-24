<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <v-row>
      <v-col cols="4">
        <v-card class="mx-auto my-2 mx-1">
          <v-card-title>Egresos/Gastos</v-card-title>
          <v-card-text>
            <v-simple-table dense>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">
                      Concepto
                    </th>
                    <th class="text-right">
                      Caja Chica
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="font-weight-bold">Egresos</td>
                    <td class="text-right">S/. {{ Number(egresos.egresos).toFixed(2) }}</td>
                  </tr>
                  <tr>
                    <td class="font-weight-bold">Depósitos</td>
                    <td class="text-right">S/. {{ Number(egresos.cancelaciones).toFixed(2) }}</td>
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
              <div class="font-weight-bold text-h6">S/. {{ total_egresos }}</div>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
      <v-col cols="8">
        <v-card class="mx-auto my-2 mx-1">
          <v-card-title>Ingresos</v-card-title>
          <v-card-text>
            <v-simple-table dense>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">
                      Concepto
                    </th>
                    <th v-for="titulo in ingresos.ventas" class="text-left">
                      {{ titulo.medio  }}
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>Ventas</td>
                    <td v-for="venta in ingresos.ventas">{{ venta.total }}</td>
                  </tr>

                  <tr>
                    <td>Deudas Clientes</td>
                    <td v-for="venta in ingresos.deudas_clientes">{{ venta.total }}</td>
                  </tr>

                  <tr>
                    <td>Totales</td>
                    <td v-for="total in ingresos_totales">{{ total.total.toFixed(2) }}</td>

                  </tr>

                  <tr>
                    <td class="font-weight-bold">Caja Inicial</td>
                    <td class="font-weight-bold">S/.{{ caja.monto_inicial }}</td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
            <v-divider class="my-1"></v-divider>
            <div class="d-flex">
              <div class=" font-weight-bold text-h6">
                <span class="success--text">Ingresos</span>
              </div>
              <div class="font-weight-bold text-h6 ml-3">S/. {{ total_ingresos }}</div>
            </div>
            <div class="d-flex">
              <div class=" font-weight-bold text-h6">
                <span class="success--text">Ingresos</span> - <span class="error--text">Egresos:</span>
              </div>
              <div class="font-weight-bold text-h6 ml-3">S/. {{ total_ingresos - total_egresos }}</div>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <v-card class="mx-auto my-2 mx-1">
          <v-card-title>
            Cuadres de Caja
          </v-card-title>
          <v-card-subtitle>
            <v-btn small color="primary" class="mr-2" @click="dialog = true"
            ><v-icon>mdi-plus</v-icon> Añadir</v-btn>
          </v-card-subtitle>
          <v-divider class="my-1"></v-divider>
          <v-card-text>
            <div class="d-flex">
              <div class="red--text font-weight-bold text-h6">
                Total Egresos:
              </div>
              <v-spacer></v-spacer>
              <div class="font-weight-bold text-h6">S/. {{ total_egresos }}</div>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <v-dialog v-model="dialog" persistent max-width="1000px" @click:outside="reset()">
      <v-card>
        <v-card-title>
          <span class="headline">Nuevo Cuadre de Caja</span>
        </v-card-title>
        <v-card-text>
          <div class="d-flex">
            <v-col cols="12" sm="12" md="12">
              <v-simple-table dense>
              <template v-slot:default>
                <thead>
                  <tr>
                    <th class="text-left">
                      Denominación
                    </th>
                    <th class="text-left">
                      Cantidad
                    </th>
                    <th class="text-left">
                      Denominación
                    </th>
                    <th class="text-left">
                      Cantidad
                    </th>
                    <th class="text-left">
                      Denominación
                    </th>
                    <th class="text-left">
                      Cantidad
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="font-weight-bold">S/ 0.10</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.centimos10" v-on:keyup="calcularTotal()"/></td>

                    <td class="font-weight-bold">S/ 2.00</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.soles2" v-on:keyup="calcularTotal()"></v-text-field></td>

                    <td class="font-weight-bold">S/ 50.00</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.soles50" v-on:keyup="calcularTotal()"></v-text-field></td>
                  </tr>
                  <tr>
                    <td class="font-weight-bold">S/ 0.20</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.centimos20" v-on:keyup="calcularTotal()"></v-text-field></td>

                    <td class="font-weight-bold">S/ 5.00</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.soles5" v-on:keyup="calcularTotal()"></v-text-field></td>

                    <td class="font-weight-bold">S/ 100.00</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.soles100" v-on:keyup="calcularTotal()"></v-text-field></td>
                  </tr>
                  <tr>
                    <td class="font-weight-bold">S/ 0.50</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.centimos50" v-on:keyup="calcularTotal()"></v-text-field></td>

                    <td class="font-weight-bold">S/ 10.00</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.soles10" v-on:keyup="calcularTotal()"></v-text-field></td>

                    <td class="font-weight-bold">S/ 200.00</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.soles200" v-on:keyup="calcularTotal()"></v-text-field></td>
                  </tr>
                  <tr>
                    <td class="font-weight-bold">S/ 1.00</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.soles1" v-on:keyup="calcularTotal()"></v-text-field></td>

                    <td class="font-weight-bold">S/ 20.00</td>
                    <td class="font-weight-bold"><v-text-field label="Cantidad" v-model="nuevo_cuadre.soles20" v-on:keyup="calcularTotal()"></v-text-field></td>
                    
                    <td class="font-weight-bold text-right"><b>Total: </b></td>
                    <td class="font-weight-bold">{{ nuevo_cuadre.total }}</td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
            </v-col>
          </div>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import axios from 'axios';
import API from '../../../api';

export default {
  data() {
    return {
      breadcrumbs_title: "Ver Caja",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Ver Caja" }
      ],
      caja: {
        id_caja: null
      },
      egresos: {},
      ingresos: {},
      ingresos_totales: [],
      total_ingresos: 0,
      total_egresos: 0,
      headers: [],
      dialog: false,
      nuevo_cuadre: {
        centimos10: 0,
        centimos20: 0,
        centimos50: 0,
        soles1:     0,
        soles2:     0,
        soles5:     0,
        soles10:    0,
        soles20:    0,
        soles50:    0,
        soles100:   0,
        soles200:   0
      },
      requiredRules: [v => !!v || "Campo obligatorio"],
      defaultForm: {},
    };
  },
  mounted() {
    this.searchCaja();
  },
  methods: {
    reset() {
      this.dialog = false;
    },
    calcularTotal(){
      console.log("adsasdds");
    },
    async searchCaja(){
      const vm = this;
      const res = await API.caja.buscar();
      vm.caja = res.data.data;
      vm.loadDetails();
    },
    async loadDetails(){
      const vm = this; 
      const { data } = await axios.get("api/caja/detalles/" + vm.caja.id_caja);
      
      vm.ingresos = data.data.ingresos;
      vm.egresos = data.data.egresos;

      for (let index = 0; index < vm.ingresos.ventas.length; index++) {
        let totalIngreso = {
          medio: vm.ingresos.ventas[index].medio,
          total: Number(vm.ingresos.ventas[index].total) + Number(vm.ingresos.deudas_clientes[index].total),
        }
        vm.ingresos_totales.push(totalIngreso);
      }
      vm.ingresos_totales.forEach((e) => {
        vm.total_ingresos += e.total
      })

      vm.total_ingresos = Number(vm.total_ingresos).toFixed(2);
      vm.total_egresos = Number(vm.egresos.egresos + vm.egresos.cancelaciones).toFixed(2)
    
    },
    
    
  },

};
</script>
