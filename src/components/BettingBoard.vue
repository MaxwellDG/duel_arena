<template>
    <div class="bet-con">
        <div class="filterCon">
            <p class="filterText">Filter ></p>
            <input type="text" :value="filter" class="filterInput"/>
        </div>
        <div class="list-con">
            <ul class='bettingBoard'>
                <OpenBet v-for="bet in openBets" :bet="bet" :key="bet.id" />
            </ul>
        </div>
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
            web3: state => state.web3
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
    .filterCon{
        display: flex;
        align-items: center;
        margin: 30px 0 10px 0;
    }

    .filterInput{
        background-color: transparent;
        border: none;
        padding: 2px 5px;
    }

    .filterText{
        margin: 0;
    }

    .bet-con{
        flex: 1;
        display: flex;
        flex-direction: column;
        width: 100%;
        padding: 0 10px 10px 10px;
        overflow: hidden;
    }

    .list-con{
        flex: 1;
        overflow-y: auto;
        padding: 0 17px;
    }
    
    .bettingBoard{
        height: 0;
        margin: 0;
        padding: 0;
    }
</style>