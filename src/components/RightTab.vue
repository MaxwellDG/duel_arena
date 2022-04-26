<template>
    <div :class="getClasses" class="clipped-button" :style="`bottom: ${this.index == 2 ? '1rem' : this.index == 1 ? '80px' : '133px'}`">
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
