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
                    :options="FILTER_OPTIONS"
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

<script setup>
import OpenBet from './Bet.vue'

import Bet from '@/models/bet'

import { useStore } from 'vuex'
import { inject, onMounted, reactive, ref } from '@vue/runtime-core'

const store = useStore();
const $web3 = inject('$web3')

onMounted(() => {
    getSelfBets();
})

const filter =  reactive({label: 'Token', code: 'token'})
const filterInput = ref('')
const FILTER_OPTIONS = [
                {label: 'Token', code: 'token'},
                {label: 'DisplayName', code: 'displayName'},
                {label: 'USD', code: 'USD'},
            ]

const type = ref('self')
const getClass = (str) => str == type.value ? 'selected-button' : 'unselected-button'

const openBets = reactive([])
const selfBets = reactive([])
const getBets = () => {
    const arr = this.type == 'self' ? this.selfBets : this.openBets
    if(this.filterInput.length == 0) return arr;
    return arr.filter(bet => {
        return bet[this.filter.code].includes(this.filterInput)
    })
}
const getSelfBets = async () =>{
    let count = 0;
    let interval = setInterval(async () => {
        if(count >= 3){
            clearInterval(interval) // Give up
            // TODO Some kind of error alert
        }
        if($web3.BetFactoryContract){
            try{
                const selfBetAddresses = await $web3.getSelfBets();
                selfBetAddresses.forEach(async j => {
                    const betContract = await $web3.getBetContract(j);
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