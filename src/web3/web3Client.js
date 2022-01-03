//Blockchain
import Web3 from 'web3'
import BetFactory from '../../build/contracts/BetFactory.json'
import Bet from '../../build/contracts/Bet.json'

import BetModel from '../models/bet';

import {store} from '../store/store';

const BET_FACTORY_ADDRESS = '0x1243a8e4F4Ec865c59C682d0ef75e6510e79Ad53';


export default class Web3Client{

    constructor(){
        this.web3;
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
            this.web3 = web3;
            this.web3.eth.handleRevert = true;

            this.accounts = await web3.eth.getAccounts();
            this.networkId = await web3.eth.net.getId();
            const deployedNetwork = BetFactory.networks[this.networkId];

            this.BetFactoryContract = new web3.eth.Contract(BetFactory.abi, deployedNetwork.address)
            console.log(this.BetFactoryContract)

            console.log(await this.getBetCounter());
            console.log(await this.getSelfBets());
        } else { 
            // Non-dapp browsers
            console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
        }
    }

    async getBetCounter(){
        return await this.BetFactoryContract.methods.betCounter().call();
    }

    async getSelfBets(){
        return await this.BetFactoryContract.methods.getSelfBets().call()
    }

    async getBetContract(address){
        const contract = new this.web3.eth.Contract(Bet.abi, address);
        const betData = await contract.methods.betData().call();
        console.log("Whats this")
        console.log(betData)
        return {
            contract,
            betData
        }
    }
}