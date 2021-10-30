<template>
    <div id='App'>
        <NavBar />
        <Principal />
        <Footer />
    </div>
</template>

<script>
import Vue from 'vue';
import VueToast from 'vue-toast-notification'
import VueFormulate from '@braid/vue-formulate'
import 'vue-toast-notification/dist/theme-default.css'
import Principal from './screens/Principal.vue'
import NavBar from './components/NavBar.vue'
import Footer from './components/Footer.vue'

Vue.use(VueToast);
Vue.use(VueFormulate)

export default {
    name: 'App',
    components: {
        Principal,
        NavBar,
        Footer
    },
    data() {
        return{
            
        }
    },
    
}
</script>

<style scoped>
    #container{
        
    }
</style>