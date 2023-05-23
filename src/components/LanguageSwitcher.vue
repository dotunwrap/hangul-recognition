<script lang="ts">
export default {
    data() {
        return {
            
        }
    },
    methods: {
        changeLanguage(lang: string) {
            this.$emit('changeLanguage', lang);
        }
    }
};
</script>

<template>
    <div id="language-swticher">
        <h2 class="clickable" @click="changeLanguage('en')">🇬🇧</h2>
        <h2 class="clickable" @click="changeLanguage('ko')">🇰🇷</h2>
    </div>
</template>

<style scoped>
#language-swticher {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 1rem;
}

#language-swticher h2 {
    font-size: 1.5rem;
}
</style>