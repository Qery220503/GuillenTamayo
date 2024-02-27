<template>
  <v-dialog v-model="dialog" max-width="500px">
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="primary" dark v-bind="attrs" v-on="on">
        Crear
      </v-btn>
    </template>

    <v-card>
      <v-card-title class="text-h5 grey lighten-2">
        Crear Campaña
      </v-card-title>

      <v-card-text>
        <v-form ref="form" v-model="valid" lazy-validation>
          <v-row class="mt-2" style="padding: 0px 10px !important">
            <v-col class="py-2 px-1" cols="12" md="12">
              <v-text-field v-model="name" label="Nombre" required filled></v-text-field>
            </v-col>
            <v-col class="py-2 px-1" cols="12" md="12">
              <div>
                <v-spacer></v-spacer>
              <v-btn color="primary">
                Guardar
              </v-btn>
              </div>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>

      <v-divider></v-divider>


    </v-card>


  </v-dialog>
</template>
<script>
export default {
  data() {
    return {
      dialog: false,
    }
  }
}
</script>
