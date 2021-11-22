<template>
    <div class="main-con">
        <div class="banner">
            <h1 class="banner-text">50/50 Bets -> 2x</h1>
            <Info>
                <p style="margin: 0;">*$1 flat fee subtracted from winner</p>
            </Info>
        </div>
        <Connect />
        <div id='center-con'>
            <Artwork />
            <BettingBoard />
            <NewBetInterface />
        </div>
        <Scanners />
    </div>
</template>

<script>
import Vue from 'vue';
import Vuex from 'vuex';
import VueFormulate from '@braid/vue-formulate'
import Web3 from 'web3'

//Components
import VueToast from 'vue-toast-notification'
import Address from './components/Address.vue'
import Scanners from './components/Scanners.vue'
import Connect from './components/Connect.vue'
import NewBetInterface from './components/NewBetInterface.vue'
import Artwork from './components/Artwork.vue'
import BettingBoard from './components/BettingBoard.vue'
import 'vue-toast-notification/dist/theme-default.css'

//SVGs
import Info from './icons/info.vue'

Vue.use(Vuex);
Vue.use(VueFormulate)
Vue.use(VueToast);

// Need something on the smartcontract that watches for if a bet has already been filled. And sends back a notice
// before any kind of transaction fee from a denial occurs

// Start advertisement with runescape bots 
// Maybe do some advertising? '50/50 2x Peer-2-Peer Crypto Gambling - DuelArena.io'
// Miss DuelArena? Gamble like a big boi @ DuelArena.io

const BET_FACTORY_ADDRESS = '0x0F5F5268246cbF5f3a9381b6511D34f5aB3Af08A';


export default {
    name: 'App',
    components: {
        Address,
        Artwork,
        Scanners,
        NewBetInterface,
        Connect,
        BettingBoard,
        Info
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
    .main-con{
        height: 100vh;
    }

    #center-con{
        display: flex;
        flex-direction: column;
        height: 100%;
        justify-content: space-between;
        align-items: center;
        width: 50%;
        margin: 0 auto;
    }
    .top-con{
        display: flex;
    }
    .banner{
        display: flex;
    }
    .banner-text{
        margin: 0 5px 0 0;
    }
</style>