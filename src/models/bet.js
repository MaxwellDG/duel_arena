import {v4} from 'uuid';

export default class Bet{

    constructor(obj){
        this.id = obj.id ?? v4(),
        this.token = obj.token,
        this.displayName = obj.displayName ?? 'shootPoster9000',
        this.isEven = obj.isEven,
        this.wager = obj.wager,
        this.inUSD = obj.inUSD 
    }

}