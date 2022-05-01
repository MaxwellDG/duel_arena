<template>
    <div class="bet-con">
        <div class="filterCon">
            <div class="board-buttons">
                <button :class="getClass('board')" @click="() => type = 'board'">Betting Board</button>
                <button :class="getClass('self')" @click="() => type = 'self'">My Bets</button>
            </div>
            <div class="flex align">
                <div v-if="type != 'self'" class="flex align" :style="{marginRight: '0.5rem'}">
                    <p class="filterText">Search</p>
                    <v-select 
                        class="standard-dropdown token-drop"
                        :modelValue="search"
                        @update:modelValue="handleSearchUpdate"
                        v-model="search"
                        :clearable="false"
                        :searchable="false"
                        :options="SEARCH_OPTIONS"
                    />
                    <input 
                        type="text" 
                        :value="searchInput" 
                        @input="debounceSearch" 
                        class="filterInput" 
                        :disabled="search.code == 'ALL'"
                    />
                </div>
                <div class="flex align">
                    <p class="filterText">Filter</p>
                    <v-select 
                        class="standard-dropdown token-drop"
                        v-model="filter"
                        :clearable="false"
                        :searchable="false"
                        :options="FILTER_OPTIONS"
                    />
                    <input type="text" v-model="filterInput" class="filterInput"/>
                </div>
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
import _ from 'lodash';
import * as Types from "@/store/types"
import { SEARCH_FILTERS } from '@/util/constants'
import { computed, inject, ref } from '@vue/runtime-core'

const store = useStore();
const $web3 = inject('$web3')

const type = ref('self')
const getClass = (str) => str == type.value ? 'selected-button' : 'unselected-button'
const getBets = computed(() => {
    const arr = type.value == 'self' ? store.state.selfBets : store.state.openBets;
    if(filterInput.value.length == 0) return arr;
    else return arr.filter(bet => {
        return bet[filter.value.code].includes(filterInput.value)
    })
})

const filter = ref({label: 'Token', code: 'token'})
const filterInput = ref('')
const FILTER_OPTIONS = [
        {label: 'Token', code: 'token'},
        {label: 'Display Name', code: 'displayName'},
        {label: 'USD', code: 'USD'},
    ]

const search = ref({label: 'All', code: 'ALL'})
const searchInput = ref('')
const SEARCH_OPTIONS = [
        {label: 'All', code: 'ALL'},
        {label: 'Token', code: 'TOKEN'},
        {label: 'Display Name', code: 'DISPLAY_NAME'},
    ]

const getFreshBets = async (filter, input) => {
    store.commit(Types.RESET_PAGE_NUM, true);
    const bets = await getMoreBets(0, filter, input)
    store.commit(Types.SET_OPEN_BETS, bets)
}

const handleSearchUpdate = (e) => {
    search.value = e;
    searchInput.value = '';
    filterInput.value = '';
    if(e.code == 'ALL')getFreshBets(SEARCH_FILTERS.ALL)
    else store.commit(Types.SET_OPEN_BETS, [])
}
const handleSearchInput = async (e) => {
    searchInput.value = e.target.value;
    getFreshBets(SEARCH_FILTERS[search.value.code], e.target.value)
}
const debounceSearch = _.debounce(handleSearchInput, 1000, {leading: false, trailing: true});

const getMoreBets = async (pageNum, filter, input) => {
    if($web3.BetFactoryContract){
        try{
            const contractAddresses = await $web3.getBets(pageNum, filter, input);
            return await Promise.all(contractAddresses.map(async j => {
                const betContract = await $web3.getBetContract(j);
                return new Bet({
                    address: betContract.contract._address,
                    ...betContract.betData
                });
            }));
        } catch (e) {
            // error alert
        }
    } 
}

</script>
