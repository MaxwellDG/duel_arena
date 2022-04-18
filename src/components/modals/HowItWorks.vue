<template>
    <div class="how-modal-con">
        <p>'The house always wins' right?  Well what if the 'house' didn't exist. DuelArena facilitates gambling between two parties directly; optimizing the return for both.</p>
        <h2>How do I use this?</h2>
        <p>
            No accounts are necessary, but you do need to have a Metamask wallet connected which is done by clicking the 'connect' button at the top-right of the screen.
            Once connected, you may bet against the list of open bets shown in the center of the screen. Or create your own bet by clicking 'Place New Bet' at the bottom-right.
        </p>
        <h2>How does the tech work?</h2>
        <p>
            Creating, or matching, a bet sends your currency to a smart contract wallet on its respective blockchain. No one in the world is able to access it, including DuelArena.
            The funds are restricted to the rules of the smart contract, which specifically state that they can only be released in 1 of 2 scenarios.
        </p>
        <ul>
            <li>
                The bet is matched, and a random number is generated. This random number comes from CHAINLINK's Random-Number-Generator (RNG) service. The currency is then sent automatically
                to the wallet of the winner
            </li>
            <li>
                The creator of the bet selects to cancel it before someone else matches the bet. This will send the money back to the wallet of the creator
            </li>
        </ul>
        <h2>Why are there still fees?</h2>
        <p>Fees are as follows:</p>
        <ul>
            <li>_ for a CHAINLINK Random-Number-Generator (RNG) call</li>
            <li>1% service fee for DuelArena (capped at $1.00 USD)</li>
            <li>gas fees native to the respective blockchain you are using</li>
        </ul>
    </div>
</template>

<script>
export default {
    name: 'HowItWorks',
    data() {
        return{
            
        }
    },
}
</script>

<style scoped>

</style>