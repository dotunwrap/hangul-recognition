<script setup lang="ts">

</script>

<template>
    <div id="options">
        <div class="options-header">
            <h2>{{ lang != "en" ? "설정" : "Settings" }}</h2>
        </div>
        <div class="options-values">
            <ul>
                <li v-for="(bool, option) in options">
                    <input type="checkbox" :value="option" v-model="checkedOptions" @change="changeOptions" >{{ option }}
                </li>
            </ul>
        </div>
    </div>
</template>

<script lang="ts">
export default {
    data() {
        return {
            checkedOptions: this.buildCheckedOptions(),
        }
    },
    props: ['lang', 'options'],
    methods: {
        buildCheckedOptions() {
            let resultArray = [];

            for (let option in this.options) {
                if (!this.options[option]) continue;
                resultArray.push(option);
            }

            return resultArray;
        },
        buildOptionsObject() {
            let resultObject: any = {};

            for (let option in this.options) {
                if (!this.checkedOptions.includes(option)) resultObject[option] = false;
                else resultObject[option] = true;
            }

            return resultObject;
        },
        changeOptions() {
            this.$emit('changeOptions', this.buildOptionsObject());
        }
    }
}
</script>

<style scoped>
#options {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.options-header {
    position: absolute;
    font-size: 2rem;
    margin-bottom: 2rem;
    top: 1rem;
}

.options-values {
    text-transform: capitalize;
    margin-top: 4rem;
    font-size: 1.5rem;
    margin-left: -2rem;

    & ul {
        list-style: none;
    }

    & input {
        margin-right: 1rem;
        transform: scale(1.5);
        /* float: right; */
    }
}
</style>