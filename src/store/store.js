import Vue from 'vue'
import Vuex from 'vuex'
import { v4 as uuidv4 } from 'uuid';
Vue.use(Vuex)

export const store = new Vuex.Store({
  state: {
    web3: {},
    isBetModal: false,
    openBets: [{
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
    {
      id: uuidv4(),
      coin: 'ada',
      displayName: 'shitPoster9000',
      bet: 15,
      usd: 37
    },
  ]
  },
  mutations: {
    toggleNewBetModal (state) {
      state.isBetModal = !state.isBetModal;
    },
    setWeb3 (state, web3){
      state.web3 = web3;
    },
    addBet (state, bet) {
      state.openBets.push(bet);
    }
  },
  getters: {
    getUSDConversion: (state) => (payload) => {
      return 69.420
    }
  }
})
