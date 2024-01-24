<template>
  <v-card
    class="d-flex align-center"
    color="surface"
    flat
    :height="fullpage ? '100vh' : '10vh'"
    tile
  >
    <v-card
      class="d-flex justify-center"
      flat
      color="rgb(53, 56, 65, 0)"
      width="100%"
      tile
    >
      <atom-spinner
        v-if="kind == 'atom'"
        :animation-duration="1000"
        :size="100"
        :color="'#043c77'"
      />
      <hollow-dots-spinner
        v-if="kind == 'dots'"
        :animation-duration="1000"
        :size="100"
        :color="'#043c77å'"
      />
    </v-card>
  </v-card>
</template>
<script>
/*
|---------------------------------------------------------------------
| Trend Percent Component
|---------------------------------------------------------------------
|
| Shows and up or down arrow with green or red color presenting the
| trend of the given value
|
*/
import { AtomSpinner } from "epic-spinners";
import { HollowDotsSpinner } from "epic-spinners";

export default {
  props: {
    fullpage: {
      type: Boolean,
      default: true
    },
    kind: {
      type: String,
      default: "atom"
    }
  },
  components: { AtomSpinner, HollowDotsSpinner },
  data() {
    return {};
  }
};
</script>
