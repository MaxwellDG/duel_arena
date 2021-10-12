<template>
    <div id="Interfaz">
        <DonationBlock />
        <DonationBlock />
        <DonationBlock />
        <DonationBlock />
    </div>
</template>

<script>
import DonationBlock from '../components/DonationBlock.vue'

export default {
  name: 'Interfaz',
  components: {
    DonationBlock
  }
}
</script>

<style scoped>
  #Interfaz{
    display: flex;
    flex-direction: row;
    justify-content: space-around;
  }
</style>