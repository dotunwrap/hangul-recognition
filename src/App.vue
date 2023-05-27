<script setup lang="ts">
import LanguageSwitcher from './components/LanguageSwitcher.vue';
import Main from './components/Main.vue';
import Options from './components/Options.vue';
</script>

<template>
  <header>
    <div class="header-title">
      <h1>{{ lang != "en" ? "한글" : "Hangul" }}</h1>
    </div>
    <div class="header-buttons">
      <LanguageSwitcher @changeLanguage="lang = $event" />
      <h2 id="options-button" class="clickable" @click="showOptions = !showOptions">⚙️</h2>
    </div>
  </header>

  <main>
    <Main :key="mainKey" :lang="lang" :options="optionsJson" />
  </main>

  <footer>
    <h3>{{ lang != "en" ? "Gabby가 🩷로 만든 웹사이트" : "Made with 🩷 by Gabby" }}</h3>
  </footer>

  <div class="modal" v-if="showOptions">
    <Options :key="mainKey" :lang="lang" :options="optionsJson" @changeOptions="changeOptions" />
  </div>
</template>

<script lang="ts">
import optionsJson from './config/options.json';
export default {
    created() {
      window.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
          this.showOptions = false;
        }
      });
      window.addEventListener('click', (e) => {
        if (!this.showOptions || e.target == document.getElementById('options-button') || e.target == document.getElementById('options') || (e.target instanceof Node && document.getElementById('options')?.contains(e.target))) return;
        this.showOptions = false;
      });
    },
    data() {
      return {
        lang: "en",
        showOptions: false,
        optionsJson: optionsJson,
        mainKey: 0
      }
    },
    components: { LanguageSwitcher, Main, Options },
    methods: {
      changeOptions(event: Object) {
        Object.assign(this.optionsJson, event);
        this.mainKey++;
      }
    }
}
</script>

<style scoped>
@import './assets/base.css';

header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
  width: 100vw;
  padding: 1rem 2rem;
}

.header-buttons {
  display: flex;
  align-items: center;
  gap: 1rem;
}

#main {
  width: 75vw;
  height: 50vh;
  min-height: 300px;
  background-color: var(--color-background-mute);
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  border-radius: 2rem;
}

#main:not(.wrong-answer) {
  border: 1px solid var(--color-border);
}

#main.wrong-answer {
  border: 1px solid red;
}

footer {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 1rem;
  background: var(--color-background-mute);
  width: 100vw;
  padding: 1rem;
}

#options {
  z-index: 2;
  top: 50%;
  left: 50%;
  position: fixed;
  padding: 0;
  margin: 0;
  border: 1px solid var(--color-border);
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  transform: translate(-50%, -50%);
  background-color: var(--color-background-mute);
  width: 15vw;
  min-width: 300px;
  min-height: 350px;
  height: 35vh;
  border-radius: 2rem;
}
</style>
