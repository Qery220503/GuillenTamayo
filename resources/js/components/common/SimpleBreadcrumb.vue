<template>
  <div>
    <div class="display-1">{{ title }}</div>
    <v-breadcrumbs :items="breadcrumbs" class="pa-0 py-1"></v-breadcrumbs>
    <v-spacer></v-spacer>
  </div>
</template>

<script>
export default {
  name: "simple-breadcrumb",
  props: {
    title: {
      type: String,
      default: ""
    },
    prev: {
      type: String,
      default: ""
    },
    to: {
      type: String,
      default: ""
    },
    menu: {
      type: String,
      default: ""
    }
  },
  data() {
    return {
      breadcrumbs: [
        {
          text: this.prev,
          disabled: false,
          href: "/" + this.to
        },
        {
          text: this.menu
        }
      ]
    };
  },
  watch: {},
  mounted() {},
  methods: {}
};
</script>
