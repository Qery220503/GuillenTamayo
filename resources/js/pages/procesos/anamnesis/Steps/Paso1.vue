<template>
  

  <div class="overflow-y-auto pa-3" style="overflow-x: hidden !important">
    <!--Paciente-->
    <v-row>
      <v-col class="py-2 px-1" cols="12" md="3">
        <v-select
          :items="items_tipo_doc"
          label="Tipo Documento"
          placeholder="Selecciona un tipo documento"
          v-model="$form.cliente.cod_tipo_doc"
          :rules="[rules.required]"
          required
          item-text="nombre_tipo_documento"
          item-value="id_tipo_documento"
          filled
          dense
        ></v-select>
      </v-col>
      <v-col class="py-2 px-1" cols="12" md="3">
        <v-text-field
          v-model="$form.cliente.nro_documento"
          label="Nro. Documento"
          :rules="[rules.required, rules.dni]"
          v-if="$form.cliente.cod_tipo_doc == 1"
          filled
          dense
          autocomplete="off"
          maxlength="8"
        >
          <template #append>
            <v-btn
              small
              icon
              color="primary"
              class="mb-1"
              @click="obtenerDataDocumentos()"
            >
              <v-icon>mdi-magnify</v-icon>
            </v-btn>
          </template>
          <!-- <template #append-outer>
            <v-btn
              color="primary"
              class="mb-1"
              @click="obtenerDataDocumentos()"
            >
              <v-icon>mdi-magnify</v-icon>
            </v-btn>
          </template> -->
        </v-text-field>
        <v-text-field
          v-model="$form.cliente.nro_documento"
          label="Nro. Documento"
          :rules="[rules.required, rules.ruc]"
          v-if="$form.cliente.cod_tipo_doc == 2"
          filled
          dense
          autocomplete="off"
          maxlength="11"
        >
          <template #append>
            <v-btn
              small
              icon
              color="primary"
              class="mb-1"
              @click="obtenerDataDocumentos()"
            >
              <v-icon>mdi-magnify</v-icon>
            </v-btn>
          </template>
        </v-text-field>
        <v-text-field
          v-model="$form.cliente.nro_documento"
          label="Nro. Documento"
          :rules="[rules.required]"
          v-if="
            $form.cliente.cod_tipo_doc != 1 && $form.cliente.cod_tipo_doc != 2
          "
          filled
          dense
          autocomplete="off"
        >
          <template #append>
            <v-btn
              small
              icon
              color="primary"
              class="mb-1"
              @click="obtenerDataDocumentos()"
            >
              <v-icon>mdi-magnify</v-icon>
            </v-btn>
          </template>
        </v-text-field>
      </v-col>
      <v-col class="py-2 px-1" cols="12" md="3">
        <v-text-field
          v-model="$form.cliente.nombre_razon_social"
          label="Nombre"
          :rules="[rules.required]"
          autocomplete="off"
          filled
          dense
        ></v-text-field>
      </v-col>
      <v-col class="py-2 px-1" cols="12" md="3">
        <v-menu
          v-model="menu2"
          :close-on-content-click="false"
          transition="scale-transition"
          offset-y
          min-width="auto"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="dateFormatted"
              label="Fecha Nacimiento"
              prepend-inner-icon="mdi-calendar"
              v-bind="attrs"
              v-on="on"
              :rules="[rules.required]"
              dense
              filled
              @blur="$form.cliente.fecha_nacimiento = parseDate(dateFormatted)"
            ></v-text-field>
          </template>
          <v-date-picker
            v-model="$form.cliente.fecha_nacimiento"
            @input="menu2 = false"
            no-title
            :max="today"
            @change="updateFormat"
          ></v-date-picker>
        </v-menu>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="3">
        <v-text-field
          v-model="$form.cliente.telefono"
          label="Teléfono Principal"
          maxlength="9"
          :rules="[rules.required, rules.only_numbers]"
          filled
          dense
          autocomplete="off"
        ></v-text-field>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="3">
        <v-text-field
          v-model="$form.cliente.telefono_adic"
          label="Teléfono Adicional"
          maxlength="9"
          :rules="[rules.only_numbers]"
          filled
          dense
          autocomplete="off"
        ></v-text-field>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="3">
        <v-text-field
          v-model="$form.cliente.email"
          label="Correo Electrónico"
          :rules="[rules.email, rules.required]"
          filled
          dense
          autocomplete="off"
          type="email"
        ></v-text-field>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="3">
        <v-select
          :items="items_ocupacion"
          label="Ocupación/Trabajo"
          placeholder="Selecciona una ocupación"
          v-model="$form.cliente.id_ocupacion"
          :rules="[rules.required]"
          filled
          dense
          item-text="nombre_ocupacion"
          item-value="id_ocupacion"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="3">
        <v-select
          :items="items_departamento"
          label="Departamento"
          placeholder="Selecciona un departamento"
          v-model="$form.cliente.id_departamento"
          :rules="[rules.required]"
          filled
          dense
          item-text="nombre_departamento"
          item-value="id_departamento"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="3">
        <v-select
          :items="items_provincia"
          label="Provincia"
          placeholder="Selecciona una provincia"
          v-model="$form.cliente.id_provincia"
          :rules="[rules.required]"
          filled
          dense
          item-text="nombre_provincia"
          item-value="id_provincia"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="6" md="3">
        <v-select
          :items="items_distrito"
          label="Distrito"
          placeholder="Selecciona un distrito"
          v-model="$form.cliente.id_distrito"
          :rules="[rules.required]"
          filled
          dense
          item-text="nombre_distrito"
          item-value="id_distrito"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="3">
        <v-text-field
          v-model="$form.cliente.direccion"
          label="Dirección"
          :rules="[rules.required]"
          filled
          dense
          autocomplete="off"
        ></v-text-field>
      </v-col>
    </v-row>

    <v-divider class="my-5"></v-divider>

    <!--Antecedentes-->
    <v-row>
      <v-col class="py-1 px-1" cols="12" md="12">
        <!--<v-textarea
        v-model="$form.anamnesis.antecedentes_familiares"
        label="Antecedentes Familiares"
        rows="3"
        filled
        dense
        autocomplte="off"
        ></v-textarea>-->

        <v-combobox
          v-model="$form.anamnesis.antecedentes_familia"
          :items="antecedes_familiares"
          label="Antecedentes Familiares"
          filled
          multiple
          chips
        ></v-combobox>
      </v-col>
    </v-row>

    <v-divider class="my-5"></v-divider>
    <!--Antecedentes-->
    <div>
      <v-row>
        <v-col
          cols="12"
          sm="4"
          md="4"
          class="py-1 px-1"
          v-for="(enfermedad, index) in items_enfermedades"
          :key="'enfermedad' + index"
        >
          <v-card outlined class="pa-1" color="#0000000f">
            <v-checkbox
              v-model="$form.anamnesis.enfermedades"
              :label="enfermedad"
              color="success"
              :value="enfermedad"
              class="mt-0"
              hide-details
            ></v-checkbox>
            <v-text-field
              v-if="
                form.anamnesis.enfermedades.includes('Otros:') &&
                index + 1 == items_enfermedades.length
              "
              v-model="$form.email"
              autocomplete="off"
              hide-details
            ></v-text-field>
          </v-card>
        </v-col>
      </v-row>
    </div>

    <v-divider class="my-5"></v-divider>

    <!--Antecedentes-->
    <v-row>
      <v-col class="py-1 px-1" cols="12" md="6">
        <v-textarea
          v-model="$form.anamnesis.medicamentos"
          label="Medicamentos que actualmente utiliza:"
          rows="2"
          filled
          dense
          autocomplete="off"
        ></v-textarea>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="6">
        <v-textarea
          v-model="$form.anamnesis.frecuencia_visita"
          label="Frecuencia de visita al oculista:"
          rows="2"
          filled
          dense
          autocomplete="off"
        ></v-textarea>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          :items="items_clinicas"
          label="Clínica Referente"
          placeholder="Clínica Referente"
          v-model="$form.anamnesis.id_clinica"
          :rules="[rules.required]"
          filled
          dense
          item-text="nombre_clinica"
          item-value="id_clinica"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          :items="items_doctores"
          label="Doctor Referente"
          placeholder="Doctor Referente"
          v-model="$form.anamnesis.id_doctor"
          :rules="[rules.required]"
          filled
          dense
          item-text="nombres"
          item-value="id_doctor"
        ></v-select>
      </v-col>
      <v-col class="py-1 px-1" cols="12" md="4">
        <v-select
          :items="items_convenios"
          label="Empresa Convenio"
          placeholder="Empresa Convenio"
          v-model="$form.anamnesis.id_empresa_convenio"
          :rules="[rules.required]"
          filled
          dense
          item-text="nombre_empresa"
          item-value="id_empresa_convenio"
        ></v-select>
      </v-col>
    </v-row>

    <v-row>
      <v-col style="display: flex; justify-content: center; flex-direction: row; flex-wrap: wrap;">
        <v-btn color="info" @click="send(true)">
          <v-icon left> mdi-cash </v-icon>
          Cotizar
        </v-btn>
        <v-spacer></v-spacer>
        <div>
          <v-btn color="error" text to="/dashboard">Cancelar</v-btn>
          <v-btn color="primary" @click="send()"> Guardar </v-btn>
        </div>
      </v-col>
    </v-row>


    <v-dialog v-model="dialogMantenimiento" persistent max-width="350">
      <v-card color="primary" dark>
        <v-card-title class="text-h5 text-center">
          En Mantenimiento
        </v-card-title>
        <br />
        <v-card-subtitle class="text-subtitle-01">
          La lista de precios se encuentra en mantenimiento, porfavor actualice
          e intente en unos minutos
        </v-card-subtitle>
        <v-card-actions>
          <v-btn dark text link to="/dashboard"> Cerrar </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import API from "../../../../api";
