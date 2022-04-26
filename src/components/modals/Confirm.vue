<template>
    <div class="contact-con">
        <p>Are you sure you'd like to delete:</p>
        <p>{{`Wager: ${wager} ${token}`}}</p>
        <p>{{`Display name: ${displayName}`}}</p>
        <p>{{`Bet: ${isEven ? 'Even' : 'Odd'}`}}</p>
        <div>
            <button @click="closeModal">Cancel</button>
            <button @click="handleConfirm">Confirm</button>
        </div>
    </div>
</template>

<script setup>
import { computed, inject } from "@vue/runtime-core";
import { useStore } from "vuex";
import * as Types from '@/store/types'

const store = useStore();
const $web3 = inject('$web3')

const {wager, token, isEven, displayName, address} = store.state.modal.data

const closeModal = () => store.commit(Types.SET_MODAL, {modal: null})

const handleConfirm = () => {
    $web3.deleteBet(address)
}

</script>