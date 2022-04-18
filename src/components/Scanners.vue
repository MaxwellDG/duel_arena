<template>
    <div class='scanners'>
        <p class="find">Find Your Transaction</p>
        <div class="scanner-buttons">
            <div v-on:click="() => website = 'https://btc.com/'" class="scanner-icon-con">
                <img :src="BTC" alt="icon" :width=32 :height=32 />
            </div>
            <div v-on:click="() => website = 'https://etherscan.io/'" class="scanner-icon-con">
                <img :src="ETH" alt="icon" :width=32 :height=32 />
            </div>
            <div v-on:click="() => website = 'https://cardanoscan.io/'" class="scanner-icon-con">
                <img :src="ADA" alt="icon" :width=32 :height=32 />
            </div>
            <div v-on:click="() => website = 'https://solscan.io/'" class="scanner-icon-con">
                <img :src="SOL" alt="icon" :width=32 :height=32 />
            </div>
        </div>
        <div @click="handleCopy" class="website-con">
            <p class="website-text">{{website}}</p>
            <img :src="Copy" alt="icon" :width=12 :height=12 />
        </div>
    </div>
</template>

<script setup>
import BTC from '../../node_modules/cryptocurrency-icons/svg/black/btc.svg'
import ETH from '../../node_modules/cryptocurrency-icons/svg/black/eth.svg'
import ADA from '../../node_modules/cryptocurrency-icons/svg/black/ada.svg'
import SOL from '../../node_modules/cryptocurrency-icons/svg/black/sol.svg'
import Copy from '../icons/copy.svg';

import { ref } from 'vue';

const website = ref(`https://btc.com/`)

const handleCopy = () =>{
    navigator.clipboard.writeText(website.value);
    $toast.open({
        message: 'Copied to clipboard',
        type: 'info'
    })
}
</script>

<style scoped lang='less'>
    .scanners{
        position: absolute;
        bottom: 1rem;
        left: 0;
        width: 11rem;
        background-color: rgba(128, 0, 128, 0.3);
        border-top: 2px solid purple;
        border-right: 2px solid purple;
        border-bottom: 2px solid purple;
        border-top-right-radius: 3px;
        border-bottom-right-radius: 3px;
        padding: 5px;

        @media only screen and (max-width: 700px) {
            display: none;
        }
    }

    .scanner-buttons{
        display: flex;
        margin: 10px 0;
    }

    .find{
        color: white;
    }


    .website-con{
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: white;
        border-radius: 2px;
        cursor: pointer;
        padding: 2px 3px 1px 3px;

        .website-text{
            padding: 2px 5px;
        }

        img{
            display: none;
        }

        &:hover img{
            display:  inline;
        }
    }

    .scanner-icon-con{
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0 5px 0 5px;
        cursor: pointer;
    }

    .else{
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>