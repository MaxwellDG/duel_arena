<template>
    <div id='newBetInterface'>
        <h3>Create a new 50/50 bet</h3>
            <FormulateForm
                v-model="formValues"
                @submit="handleSubmit"
                class="formContainer"
            >
                <FormulateInput
                    name="coin"
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
                    name="even"
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

export default {
    name: 'NewBetInterface',
    components: {
    },
    data() {
        return{
            formValues: {
                coin: 'safemoon', 
                displayName: '',
                wager: '',
                even: true
            },
            icon: () => import(`../../../node_modules/cryptocurrency-icons/svg/color/${this.formValues.coin}.svg`)
        }
    },
    computed: {
        handleUSDConversion(){
            return this.$store.getters.getUSDConversion({coin: this.formValues.coin, bet: this.formValues.bet})
        },
    },
    watch: {
        formValues(oldVal, newVal){
            this.icon = () => import(`../../../node_modules/cryptocurrency-icons/svg/color/${newVal.coin}.svg`)
        }
    },
    methods: {
        async handleSubmit(){
            await this.web3.BetFactoryContract.methods.createBet(58, "SOL", "NODNOD").send({
                from: this.web3.accounts[0],
            })
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