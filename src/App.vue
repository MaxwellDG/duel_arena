<template>
    <div id='App'>
        <Connect />
        <Artwork />
        <NewBetInterface />
        <Scanners />
    </div>
</template>

<script>
import Vue from 'vue';
import Vuex from 'vuex';
import VueFormulate from '@braid/vue-formulate'
import Web3 from 'web3'

import VueToast from 'vue-toast-notification'
import Address from './components/Address.vue'
import Scanners from './components/Scanners.vue'
import Connect from './components/Connect.vue'
import NewBetInterface from './components/NewBetInterface.vue'
import Artwork from './components/Artwork.vue'
import 'vue-toast-notification/dist/theme-default.css'

Vue.use(Vuex);
Vue.use(VueFormulate)
Vue.use(VueToast);

// Need something on the smartcontract that watches for if a bet has already been filled. And sends back a notice
// before any kind of transaction fee from a denial occurs

// The open bet options you make yourself will have retard names but not all cause that's too obvious
// NICECOCKRETARD, jj98, n00bpkerpl0x, 69mefaggot, 69mefaggot, 69mefaggot, lllllllllll, Shamesh98

// Start advertisement with runescape bots 
// Maybe do some advertising? '50/50 2x Peer-2-Peer Crypto Gambling - DuelArena.io'
// Miss DuelArena? Gamble like a big boi @ DuelArena.io

export default {
    name: 'App',
    components: {
        Address,
        Artwork,
        Scanners,
        NewBetInterface,
        Connect
    },
    mounted(){
        (async () => {
            if (typeof window.ethereum !== 'undefined') {          
                this.$store.commit('setWeb3', new Web3(Web3.givenProvider || new Web3.providers.HttpProvider('http://localhost:8545')));
            } else { 
                // Non-dapp browsers
                console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
            }
        })()
    },
    data() {
        return{

        }
    },
    
}
</script>

<style scoped>
    #App{
        display: flex;
        flex-direction: column;
        height: 100%;
        justify-content: center;
        align-items: center;
    }
</style>