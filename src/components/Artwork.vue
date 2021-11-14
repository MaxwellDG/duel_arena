<template>
    <div id='artwork'>
        <div>
            
        </div>
        <div>

        </div>
        <div class="wowText">
            <img src="/images/wowroll.png" class="wowroll" />
            <img src="/images/sudoku.png" class="sudoku" />
        </div>
        <div>
            <img src="/images/Grunt.png" class="orc"/>
        </div>
    </div>
</template>

<script>
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
        display: flex;
        flex-direction: row;
        justify-content: space-between;   
    }

    .wowroll{
        margin-right: 50px;
    }

    .sudoku{
        margin: 0 0 50px 50px;
    }

    .wowText{
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;
    }

</style>