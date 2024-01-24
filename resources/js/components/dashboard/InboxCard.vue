<template>
  <inbox-page class="email-card"></inbox-page>
</template>

<script>
import ListPage from "../../apps/email/pages/ListPage";

export default {
  components: {
    ListPage
  }
};
</script>

<style lang="scss" scoped>
.email-card {
  max-height: 340px;
  overflow-y: scroll;
}
</style>
