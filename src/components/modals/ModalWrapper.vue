<template>
    <div class="modal" @click="handleClose">
        <div @click.stop class="container">
            <div class="inner-container">
                <slot />
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'ModalWrapper',
    methods: {
        handleClose(){
            this.$emit('close-modal')
        }
    }
}
</script>

<style scoped>
    .modal{
        position: absolute;
        top: 0;
        right: 0;
        left: 0;
        bottom: 0;
        height: 100%;
        width: 100%;
        background-color: rgba(0, 0, 0, 0.3);
    }

    .container{
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        border: 2px solid purple;
        background-color: #deedf9;
        border-radius: 3px;
    }

    .inner-container{
        padding: 12px;
        background-color: rgba(128, 0, 128, 0.3);
    }
</style>