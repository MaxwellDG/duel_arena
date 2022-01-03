<template>
    <li class="bet">
        <div style="display: flex; align-items: center;">
            <p style="margin-right: 15px;">{{bet.token}}</p>
            <div style="height: 25px; width: 25px;">
                <component :is="icon"/>
            </div>
        </div>
        <p>{{bet.displayName}}</p>
        <div style="display: flex;">
            <p>{{bet.wager}}</p>
            <p class="usd">{{bet.inUSD}}</p>
        </div>
        <div>
            <p>{{bet.isEven.toString()}}</p>
        </div>
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
            icon: () => import(`../../node_modules/cryptocurrency-icons/svg/color/${this.bet.token}.svg`)
        }
    },
    methods: {
        handleBet(){
            // TODO some wiggidy wack metamask stuff
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

    .usd{
        color: grey;
        margin-left: 10px;
    }
</style>