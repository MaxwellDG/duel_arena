const BetFactory = artifacts.require("BetFactory");
const Bet = artifacts.require('Bet');

module.exports = async function (deployer, network, accounts) {
  // deployment steps
  await deployer.deploy(BetFactory);
};