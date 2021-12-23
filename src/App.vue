<template>
    <div class="main-con">
        <Banner />
        <div class='center-con'>
            <Artwork />
            <BettingBoard />
            <Footer />
        </div>
        <BottomButtons v-if="windowWidth < 700"/>

        <!-- media queries set to display = none when width < 700px -->
        <Connect />
        <Scanners />
        <RightTab :text="'How it Works'" :index="0"/>
        <RightTab :text="'Contact'" :index="1"/>
        <RightTab :text="'Place New Bet'" :index="2"/>
    </div>
</template>

<script>
import Vue from 'vue';
import Vuex from 'vuex';
import VueFormulate from '@braid/vue-formulate'
import 'vue-toast-notification/dist/theme-default.css'

//Blockchain
import Web3 from 'web3'
import BetFactory from '../build/contracts/BetFactory.json'

//Components
import VueToast from 'vue-toast-notification'
import Banner from './components/Banner.vue'
import BottomButtons from './components/BottomButtons';
import Address from './components/Address.vue'
import RightTab from './components/RightTab.vue'
import Connect from './components/Connect.vue';
import Scanners from './components/Scanners.vue'
import Artwork from './components/Artwork.vue'
import Footer from './components/Footer.vue';
import BettingBoard from './components/BettingBoard.vue'

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
const WINDOW_WIDTH = window.innerWidth;


export default {
    name: 'App',
    components: {
        Address,
        Artwork,
        Scanners,
        BottomButtons,
        Connect,
        Banner,
        RightTab,
        Footer,
        BettingBoard,
        Info
    },
    created(){
        this.$nextTick(() => {
            window.addEventListener('resize', this.onResize);
        })
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
    beforeDestroy() { 
        window.removeEventListener('resize', this.onResize); 
    },    
    data() {
        return{
            windowWidth: WINDOW_WIDTH,
        }
    },
    methods: {  
        onResize() {
            this.windowWidth = window.innerWidth;
        }
    },
}
</script>

<style>
    .main-con{
        display: flex;
        height: 100%;
        flex-direction: column;
        justify-content: flex-start;
        font-family: 'Runescape UF';
    }

    .center-con{
        display: flex;
        flex-direction: column;
        align-items: center;
        height: 100%;
        width: 50%;
        margin: 0 auto;
    }
</style>