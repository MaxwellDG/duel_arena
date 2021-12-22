<template>
    <div class="main-con">
        <div class="banner">
            <h1 class="banner-text">50/50 Bets -> 2x</h1>
            <Info>
                <p style="margin: 0; font-size: 12px; font-family: 'RuneScape UF';">*$1 flat fee subtracted from winner</p>
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

//Blockchain
import Web3 from 'web3'
import BetFactory from '../build/contracts/BetFactory.json'

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
                const web3 = new Web3(new Web3.providers.HttpProvider('HTTP://127.0.0.1:7545'))
                const addresses = await web3.eth.getAccounts()
                const networkId = await web3.eth.net.getId();
                const deployedNetwork = BetFactory.networks[networkId];

                // const web3 = new Web3(Web3.givenProvider || new Web3.providers.HttpProvider('http://localhost:7545'))
                this.$store.commit('setWeb3', web3);
                const BetFactoryContract = new web3.eth.Contract(BetFactory.abi, deployedNetwork.address)
                console.log(BetFactoryContract)

                try{
                    const betCounter = await BetFactoryContract.methods.betCounter().call();
                    console.log(betCounter);
                } catch (e){
                    console.log('errrr', e)
                }

                try{
                    const self = await BetFactoryContract.methods.readSelfBets().call()
                    console.log('READING BETS');
                    console.log(self)
                } catch(e){
                    console.log('got and error:')
                    console.log(e);
                }

                await BetFactoryContract.methods.createBet(58, "SOL", "NODNOD").send({
                    from: addresses[0],
                })
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

<style>
    @font-face {
        font-family: 'RuneScape UF';
        font-weight: normal;
        font-style: normal;
        src: local("Runescape-UF"), url("./fonts/RuneScape-UF.woff2") format("woff2");
    }

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
        font-family: 'RuneScape UF';
        margin: 0 5px 0 0;
    }
</style>