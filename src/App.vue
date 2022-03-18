<template>
    <div class="main-con">
        <Banner />
        <div class='center-con'>
            <Artwork />
            <BettingBoard />
            <Footer />
        </div>
        <BottomButtons v-if="windowWidth < 700"/>

        <!-- media queries set to 'display = none' when width < 700px -->
        <Connect />
        <Scanners />
        <RightTab :text="'How it Works'" :index="0" @click.native="modal = 'HowItWorks'"/>
        <RightTab :text="'Contact'" :index="1" @click.native="modal = 'Contact'"/>
        <RightTab :text="'Place New Bet'" :index="2" @click.native="modal= 'NewBetInterface'"/>

        <!-- Modals -->
        <ModalWrapper @close-modal="modal = null" v-if="modal != null">
            <HowItWorks v-if="modal == 'HowItWorks'"/>
            <Contact v-else-if="modal == 'Contact'"/>
            <NewBetInterface v-else-if="modal == 'NewBetInterface'" />
        </ModalWrapper>
    </div>
</template>

<script>
//Components
import Banner from './components/Banner.vue'
import BottomButtons from './components/BottomButtons';
import ModalWrapper from './components/modals/ModalWrapper';
import Address from './components/Address.vue'
import RightTab from './components/RightTab.vue'
import Connect from './components/Connect.vue';
import Scanners from './components/Scanners.vue'
import Artwork from './components/Artwork.vue'
import Footer from './components/Footer.vue';
import BettingBoard from './components/BettingBoard.vue'
import Contact from './components/modals/Contact.vue'
import HowItWorks from './components/modals/HowItWorks.vue'
import NewBetInterface from './components/modals/NewBetInterface.vue'

//Libraries
import Vue from 'vue';
import Vuex from 'vuex';
import 'vue-toast-notification/dist/theme-default.css'
import axios from 'axios';
import VueToast from 'vue-toast-notification'

//Util
import Web3Client from './web3/web3Client';
import * as Types from '@/store/types';
import {mapState, mapMutations} from 'vuex';

//SVGs
import Info from './icons/info.vue'

Vue.use(Vuex);
Vue.use(VueToast, {
    position: 'bottom'
});



// Need something on the smartcontract that watches for if a bet has already been filled. And sends back a notice
// before any kind of transaction fee from a denial occurs

// Start advertisement with runescape bots 
// Maybe do some advertising? '50/50 2x Peer-2-Peer Crypto Gambling - DuelArena.io'
// Miss DuelArena? Gamble like a big boi @ DuelArena.io

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
        ModalWrapper,
        Info,
        HowItWorks,
        Contact,
        NewBetInterface
    },
    created(){
        let web3Client = new Web3Client();
        this.SET_WEB3_CLIENT(web3Client);

        this.getTokenValues();

        this.$nextTick(() => {
            window.addEventListener('resize', this.onResize);
        })
    },
    beforeDestroy() { 
        window.removeEventListener('resize', this.onResize); 
    },    
    data() {
        return{
            windowWidth: WINDOW_WIDTH,
            modal: null,
        }
    },
    computed: {
        ...mapState({
            usdValues: state => state.usdValues
        })
    },
    methods: {  
        ...mapMutations([
            Types.SET_USD_VALUES,
            Types.SET_WEB3_CLIENT
        ]),
        onResize() {
            this.windowWidth = window.innerWidth;
        },
        getTokenValues(){
            const ids = Object.keys(this.usdValues).join();
            axios({url: `https://api.coingecko.com/api/v3/simple/price?ids=${ids}&vs_currencies=usd`}).then(res => {
                if(res.status == 200)
                    this.SET_USD_VALUES(res.data);
            }).catch(e => console.log(e));
        },
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
        justify-content: center;
        align-items: center;
        height: 100%;
        width: 50%;
        margin: 0 auto;
    }
</style>