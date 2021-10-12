<template>
    <div class='container p15'>
        <div class="leftNav">
           CRYPTO CRUZ 
        </div>
        <div class="between rightNav">
            <p v-on:click="(e) => handleClick(e, `about`)">About</p>
            <p v-on:click="(e) => handleClick(e, `interface`)">Interface</p>
            <p v-on:click="(e) => handleClick(e, `whoweare`)">How it Works</p>
            <p v-on:click="(e) => handleClick(e, `tech`)">Team</p>
            <p v-on:click="(e) => handleClick(e, `faq`)">FAQ</p>
            <p v-on:click="(e) => handleClick(e, `contact`)">Contact</p>
        </div>
    </div>
</template>

<script>
export default {
    name: '',
    components: {
        
    },
    data() {
        return{
            
        }
    },
    methods: {
        handleClick(e, loc){
            this.$router.push(loc)
        }
    }
}
</script>

<style scoped>
    .container{
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .rightNav p{
        margin-left: 15px;
    }
</style>