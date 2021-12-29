import Vue from 'vue'
import Vuex from 'vuex'
import Bet from '../models/bet';

Vue.use(Vuex)

const DEFAULT_BETS = []

for (let i = 0; i < 10; i++) {
  DEFAULT_BETS.push(new Bet({
    coin: 'ada',
    bet: (i + 1) * 5,
    inUSD: (i + 1) * 5 * 2
  }))
}

export const store = new Vuex.Store({
  state: {
    web3: undefined,
    isBetModal: false,
    isConnected: false,
    openBets: DEFAULT_BETS,
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
    },
    toggleConnected (state) {
      state.isConnected = !state.isConnected;
    }
  },
  getters: {
    getUSDConversion: (state) => (payload) => {
      return 69.420
    }
  }
})
