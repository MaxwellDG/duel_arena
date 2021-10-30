<template>
  <div id="container">
    <Landing />
    <Interfaz />
    <ComoFunciona />
    <SobreNosotros />
    <Contacta />
  </div>
</template>

<script>
import Interfaz from './Interfaz.vue'
import Landing from './Landing.vue'
import ComoFunciona from './ComoFunciona.vue'
import SobreNosotros from './SobreNosotros.vue'
import Contacta from './Contacta.vue'

export default {
  name: 'Principal',
  components: {
    Landing,
    Interfaz,
    ComoFunciona,
    SobreNosotros,
    Contacta
  }
}
</script>

<style>

</style>
