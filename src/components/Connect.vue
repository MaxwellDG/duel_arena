<template>
    <div class="connectCon">
        <button v-if="!isConnected" @click="connectToMetamask" class='connect butt'>Connect -></button>
        <div class="connected-con" v-else-if="isConnected">
            <button class='disconnect butt'>Disconnect</button> 
            <div class="info-con">
                <p class="info-label">Account: </p>
                <p class="account">&nbsp;{{account}}</p>
            </div>
            <div class="info-con">
                <p class="info-label">Balance: </p>
                <p class="balance">&nbsp;{{balance}}</p>
            </div>
        </div>
    </div>
</template>

<script>
import {mapState, mapMutations} from 'vuex';
import * as Types from '@/store/types';

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
        ...mapMutations([
            Types.TOGGLE_CONNECTED
        ]),
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
                this.TOGGLE_CONNECTED();
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

    .info-con{
        display: flex;
        overflow: hidden;
        white-space: nowrap;   
        text-overflow: ellipsis;
    }

    .info-label{
        color: black;
    }

    .disconnect{
        background-color: purple;
        width: 100%;
        color: white;
        margin-bottom: 5px;
    }

    .connected-con{
        display: flex;
        flex-direction: column;
        justify-content: center;
        padding: 5px 25px;
        max-width: 100px;   
    }

    .account{
        text-overflow: ellipsis;
    }

    .balance{
        text-overflow: ellipsis;
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