<template>
    <div class="bet-con">
        <div class="filterCon">
            <div class="flex align">
                <p class="filterText">Filter</p>
                <v-select 
                    class="standard-dropdown token-drop"
                    name="filterInput"
                    v-model="filter" 
                    :clearable="false"
                    :options="getFilterOptions"
                />
                <input type="text" v-model="filterInput" class="filterInput"/>
            </div>
            <div class="board-buttons">
                <button :class="getClass('board')" @click="() => type = 'board'">Betting Board</button>
                <button :class="getClass('self')" @click="() => type = 'self'">My Bets</button>
            </div>
        </div>
        <div class="list-con">
            <ul class='bettingBoard'>
                <OpenBet v-for="bet in getBets" :bet="bet" :key="bet.id" :isSelf="type == 'self'"/>
            </ul>
        </div>
    </div>
</template>

<script>
import { mapState } from 'vuex'
import OpenBet from './Bet.vue'

import Bet from '@/models/bet'

export default {
    name: 'BettingBoard',
    components: {
        OpenBet
    },
    mounted(){
        this.getSelfBets();
    },
    data() {
        return{
            filter: {label: 'Token', code: 'token'},
            filterInput: '',
            type: 'self',
            openBets: [],
            selfBets: []
        }
    },
    computed: {
        ...mapState({
            web3Client: state => state.web3Client
        }),
        getBets(){
            const arr = this.type == 'self' ? this.selfBets : this.openBets
            if(this.filterInput.length == 0) return arr;
            return arr.filter(bet => {
                return bet[this.filter.code].includes(this.filterInput)
            })
        },
        getFilterOptions(){
            return [
                {label: 'Token', code: 'token'},
                {label: 'DisplayName', code: 'displayName'},
                {label: 'USD', code: 'USD'},
            ]
        }
    },
    methods: {
        async getSelfBets(){
            let count = 0;
            let interval = setInterval(async () => {
                if(count >= 3){
                    clearInterval(interval) // Give up
                    // TODO Some kind of error alert
                }
                if(this.web3Client.BetFactoryContract){
                    try{
                        const selfBetAddresses = await this.web3Client.getSelfBets();
                        selfBetAddresses.forEach(async j => {
                            const betContract = await this.web3Client.getBetContract(j);
                            const BetData = new Bet(betContract.betData);
                            this.selfBets.push(BetData);
                        });
                        clearInterval(interval)
                    } catch (e) {
                        count++
                    }
                } else {
                    count++;
                } 
            }, 1000)
        },
        getClass(type){
            return type == this.type ? 'selected-button' : 'unselected-button'
        },
    }
}
</script>

<style scoped>
    .filterCon{
        display: flex;
        justify-content: space-between;
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
        scrollbar-color: rgba(128, 0, 128, 0.3) transparent;
        scrollbar-width: thin;
        flex: 1;
        overflow-y: auto;
    }
    
    .bettingBoard{
        height: 0;
        margin: 0;
        padding: 0;
    }
</style>