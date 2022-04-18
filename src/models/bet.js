import {v4} from 'uuid';
import store from "@/store/store"
import * as Types from '@/store/types';

export default class Bet{

    constructor(obj){
        this.id = obj.id ?? v4(),
        this.token = obj.token,
        this.displayName = obj.displayName ?? 'shootPoster9000',
        this.isEven = obj.isEven,
        this.wager = obj.wager,
        this.USD = this.calcUSD(this.wager, this.token)
    }

    calcUSD(wager, token){
        const tokenName = Object.keys(Types.TOKEN_CODES).find(j => Types.TOKEN_CODES[j] == token)
        if(tokenName)
            return (parseFloat(wager) * parseFloat(store.state.usdValues[tokenName].usd)).toFixed(2);
    }

}

