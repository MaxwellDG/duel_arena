<template>
    <div id='container'>
        <!-- <img /> -->
        <p>{{name}}</p>
        <p>{{role}}</p>
        <p>{{desc}}</p>
    </div>
</template>

<script>
export default {
    name: 'Miembre',
    props: {
        name: String,
        role: String,
        desc: String
    },
    data() {
        return{
            isHovering: false
        }
    },
}
</script>

<style scoped>
    #container{

    }
</style>