//Blockchain
import Web3 from 'web3'
import BetFactory from '../../build/contracts/BetFactory.json'

import {store} from '../store/store';

const BET_FACTORY_ADDRESS = '0x1243a8e4F4Ec865c59C682d0ef75e6510e79Ad53';


export default class Web3Client{

    constructor(){
        this.accounts;
        this.networkId;

        this.BetFactoryContract;

        this.init();
    }

    async init(){
        if (typeof window.ethereum !== 'undefined') {   
            // Truffle Ganache
            const web3 = new Web3(new Web3.providers.HttpProvider('http://127.0.0.1:7545'))  
            // Live
            // const web3 = new Web3(Web3.givenProvider || new Web3.providers.HttpProvider('http://localhost:7545'))

            this.accounts = await web3.eth.getAccounts();
            this.networkId = await web3.eth.net.getId();
            const deployedNetwork = BetFactory.networks[this.networkId];

            store.commit('setWeb3', web3);
            this.BetFactoryContract = new web3.eth.Contract(BetFactory.abi, deployedNetwork.address)
            console.log(this.BetFactoryContract)

            try{
                const betCounter = await this.BetFactoryContract.methods.betCounter().call();
                console.log('Bet Counter is at: ', betCounter);
            } catch (e){
                console.log('errrr', e)
            }

            try{
                const self = await this.BetFactoryContract.methods.getSelfBets().call()
                console.log('READING BETS');
                console.log(self)
            } catch(e){
                console.log('got and error:')
                console.log(e);
            }
        } else { 
            // Non-dapp browsers
            console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
        }
    }
    

}