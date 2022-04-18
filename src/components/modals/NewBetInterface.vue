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
                <img :src="icon" alt="icon"/>
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
                    :value="formValues.USD"
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

<script setup>
import Info from '@/icons/info';

import * as Types from '@/store/types';
import { reactive, ref } from '@vue/reactivity';
import { computed, inject } from '@vue/runtime-core';
import { useStore } from 'vuex';

const store = useStore();
const $web3 = inject('$web3')

const formValues = reactive({
    token: { value: 'btc', label: 'BTC', gecko: 'bitcoin' },
    displayName: '',
    wager: 0,
    USD: 0,
    isEven: true
})

const focusedField = ref(null);

const icon = computed(() => {
    console.log('changing', formValues.token.value)
    return import(`../../../node_modules/cryptocurrency-icons/svg/color/${formValues.token.value}.svg`)
})

const handleBetChange = (e) => {
    if(e.target.value){
        const val = e.target.value;
        const conversion = store.state.usdValues[formValues.token.gecko].usd;
        if(e.target.name == 'wager' && focusedField == 'wager'){
            formValues.USD = Math.round( ((val * conversion) + Number.EPSILON) * 100 ) / 100;
            formValues.wager = val;
        } else if(e.target.name == 'usd' && focusedField == 'usd'){
            formValues.wager = (val / conversion).toFixed(9);
            formValues.USD = val
        }
    }
}

const txCallback = (err, txHash) => console.log('Err', err, 'TxHash:', txHash);
        
const handleRadioChange = (e) => formValues.isEven = e.target.id == 'even';

const handleFocus = (e) => {
    focusedField = e.target.name;
    if(e.target.value == 0)
        e.target.value = '';
}

const handleSubmit = async () => {
    const account = $web3.accounts[0]

    const estimatedGas = await $web3.BetFactoryContract.methods
        .createBet(parseFloat(formValues.wager), formValues.isEven, formValues.token.value, formValues.displayName)
        .estimateGas();

    // TODO this needs to actually send money
    const receipt = await $web3.BetFactoryContract.methods
        .createBet(parseFloat(formValues.wager), formValues.isEven, formValues.token.value, formValues.displayName)
        .send({
            from: account,
            gas: estimatedGas * 2 // TODO this needs to be more accurate
    }, txCallback)

    // TODO get the return so you can stub in the new bet

    store.commit(Types.TOGGLE_NEW_BET_MODAL);
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