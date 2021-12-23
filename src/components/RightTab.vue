<template>
    <div :class="getClasses" :style="`bottom: ${this.index == 2 ? '1rem' : this.index == 1 ? '80px' : '133px'}`">
        <p>{{text}}</p>
    </div>
</template>

<script>
export default {
    name: 'RightTab',
    props: {
        text: String,
        index: Number,
    },
    components: {
        
    },
    data() {
        return{
            
        }
    },
    computed: {
        getClasses(){
            return this.index == 2 ? 'tab right-tab bottom-tab' : 'tab right-tab top-tab'
        },
    }
}
</script>

<style scoped>
    .tab{
        position: absolute;
        color: black;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
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

    p{
        margin: 0;
    }

    @media only screen and (max-width: 700px) {
        .tab {
            display: none;
        }
    }

</style>