import Vue from "vue";

Vue.filter("formatCorrelative", value => {
  if (value) {
    return String(value).padStart(8, "0");
  }

  return "";
});
