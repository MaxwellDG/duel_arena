<template>
    <div class="main-con">
        <Banner />
        <div class='center-con'>
            <Artwork />
            <BettingBoard />
            <Footer />
        </div>
        <BottomButtons v-if="width && width < 700"/> 

        <!-- media queries set to 'display = none' when width < 700px -->
        <Connect />
        <Scanners />
        <RightTab :text="'How it Works'" :index="0" @click="toggleModal('HowItWorks')"/>
        <RightTab :text="'Contact'" :index="1" @click="toggleModal('Contact')"/>
        <RightTab :text="'Place New Bet'" :index="2" @click="toggleModal('NewBetInterface')"/>

        <!-- Modals -->
        <ModalWrapper v-if="store.state.modal != null" @close-modal="toggleModal(null)" >
            <HowItWorks v-if="store.state.modal == 'HowItWorks'"/>
            <Contact v-else-if="store.state.modal == 'Contact'"/>
            <NewBetInterface v-else-if="store.state.modal == 'NewBetInterface'" />
        </ModalWrapper>
    </div>
</template>

<script setup>
import { onUnmounted, onMounted } from '@vue/runtime-core';
import { ref } from 'vue'

//Components
import Banner from './components/Banner.vue'
import BottomButtons from './components/BottomButtons';
import ModalWrapper from './components/modals/ModalWrapper';
import RightTab from './components/RightTab.vue'
import Connect from './components/Connect.vue';
import Scanners from './components/Scanners.vue'
import Artwork from './components/Artwork.vue'
import Footer from './components/Footer.vue';
import BettingBoard from './components/BettingBoard.vue'
import Contact from './components/modals/Contact.vue'
import HowItWorks from './components/modals/HowItWorks.vue'
import NewBetInterface from './components/modals/NewBetInterface.vue'

//Libs
import axios from 'axios';

//Util
import * as Types from '@/store/types';
import { useStore } from 'vuex';

const store = useStore()
const toggleModal = (text) => store.commit(Types.TOGGLE_MODAL, text)

const width = ref(null)
const onResize = () => width.value = window.innerWidth;

onMounted(() => {
    window.addEventListener('resize', onResize);
    getTokenValues();
})

onUnmounted(() => {
    window.removeEventListener('resize', onResize); 
})

const getTokenValues = () => {
    const ids = Object.keys(store.state.usdValues).join();
    axios({url: `https://api.coingecko.com/api/v3/simple/price?ids=${ids}&vs_currencies=usd`}).then(res => {
        if(res.status == 200)
            store.commit(Types.SET_USD_VALUES, (res.data));
    }).catch(e => console.log(e));
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