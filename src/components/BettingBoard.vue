<template>
    <div class="bet-con">
        <div class="filterCon">
            <div class="flex align">
                <p class="filterText">Filter</p>
                <v-select 
                    class="standard-dropdown token-drop"
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
import * as Types from "@/store/types"
import { computed, inject, onMounted, reactive, ref } from '@vue/runtime-core'

const store = useStore();
const $web3 = inject('$web3')

onMounted(() => {
    getSelfBets();
})

const filter = ref({label: 'Token', code: 'token'})
const filterInput = ref('')
const FILTER_OPTIONS = [
                {label: 'Token', code: 'token'},
                {label: 'Display Name', code: 'displayName'},
                {label: 'USD', code: 'USD'},
            ]

const type = ref('self')
const getClass = (str) => str == type.value ? 'selected-button' : 'unselected-button'

const openBets = reactive([])
const getBets = computed(() => {
    const arr = type.value == 'self' ? store.state.selfBets : openBets
    if(filterInput.value.length == 0) return arr;
    else return arr.filter(bet => {
        return bet[filter.value.code].includes(filterInput.value)
    })
})

// TODO maybe move these two functions below into a util file so they can be called everywhere
// then call them here in mounted()
// Or look into the Composition API thing about using functions in other classes easily

const getSelfBets = async () => {
    let count = 0;
    let interval = setInterval(async () => {
        if(count >= 3){
            clearInterval(interval) // Give up
            // TODO Some kind of error alert
        }
        if($web3.BetFactoryContract){
            try{
                const selfBetAddresses = await $web3.getSelfBets(0); 
                selfBetAddresses.forEach(async j => {
                    const betContract = await $web3.getBetContract(j);
                    const BetData = new Bet({
                        address: betContract.contract._address,
                        ...betContract.betData
                    });
                    store.commit(Types.ADD_SELF_BET, BetData)
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
