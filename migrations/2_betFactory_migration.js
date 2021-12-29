const BetFactory = artifacts.require("BetFactory");

module.exports = async function (deployer, network, accounts) {
  // deployment steps
  await deployer.deploy(BetFactory);
};