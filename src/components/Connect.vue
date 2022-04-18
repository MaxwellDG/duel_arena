<template>
    <div class="connectCon">
        <button v-if="!store.state.isConnected" @click="connectToMetamask" class='connect butt'>Connect -></button>
        <div class="connected-con" v-else>
            <button class='disconnect butt'>Disconnect</button> 
            <div class="info-con">
                <p class="info-label">Account: </p>
                <p class="account">&nbsp;{{account}}</p>
            </div>
            <div class="info-con">
                <p class="info-label">Balance: </p>
                <p class="balance">&nbsp;{{balance}}</p>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, inject } from 'vue';

import { useStore } from 'vuex'
import * as Types from '@/store/types';

const store = useStore();

const $web3 = inject('$web3')

const account = ref()
const balance = ref()

const connectToMetamask = async () => {
    // modern version of 'window.ethereum.enable()'
    await window.ethereum.send('eth_requestAccounts')
    try{
        const accounts = await $web3.web3.eth.getAccounts()
        account.value = accounts[0]
        if(accounts[0]){
            const bal = await $web3.web3.eth.getBalance(account.value)
            balance.value = parseInt(bal)
        }
        store.commit(Types.TOGGLE_CONNECTED);
    } catch(e){
        console.log(e)
    }
}

</script>

<style scoped lang='less'>
    .connectCon{
        position: absolute;
        top: 0 ;
        right: 2rem;
        background-color: rgba(128, 0, 128, 0.3);
        border-left: 2px solid purple;
        border-right: 2px solid purple;
        border-bottom: 2px solid purple;
        border-bottom-left-radius: 3px;
        border-bottom-right-radius: 3px;
    }

    .info-con{
        display: flex;
        overflow: hidden;
        white-space: nowrap;   
        text-overflow: ellipsis;
    }

    .info-label{
        color: black;
    }

    .disconnect{
        background-color: purple;
        width: 100%;
        color: white;
        margin-bottom: 5px;
    }

    .connected-con{
        display: flex;
        flex-direction: column;
        justify-content: center;
        padding: 5px 25px;
        max-width: 100px;   
    }

    .account{
        text-overflow: ellipsis;
    }

    .balance{
        text-overflow: ellipsis;
    }

    p{
        border: none;
        background-color: transparent;
        color: white;
        margin: 0;
    }

    .butt{
        border-radius: 5px;
        font-family: 'Runescape UF';
        cursor: pointer;
        padding: 5px 10px;
        font-size: 16px;
    }

    .connect{
        margin: 2rem 1rem 1rem 1rem;
        font-size: 22px;
        color: black;
        border: 2px solid rgba(128, 0, 128, 0.3);
        background-color: transparent;
    }

    .connect:hover{
        background-color: rgba(128, 0, 128, 0.7);
        color: white;
    }

    @media only screen and (max-width: 700px) {
        .connectCon {
            display: none;
        }
    }
</style>