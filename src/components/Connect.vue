<template>
    <div class="connectCon">
        <button v-if="!store.state.isConnected" @click="store.commit(Types.SET_MODAL, { modal: 'Connect' });" class='connect butt'>
            Connect ->
        </button>
        <div class="connected-con" v-else>
            <button class='disconnect butt'>Disconnect</button> 
            <div class="wallet-info">
                <p class="info-label">Blockchain: </p>
                <p class="account">&nbsp;{{store.state.blockchain}}</p>
            </div>
            <div class="wallet-info">
                <p class="info-label">Account: </p>
                <p class="account">&nbsp;{{store.state.account}}</p>
            </div>
            <div class="wallet-info">
                <p class="info-label">Balance: </p>
                <p class="balance">&nbsp;{{store.state.balance}}</p>
            </div>
        </div>
    </div>
</template>

<script setup>

import { useStore } from 'vuex'
import * as Types from '@/store/types';

const store = useStore();

</script>

<style scoped lang='less'>
    .connectCon{
        position: absolute;
        top: 0 ;
        right: 2rem;
        background-color: rgba(128, 0, 128, 0.3);
        border-left: 2px solid rgba(128, 0, 128, 0.7);
        border-right: 2px solid rgba(128, 0, 128, 0.7);
        border-bottom: 2px solid rgba(128, 0, 128, 0.7);
        border-bottom-left-radius: 3px;
        border-bottom-right-radius: 3px;
    }

    .wallet-info{
        display: flex;
        flex-direction: column;
        align-items: center;
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
        // max-width: 100px;   
    }

    .account{
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
    }

    .balance{
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
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