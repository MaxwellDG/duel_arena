<template>
    <li class="bet">
        <div class="fifth" style="display: flex; align-items: center;">
            <p style="margin-right: 15px;">{{bet.token}}</p>
            <img :src="icon" :width="15" :height="15" />
        </div>
        <div class="fifth">
            <p>{{bet.displayName}}</p>
        </div>
        <div class="fifth" style="display: flex;">
            <p>{{bet.wager}}</p>
            <p class="usd">{{bet.USD}}</p>
        </div>
        <div class="fifth">
            <p>{{bet.isEven ? 'Even' : 'Odd'}}</p>
        </div>
        <div v-if="!isSelf" class="fifth bet-div">
            <button @click="handleBet" class="bet-button">BET</button>
        </div>
        <div v-else>
            <button @click="openConfirmModal">X</button>
        </div>
    </li>
</template>

<script setup>
import { computed, inject } from '@vue/runtime-core'
import { useStore } from 'vuex'
import * as Types from "@/store/types"

const store = useStore();
const $web3 = inject('$web3')

const props = defineProps({
    bet: Object,
    isSelf: Boolean
})

const icon = computed(() => require(`../../node_modules/cryptocurrency-icons/svg/color/${props.bet.token}.svg`))

const openConfirmModal = () => store.commit(Types.SET_MODAL, {
    modal: 'Confirm', 
    data: props.bet,
    acceptFunc: async () => {
        store.commit(Types.SET_MODAL, {modal: null});
        await $web3.deleteBet(props.bet.address)
        store.commit(Types.REMOVE_SELF_BET, props.bet.address)
    }
})

</script>

<style scoped>
    .bet{
        display: flex;
        justify-content: space-around;
        align-items: center;
        background-color: white;
        border-radius: 4px;
        padding: 5px 15px;
        margin: 0 0 10px 0;
    }

    .bet-button{
        cursor: pointer;
        font-size: 14px;
        background-color: rgba(128, 0, 128, 0.3);
        border: 2px solid purple;
        color: black;
        font-weight: 600;
    }

    .usd{
        color: grey;
        margin-left: 10px;
    }

    .fifth{
        width: 20%;
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>