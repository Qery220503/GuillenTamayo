<template>
  <v-dialog v-model="$store.state.loader" persistent width="200">
    <v-card color="primary" dark class="align-center" style="display: flex;">
      <v-card-text color="white" class="text-center">
        Cargando...
        <v-progress-linear
          indeterminate
          color="white"
          class="mb-0"
        ></v-progress-linear>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
<script>
export default {
  components: {}
};
</script>

<style lang="scss" scoped>
.v-dialog:not(.v-dialog--fullscreen) {
  max-height: 90%;
  box-shadow: none !important;
}
</style>
