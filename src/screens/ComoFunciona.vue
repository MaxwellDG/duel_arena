<template>
    <div id='container'>
        <div>
            <h1>How it Works</h1>
            <div>
                <h2>Quick Blockchain lesson</h2>
                <div class="center">
                    <img src="/images/maxresdefault.png" />
                </div>
                <p>
                    A blockchain is really long 'chain' of data 'blocks' that are publicly available for everyone to see. Every transaction, every fee, every recipient etc... 
                    can be viewed by anyone. The privacy comes from how no one knows who owns which cryto 'address' or 'wallet'. This means you can send money anywhere in the world,
                    and all of its future movements can be tracked by you.
                </p>
            </div>
        </div>
        <div class="between">
            <div class="con-third center">
                <div>
                    <img src="/images/lock.png" height="500px" width="500px" />
                </div>
            </div>
            <div class="con-two-thirds">
                <div class="middle-con" style="backgroundColor: #FFF;">
                    <h2>Where is my money stored?</h2>
                    <p>
                        Each grocery store has an intermediary wallet associated with it that stores donations until their use. The storage wallet then pairs your donation with your transaction ID. This ensures
                        that usage of say, a $20 payment at a grocery store, is specifically your $20 and not a duplicated receipt. 
                    </p>
                </div>
            </div>
        </div>
        <div class='between'>
            <div class='con-two-thirds '>
                <div class="middle-con" style="backgroundColor: #aa84c2;">
                    <h2>What exactly am I paying for?</h2>
                    <p>
                        The Point-of-Sale (POS) systems at partnered locations are equipped with a crypto payment method. A customer that is interested in utilizing this payment method must present
                        their government-issued ID card. In El Salvador, these ID cards have information related to the person's employment and financial status. If the customer qualifies, then 
                        the POS crypto payment method will be authorized to send a portion of the funds in the store's respective intermediary wallet to the store owner's wallet.
                        Upon payment, you will be sent a copy of the receipt so you may view the specifics of your purchase. 
                    </p>
                </div>
            </div>            
            <div class="center con-third">
                <img src="/images/groceries.png" height="500px" width="500px"/>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'ComoFunciona',
    components: {
        
    },
    data() {
        return{
            
        }
    },
}
</script>

<style scoped>
    .con-third{
        width: 33.3%;
    }
    .con-two-thirds{
        width: 66.6%;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .middle-con{
        width: 50%;
        height: 50%;
        border-radius: 5px;
        padding: 0px 15px;
    }
</style>