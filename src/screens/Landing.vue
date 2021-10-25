<template>
    <div id="landing">
        <div class="center-container">
            <img src="/images/blue-plus-stock.jpg" class="cruz" />
            <div>
                <h2>Our mission:</h2>
                <h4>The problem</h4>
                <p>- Charities often don't have enough transparency with your money</p>
                <p>- Charities can have too much overhead (paying employees' salaries, marketing, accounting, etc...) which results in
                in a lower percentage of your donation actually going to help those in need
                </p>
                <h4>Our solution</h4>
                <p>One of the major driving factors in crypto (blockchain) adoption is its transparency. Utilzing crypto payments, you can track your money every 
                    single step of the way. You can watch it go from your wallet -> to the assigned wallet at a partnered grocery store -> to the actual payment at the cashier. We'll even send you
                    a receipt of the transaction so you can see exactly what was purchased.
                </p>    
            </div>
        </div>
    </div>
</template>

<script>

export default {
  name: 'Landing',
  components: {

  }
}
</script>

<style scoped>
    #landing{
        height: 100vh;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .cruz{
        height: 100%;
    }
    .center-container{
        display: flex;
        align-items: center;
        height: 50vh;
        margin: 0 auto;
        width: 75%;
    }
</style>