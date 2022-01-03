<template>
    <div id='newBetInterface'>
        <h3>Create a new 50/50 bet</h3>
            <FormulateForm
                v-model="formValues"
                @submit="handleSubmit"
                class="formContainer"
            >
                <FormulateInput
                    name="token"
                    :options="[
                            { value: 'btc', label: 'BTC' },
                            { value: 'eth', label: 'ETH', disabled: true, id: '69420' },
                            { value: 'ada', label: 'ADA' },
                            { value: 'sol', label: 'SOL'},
                            { value: 'safemoon', label: 'SAFEMOON'},
                        ]"
                    type="select"
                />
                <div class="iconCon">
                    <component :is="icon" :height="32" :width="32" />
                </div>
                <FormulateInput
                    name="displayName"
                    label="Display Name"
                    validation="required|alphanumeric|max:20"
                />
                <FormulateInput
                    name="wager"
                    label="Wager"
                    validation="required|number"
                />
                <label>
                    / $USD
                    <p style="margin: 0;">{{handleUSDConversion}}</p>
                </label>
                <!-- ENSURE that these values get changed to bool values before being sent  -->
                <FormulateInput
                    name="isEven"
                    :options="{true: 'Even', false: 'Odd'}" 
                    type="radio"
                    label="Tx last digit"
                />
                <FormulateInput
                    input-class="but-sub"
                    type="submit"
                    label="Place bet"
                />
            </FormulateForm>
    </div>
</template>

<script>
import {mapState} from 'vuex';

export default {
    name: 'NewBetInterface',
    components: {
    },
    data() {
        return{
            formValues: {
                token: 'btc', 
                displayName: 'tester',
                wager: '777',
                isEven: true
            },
            icon: () => import(`../../../node_modules/cryptocurrency-icons/svg/color/${this.formValues.token}.svg`)
        }
    },
    computed: {
        ...mapState({
            web3Client: state => state.web3Client,
        }),
        handleUSDConversion(){
            return this.$store.getters.getUSDConversion({token: this.formValues.token, bet: this.formValues.bet})
        },
    },
    watch: {
        formValues(oldVal, newVal){
            this.icon = () => import(`../../../node_modules/cryptocurrency-icons/svg/color/${newVal.token}.svg`)
        }
    },
    methods: {
        txCallback(err, txHash){
            console.log('Err', err)
            console.log('TxHash', txHash)
        },
        async handleSubmit(formData){
            console.log("Formdaatata")
            console.log(formData);
            const account = this.web3Client.accounts[0]

            const estimatedGas = await this.web3Client.BetFactoryContract.methods
                .createBet(formData.wager, formData.isEven === 'true', formData.token, formData.displayName)
                .estimateGas();
            console.log('Estimated gas', estimatedGas)

            // TODO this needs to be more accurate
            // TODO this needs to actually send money
            const receipt = await this.web3Client.BetFactoryContract.methods
                .createBet(formData.wager, formData.isEven === 'true', formData.token, formData.displayName)
                .send({
                    from: account,
                    gas: estimatedGas * 2
            }, this.txCallback)

            // TODO get the return so you can stub in the new bet

            console.log(receipt)
        }
    }
}
</script>

<style scoped>
    h3{
        color: black;
        margin: 0;
    }

    #newBetInterface{
        padding: 0 10px 10px 10px;
        border-radius: 5px;
        font-family: 'RuneScape UF';
        padding: 12px;
    }
    .formContainer{
        display: flex;
        justify-content: space-evenly;
        align-items: flex-end;
        color: white;
    }

    .iconCon{
        margin: 0 10px;
    }
</style>