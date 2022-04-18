<template>
    <div :class="getClasses" :style="`bottom: ${this.index == 2 ? '1rem' : this.index == 1 ? '80px' : '133px'}`">
        <p>{{text}}</p>
    </div>
</template>

<script setup>
import { computed, defineProps } from '@vue/runtime-core'

const props = defineProps({
    text: String,
    index: Number,
})

const getClasses = computed(() => props.index == 2 ? 'tab right-tab bottom-tab' : 'tab right-tab top-tab')

</script>

<style scoped lang="less">
    .tab{
        position: absolute;
        color: black;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;

        @media only screen and (max-width: 700px) {
            display: none;
        }
    }

    .bottom-tab{
        width: 11rem;
        height: 35px;
        font-size: 24px;
    }

    .top-tab{
        height: 25px;
        font-size: 16px;
    }

    .right-tab{
        right: 0;
        padding: 5px;
        cursor: pointer;
        background-color: rgba(128, 0, 128, 0.3);
        border-top: 2px solid purple;
        border-left: 2px solid purple;
        border-bottom: 2px solid purple;
        border-top-left-radius: 3px;
        border-bottom-left-radius: 3px;
    }

    p{
        margin: 0;
    }

</style>