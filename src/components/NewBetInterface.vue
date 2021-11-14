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
                    name="bet"
                    label="Bet"
                    validation="required|number"
                />
                <label>
                    / $USD
                    <p style="margin: 0;">{{handleUSDConversion}}</p>
                </label>
                <FormulateInput
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
                bet: '',
            },
            icon: () => import(`../../node_modules/cryptocurrency-icons/svg/color/${this.formValues.coin}.svg`)
        }
    },
    computed: {
        handleUSDConversion(){
            return this.$store.getters.getUSDConversion({coin: this.formValues.coin, bet: this.formValues.bet})
        },
    },
    watch: {
        formValues(oldVal, newVal){
            this.icon = () => import(`../../node_modules/cryptocurrency-icons/svg/color/${newVal.coin}.svg`)
        }
    },
    methods: {
        handleSubmit(){

        }
    }
}
</script>

<style scoped>
    h3{
        color: white;
    }

    #newBetInterface{
        background-color: purple;
        padding: 10px;
        border-radius: 5px;
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