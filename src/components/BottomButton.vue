<template>
    <div class="bot-button">
        <slot />
    </div>
</template>

<script setup>

</script>

<style scoped>
    .bot-button{
        border: 2px solid purple;
        border-radius: 5px;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 20%;
        padding: 10px;
        background-color: rgba(128, 0, 128, 0.3);
    }
</style>