import {v4} from 'uuid';

export default class Bet{

    constructor(obj){
        this.id = obj.id ?? v4(),
        this.coin = obj.coin,
        this.displayName = obj.displayName ?? 'shitPoster9000',
        this.bet = obj.bet,
        this.inUSD = obj.inUSD
    }

}