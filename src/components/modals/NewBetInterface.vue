<template>
    <div class='newBetInterface'>
        <h2 style="margin: 0;">Create a new 50/50 bet</h2>
        <div style="width: 100%;">
            <label for="displayName">Display&nbsp;Name&nbsp;</label>
            <input name="displayName" type="text" class="displayInput standard-input-text" v-model="formValues.displayName"/>
        </div>
        <div>
            <label for="tokens">Token&nbsp;</label>
            <div class="new-bet-token">
                <v-select 
                    class="new-token-dropdown standard-dropdown"
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
                <img :src="getIconSrc" :width="32" :height="32"/>   
            </div>
        </div>
        <div class="flex">
            <div class="field-con">
                <label for="wager">Wager</label>
                <input 
                    name="wager"    
                    class="standard-input-text"    
                    type="text"    
                    v-model="formValues.wager"
                    @input="handleWagerChange"
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
                    @input="handleWagerChange"
                    @focus="handleFocus"
                />
            </div>
        </div>
        <div class="flex align">
            <!-- ENSURE that these values get changed to bool values before being sent  -->
            <Info :leftAlign="true">
                <p>A number between 1-10 will be randomly generated. Bet whether it will be even or odd</p>
            </Info>
            <p>Bet:</p>
            <div class="bet-buttons">
                <button id="even" :class="formValues.isEven ? 'selected-button' : 'unselected-button'" @click="handleBetChange">EVEN</button>
                <button id="odd" :class="formValues.isEven ? 'unselected-button' : 'selected-button'" @click="handleBetChange">ODD</button>
            </div>
        </div>
        <button class="but-sub" style="width: 100%;" @click="handleSubmit">Submit</button>
    </div>
</template>

<script setup>
import Info from '@/icons/info';
import Bet from '@/models/bet'
import Web3 from 'web3'

import * as Types from '@/store/types';
import { reactive, ref } from '@vue/reactivity';
import { computed, inject, nextTick } from '@vue/runtime-core';
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

const getIconSrc = computed(() => require(`@/../node_modules/cryptocurrency-icons/svg/color/${formValues.token.value}.svg`))

const handleWagerChange = (e) => {
    if(e.target.value){
        const val = e.target.value;
        const conversion = store.state.usdValues[formValues.token.gecko].usd;
        if(e.target.name == 'wager' && focusedField.value == 'wager'){
            formValues.USD = Math.round( ((val * conversion) + Number.EPSILON) * 100 ) / 100;
            formValues.wager = val;
        } else if(e.target.name == 'usd' && focusedField.value == 'usd'){
            formValues.wager = (val / conversion).toFixed(9);
            formValues.USD = val
        }
    }
}

const txCallback = (err, txHash) => console.log('Err', err, 'TxHash:', txHash);
        
const handleBetChange = (e) => formValues.isEven = e.target.id == 'even';

const handleFocus = (e) => {
    focusedField.value = e.target.name;
    if(e.target.value == 0)
        e.target.value = '';
}

const handleSubmit = async () => {
    store.commit(Types.SET_MODAL, {modal: null});

    const account = $web3.accounts[1] // TODO this is only for testing. Get real connected account later

    const estimatedGas = await $web3.BetFactoryContract.methods
        .createBet(parseFloat(formValues.wager), formValues.isEven, formValues.token.value, formValues.displayName)
        .estimateGas({
            from: account,
            value: Web3.utils.toWei(formValues.wager),
        });

    // TODO this needs to actually send money
    const receipt = await $web3.BetFactoryContract.methods
        .createBet(parseFloat(formValues.wager), formValues.isEven, formValues.token.value, formValues.displayName)
        .send({
            from: account,
            value: Web3.utils.toWei(formValues.wager),
            gas: estimatedGas * 2 // TODO this needs to be more accurate
    }, txCallback)

    // Stubs in new self bet
    const createdBet = receipt.events?.CreatedBet
    if(createdBet){
        store.commit(Types.ADD_SELF_BET, new Bet({
                address: createdBet.returnValues[0],
                ...createdBet.returnValues
            }
        ));
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