<template>
    <div id='scanners'>
        <div class="scanner-buttons">
            <div>
                <img src="/images/research.png"  :width="50" :height="50"/>
            </div>
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
        <div class="website-con">
            <p>{{website}}</p>
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
            website: `https://btc.com/`
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
        }
    }
}
</script>

<style scoped>
    #container{
        
    }

    #scanners{
        position: absolute;
        bottom: 1rem;
        left: 1rem;
    }

    .scanner-buttons{
        display: flex;
    }
    .website-con{
        background-color: white;
        border-bottom-left-radius: 5px;
        border-bottom-right-radius: 5px;
    }

    .scanner-icon-con{
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0 5px 0 5px;
    }

    .else{
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>