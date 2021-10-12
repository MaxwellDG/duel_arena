<template>
  <div 
        id="anAddress"
        @click="handleCopy"
        @mouseover="() => this.isCopy = true" 
        @mouseout="() => this.isCopy = false"
    >
      <p class="text">{{address}}</p>
      <div v-if="isCopy" class="copy">
        <img class="copyImg" src="/images/copy.png"/>
      </div>
  </div>
</template>

<script>
import Vue from 'vue'


export default {
  name: 'anAddress',
  props: {
      address: String
  },
  data(){
      return{
          isCopy: false
      }
  },
  methods: {
      async handleCopy(e){
          navigator.clipboard.writeText(this.$props.address).then(res => {
            let instance = Vue.$toast.open({
                message: 'Copied',
                type: 'info',
                position: 'bottom',
                duration: 1500,
            });

          })
      }
  }
}
</script>

<style scoped>
    #anAddress{
        position: relative;
        border: 1px solid plum;
        border-radius: 45px;
        padding: 8px 4px;
        background-color: white;
    }
    .text{

    }
    .copy{
        position: absolute;
        top: 5%;
        right: 0%;
        height: 25%;
    }
    .copyImg{
        height: 100%;
    }
</style>
