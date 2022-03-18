<template>
    <div id='artwork'>
        <img src="/images/osrs-dance.png" class="osrsDance" />
        <div class="wowText">
            <img src="/images/wowroll.png" class="wowroll" />
            <img src="/images/sudoku.png" class="sudoku" />
        </div>
        <img src="/images/Grunt.png" class="orc"/>
    </div>
</template>

<script>

// TODO Photoshop them all into 1 photo

export default {
    name: 'Artwork',
    components: {
        
    },
    data() {
        return{
            
        }
    },
}
</script>

<style scoped>
    #artwork{
        height: 30%;
        display: flex;
        flex-direction: row;
        justify-content: center;  
    }

    .wowText{
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;
    }


</style>