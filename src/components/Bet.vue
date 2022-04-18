<template>
    <li class="bet">
        <div class="fifth" style="display: flex; align-items: center;">
            <p style="margin-right: 15px;">{{bet.token}}</p>
            <div style="height: 25px; width: 25px;">
                <!-- <component :is="icon"/> -->
            </div>
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
    </li>
</template>

<script setup>
import { reactive } from '@vue/reactivity'

const props = defineProps({
    bet: Object,
    isSelf: Boolean
})

// const icon = reactive(() => import(`../../node_modules/cryptocurrency-icons/svg/color/${this.bet.token}.svg`))

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