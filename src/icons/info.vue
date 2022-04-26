<template>
    <div class="info-con">
        <svg 
            width="24px" height="24px" 
            viewBox="0 0 24 24" 
            fill="none" 
            xmlns="http://www.w3.org/2000/svg"
        >
            <circle cx="12" cy="12" r="10" stroke="#b784c2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M12 6.01953V6" stroke="#b784c2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M12 10V18" stroke="#b784c2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        <!-- TODO get this aligned properly -->
        <div v-if="!props.leftAlign" class="box-con">
            <slot />
        </div>
    </div>
</template>

<script setup>
import { ref } from '@vue/reactivity';

const isShowing = ref(false)

const props = defineProps({
    leftAlign: Boolean
})

</script>
