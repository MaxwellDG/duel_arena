<template>
    <div class="contact-con">
      <h2>Which blockchain / wallet would you like to connect to?</h2>
      <ul class="chains-con">
        <li key=0>
          <div v-on:click="connectToMetamask" class="chain-con">
            <img :src="ETH" alt="icon" :width=32 :height=32 />
            <h3>Ethereum</h3>
            <h5>MetaMask</h5>
          </div>
        </li>
        <li key=1>
          <div v-on:click="connectToPhantom" class="chain-con">
            <img :src="SOL" alt="icon" :width=32 :height=32 />
            <h3>Solana</h3>
            <h5>Phantom</h5>
          </div>
        </li>
      </ul>
    </div>
</template>

<script setup>
import { inject } from 'vue';
import { useStore } from "vuex";
import * as Types from '@/store/types'
import ETH from '../../../node_modules/cryptocurrency-icons/svg/black/eth.svg'
import SOL from '../../../node_modules/cryptocurrency-icons/svg/black/sol.svg'

const store = useStore();

const $web3 = inject('$web3')

const closeModal = () => store.commit(Types.SET_MODAL, {modal: null})

const connectToMetamask = async () => {
    // modern version of 'window.ethereum.enable()'
    await window.ethereum.request({ method: 'eth_requestAccounts' });
    try{
        const accounts = await $web3.web3.eth.getAccounts()
        account.value = accounts[0]
        if(accounts[0]){
            const bal = await $web3.web3.eth.getBalance(account.value)
            balance.value = parseInt(bal)
        }
        store.commit(Types.TOGGLE_CONNECTED);
    } catch(e){
        console.log(e)
    }
}

const connectToPhantom = async () => {
  const { solana } = window;

  if (solana?.isPhantom) {
    const response = await solana.connect();
    console.log('Connected with Public Key:', response.publicKey.toString());
    setWalletAddress(response.publicKey.toString());
  }
};

</script>

<style scoped lang='less'>

  .chains-con{
    display: flex;
    list-style-type: none;
    padding: 0;
  }

  .chain-con{
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin: 1rem;

    img{
      margin-bottom: 0.5rem;
    }

    h3{
      margin: 0;
    }

    h5{
      margin: 0;
    }

    &:hover{
      cursor: pointer;
    }
  }

</style>