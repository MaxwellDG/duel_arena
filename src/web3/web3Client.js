//Blockchain
import Web3 from 'web3'
import BetFactory from '../../build/contracts/BetFactory.json'
import Bet from '../../build/contracts/Bet.json'

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
        } else { 
            // Non-dapp browsers
            console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
        }
    }

    txCallback(err, txHash){
        console.log('Err', err, 'TxHash:', txHash);
    }

    async getBetCounter(){
        return await this.BetFactoryContract.methods.betCounter().call();
    }

    async getSelfBets(pageNum){
        return await this.BetFactoryContract.methods.get25Bets('self', pageNum, '').call({
            from: this.accounts[1] // TODO change this
        });
    }

    async getOpenBets(filter, pageNum, input){
        return await this.BetFactoryContract.methods.get25Bets(filter, pageNum, input).call({
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