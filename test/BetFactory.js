const assert = require("assert");

// NOTE assert.deepEqual() is required for comparing objects and arrays 

const BetFactory = artifacts.require('BetFactory');

// 'contract' is comparable to 'describe' in standard mocha
contract('BetFactory can create a bet', () => {
    let betFactory 
    before(async () => {
        betFactory = await BetFactory.deployed();
    });

    it('Should deploy smart contract', async () => {
        const betFactory = await BetFactory.deployed();
        console.log('Hello', betFactory.address);
        assert(betFactory.address != '');
    })

    it('No bets present', async () => {
        const betsLength = await betFactory.getSelfBetsLength();
        assert(betsLength == 0);
    })

    it('Created a bet', async () => {
        await betFactory.createBet(55, 'SOL', 'Martian');

        const betsLengthAfter = await betFactory.getSelfBetsLength();
        assert(betsLengthAfter == 1);

        const seeTheBet = await betFactory.getSelfBets();
        assert(seeTheBet.length > 0);

        const counter = await betFactory.betCounter();
        assert(counter.toNumber() == 2);
    })
})