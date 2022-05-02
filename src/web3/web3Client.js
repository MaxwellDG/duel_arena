//Blockchain
import Web3 from 'web3'
import BetFactory from '../../build/contracts/BetFactory.json'
import Bet from '../../build/contracts/Bet.json'

import BetModel from "@/models/bet";

//Util
import store from "@/store/store";
import * as Types from "@/store/types";
import { SEARCH_FILTERS } from "@/util/constants"

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
            const allBets = await this.initFirstBets(0, SEARCH_FILTERS.ALL)
            store.commit(Types.SET_OPEN_BETS, allBets)
            const selfBets = await this.initFirstBets(0, SEARCH_FILTERS.SELF)
            store.commit(Types.SET_SELF_BETS, selfBets)
            
        } else { 
            // Non-dapp browsers
            console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
        }
    }

    async initFirstBets(pageNum, filter){
        const contractAddresses = await this.getBets(pageNum, filter);
        return await Promise.all(contractAddresses.map(async j => {
            const betContract = await this.getBetContract(j);
            return new BetModel({
                address: betContract.contract._address,
                ...betContract.betData
            });
        }));
    }

    txCallback(err, txHash){
        console.log('Err', err, 'TxHash:', txHash);
    }

    async getBets(pageNum, filterNum, input = ''){
        return await this.BetFactoryContract.methods.get25Bets(pageNum, filterNum, input).call({
            from: this.accounts[1] // TODO change this
        });
    }

    async deleteBet(address){
        const estimatedGas = await this.BetFactoryContract.methods.deleteBet(address).estimateGas();
        await this.BetFactoryContract.methods.deleteBet(address).send({
            from: this.accounts[1], // TODO get the real one later
            gas: estimatedGas * 3 // TODO this needs to be more accurate
        }, this.txCallback)
    }

    async getBetContract(address){
        const contract = new this.web3.eth.Contract(Bet.abi, address);
        const betData = await contract.methods.betData().call();
        return {
            contract,
            betData
        }
    }
}