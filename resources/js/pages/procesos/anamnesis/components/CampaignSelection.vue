<template>
  <v-dialog v-model="dialog" max-width="500px" persistent>

    <v-card>
      <v-card-title>
        Seleccionar Campaña
      </v-card-title>

      <v-card-text>
        <v-form ref="form" v-model="valid" lazy-validation @submit.prevent="sendCampaign()">
          <v-row class="mt-2" style="padding: 0px 10px !important">
            <v-col class="py-2 px-1" cols="12" md="12">
              <v-select
                filled
                :items="campaigns"
                v-model="campaign"
                label="Campaña"
                item-text="name"
                item-value="id"
                :loading="loading"
                :rules="[rules.required]"
              ></v-select>
            </v-col>
          </v-row>
          <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn
                type="submit"
                color="primary"
                :disabled="!valid"
                :loading="loading"
                >Asociar a Campaña</v-btn
              >
            </v-card-actions>
        </v-form>
      </v-card-text>

      <v-divider></v-divider>


    </v-card>


  </v-dialog>
</template>
<script>
import UTILS from '../../../../utils/index';
export default {
  props: {
    dialog: {
      type: Boolean,
      required: true,
    }
  },
  data() {
    return {
      valid: false,
      loading: false,
      campaign: {},
      campaigns: [],
      rules: {
        required: UTILS.nRules.required,
      },
    }
  },
  methods: {
    async loadCampaigns(){
      const response = await API.campaign.combo();
      this.campaigns = response.data;
    },
    sendCampaign(){
      this.$emit('selected', this.campaign);
      return;
    }
  },
  created(){
    this.loadCampaigns();
  }
}
</script>
