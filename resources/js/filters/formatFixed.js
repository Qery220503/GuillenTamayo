import Vue from 'vue'

Vue.filter('formatFixed', function (value) {9
  /*if (typeof value !== "number") {
      return value;
  }*/
  return Number(value).toFixed(2).toLocaleString();
});