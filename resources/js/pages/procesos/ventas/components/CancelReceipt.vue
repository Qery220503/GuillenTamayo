<template>
  <v-dialog v-model="dialog" max-width="500px">

    <v-card>
      <v-card-title>
        Anular comprobante
      </v-card-title>

      <v-card-text>
        <v-form ref="form" v-model="valid" lazy-validation @submit.prevent="save()">
          <v-row class="mt-2" style="padding: 0px 10px !important">
            <v-col class="py-2 px-1" cols="12" md="12">
              <v-textarea outlined label="Motivación de anulación" v-model="form.motivo_anulacion"
                :disabled="loading"></v-textarea>
            </v-col>
            <v-col>
              <v-checkbox v-model="form.disminucion_valor" label="Disminución de valor"
                :disabled="loading"></v-checkbox>
            </v-col>
          </v-row>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn type="submit" color="primary" :disabled="!valid" :loading="loading">Anular Comprobante</v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
      <v-divider></v-divider>
    </v-card>
  </v-dialog>
</template>

<script>
import API from '../../../../api';
import UTILS from '../../../../utils/index';
export default {
  props: {
    dialog: {
      type: Boolean,
      required: true,
    },
    id_comprobante: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      valid: false,
      loading: false,
      form: {
        motivo_anulacion: '',
        disminucion_valor: 0,
      },
      rules: {
        required: UTILS.nRules.required,
      },
    }
  },
  methods: {
    async save() {
      try {
        this.loading = true;
        await API.comprobante.anular(this.form, this.id_comprobante);
        this.$emit("deleted", this.form);
      } catch (e) {
        console.error(e)
      } finally {
        this.loading = false;
      }
    }
  },
  watch: {
    "dialog"() {
      this.form.motivo_anulacion = "";
      this.form.disminucion_valor = 0;
    },
    "form.disminucion_valor"(value) {
      if (value === true) {
        this.$swal({
          position: "center",
          icon: "info",
          title: "Disminución de valor",
          text: "Esta opción no devuelve stock",
          showConfirmButton: true,
        });
      }
    }
  },
}
</script>
