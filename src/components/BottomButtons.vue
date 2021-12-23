<template>
    <div class="bottomButtons">
        <BottomButton>
        
        </BottomButton>
        <BottomButton>
        
        </BottomButton>
        <BottomButton>
            <button>Connect</button>
        </BottomButton>
        <BottomButton>
        
        </BottomButton>
        <BottomButton>
        
        </BottomButton>
    </div>
</template>

<script>
import BottomButton from './BottomButton.vue'

export default {
    name: '',
    components: {
        BottomButton,
    },
    data() {
        return{
            
        }
    },
}
</script>

<style scoped>
    .bottomButtons{
        width: 100%;
        display: flex;
        
    }
</style>