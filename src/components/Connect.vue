<template>
    <div class="connectCon">
        <button v-if="!isConnected" @click="connectToMetamask" class='connect butt'>Connect -></button>
        <div v-else-if="isConnected">
            <button class='disconnect butt'>Disconnect</button> 
            <p>{{account}}</p>
            <p>{{balance}}</p>
        </div>
    </div>
</template>

<script>
import {mapState, mapMutations} from 'vuex';

export default {
    name: '',
    components: {
        
    },
    data() {
        return{
            account: 0,
            balance: 0,
            isHovering: false,
        }
    },
    computed: {
        ...mapState({
            isConnected: state => state.isConnected
        }),
    },
    methods: {
        ...mapMutations(['toggleConnected']),
        connectToMetamask: async function(){
            // modern version of 'window.ethereum.enable()'
            await window.ethereum.send('eth_requestAccounts')
            try{
                const account = await this.$store.state.web3Client.web3.eth.getAccounts()
                this.account = account[0]
                if(!!this.account){
                    const balance = await this.$store.state.web3Client.web3.eth.getBalance(this.account)
                    this.balance = parseInt(balance)
                }
                this.toggleConnected();
            } catch(e){
                console.log(e)
            }
        }, 
    }
}
</script>

<style scoped>
    .connectCon{
        position: absolute;
        top: 0 ;
        right: 2rem;
        background-color: rgba(128, 0, 128, 0.3);
        border-left: 2px solid purple;
        border-right: 2px solid purple;
        border-bottom: 2px solid purple;
        border-bottom-left-radius: 3px;
        border-bottom-right-radius: 3px;
    }

    p{
        border: none;
        background-color: transparent;
        color: white;
        margin: 0;
    }

    .butt{
        border-radius: 5px;
        font-family: 'Runescape UF';
        cursor: pointer;
        padding: 5px 10px;
        font-size: 16px;
    }

    .connect{
        margin: 2rem 1rem 1rem 1rem;
        font-size: 22px;
        color: black;
        border: 2px solid rgba(128, 0, 128, 0.3);
        background-color: transparent;
    }

    .connect:hover{
        background-color: rgba(128, 0, 128, 0.7);
        color: white;
    }

    @media only screen and (max-width: 700px) {
        .connectCon {
            display: none;
        }
    }
</style>