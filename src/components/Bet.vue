<template>
    <div id='container'>
        <div style="display: flex; align-items: center;">
            <p style="margin-right: 15px;">{{bet.coin}}</p>
            <component :is="icon"/>
        </div>
        <p>{{bet.displayName}}</p>
        <p @mouseover="handleHover" @mouseout="handleHoverout">{{bet.bet}}</p>
        <p v-show="isHoveringBet">99</p>
        <button @click="handleBet" class="bet-button">BET</button>
    </div>
</template>

<script>
export default {
    name: '',
    props: {
        bet: Object,
    },
    components: {
        
    },
    data() {
        return{
            isHoveringBet: false,
            icon: () => import(`../../node_modules/cryptocurrency-icons/svg/color/${this.bet.coin}.svg`)
        }
    },
    methods: {
        handleBet(){
            // TODO some wiggidy wack metamask stuff
        },
        handleHover(){
            this.isHoveringBet = true;
        },
        handleHoverout(){
            this.isHoveringBet = false;
        },
    }
}
</script>

<style scoped>
    #container{
        display: flex;
        justify-content: space-around;
        align-items: center;
        background-color: white;
        margin: 5px 0;
        padding: 0 5px;
        border-radius: 2px;
    }
    .bet-button{
        padding: 0 15px;
    }
</style>