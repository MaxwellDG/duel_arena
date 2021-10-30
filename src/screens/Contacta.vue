<template>
    <div id='container'>
        <FormulateForm
            @submit="handleSubmit"
            v-model="vals"
        >
        <FormulateInput
            name="name"
            label="What's your name?"
            validation="required|min: 2|max: 30"
        />
        <FormulateInput
            name="email"
            type="email"
            label="What's your email?"
            validation="required|max:120"
        />
        <FormulateInput
            type="textarea"
            name="message"
            label="Message"
            validation="required|max: 1000|min: 5"
        />
        <FormulateInput
            type="submit"
            label="Sign up"
        />
        </FormulateForm>
    </div>
</template>

<script>
export default {
    name: 'Contacta',
    components: {
        
    },
    data() {
        return{
            vals: {
                name: '',
                email: '',
                message: ''
            }
        }
    },
    methods: {
        async handleSubmit (data) {
            console.log('sent')
            Email.send({
                    Host: "smtp.gmail.com",
                    Username : "maxwellmdg@gmail.com",
                    Password : "d.flame2",
                    To : 'maxwellmdg@protonmail.com',
                    From : "maxwellmdg@gmail.com",
                    Subject : data.email,
                    Body : `From ${data.name}: ${data.message}`,
                }).then(
                    message => alert("mail sent successfully")
            );
        }
    }
}
</script>

<style scoped>
    #container{
        
    }
</style>