<template>
  <div id="app">
    <Landing />
    <Interfaz />
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import NavBar from '../components/NavBar.vue'
import Interfaz from './Interfaz.vue'
import Landing from './Landing.vue'

import VueToast from 'vue-toast-notification'
import 'vue-toast-notification/dist/theme-default.css';
// import 'vue-toast-notification/dist/theme-sugar.css';

Vue.use(VueToast);
Vue.use(VueRouter);

export default {
  name: 'App',
  components: {
    Landing,
    Interfaz,
    NavBar
  }
}
</script>

<style>

</style>
