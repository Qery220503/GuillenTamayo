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
            Crear Guía de remisión
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
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="sucursales"
                :rules="[rules2.required]"
                v-model="guias_remision.id_sucursal"
                label="Sucursales"
                item-text="nombre_sucursal"
                item-value="id_sucursal"
                filled
                @input="getSeries"
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="series"
                :rules="[rules2.required]"
                v-model="guias_remision.id_serie"
                label="Serie"
                item-text="serie"
                item-value="id_serie"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-menu
                v-model="menu"
                :close-on-content-click="true"
                :nudge-right="40"
                transition="scale-transition"
                offset-y
                min-width="auto"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    :rules="[rules2.required]"
                    v-model="guias_remision.fecha_emision"
                    label="Fecha de emisión"
                    filled
                    readonly
                    
                    v-bind="attrs"
                    v-on="on"
                  ></v-text-field>
                </template>
                <v-date-picker
                  v-model="guias_remision.fecha_emision"
                  no-title
                  @input="menu = false"
                ></v-date-picker>
              </v-menu>
            </v-col>

            <v-col class="py-1 px-1" cols="12" md="4">
              <v-autocomplete
                v-model="getCliente"
                :items="clientes"
                hide-no-data
                hide-selected
                :item-text="formatItemText"
                item-value="API"
                label="Buscar Cliente"
                placeholder="Buscar Cliente"
                return-object
                filled
                clearable
              ><template v-slot:append>
                <v-tooltip bottom>
                  <template v-slot:activator="{ on }">
                    <v-btn
                      color="primary"
                      class="mb-1 mx-1"
                      dark
                      v-on="on"
                      small
                      @click.stop="addDialogClient = true"
                    >
                    <v-icon>mdi-plus</v-icon>
                    </v-btn>
                  </template>
                  <span>Tooltip</span>
                </v-tooltip>
              </template></v-autocomplete>
              
            </v-col>

            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="modo_traslado"
                :rules="[rules2.required]"
                v-model="guias_remision.modo_traslado"
                label="Modo de Traslado"
                item-text="modo"
                item-value="modo_traslado"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :rules="[rules2.required]"
                v-model="guias_remision.id_motivo_traslado"
                label="Motivo de Traslado"
                item-text="motivo"
                item-value="motivo_traslado"
                filled
              ></v-select>
            </v-col>

            <v-col class="py-1 px-1" cols="12" md="4">
              <v-menu
                v-model="menu2"
                :close-on-content-click="true"
                :nudge-right="40"
                transition="scale-transition"
                offset-y
                min-width="auto"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    :rules="[rules2.required]"
                    v-model="guias_remision.fecha_traslado"
                    label="Fecha traslado"
                    filled
                    readonly
                    
                    v-bind="attrs"
                    v-on="on"
                  ></v-text-field>
                </template>
                <v-date-picker
                  v-model="guias_remision.fecha_traslado"
                  no-title
                  @input="menu2 = false"
                ></v-date-picker>
              </v-menu>
            </v-col>

            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="unidades_de_medida"
                :rules="[rules2.required]"
                v-model="guias_remision.id_unidad_medida"
                label="Unidad de medida"
                item-text="nombre_unidad_medida"
                item-value="id_unidad_medida"
                filled
              ></v-select>
            </v-col>

            <v-col class="py-1 px-1" cols="12" md="4">
              <v-textarea
                v-model="guias_remision.descripcion_motivo_traslado"
                label="Descripción del motivo de Traslado"
                rows="1"
                row-height="5"
                filled
              ></v-textarea>
            </v-col>

            <v-col class="py-1 px-1" cols="12" md="4">
              <v-text-field
                v-model="guias_remision.peso_total"
                :rules="rules"
                :min="1"
                :max="100"
                persistent-hint
                label="Peso total"
                type="number"
                filled
              />
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-text-field
                v-model="guias_remision.cantidad"
                :rules="[rules2.required]"
                :min="1"
                :max="50"
                persistent-hint
                label="Número de paquetes"
                type="number"
                filled
              />
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-textarea
                v-model="guias_remision.observaciones"
                label="Observaciones"
                rows="1"
                row-height="5"
                filled
              ></v-textarea>
            </v-col>
          </v-row>
          <v-divider></v-divider>
          <div class="mt-4 text-subtitle-1">Datos envío</div>
          <br />
          <v-row>
            <v-col class="py-1" cols="12" md="12">
              <div class="mt-0 text-subtitle-2 ">Punto partida</div>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="items_departamento"
                label="Departamento"
                placeholder="Selecciona un departamento"
                v-model="guias_remision.id_departamento_partida"
                required
                item-text="nombre_departamento"
                item-value="id_departamento"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="items_provincia"
                label="Provincia"
                placeholder="Selecciona una provincia"
                v-model="guias_remision.id_provincia_partida"
                item-text="nombre_provincia"
                item-value="id_provincia"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="6" md="4">
              <v-select
                :items="items_distrito"
                label="Distrito"
                placeholder="Selecciona un distrito"
                v-model="guias_remision.id_distrito_partida"
                item-text="nombre_distrito"
                item-value="id_distrito"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="12">
              <v-text-field
                v-model="guias_remision.direccion_partida"
                :rules="[rules2.required]"
                label="Dirección"
                filled
              ></v-text-field>
            </v-col>
            <v-col class="py-1" cols="12" md="12">
              <div class="mt-0 text-subtitle-2 ">Punto llegada</div>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="items_departamento"
                label="Departamento"
                placeholder="Selecciona un departamento"
                v-model="guias_remision.id_departamento_llegada"
                required
                item-text="nombre_departamento"
                item-value="id_departamento"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="items_provincia"
                label="Provincia"
                placeholder="Selecciona una provincia"
                v-model="guias_remision.id_provincia_llegada"
                item-text="nombre_provincia"
                item-value="id_provincia"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="6" md="4">
              <v-select
                :items="items_distrito"
                label="Distrito"
                placeholder="Selecciona un distrito"
                v-model="guias_remision.id_distrito_llegada"
                item-text="nombre_distrito"
                item-value="id_distrito"
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="12">
              <v-text-field
                v-model="guias_remision.direccion_llegada"
                :rules="[rules2.required]"
                label="Dirección"
                filled
              ></v-text-field>
            </v-col>
          </v-row>
          <v-divider></v-divider>
          <div class="mt-4 text-subtitle-1">Datos modo de traslado</div>
          <br />
          <v-row v-if="guias_remision.modo_traslado == 1">
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="items_tipo_doc"
                label="Tipo Documento"
                v-model="guias_remision.cod_tipo_doc_transp_publico"
                item-text="nombre_tipo_documento"
                item-value="id_tipo_documento"
                :rules="[rules2.required]"
                required
                filled
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-text-field
                v-model="guias_remision.nro_documento_transp_publico"
                label="Nro. Documento"
                item-value="nro_documento_transp_publico"
                :rules="[rules2.required]"
                autocomplete="off"
                filled
                >
                <template #append-outer>
                    <v-btn
                        color="primary"
                        class="mb-1"
                        @click="obtenerDataDocumentos()">
                        <v-icon>mdi-magnify</v-icon>
                    </v-btn>
                </template>
              </v-text-field>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-text-field
                v-model="guias_remision.mtc_transp_publico"
                label="MTC"
                :rules="[rules2.required]"
                filled
                
                autocomplete="off"
              ></v-text-field>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="6">
              <v-text-field
                v-model="guias_remision.nombre_razon_social_transp_publico"
                label="Nombre"
                :rules="[rules2.required]"
                filled
                
                autocomplete="off"
              ></v-text-field>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="6">
              <v-text-field
                v-model="guias_remision.direccion_transp_publico"
                label="Dirección fiscal"
                :rules="[rules2.required]"
                filled
                
                autocomplete="off"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-row v-else>
            <v-col class="py-1" cols="12" md="12">
              <div class="mt-0 text-subtitle-3 ">Datos del Conductor</div>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-select
                :items="items_tipo_doc"
                label="Tipo Documento"
                v-model="guias_remision.cod_tipo_doc_transp_privado"
                item-text="nombre_tipo_documento"
                item-value="id_tipo_documento"
                :rules="[rules2.required]"
                required
                filled
                
              ></v-select>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-text-field
                v-model="guias_remision.nro_documento_transp_privado"
                label="Nro. Documento"
                item-value="nro_documento_transp_privado"
                :rules="[rules2.required]"
                autocomplete="off"
                filled
                >
                    <template #append-outer>
                        <v-btn
                            color="primary"
                            class="mb-1"
                            @click="obtenerDataDocumentos2()">
                            <v-icon>mdi-magnify</v-icon>
                        </v-btn>
                    </template>
              </v-text-field>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="4">
              <v-text-field
                v-model="guias_remision.mtc_transp_privado"
                label="MTC"
                :rules="[rules2.required]"
                filled
                
                autocomplete="off"
              ></v-text-field>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="6">
              <v-text-field
                v-model="guias_remision.nombre_razon_social_transp_privado"
                label="Nombre"
                :rules="[rules2.required]"
                filled
                
                autocomplete="off"
              ></v-text-field>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="6">
              <v-text-field
                v-model="guias_remision.direccion_transp_privado"
                label="Dirección fiscal"
                :rules="[rules2.required]"
                filled
                
                autocomplete="off"
              ></v-text-field>
            </v-col>
            <v-col class="py-1" cols="12" md="12">
              <div class="mt-0 text-subtitle-3 ">Datos del Vehículo</div>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="6">
              <v-text-field
                v-model="guias_remision.nro_placa_transp_privado"
                label="Nro. de Placa"
                :rules="[rules2.required]"
                filled
                
                autocomplete="off"
              ></v-text-field>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="6">
              <v-text-field
                v-model="guias_remision.modelo_transp_privado"
                label="Modelo"
                :rules="[rules2.required]"
                filled
                
                autocomplete="off"
              ></v-text-field>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="6">
              <v-text-field
                v-model="guias_remision.marca_transp_privado"
                label="Marca"
                :rules="[rules2.required]"
                filled
                
                autocomplete="off"
              ></v-text-field>
            </v-col>
            <v-col class="py-1 px-1" cols="12" md="3">
              <v-text-field
                v-model="guias_remision.placa_semir_transp_privado"
                label="N° placa semirremolque"
                type="text"
                filled
                
              />
            </v-col>
          </v-row>
          <v-divider></v-divider>
          <br />
          <v-row>
            <v-col>
              <v-simple-table fixed-header height="300px">
                <template v-slot:default>
                  <thead>
                    <tr>
                      <th>
                        #
                      </th>
                      <th class="text-left">
                        Unidad
                      </th>
                      <th class="text-left">
                        Descripción
                      </th>
                      <th class="text-left">
                        Cantidad
                      </th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="d in productos" :key="d">
                      <td>{{ d.id_producto }}</td>
                      <td>{{ d.unidad }}</td>
                      <td>{{ d.descripcion }}</td>
                      <td>{{ d.cantidad }}</td>
                      <td>
                        <v-btn small icon @click="console.log(d.id_producto)">
                          <v-icon small>mdi-close</v-icon>
                        </v-btn>
                      </td>
                    </tr>
                  </tbody>
                </template>
              </v-simple-table>
            </v-col>
          </v-row>
          <v-row class="d-flex justify-end">
            <v-col>
              <div class="d-flex justify-end">
                <v-btn color="primary">Generar</v-btn>
                <v-btn color="secondary" class="ml-2">Cancelar</v-btn>
              </div>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
    </v-card>

    <!-- Add Client Dialog Start -->
    <v-dialog v-model="addDialogClient" max-width="60%" persistent>
      <v-card>
        <v-card-title>
          <span class="headline">{{ dialogTitles.addFormClientTitle }}</span>
        </v-card-title>
        <v-card-text>
          <v-form
            ref="addClientForm"
            v-model="validClientAddForm"
            @submit.prevent="saveClientReg()"
            lazy-validation
          >
            <v-row class="mt-2">
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-select
                  :items="items_tipo_doc"
                  label="Tipo Documento"
                  v-model="addClientForm.cod_tipo_doc"
                  item-text="nombre_tipo_documento"
                  item-value="id_tipo_documento"
                  :rules="[rules2.required]"
                  required
                  filled
                  
                ></v-select>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field
                  v-model="addClientForm.nro_documento"
                  label="Nro. Documento"
                  :rules="[rules2.required]"
                  autocomplete="off"
                  filled
                  >
                    <template #append-outer>
                        <v-btn
                            color="primary"
                            class="mb-1"
                            @click="obtenerDataDocumentos()">
                            <v-icon>mdi-magnify</v-icon>
                        </v-btn>
                    </template>
                </v-text-field>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field
                  v-model="addClientForm.nombre_razon_social"
                  label="Nombre"
                  :rules="[rules2.required]"
                  filled
                  
                  autocomplete="off"
                ></v-text-field>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-menu
                  v-model="menu3"
                  :close-on-content-click="false"
                  transition="scale-transition"
                  offset-y
                  min-width="auto"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                      v-model="addClientForm.fecha_nacimiento"
                      label="Fecha Nacimiento"
                      prepend-inner-icon="mdi-calendar"
                      v-bind="attrs"
                      v-on="on"
                      :rules="[rules2.required]"
                      
                      filled
                    ></v-text-field>
                  </template>
                  <v-date-picker
                    v-model="addClientForm.fecha_nacimiento"
                    @input="menu3 = false"
                    no-title
                  ></v-date-picker>
                </v-menu>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field
                  v-model="addClientForm.telefono"
                  label="Teléfono Principal"
                  autocomplete="off"
                  filled
                  
                ></v-text-field>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field
                  v-model="addClientForm.telefono_adic"
                  label="Teléfono Adicional"
                  autocomplete="off"
                  filled
                  
                ></v-text-field>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-text-field
                  v-model="addClientForm.email"
                  label="Correo Electrónico"
                  :rules="[rules2.email, rules2.required]"
                  autocomplete="off"
                  type="email"
                  filled
                  
                ></v-text-field>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-select
                  :items="items_ocupacion"
                  label="Ocupación/Trabajo"
                  placeholder="Selecciona una ocupación"
                  v-model="addClientForm.id_ocupacion"
                  item-text="nombre_ocupacion"
                  item-value="id_ocupacion"
                  filled
                  
                ></v-select>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-select
                  :items="items_departamento"
                  label="Departamento"
                  placeholder="Selecciona un departamento"
                  v-model="addClientForm.id_departamento"
                  required
                  item-text="nombre_departamento"
                  item-value="id_departamento"
                  filled
                  
                ></v-select>
              </v-col>
              <v-col class="py-1 px-1" cols="12" md="4">
                <v-select
                  :items="items_provincia"
                  label="Provincia"
                  placeholder="Selecciona una provincia"
                  v-model="addClientForm.id_provincia"
                  item-text="nombre_provincia"
                  item-value="id_provincia"
                  filled
                  
                ></v-select>
              </v-col>
              <v-col class="py-1 px-1" cols="6" md="4">
                <v-select
                  :items="items_distrito"
                  label="Distrito"
                  placeholder="Selecciona un distrito"
                  v-model="addClientForm.id_distrito"
                  item-text="nombre_distrito"
                  item-value="id_distrito"
                  filled
                  
                ></v-select>
              </v-col>
              <v-col class="py-1 px-1" cols="12">
                <v-text-field
                  v-model="addClientForm.direccion"
                  label="Dirección"
                  :rules="[rules2.required]"
                  autocomplete="off"
                  filled
                  
                ></v-text-field>
              </v-col>
              <v-col class="py-1 px-1" cols="12">
                <v-radio-group v-model="addClientForm.lista_negra" row>
                    <template v-slot:label>
                        <div>¿Paciente en Lista Negra?</div>
                    </template>
                    <v-radio label="Si" :value="1"></v-radio>
                    <v-radio label="No" :value="0"></v-radio>
                </v-radio-group>
              </v-col>
            </v-row>
            <br />
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="error" text @click="addDialogClient = false"
                >Cancelar</v-btn
              >
              <v-btn
                type="submit"
                color="primary"
                :disabled="!validClientAddForm"
              >
                Guardar
              </v-btn>
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </v-dialog>
    <!-- Add Client Dialog End -->
  </div>
