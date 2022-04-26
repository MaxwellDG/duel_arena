<template>
    <div class="contact-con">
        <p>Are you sure you'd like to delete:</p>
        <p>{{`Wager: ${wager} ${token}`}}</p>
        <p>{{`Display name: ${displayName}`}}</p>
        <p>{{`Bet: ${isEven ? 'Even' : 'Odd'}`}}</p>
        <div>
            <button @click="closeModal">Cancel</button>
            <button @click="store.state.modal.acceptFunc">Confirm</button>
        </div>
    </div>
</template>

<script setup>
import { useStore } from "vuex";
import * as Types from '@/store/types'

const store = useStore();

const {wager, token, isEven, displayName, address} = store.state.modal.data

const closeModal = () => store.commit(Types.SET_MODAL, {modal: null})

</script>