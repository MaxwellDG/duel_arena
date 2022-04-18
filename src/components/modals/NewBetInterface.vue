<template>
    <div id='newBetInterface'>
        <h2 style="margin: 0;">Create a new 50/50 bet</h2>
        <div class="row section" style="width: 100%;">
            <label for="displayName">Display&nbsp;Name&nbsp;</label>
            <input name="displayName" type="text" class="displayInput standard-input-text" v-model="formValues.displayName"/>
        </div>
        <div class="row section">
            <div class="row" style="align-items: center;">
                <label for="tokens">Token&nbsp;</label>
                <v-select 
                    class="standard-dropdown"
                    name="tokens"
                    label="label"
                    v-model="formValues.token" 
                    :clearable="false"
                    :options="[
                            { value: 'btc', label: 'BTC', gecko: 'bitcoin'},
                            { value: 'eth', label: 'ETH', gecko: 'ethereum'},
                            { value: 'ada', label: 'ADA', gecko: 'cardano'},
                            { value: 'sol', label: 'SOL', gecko: 'solana'},
                        ]"
                />
            </div>
            <div class="iconCon">
                <component :is="icon" :height="32" :width="32" />
            </div>
        </div>
        <div class="row section">
            <div class="field-con">
                <label for="wager">Wager</label>
                <input 
                    name="wager"    
                    class="standard-input-text"    
                    type="text"    
                    v-model="formValues.wager"
                    @input="handleBetChange"
                    @focus="handleFocus"
                />
            </div>
            <div class="field-con">
                <label for="usd">/ $USD</label>
                <input 
                    class="standard-input-text" 
                    type="text" 
                    name="usd"  
                    :value="formValues.inUSD"
                    @input="handleBetChange"
                    @focus="handleFocus"
                />
            </div>
        </div>
        <div class="row section">
            <!-- ENSURE that these values get changed to bool values before being sent  -->
            <p>Bet:</p>
            <Info style="margin: 0 .5rem;">
                <p>A number between 1-10 will be randomly generated. Bet whether it will be even or odd</p>
            </Info>
            <div class="row" style="margin-right: .5rem;">
                <label>Even</label>
                <input
                    id="even"
                    name="dudebro" 
                    type="radio" 
                    :checked="formValues.isEven"
                    :value="formValues.isEven" 
                    @change="handleRadioChange"
                />
            </div>
            <div class="row" style="margin-right: .5rem;">
                <label>Odd</label>
                <input 
                    id="odd"
                    name="dudebro" 
                    type="radio" 
                    :checked="!formValues.isEven"
                    :value="!formValues.isEven" 
                    @change="handleRadioChange"
                />
            </div>
            <button class="but-sub" style="width: 100%;" @click="handleSubmit">Submit</button>
        </div>
    </div>
</template>

<script>
import Info from '@/icons/info';
import 'vue-select/dist/vue-select.css';

import * as Types from '@/store/types';
import {mapMutations, mapState} from 'vuex';

export default {
    name: 'NewBetInterface',
    props: {
    },
    components: {
        Info,
    },
    data() {
        return{
            formValues: {
                token: { value: 'btc', label: 'BTC', gecko: 'bitcoin' },
                displayName: '',
                wager: 0,
                inUSD: 0,
                isEven: true
            },
            focusedField: null,
            icon: () => import(`../../../node_modules/cryptocurrency-icons/svg/color/${this.formValues.token.value}.svg`),
        }
    },
    computed: {
        ...mapState({
            web3Client: state => state.web3Client,
            usdValues: state => state.usdValues,
        }),
        handleUSDConversion(){
            return 
        },
    },
    watch: {
        'formValues.token'(newVal){
            this.icon = () => import(`../../../node_modules/cryptocurrency-icons/svg/color/${newVal.value}.svg`)
        }
    },
    methods: {
        ...mapMutations([
            Types.TOGGLE_NEW_BET_MODAL
        ]),
        handleBetChange(e){
            if(e.target.value){
                const val = e.target.value;
                const conversion = this.usdValues[this.formValues.token.gecko].usd;
                if(e.target.name == 'wager' && this.focusedField == 'wager'){
                    console.log('wager change', e.target.value);
                    this.formValues.inUSD = Math.round( ((val * conversion) + Number.EPSILON) * 100 ) / 100;
                    this.formValues.wager = val;
                } else if(e.target.name == 'usd' && this.focusedField == 'usd'){
                    console.log('usd change', e.target.value);
                    this.formValues.wager = (val / conversion).toFixed(9);
                    this.formValues.inUSD = val
                }
            }
        },
        txCallback(err, txHash){
            console.log('Err', err)
            console.log('TxHash', txHash)
        },
        handleRadioChange(e){
            this.formValues.isEven = e.target.id == 'even';
        },
        handleFocus(e){
            this.focusedField = e.target.name;
            if(e.target.value == 0)
                e.target.value = '';
        },
        async handleSubmit(){
            console.log("Formdaatata")
            console.log(this.formValues);
            const account = this.web3Client.accounts[0]

            const estimatedGas = await this.web3Client.BetFactoryContract.methods
                .createBet(parseFloat(this.formValues.wager), this.formValues.isEven, this.formValues.token.value, this.formValues.displayName)
                .estimateGas();
            console.log('Estimated gas', estimatedGas)

            
            // TODO this needs to actually send money
            const receipt = await this.web3Client.BetFactoryContract.methods
                .createBet(parseFloat(this.formValues.wager), this.formValues.isEven, this.formValues.token.value, this.formValues.displayName)
                .send({
                    from: account,
                    gas: estimatedGas * 2 // TODO this needs to be more accurate
            }, this.txCallback)

            // TODO get the return so you can stub in the new bet

            console.log(receipt)
            this.TOGGLE_NEW_BET_MODAL();
        }
    }
}
</script>

<style scoped>

    .field-con{
        width: 7.5rem;
    }

    .field-con input{
        width: 100%;
    }

    .section{
        margin: .5rem 0;
    }

    .token-drop{
        width: 200px;
    }

    input{
        height: 2rem;
        padding: 0 .5rem;
    }

    .iconCon{
        display: flex;
        justify-content: center;
        align-items: center;
    }


</style>