</template>

<script>
import axios from "axios";
import API from "../../../api";

export default {
  data() {
    return {
      breadcrumbs_title: "Guías de remisión",
      breadcrumbs: [
        { text: "Inicio", disabled: false, href: "#" },
        { text: "Procesos", disabled: false, href: "#" },
        { text: "Guías de remisión" }
      ],
      validAddForm: false,
      guias_remision: {
        id_sucursal: null,
        id_serie: null,
        fecha_emision: new Date(
          Date.now() - new Date().getTimezoneOffset() * 60000
        )
          .toISOString()
          .substr(0, 10),
        fecha_traslado: new Date(
          Date.now() - new Date().getTimezoneOffset() * 60000
        )
          .toISOString()
          .substr(0, 10),
        id_cliente: null,
        modo_traslado: 1,
        id_motivo_traslado: null,
        descripcion_motivo_traslado: null,
        id_unidad_medida: null,
        peso_total: null,
        cantidad: null,
        observaciones: null,

        id_departamento_partida: null,
        id_provincia_partida: null,
        id_distrito_partida: null,
        direccion_partida: null,

        id_departamento_llegada: null,
        id_provincia_llegada: null,
        id_distrito_llegada: null,
        direccion_llegada: null,

        dni_conductor: null,
        nombre_conductor: null,
        licencia_conductor: null,
        telefono_conductor: null,
        placa_vehiculo: null,


      },
      sucursales: [],
      series: [],
      unidades_de_medida: [],
      clientes: [],

      entries_clientes: [],

      modo_traslado: [
        { modo_traslado: '1', modo: "Transporte público" },
        { modo_traslado: '0', modo: "Transporte privado" }
      ],

      motivo_traslado: [],

      rules: [
        v => !!v || "Requerido",
        v => v >= 1 || "El peso debe ser mayor a 1",
        v => v <= 100 || "El peso debe ser menor a 100"
      ],
      rules2: {
        required: UTILS.nRules.required,
        dni: UTILS.nRules.min8,
        ruc: UTILS.nRules.min811,
        only_numbers: UTILS.nRules.only_numbers,
        email: UTILS.nRules.email
      },

      vehiculos: [],
      productos: [],

      addClientForm: {
        cod_tipo_doc: 1,
        nombre_razon_social: null,
        direccion: null,
        id_departamento: null,
        id_provincia: null,
        id_distrito: null,
        lista_negra: 0
      },

      dialogTitles: {
        addFormClientTitle: "Agregar cliente",
      },

      validClientAddForm: false,
      addDialogClient: false,

      items_tipo_doc: [],

      getCliente: null,

      items_ocupacion: [],
      items_departamento: [],
      items_provincia: [],
      items_distrito: [],
      menu: false,
      menu2: false,
      menu3: false,

      datosBus: {
        tipoDoc: null,
        numDoc: null
      },
    };
  },

  // computed: {
  //   items_cliente() {
  //     const clients = this.entries_clientes.map(entry => {
  //       let Description = "";
  //       Description = "[" + entry.nro_documento + "] " + entry.nombre_razon_social;
  //       return Object.assign({}, entry, { Description });
  //     });
  //     console.log();
  //     return [...clients];
  //   } 
  // },

  created() {
    let vm = this;
    vm.getSucursal();
    vm.getSeries();
    vm.getUnidadMedida();
    vm.getTipoDoc();
    vm.getClientes();

    console.log("Created");
  },
  methods: {
    saveReg() {
      console.log("Saved");
    },

    saveClientReg() {
      console.log("Saved");
    },

    async getSucursal() {
      let vm = this;
      try {
        const response = await API.sucursales.combo();
        vm.sucursales = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getTipoDoc() {
      let vm = this;
      try {
          const response = await API.tipos_documentos.combo();
          vm.items_tipo_doc = response.data;
          
      } catch (e) {
          UTILS.toastr.error("Ups! Ocurrió un error", this);
          console.error(e);
      }
    },
    async getSeries() {
      let vm = this;
      try {
        const response = await API.series.search('5',vm.guias_remision.id_sucursal);
        vm.series = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

    async getClientes() {
      let vm = this;
      try {
        const response = await API.guia_remision.clientes();
        vm.clientes = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

    async getMotivoTraslado() {

    },

    async getUnidadMedida() {
      let vm = this;
      try {
        const response = await API.unidad_medida.list();
        vm.unidades_de_medida = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

    async getDepartamento() {

    },

    async getDistrito() {

    },

    async getProvincia() {

    },

    async obtenerDataDocumentos() {
      try {
        this.$store.commit("loader", true);
        this.datosBus.tipoDoc = this.guias_remision.cod_tipo_doc_transp_publico;
        this.datosBus.numDoc = this.guias_remision.nro_documento_transp_publico;
        const rpta = await API.apis.dniruc(this.datosBus);
        if (rpta.data.success === true) {
          if (this.datosBus.tipoDoc === 2) {
            this.guias_remision.nombre_razon_social_transp_publico = rpta.data.nombre_o_razon_social;
            this.guias_remision.direccion_transp_publico = rpta.data.direccion_completa;
            this.$store.commit("loader", false);
          } else if (this.datosBus.tipoDoc === 1) {
            this.guias_remision.nombre_razon_social_transp_publico =
              rpta.data.result.Apellidos + " " + rpta.data.result.Nombres;
            this.guias_remision.direccion_transp_publico = rpta.data.result.direccion_completa
            this.$store.commit("loader", false);
          }
        } else {
          this.$store.commit("loader", false);
        }
        this.$store.commit("loader", false);
      } catch (error) {
        this.$store.commit("loader", false);
      }
    },

    async obtenerDataDocumentos2() {
      try {
        this.$store.commit("loader", true);
        this.datosBus.tipoDoc = this.guias_remision.cod_tipo_doc_transp_privado;
        this.datosBus.numDoc = this.guias_remision.nro_documento_transp_privado;
        const rpta = await API.apis.dniruc(this.datosBus);
        if (rpta.data.success === true) {
          if (this.datosBus.tipoDoc === 2) {
            this.guias_remision.nombre_razon_social_transp_privado = rpta.data.nombre_o_razon_social;
            this.guias_remision.direccion_transp_privado = rpta.data.direccion_completa;

            if(rpta.data.estado == "ACTIVO" && rpta.data.condicion == "HABIDO"){
              UTILS.toastr.success("El documento ingresado se encuentra ACTIVO y HABIDO", this);
            }else{
              UTILS.toastr.info("Cuidado, el documento ingresado se encuentra " + rpta.data.estado + " y " + rpta.data.condicion, this);
            }
            this.$store.commit("loader", false);
          } else if (this.datosBus.tipoDoc === 1) {
            this.guias_remision.nombre_razon_social_transp_privado =
              rpta.data.result.Apellidos + " " + rpta.data.result.Nombres;
            this.guias_remision.direccion_transp_privado = rpta.data.result.direccion_completa
            this.$store.commit("loader", false);
          }
        } else {
          this.$store.commit("loader", false);
        }
        this.$store.commit("loader", false);
      } catch (error) {
        this.$store.commit("loader", false);
      }
    },
    
    formatItemText(item) {
      return `[${item.nro_documento}] ${item.nombre_razon_social}`;
    },
  },
  watch: {
    getCliente(val) {
      if (val === null) return;
      this.guias_remision.id_cliente = val.id_cliente ;
    },
  }
};
</script>
