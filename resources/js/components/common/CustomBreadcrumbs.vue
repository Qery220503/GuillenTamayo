<template>
  <v-container class="pa-0" fluid>
    <div class="py-3 min-w-0 w-full pb-1 pt-1">
      <div class="d-flex justify-space-between">
        <div class="text-left">
          <h2>{{ breadcrumbs_title }}</h2>
          <slot></slot>
          <v-breadcrumbs :items="breadcrumbs" class="pa-0 py-2"></v-breadcrumbs>
        </div>
      </div>
    </div>
  </v-container>
</template>
<script>
export default {
  name: "custom-breadcrumbs",
  props: {
    breadcrumbs_title: {
      type: String,
      default: ""
    },
    breadcrumbs: {
      type: Array,
      default: [
        {
          text: "Inicio",
          disabled: false,
          href: "#"
        },
        {
          text: ""
        }
      ]
    }
  },
  data() {
    return {};
  },
  computed: {},
  methods: {
    onClick() {
      var vm = this;
      vm.helper.action();
    }
  }
};
</script>
