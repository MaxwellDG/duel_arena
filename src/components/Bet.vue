<template>
    <li class="bet">
        <div style="display: flex; align-items: center;">
            <p style="margin-right: 15px;">{{bet.coin}}</p>
            <component :is="icon"/>
        </div>
        <p>{{bet.displayName}}</p>
        <p @mouseover="handleHover" @mouseout="handleHoverout">{{bet.bet}}</p>
        <p>{{bet.inUSD}}</p>
        <button @click="handleBet" class="bet-button">BET</button>
    </li>
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
    .bet{
        display: flex;
        justify-content: space-around;
        align-items: center;
        background-color: white;
        border-radius: 4px;
        padding: 5px 15px;
        margin: 0 0 10px 0;
    }

    .bet-button{
        font-size: 14px;
        background-color: rgba(128, 0, 128, 0.3);
        border: 2px solid purple;
        color: black;
        font-weight: 600;
    }
</style>