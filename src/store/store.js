import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export const store = new Vuex.Store({
  state: {
    web3: {},
    isBetModal: false
  },
  mutations: {
    toggleNewBetModal (state) {
      state.isBetModal = !state.isBetModal;
    },
    setWeb3 (state, web3){
      state.web3 = web3;
    }
  },
  getters: {
    getUSDConversion: (state) => (payload) => {
      return 69.420
    }
  }
})
