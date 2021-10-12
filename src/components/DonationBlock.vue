<template>
  <div id="DonationBlock">
      <img src="/images/grocery-1.jpeg" class="groceryImg"/>
      <Address :address="`0x934uh3nb3035bdjnibr`"/>
  </div>
</template>

<script>
import Address from './Address.vue'

export default {
  name: 'DonationBlock',
  props: {

  },
  components:{
      Address,
  }
}
</script>

<style scoped>
    #DonationBlock{
        display: flex;
        flex-direction: column;
        justify-content: center;
        height: 300px;
        width: 15%;
    }
    .groceryImg{
        height: 100%;
    }
</style>
