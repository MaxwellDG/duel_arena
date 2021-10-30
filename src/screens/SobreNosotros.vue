<template>
    <div id='container'>
        <p class="white-text">- We have no interest in continuing as a company, our goal is to become an automated public utility -</p>
        <p class="white-text">
            Once upon a time, there were societies that created infrastructure solely for the benefit of each other. They created roads
            and bridges because they and their neighbours needed to get across - and nothing more. We strive to do the same. We are a small team
            of professionals that have full-time employment elsewhere. All of us have opted to dedicate our free-time to creating this project.
            We are building the roads and bridges that will connect us through the blockchain. 
        </p>
        <div class="members-con">
            <h3 class="white-text">Core</h3>
            <div class="miembres-con">
                <Miembre :name="`Maxwell`" :role="`Software Development`"/>
                <Miembre :name="`Joha`" :role="`Civil Law`"/>
                <Miembre :name="`Deimer`" :role="`Accounting`"/>
                <Miembre :name="`Dhayanna`" :role="`Marketing`"/>
                <Miembre :name="`Daniela`" :role="`Relations`"/>
            </div>
            <h3 class="white-text">Participating Store Owners</h3>
            <div class="miembres-con">
                <Miembre :name="`Hector`" />
                <Miembre :name="`Juan-Pablo`" />
                <Miembre :name="`Jesus`" />
            </div>
            <h3 class="white-text">Partners</h3>
            <div class="miembres-con">
                <Miembre :name="`SMART`" />
                <Miembre :name="`Government of El Salvador`" />
            </div>
        </div>
    </div>
</template>

<script>
import Miembre from '../components/Miembre.vue';

export default {
    name: 'SobreNosotros',
    components: {
        Miembre
    },
    data() {
        return{
            
        }
    },
}
</script>

<style scoped>
    #container{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        background-color: #4485ac;
    }
    .members-con{
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    .miembres-con{
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: space-evenly;
        align-items: center;
    }
</style>