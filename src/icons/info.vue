<template>
    <div class="info-con">
        <svg 
            @mouseover="handleMouseover" 
            @mouseout="handleMouseout" 
            width="24px" height="24px" 
            viewBox="0 0 24 24" 
            fill="none" 
            xmlns="http://www.w3.org/2000/svg"
        >
            <circle cx="12" cy="12" r="10" stroke="#b784c2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M12 6.01953V6" stroke="#b784c2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M12 10V18" stroke="#b784c2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        <div v-show="isShowing" class="box-con">
            <slot />
        </div>
    </div>
</template>

<script>
export default {
    name: '',
    components: {
        
    },
    data() {
        return{
            isShowing: false
        }
    },
    methods: {
        handleMouseover(){
            this.isShowing = true;
            document.body.style.cursor = 'pointer';
        },
        handleMouseout(){
            this.isShowing = false;
            document.body.style.cursor = 'default';
        }
    }
}
</script>

<style scoped>
    .info-con{
        position: relative;
        display: flex;
        flex-direction: row;
        align-items: center;
    }

    .box-con{
        position: absolute;
        top: 0;
        left: 26px;
        min-width: 100px;
        max-width: 200px;
        background-color: #b784c2;
        border-radius: 3px;
        padding: 2px 6px;
    }
</style>