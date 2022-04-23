import { createStore } from 'vuex'
import * as Types from '@/store/types';

export default createStore({
  state: {
    modal: null,
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
    [Types.TOGGLE_MODAL] (state, payload) {
      state.modal = payload;
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
    [Types.ADD_SELF_BET] (state, payload){
      state.selfBets.push(payload);
    },
  },
  getters: {

  }
})
