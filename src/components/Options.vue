<script setup lang="ts">

</script>

<template>
    <div id="options">
        <div class="options-header">
            <h2>{{ lang != "en" ? "설정" : "Settings" }}</h2>
        </div>
    </div>
</template>

<script lang="ts">
export default {
    props: ['lang', 'options']
}
</script>

<style scoped>
#options {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
</style>