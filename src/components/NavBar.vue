<template>
    <div class='container p15'>
        <div class="leftNav primary-brand">
           Agrano
        </div>
        <div class="between rightNav">
            <p v-on:click="(e) => handleClick(e, `mission`)" class="primary-brand">Misson</p>
            <p v-on:click="(e) => handleClick(e, `interface`)" class="primary-brand">Interface</p>
            <p v-on:click="(e) => handleClick(e, `tech`)" class="primary-brand">How it Works</p>
            <p v-on:click="(e) => handleClick(e, `faq`)" class="primary-brand">FAQ</p>
            <p v-on:click="(e) => handleClick(e, `about`)" class="primary-brand">Team</p>
            <p v-on:click="(e) => handleClick(e, `contact`)" class="primary-brand">Contact</p>
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