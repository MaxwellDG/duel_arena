<template>
    <div class="banner">
        <div class="left">
            <h1 class="banner-text">50 / 50 Bets -> 2x</h1>
            <Info>
                <p class="fee">* 1% service fee from winner</p>
            </Info>
        </div>
    </div>
</template>

<script>
import Info from '../icons/info.vue';

export default {
    name: 'Banner',
    components: {
        Info,
    },
    data() {
        return{
            
        }
    },
}
</script>

<style scoped>
    .banner{
        display: flex;
        align-items: center;
        padding: 1rem;
    }
    .left{
        display: flex;
        align-items: flex-start;
    }
    .banner-text{
        font-family: 'RuneScape UF';
        margin: 0 5px 0 30px;
        font-size: 60px;
    }
    .fee{
        margin: 0;
        font-size: 12px;
        font-family: 'RuneScape UF';
    }
</style>