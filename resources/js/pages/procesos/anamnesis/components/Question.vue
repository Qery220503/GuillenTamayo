<template>
    <v-col md="12">
      <v-row>
        <v-col md="4" class="d-flex align-center"
          ><h4>{{ label }}</h4></v-col
        >
        <v-col md="4"
          ><v-radio-group v-model="value" row>
            <v-radio label="Si" :value="true"></v-radio>
            <v-radio label="No" :value="false"></v-radio> </v-radio-group
        ></v-col>
        <v-col md="4"
          ><v-textarea
            v-model="observations"
            rows="1"
            label="Observaciones"
            outlined
          ></v-textarea
        ></v-col>
      </v-row>
    </v-col>
  </template>
  
  <script>
  export default {
    props: {
      label: { required: true, default: "" },
    },
    data() {
      return {
        value: null,
        observations: "",
      };
    },
    watch: {
      value: function (val) {
        //   console.log("Val cambio", val);
        this.$emit("changeValue", val);
      },
      observations: function (val) {
        this.$emit("changeObservations", val);
      },
    },
  };
  </script>
  
  <style></style>
  