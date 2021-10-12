<template>
    <div id='container'>
        <NavBar />
        <Principal />
        <Footer />
    </div>
</template>

<script>
import Principal from './screens/Principal.vue'
import NavBar from './components/NavBar.vue'
import Footer from './components/Footer.vue'

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