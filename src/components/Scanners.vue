<template>
    <div class='scanners'>
        <p class="find">Find Your Transaction</p>
        <div class="scanner-buttons">
            <div v-on:click="() => website = 'https://btc.com/'" class="scanner-icon-con">
                <BTC :width=32 :height=32 />
            </div>
            <div v-on:click="() => website = 'https://etherscan.io/'" class="scanner-icon-con">
                <ETH :width=32 :height=32 />
            </div>
            <div v-on:click="() => website = 'https://cardanoscan.io/'" class="scanner-icon-con">
                <ADA :width=32 :height=32 />
            </div>
            <div v-on:click="() => website = 'https://solscan.io/'" class="scanner-icon-con">
                <SOL :width=32 :height=32 />
            </div>
        </div>
        <div 
            @click="handleCopy"
            @mouseover="() => isHoverScanner = true"
            @mouseout="() => isHoverScanner = false" 
            class="website-con"
        >
            <p class="website-text">{{website}}</p>
            <Copy v-if="isHoverScanner"/>
        </div>
    </div>
</template>

<script>
import BTC from '../../node_modules/cryptocurrency-icons/svg/black/btc.svg'
import ETH from '../../node_modules/cryptocurrency-icons/svg/black/eth.svg'
import ADA from '../../node_modules/cryptocurrency-icons/svg/black/ada.svg'
import SOL from '../../node_modules/cryptocurrency-icons/svg/black/sol.svg'
import Copy from '../icons/copy.svg';


export default {
    name: '',
    components: {
        BTC,
        ETH,
        ADA,
        SOL,
        Copy
    },
    data() {
        return{
            expanded: false,
            website: `https://btc.com/`,
            isHoverScanner: false,
        }
    },
    methods: {
        handleCopy(){
            navigator.clipboard.writeText(this.website);
            this.$toast.open({
                message: 'Copied to clipboard',
                type: 'info'
            })
        }
    }
}
</script>

<style scoped>
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
    }

    .scanner-buttons{
        display: flex;
        margin: 10px 0;
    }

    .find{
        color: white;
    }

    .website-text{
        padding: 2px 5px;
    }

    .website-con{
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: white;
        border-radius: 2px;
        cursor: pointer;
        padding: 2px 3px 1px 3px;
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

    @media only screen and (max-width: 700px) {
        .scanners {
            display: none;
        }
    }

</style>