<template>
   <div class="pl-2 pr-2">
           <div class="image-freddy-o">
             <v-fade-transition>
           <div v-show="eyes" class="image-freddy" />
            </v-fade-transition>
          </div>
         </div>
</template>

<script>

export default {
    name:"freddy",
  data(){
    return{
      eyes:true,
      interval:1000
    }
  },
  methods:{
      sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    },
    refreshInterval(){
      this.interval = 1000 * (Math.floor(Math.random() * 7)+1);
    },
    async animation(){
      this.eyes = false;
      await this.sleep(300)
      this.refreshInterval();
      this.eyes = true;
      setTimeout(()=>{
         this.animation();
      },this.interval)
    }

  },
  mounted(){
      this.refreshInterval();
    setTimeout(()=>{
      this.animation();
    },this.interval)
      
  }
}
</script>
<style lang="scss" scoped>
.image-freddy{
  background-image: url("/images/illustrations/freddy-admin.png");
  background-size: contain;
  width: 100%;
  height: 350px;
  background-position-y: bottom;
}
.image-freddy-o{
  background-image: url("/images/illustrations/freddy-admin-o.png");
  background-size: contain;
  width: 100%;
  height: 350px;
  background-position-y: bottom;
}
</style>