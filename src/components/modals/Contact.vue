<template>
    <div class="contact-con">
        <p>Feel free to ask anything you'd like by filling out the form below</p>
        <form
            @submit="handleSubmit"
            class="formContainer"
        >
            <input
                label="Email"
                name="email"
                type="email"
            />
            <input
                label="Subject"
                name="subject"
            />
            <input
                label="Message"
                name="email"
                type="textarea"
            />

            <input
                type="submit"
                label="Send"
            />
        </form>
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