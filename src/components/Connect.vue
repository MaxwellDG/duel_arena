<template>
    <div v-on:click="connectToMetamask" class="connectCon">
        <p  class='connect-button'>Connect -></p>
        <p v-if="account != 0">{{account}}</p>
        <p v-if="balance != 0">{{balance}}</p>
    </div>
</template>

<script>
export default {
    name: '',
    components: {
        
    },
    data() {
        return{
            account: 0,
            balance: 0
        }
    },
    methods: {
        connectToMetamask: async function(){
            // modern version of 'window.ethereum.enable()'
            await window.ethereum.send('eth_requestAccounts')
            try{
                const account = await this.$store.state.web3.eth.getAccounts()
                this.account = account[0]
                if(!!this.account){
                    const balance = await this.$store.state.web3.eth.getBalance(this.account)
                    this.balance = parseInt(balance)
                }
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
        top: 1rem;
        right: 1rem;
        background-color: purple;
        padding: 12px;
        border-radius: 5px;
    }

    p{
        border: none;
        background-color: transparent;
        color: white;
    }
</style>