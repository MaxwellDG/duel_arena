<template>
    <div class="bet-con">
        <div class="filterCon">
            <p class="filterText">Filter</p>
            <input type="text" :value="filter" class="filterInput"/>
        </div>
        <div class="list-con">
            <ul class='bettingBoard'>
                <OpenBet v-for="bet in openBets" :bet="bet" :key="bet.id" />
            </ul>
        </div>
    </div>
</template>

<script>
import { mapState } from 'vuex'
import OpenBet from './Bet.vue'

export default {
    name: 'BettingBoard',
    components: {
        OpenBet
    },
    mounted(){
        this.getSelfBets();
    },
    data() {
        return{
            filter: 'ALL',
            openBets: []
        }
    },
    computed: {
        ...mapState({
            web3Client: state => state.web3Client
        }),
    },
    methods: {
        // TODO currently retrieving self bets cause it's simpler. Should be all bets in final.
        async getSelfBets(){
            let count = 0;
            let interval = setInterval(async () => {
                if(count >= 3){
                    clearInterval(interval) // Give up
                    // TODO Some kind of error alert
                }
                if(this.web3Client.BetFactoryContract){
                    console.log("we got here")
                    try{
                        const selfBetAddresses = await this.web3Client.getSelfBets();
                        selfBetAddresses.forEach(async j => {
                            console.log("Self bet")
                            const betContract = await this.web3Client.getBetContract(j);
                            console.log(betContract)
                            this.openBets.push(betContract.betData);
                        });
                        clearInterval(interval)
                    } catch (e) {
                        count++
                    }
                } else {
                    count++;
                } 
            }, 1000)
        }
    }
}
</script>

<style scoped>
    .filterCon{
        display: flex;
        align-items: center;
        margin: 30px 0 10px 0;
    }

    .filterInput{
        background-color: transparent;
        border: none;
        padding: 2px 5px;
    }

    .filterText{
        margin: 0;
    }

    .bet-con{
        flex: 1;
        display: flex;
        flex-direction: column;
        width: 100%;
        padding: 0 10px 10px 10px;
        overflow: hidden;
    }

    .list-con{
        scrollbar-color: rgba(128, 0, 128, 0.3) transparent;
        scrollbar-width: thin;
        flex: 1;
        overflow-y: auto;
        padding: 0 17px;
    }
    
    .bettingBoard{
        height: 0;
        margin: 0;
        padding: 0;
    }
</style>