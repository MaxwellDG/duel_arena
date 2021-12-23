<template>
    <div class='scanners'>
        <div class="find">
            <p>Find Your Transaction</p>
        </div>
        <div class="scanner-buttons">
            <div v-on:click="() => handleClick('BTC')" class="scanner-icon-con">
                <BTC :width=32 :height=32 />
            </div>
            <div v-on:click="() => handleClick('ETH')" class="scanner-icon-con">
                <ETH :width=32 :height=32 />
            </div>
            <div v-on:click="() => handleClick('ADA')" class="scanner-icon-con">
                <ADA :width=32 :height=32 />
            </div>
            <div v-on:click="() => handleClick('SOL')" class="scanner-icon-con">
                <SOL :width=32 :height=32 />
            </div>
        </div>
        <div @mouseover="() => isHoverScanner = true" @mouseout="() => isHoverScanner = false" class="website-con">
            <p class="website-text">{{website}}</p>
            
        </div>
    </div>
</template>

<script>
import BTC from '../../node_modules/cryptocurrency-icons/svg/black/btc.svg'
import ETH from '../../node_modules/cryptocurrency-icons/svg/black/eth.svg'
import ADA from '../../node_modules/cryptocurrency-icons/svg/black/ada.svg'
import SOL from '../../node_modules/cryptocurrency-icons/svg/black/sol.svg'


export default {
    name: '',
    components: {
        BTC,
        ETH,
        ADA,
        SOL
    },
    data() {
        return{
            expanded: false,
            website: `https://btc.com/`,
            isHover: false,
        }
    },
    methods: {
        handleClick(type){
            switch(type){
                case 'BTC': {
                    this.website = `https://btc.com/`
                    break;
                }
                case 'ETH': {
                    this.website = `https://etherscan.io/`
                    break;
                }
                case 'ADA': {
                    this.website = `https://cardanoscan.io/`
                    break;
                }
                case 'SOL': {
                    this.website = `https://solscan.io/`
                    break;
                }
            }
        },
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
        background-color: white;
        border-radius: 2px;
        cursor: pointer;
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