export default {
  props: {
    form: {
      type: Object,
      default: () => {},
    },
    send: {
      type: Function,
    },
  },
  data: (vm) => ({
    rules: {
      required: UTILS.nRules.required,
      dni: UTILS.nRules.min8,
      ruc: UTILS.nRules.min811,
      only_numbers: UTILS.nRules.only_numbers,
      email: UTILS.nRules.email,
    },
    isEdit: false,
    items_tipo_doc: [],
    items_ocupacion: [],
    items_departamento: [],
    items_provincia: [],
    items_distrito: [],
    validAddForm: false,
    datosBus: {
      tipoDoc: null,
      numDoc: null,
    },
    dialogMantenimiento: false,
    items_enfermedades: [
      "Ojo Seco",
      "Estrabismo",
      "Fatiga Visual",
      "Dolor de Cabeza",
      "Diabetes",
      "Ojos Rojos",
      "Legañas",
      "Mareos",
      "Daltonismo",
      "Degeneración Macular",
      "Queratocono",
      "Otros:",
    ],
    items_clinicas: [],
    items_doctores: [],
    items_convenios: [],
    menu2: false,
    antecedes_familiares: [
      "Glaucoma",
      "Retinopatia diabetica",
      "Desprendimiento de retina",
      "Presión arterial",
      "Queratocono",
    ],
    today: new Date().toISOString().substr(0, 10),
    dateFormatted: vm.formatDate(
      new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
        .toISOString()
        .substr(0, 10)
    ),
  }),
  computed: {
    $form: {
      get() {
        return this.form;
      },
      set(value) {
        props.set(this, "$form", value);
      },
    },
  },
  created() {
    let vm = this;
    vm.mantenimiento();
    vm.getTipos();
    vm.getOcupacion();
    vm.getDepartamento();
    vm.getProvincia(4);
    vm.getDistrito(401);
    vm.getClinicas();
    vm.getDoctores();
    vm.getEmpresas();
  },
  watch: {
    "$form.cliente.id_departamento"(value) {
      this.getProvincia(value);
    },
    "$form.cliente.id_provincia"(value) {
      this.getDistrito(value);
    },
    "$form.cliente.nro_documento"(value) {
      if (value == null || value == undefined) return;
      //let isRuc = value.substr(0, 2);

      if (value.length == 8 && this.$form.cliente.cod_tipo_doc == 1) {
        this.buscarPaciente();
        return;
      }
      if (value.length == 11 && this.$form.cliente.cod_tipo_doc == 2) {
        this.buscarPaciente();
        return;
      }

      if (
        this.$form.cliente.cod_tipo_doc != 1 &&
        this.$form.cliente.cod_tipo_doc != 2 &&
        value.length >= 5
      ) {
        this.buscarPaciente();
        return;
      }
    },
  },
  methods: {
    updateFormat() {
      this.dateFormatted = this.formatDate(this.$form.cliente.fecha_nacimiento);
    },
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
    async buscarPaciente() {
      const vm = this;
      try {
        const response = await API.clientes.buscar(
          "?nro_nro_documento=" +
            vm.$form.cliente.nro_documento +
            "&cod_tipo_doc=" +
            vm.$form.cliente.cod_tipo_doc
        );
        if (!response.data.success) {
          vm.resetCliente();
          vm.$emit("formReset", true);
          vm.obtenerDataDocumentos();
        } else {
          //Verificamos si es clientes varios
          if (response.data.data.id_cliente == 1) {
            UTILS.toastr.info(
              "No se encontro ningun paciente asociado a ese documento",
              vm
            );
            return;
          }
          vm.$form.cliente = response.data.data;
          // console.log(vm.$form.cliente);
        }
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", vm);
        console.error(e);
      }
    },
    resetCliente() {
      const vm = this;
      //vm.$form.cliente.cod_tipo_doc = 1;
      vm.$form.cliente.nombre_razon_social = "";
      vm.$form.cliente.direccion = null;
      vm.$form.cliente.id_departamento = 4;
      vm.$form.cliente.id_provincia = 401;
      vm.$form.cliente.id_distrito = 40101;
      vm.$form.cliente.lista_negra = null;
      vm.$form.cliente.email = null;
      vm.$form.cliente.telefono = null;
      vm.$form.cliente.telefono_adic = null;
      vm.$form.cliente.fecha_nacimiento = null;
    },
    async saveReg() {
      if (this.nota.detalle.length == 0) {
        UTILS.toastr.info("Debe agregar al menos un item", this);
        return;
      }
      if (this.$refs.form.validate()) {
        try {
          this.$store.commit("loader", true);
          const response = await API.clientes.create(this.form);
          UTILS.toastr.success("Paciente creado correctamente", this);
          this.$router.push("/pacientes");
        } catch (e) {
          UTILS.toastr.error("Ups! Ocurrió un error", this);
          console.error(e);
        } finally {
          this.$store.commit("loader", false);
          this.loadingTable = false;
        }
      }
    },

    async getTipos() {
      let vm = this;
      try {
        const response = await API.tipos_documentos.combo();
        vm.items_tipo_doc = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getOcupacion() {
      let vm = this;
      try {
        const response = await API.clientes.ocupacion();
        vm.items_ocupacion = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

    async getDepartamento() {
      let vm = this;
      try {
        const response = await API.ubigeo.departamentos();
        vm.items_departamento = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getProvincia(id_departamento) {
      let vm = this;
      try {
        const response = await API.ubigeo.provincias(id_departamento);
        vm.items_provincia = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
    async getDistrito(id_provincia) {
      let vm = this;
      try {
        const response = await API.ubigeo.distritos(id_provincia);
        vm.items_distrito = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

    async getClinicas() {
      let vm = this;
      try {
        const response = await API.clinicas.combo();
        vm.items_clinicas = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

    async getDoctores() {
      let vm = this;
      try {
        const response = await API.doctores.combo();
        vm.items_doctores = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

    async getEmpresas() {
      let vm = this;
      try {
        const response = await API.empresas_convenio.combo();
        vm.items_convenios = response.data;
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },

    async obtenerDataDocumentos() {
      try {
        this.$store.commit("loader", true);
        this.datosBus.tipoDoc = this.$form.cliente.cod_tipo_doc;
        this.datosBus.numDoc = this.$form.cliente.nro_documento;
        const rpta = await API.apis.dniruc(this.datosBus);
        if (rpta.data.success === true) {
          UTILS.toastr.success(
            "Paciente encontrado en RENIEC, debe llenar los demás datos del paciente",
            this
          );
          if (this.datosBus.tipoDoc === 2) {
            this.$form.cliente.nombre_razon_social =
              rpta.data.nombre_o_razon_social;
            this.$form.cliente.direccion = rpta.data.direccion_completa;
            if (
              rpta.data.estado == "ACTIVO" &&
              rpta.data.condicion == "HABIDO"
            ) {
              UTILS.toastr.success(
                "El documento ingresado se encuentra ACTIVO y HABIDO",
                this
              );
            } else {
              UTILS.toastr.info(
                "Cuidado, el documento ingresado se encuentra " +
                  rpta.data.estado +
                  " y " +
                  rpta.data.condicion,
                this
              );
            }
            this.$store.commit("loader", false);
          } else if (this.datosBus.tipoDoc === 1) {
            this.$form.cliente.nombre_razon_social =
              rpta.data.result.Nombres + " " + rpta.data.result.Apellidos;
            this.$store.commit("loader", false);
          }
        } else {
          UTILS.info.error("No se logro encontrar ningún registro", this);
          this.$store.commit("loader", false);
        }
        this.$store.commit("loader", false);
      } catch (error) {
        this.$store.commit("loader", false);
      }
    },

    async mantenimiento() {
      let vm = this;
      this.$store.commit("loader", true);
      try {
        const response = await API.sucursales.mantenimiento();
        if (
          response.data.mantenimiento_lentes ||
          response.data.mantenimiento_productos
        ) {
          this.dialogMantenimiento = true;
        }
        this.$store.commit("loader", false);
      } catch (e) {
        UTILS.toastr.error("Ups! Ocurrió un error", this);
        console.error(e);
      }
    },
  },
};
</script>
