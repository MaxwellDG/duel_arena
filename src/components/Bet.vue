<template>
    <li class="bet">
        <div class="fifth" style="display: flex; align-items: center;">
            <p style="margin-right: 15px;">{{bet.token}}</p>
            <div style="height: 25px; width: 25px;">
                <component :is="icon"/>
            </div>
        </div>
        <div class="fifth">
            <p>{{bet.displayName}}</p>
        </div>
        <div class="fifth" style="display: flex;">
            <p>{{bet.wager}}</p>
            <p class="usd">{{inUSD}}</p>
        </div>
        <div class="fifth">
            <p>{{bet.isEven ? 'Even' : 'Odd'}}</p>
        </div>
        <div class="fifth bet-div">
            <button @click="handleBet" class="bet-button">BET</button>
        </div>
    </li>
</template>

<script>
import * as Types from '@/store/types';
import {mapState} from 'vuex';

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
    computed: {
        ...mapState({
            usdValues: state => state.usdValues,
        }),
        inUSD(){
            const tokenName = Object.keys(Types.TOKEN_CODES).find(j => Types.TOKEN_CODES[j] == this.bet.token)
            if(tokenName)
                return (parseFloat(this.bet.wager) * parseFloat(this.usdValues[tokenName].usd)).toFixed(2);
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
        cursor: pointer;
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

    .fifth{
        width: 20%;
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>