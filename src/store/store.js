import { createStore } from 'vuex'
import * as Types from '@/store/types';

export default createStore({
  state: {
    modal: {
      modal: null,
      data: {}
    },
    isConnected: false,
    openBets: [],
    openBetsPageNum: 0,
    selfBets: [],
    selfBetsPageNum: 0,
    usdValues: {
      bitcoin: 0,
      ethereum: 0,
      cardano: 0,
      solana: 0,
      safemoon: 0
   }
  },
  mutations: {
    [Types.SET_MODAL] (state, payload) {
      state.modal = payload;
    },
    [Types.TOGGLE_CONNECTED] (state) {
      state.isConnected = !state.isConnected;
    },
    [Types.SET_USD_VALUES] (state, payload) {
      state.usdValues = payload;
    },

    // Bets
    [Types.SET_SELF_BETS] (state, bets){
      console.log("whats this payload")
      console.log(bets);
      state.selfBets = bets;
    },
    [Types.SET_OPEN_BETS] (state, bets){
      console.log("whats this payload2")
      console.log(bets);
      state.openBets = bets;
    },
    [Types.ADD_SELF_BET] (state, bet){
      state.selfBets.push(bet);
    },
    [Types.REMOVE_SELF_BET] (state, address){
      state.selfBets.splice(state.selfBets.findIndex(j => j.address == address), 1);
    },
    [Types.INCREMENT_PAGE_NUM] (state, isOpenBets){
      isOpenBets ? state.openBetsPageNum++ : state.selfBetsPageNum++;
    },
    [Types.RESET_PAGE_NUM] (state, isOpenBets){
      isOpenBets ? state.openBetsPageNum = 0 : state.selfBetsPageNum = 0;
    }
  },
  getters: {

  }
})
