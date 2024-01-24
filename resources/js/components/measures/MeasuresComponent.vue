<template>
  <div>
    <v-card elevation="0">
      <v-card flat>
        <v-card-text>
          <div class="d-flex justify-space-between align-center">
            <h2 class="mb-1">Receta Lentes</h2>
            <div>
              <v-btn
                :color="!show ? 'blue' : 'blue-grey'"
                class="ma-2 white--text"
                @click="show = !show"
              >
                {{ show ? "Ocultar" : "Mostrar" }}
                <v-icon right dark v-if="!show"> mdi-eye </v-icon>
                <v-icon right dark v-else> mdi-eye-off </v-icon>
              </v-btn>
              <v-btn
                v-if="!noeditable"
                color="blue-grey white--text"
                @click="recalculateData"
              >
                Calcular
                <v-icon right dark> mdi-cog </v-icon>
              </v-btn>
            </div>
          </div>
          <v-row>
            <v-col cols="12" md="12">
              <v-simple-table>
                <template v-slot:default>
                  <thead>
                    <tr>
                      <th></th>
                      <th class="text-left">ESF</th>
                      <th class="text-left">CYL</th>
                      <th class="text-left">EJE</th>
                      <th class="text-left">ADD. CERCA</th>
                      <th class="text-left">ADD. INTERMEDIO</th>
                      <th class="text-left">DIP</th>
                      <th class="text-left">ALT</th>
                      <th class="text-left">PRISMAS</th>
                      <th class="text-left">A.V.C.V.</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>
                        <strong> O.D </strong>
                      </td>
                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.od.esf"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.od.cyl"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>
                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.od.eje"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.od.add_cerca"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.od.add_intermedio"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td rowspan="2">
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.dip"
                          outlined
                          hide-details
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.od.alt"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.od.prismas"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.od.avcc"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>
                    </tr>

                    <tr>
                      <td>
                        <strong> O.I </strong>
                      </td>
                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.oi.esf"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.oi.cyl"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.oi.eje"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.oi.add_cerca"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.oi.add_intermedio"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.oi.alt"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.oi.prismas"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td>
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.oi.avcc"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>
                    </tr>
                  </tbody>
                  <tfoot>
                    <tr>
                      <td>
                        <strong> A. PANORÁMICO </strong>
                      </td>
                      <td colspan="2">
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.panoramic_angle"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <!--<td></td>-->
                    </tr>

                    <tr>
                      <td>
                        <strong> A. PANTOSCÓPICO </strong>
                      </td>
                      <td colspan="2">
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.pantoscopic_angle"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <!--<td></td>-->
                    </tr>

                    <tr>
                      <td>
                        <strong> DISTANCIA VERTICE </strong>
                      </td>
                      <td colspan="2">
                        <v-text-field
                          :disabled="noeditable"
                          v-model="recipes.vertex_distance"
                          outlined
                          hide-details
                          dense
                        ></v-text-field>
                      </td>

                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <!--<td></td>-->
                    </tr>
                  </tfoot>
                </template>
              </v-simple-table>
            </v-col>
            <v-col cols="12" md="12">
              <v-tabs
                v-model="recipes.selection"
                :disabled="noeditable"
                @change="recalculateData"
              >
                <v-tab key="far" href="#far" :disabled="noeditable">
                  Lejos M.
                </v-tab>
                <v-tab key="near" href="#near" :disabled="noeditable">
                  Cerca M.
                </v-tab>
                <v-tab
                  key="intermediate"
                  href="#intermediate"
                  :disabled="noeditable"
                >
                  Intermedio M.
                </v-tab>
                <v-tab
                  key="multifocal"
                  href="#multifocal"
                  :disabled="noeditable"
                >
                  Multifocal
                </v-tab>
                <v-tab key="bifocal" href="#bifocal" :disabled="noeditable">
                  Bifocal
                </v-tab>
                <v-tab key="contact" href="#contact" :disabled="noeditable">
                  Lente de Contacto
                </v-tab>
              </v-tabs>

              <v-tabs-items v-model="recipes.selection" v-if="show">
                <!-- Lejos -->
                <v-tab-item key="far" value="far">
                  <v-simple-table>
                    <template v-slot:default>
                      <thead>
                        <tr>
                          <th></th>
                          <th class="text-left">ESF</th>
                          <th class="text-left">CYL</th>
                          <th class="text-left">EJE</th>
                          <th class="text-left">DNP</th>
                          <th class="text-left">ALT</th>
                          <th class="text-left">PRISMAS</th>
                          <!--<th class="text-left">A.V.C.V.</th>-->
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <strong> O.D </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.od.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.od.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.od.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.far.od.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.od.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.od.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <strong> O.I </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.oi.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.oi.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.oi.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.far.oi.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.oi.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.far.oi.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>
                      </tbody>
                    </template>
                  </v-simple-table>
                </v-tab-item>

                <!-- Cerca -->
                <v-tab-item key="near" value="near">
                  <v-simple-table>
                    <template v-slot:default>
                      <thead>
                        <tr>
                          <th></th>
                          <th class="text-left">ESF</th>
                          <th class="text-left">CYL</th>
                          <th class="text-left">EJE</th>
                          <th class="text-left">DNP</th>
                          <th class="text-left">ALT</th>
                          <th class="text-left">PRISMAS</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <strong> O.D </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.od.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.od.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.od.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.near.od.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.od.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.od.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <strong> O.I </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.oi.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.oi.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.oi.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.near.oi.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.oi.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.near.oi.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>
                      </tbody>
                    </template>
                  </v-simple-table>
                </v-tab-item>

                <!-- Intermedio -->
                <v-tab-item key="intermediate" value="intermediate">
                  <v-simple-table>
                    <template v-slot:default>
                      <thead>
                        <tr>
                          <th></th>
                          <th class="text-left">ESF</th>
                          <th class="text-left">CYL</th>
                          <th class="text-left">EJE</th>
                          <th class="text-left">DNP</th>
                          <th class="text-left">ALT</th>
                          <th class="text-left">PRISMAS</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <strong> O.D </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.od.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.od.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.od.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.intermediate.od.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.od.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.od.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <strong> O.I </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.oi.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.oi.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.oi.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.intermediate.oi.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.oi.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.intermediate.oi.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>
                      </tbody>
                    </template>
                  </v-simple-table>
                </v-tab-item>

                <!-- Multifocal -->
                <v-tab-item key="multifocal" value="multifocal">
                  <v-simple-table>
                    <template v-slot:default>
                      <thead>
                        <tr>
                          <th></th>
                          <th class="text-left">ESF</th>
                          <th class="text-left">CYL</th>
                          <th class="text-left">EJE</th>
                          <th class="text-left">ADD</th>
                          <th class="text-left">DNP</th>
                          <th class="text-left">ALT</th>
                          <th class="text-left">PRISMAS</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <strong> O.D </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.od.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.od.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.od.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.od.add"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.multifocal.od.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.od.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.od.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>

                        <tr>
                          <td>
                            <strong> O.I </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.oi.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.oi.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.oi.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.oi.add"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.multifocal.oi.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.oi.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.oi.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>

                        <tr>
                          <td>
                            <strong> A. PANORÁMICO </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.panoramic_angle"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>

                        <tr>
                          <td>
                            <strong> A. PANTOSCÓPICO </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.pantoscopic_angle"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>

                        <tr>
                          <td>
                            <strong> DISTANCIA VERTICE </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.multifocal.vertex_distance"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>
                      </tbody>
                    </template>
                  </v-simple-table>
                </v-tab-item>

                <!-- Bifocal -->
                <v-tab-item key="bifocal" value="bifocal">
                  <v-simple-table>
                    <template v-slot:default>
                      <thead>
                        <tr>
                          <th></th>
                          <th class="text-left">ESF</th>
                          <th class="text-left">CYL</th>
                          <th class="text-left">EJE</th>
                          <th class="text-left">ADD</th>
                          <th class="text-left">DNP</th>
                          <th class="text-left">ALT</th>
                          <th class="text-left">PRISMAS</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <strong> O.D </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.od.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.od.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.od.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.od.add"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.bifocal.od.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.od.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.od.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>

                        <tr>
                          <td>
                            <strong> O.I </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.oi.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.oi.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.oi.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.oi.add"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.bifocal.oi.dnp"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.oi.alt"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td>
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.oi.prismas"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>

                        <tr>
                          <td>
                            <strong> A. PANORÁMICO </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.panoramic_angle"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <!--<td></td>-->
                        </tr>

                        <tr>
                          <td>
                            <strong> A. PANTOSCÓPICO </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.pantoscopic_angle"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <!--<td></td>-->
                        </tr>

                        <tr>
                          <td>
                            <strong> DISTANCIA VERTICE </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="true"
                              v-model="recipes.bifocal.vertex_distance"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>

                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <!--<td></td>-->
                        </tr>
                      </tbody>
                    </template>
                  </v-simple-table>
                </v-tab-item>

                <!-- Lente de contacto -->
                <v-tab-item key="contact" value="contact">
                  <v-simple-table>
                    <template v-slot:default>
                      <thead>
                        <tr>
                          <th></th>
                          <th class="text-left">ESF</th>
                          <th class="text-left">CYL</th>
                          <th class="text-left">EJE</th>
                          <th class="text-left">K1</th>
                          <th class="text-left">K2</th>
                          <th class="text-left">CB</th>
                          <th class="text-left">DIAMETRO</th>
                          <th class="text-left">DHIV</th>
                          <th class="text-left">SAG</th>
                        </tr>
                      </thead>
                      <tbody>
                        <!-- OD -->
                        <tr>
                          <td>
                            <strong> O.D </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.k1"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.k2"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.cb"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.diametro"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.dhiv"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.sag"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>

                        <!-- OI -->
                        <tr>
                          <td>
                            <strong> O.I </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.k1"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.k2"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.cb"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.diametro"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.dhiv"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.sag"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>

                        <tr>
                          <td>
                            <strong> Material </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.material"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>

                        <tr>
                          <td>
                            <strong> Color </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.color"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>

                        <tr>
                          <td>
                            <strong> Geometría </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.geometry"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>

                        <tr>
                          <td>
                            <strong> Reemplazo </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.replacement"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>
                      </tbody>
                    </template>
                  </v-simple-table>
                </v-tab-item>
              </v-tabs-items>
            </v-col>
          </v-row>
        </v-card-text>
      </v-card>
      <!-- </v-tab-item> -->

      <!-- <v-tab-item key="contact" value="contact">
          <v-card flat>
            <v-card-text>
              <div class="d-flex justify-space-between align-center">
                <h2 class="mb-1">Receta Lentes de Contacto</h2>
              </div>
              <v-row no-gutters>
                <v-col cols="12">
                  <v-simple-table>
                    <template v-slot:default>
                      <thead>
                        <tr>
                          <th></th>
                          <th class="text-left">ESF</th>
                          <th class="text-left">CYL</th>
                          <th class="text-left">EJE</th>
                          <th class="text-left">K1</th>
                          <th class="text-left">K2</th>
                          <th class="text-left">CB</th>
                          <th class="text-left">DIAMETRO</th>
                          <th class="text-left">DHIV</th>
                          <th class="text-left">SAG</th>
                        </tr>
                      </thead>
                      <tbody>
                         OD 
                        <tr>
                          <td>
                            <strong> O.D </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.k1"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.k2"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.cb"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.diametro"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.dhiv"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.od.sag"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>

                         OI 
                        <tr>
                          <td>
                            <strong> O.I </strong>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.esf"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.cyl"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.eje"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.k1"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.k2"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.cb"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.diametro"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.dhiv"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td>
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.oi.sag"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                        </tr>

                        <tr>
                          <td>
                            <strong> Material </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.material"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>

                        <tr>
                          <td>
                            <strong> Color </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.color"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>

                        <tr>
                          <td>
                            <strong> Geometría </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.geometry"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>

                        <tr>
                          <td>
                            <strong> Reemplazo </strong>
                          </td>
                          <td colspan="2">
                            <v-text-field
                              :disabled="noeditable"
                              v-model="recipes.contact.replacement"
                              outlined
                              hide-details
                              dense
                            ></v-text-field>
                          </td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>
                      </tbody>
                    </template>
                  </v-simple-table>
                </v-col>
              </v-row>
            </v-card-text>
          </v-card>
        </v-tab-item> -->
      <!-- </v-tabs-items> -->
    </v-card>
  </div>
</template>
<script>
import { RecipeService } from "../../services/RecipeService";

export default {
  name: "MeasuresComponent",
  props: {
    recipes: {
      type: Object,
      default: () => {},
    },
    noeditable: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      contact: false,
      show: false,
    };
  },
  methods: {
    recalculateData() {
      // if (this.recipes.recipe_selection !== "recipe") return;
      switch (this.recipes.selection) {
        case "near":
          RecipeService.calculateNear(this.recipes);
          break;
        case "far":
          RecipeService.calculateFar(this.recipes);
          break;
        case "intermediate":
          RecipeService.calculateIntermediate(this.recipes);
          break;
        case "bifocal":
          RecipeService.calculateBifocal(this.recipes);
          break;
        case "multifocal":
          RecipeService.calculateMultifocal(this.recipes);
          break;
        case "contact":
          //RecipeService.calculateMultifocal(this.recipes);
          break;
        default:
          break;
      }
    },
  },
};
</script>
