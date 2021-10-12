<template>
  <div id="app">
      <p>
          How do I know these donations are going where you say they are?

          These resources can show you exactly where your money travels. Select the website below that corresponds with the type of crypto you sent.
          Then type in your 'transaction' id and it will supply you with all the information you need.
          BTC: https://www.blockchain.com/explorer
          ADA: https://cardanoscan.io/
          <!-- ETH: https://etherscan.io/ --> 
          BSC: https://bscscan.com/
          SOL: https://solscan.io/

          We are registered as an official charity with the El Salvadorian government. We are also officialy partnered with: "Grocery Store".
          Look at the address posted below each grocery store. Those addresses are the same as any other crypto address - meaning they be input to the blockchain scanners posted above.
          There you will be able to see to contents of each wallet and every transaction. Every single out-going transaction will be of $20 and be sent to the exact same address
          that the grocery store owner uses to receive purchases.
        </p>
      <p>
          Why do the purchases go through a grocery store? Wouldn't donating to a food bank be better?

            If you're referring food banks where people donate directly, then that would be exactly the same. You donated the food for free, but it was still purchased from a grocery store beforehand.
            If you're referring to a service that gets food directly from a provider (like a farm or an importer), then that could be better idea. The issue comes from connecting those in need with
            such places, as well as being able to have the infrastructure to verify that those receiving the donations are valid. If you work for such an organization and would like to 
            coordinate with our team, please <a>contact us</a>.
        </p>
      <p>
          Are these donations tax-deductible?

          It depends. You
        </p>
      <p>
          What's the best crypto to donate?

          At the moment, all of the cryptos above are equal except for ETH. ETH is currently dealing with large 'gas' fees in its network. Due to its massive popularity though, it is still a common
          choice for donation. Just be aware that you will likely be charged extra (by the blockchain, not by us) on top of your donation. 
        </p>
  </div>
</template>

<script>

export default {
  name: 'App',
  components: {
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
