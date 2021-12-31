<template>
    <div>
        <FormulateForm
                v-model="formValues"
                @submit="handleSubmit"
                class="formContainer"
        >
            <FormulateInput
                label="Email"
                name="email"
                type="email"
                validation="required"
            />
            <FormulateInput
                label="Subject"
                name="subject"
            />
            <FormulateInput
                label="Message"
                name="email"
                type="textarea"
                validation="required|max:500|min:1"
            />

            <FormulateInput
                input-class="but-sub"
                type="submit"
                label="Send"
            />
        </FormulateForm>
    </div>
</template>

<script>

export default {
    name: 'Contact',
    data() {
        return{
            formValues: {
                email: '',
                subject: '',
                message: ''
            }
        }
    },
}
</script>

<style scoped>
    #container{
        
    }
</style>