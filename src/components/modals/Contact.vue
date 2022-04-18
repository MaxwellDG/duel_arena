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

<script setup>
import { reactive } from '@vue/reactivity'

const formValues = reactive({
    email: '',
    subject: '', 
    message: ''
})
</script>