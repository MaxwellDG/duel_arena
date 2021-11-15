<template>
    <div id="bet-con">
        <div style="display: flex;">
            <p>Filter ></p>
            <input type="text" :value="filter" style="background-color: transparent; border: none;"/>
        </div>
        <ul id='bettingBoard' style="padding: 0 10px;">
            <li v-for="bet in openBets" :key="bet.id" style="list-style-type: none;">
                <OpenBet :bet="bet"/>
            </li>
        </ul>
    </div>
</template>

<script>
import { mapState } from 'vuex'
import OpenBet from './Bet.vue'

export default {
    name: 'BettingBoard',
    components: {
        OpenBet
    },
    computed: {
        ...mapState({
            openBets: state => state.openBets,
        })
    },
    data() {
        return{
            filter: 'ALL',
        
        }
    },
}
</script>

<style scoped>
    #bet-con{
        height: 40vh;
        width: 100%;
        overflow: hidden;
    }
    
    #bettingBoard{
        width: 100%;
        padding: 5px 0;
        border-radius: 5px;
        height: 100%;
        overflow-y: scroll;
        padding-right: 17px; /* Increase/decrease this value for cross-browser compatibility */
        box-sizing: content-box; /* So the width will be 100% + 17px */
    }
</style>