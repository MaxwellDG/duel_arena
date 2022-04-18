import { createStore } from 'vuex'
import * as Types from '@/store/types';

export default createStore({
  state: {
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
