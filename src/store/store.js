import Vue from 'vue'
import Vuex from 'vuex'

import * as Types from '@/store/types';


Vue.use(Vuex)


export default new Vuex.Store({
  state: {
    web3Client: undefined,
    isBetModal: false,
    isConnected: false,
    selfBets: [],
    usdValues: {
      bitcoin: 0,
      ethereum: 0,
      cardano: 0,
      solana: 0,
      safemoon: 0
   }
  },
  mutations: {
    [Types.TOGGLE_NEW_BET_MODAL] (state) {
      state.isBetModal = !state.isBetModal;
    },
    [Types.SET_WEB3_CLIENT] (state, web3Client){
      state.web3Client = web3Client;
    },
    [Types.TOGGLE_CONNECTED] (state) {
      state.isConnected = !state.isConnected;
    },
    [Types.SET_USD_VALUES] (state, payload) {
      state.usdValues = payload;
    },

    // Bets
    [Types.SET_SELF_BETS] (state, payload){
      state.selfBets = payload;
    },
    [Types.ADD_BET] (state, payload){
      state.selfBets = payload;
    },
  },
  getters: {

  }
})
