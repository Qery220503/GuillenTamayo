<template>
  <v-dialog v-model="dialog" max-width="500px">
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="primary" dark v-bind="attrs" v-on="on">
        Crear
      </v-btn>
    </template>

    <v-card>
      <v-card-title>
        Crear Campaña
      </v-card-title>

      <v-card-text>
        <v-form ref="form" v-model="valid" lazy-validation @submit.prevent="createCampaign">
          <v-row class="mt-2" style="padding: 0px 10px !important">
            <v-col class="py-2 px-1" cols="12" md="12">
              <v-text-field v-model="name" label="Nombre" required filled :loading="loading" :rules="[rules.required]"></v-text-field>
            </v-col>
          </v-row>
          <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn
                color="blue darken-1"
                text
                @click="dialog = false"
                :disabled="loading"
                >Cancelar</v-btn
              >
              <v-btn
                type="submit"
                color="primary"
                :disabled="!valid"
                :loading="loading"
                >Guardar</v-btn
              >
            </v-card-actions>
        </v-form>
      </v-card-text>

      <v-divider></v-divider>


    </v-card>


  </v-dialog>
</template>
<script>
import UTILS from '../../../utils/index';
export default {
  data() {
    return {
      valid: false,
      loading: false,
      dialog: false,
      name: "",
      rules: {
        required: UTILS.nRules.required,
      },
    }
  },
  methods: {
    async createCampaign(){
      this.loading = true;
      try{
        if(!this.$refs.form.validate){
          return;
        }
        const response = await API.campaign.create({ name: this.name });
        this.name = "";
        this.dialog = false;
        this.loading = false;
        this.$emit("created", response.data);
        this.$refs.form.reset();
      }catch(e){
        console.error(e);
      }
      finally{
        this.loading = false;
      }
    }
  }
}
</script>
