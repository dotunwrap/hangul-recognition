<script setup lang="ts">
</script>

<template>
    <div id="main" :class="wrongAnswer ? 'wrong-answer' : ''">
        <div id="question">
            
            <h3 id="currentQuestion">
                {{ currentQuestion ? currentQuestion : randomQuestion() }}
            </h3>
            <p :style="wrongAnswer ? '' : 'opacity: 0; cursor: default'">{{ options["names"] ? nameJson[currentQuestion as keyof typeof nameJson]?.toString() : pronunciationJson[currentQuestion] }}</p>
        </div>
        <input v-if="!options['names']" id="answer" type="text" :placeholder="lang != 'en' ? '로마자를 입력하세요' : 'Please enter the romanization'" v-model="answer" />
        <input v-else id="answer" type="text" :placeholder="lang != 'en' ? '로마자를 한글 이름을 입력하세요' : 'Please enter the name of the character'" v-model="answer" />
    </div>
</template>

<script lang="ts">
import pronunciationJson from '../config/pronunciation.json';
import nameJson from '../config/names.json';
export default {
    created() {
        document.addEventListener('keydown', (e) => {
            if (e.key !== "Enter" || !this.answer) return;
            this.verifyAnswer();
        })
    },
    data() {
        return {
            pronunciationJson: this.buildJson(pronunciationJson),
            nameJson: this.buildJson(nameJson),
            currentQuestion: "",
            answer: "",
            wrongAnswer: false,
            leeches: {}
        }
    },
    props: ['lang', 'options'],
    methods: {
        buildJson(rawJson: any) {
            let resultJson: Object = {};

            for (let objectName in rawJson) {
                if (!this.options[objectName]) continue;
                Object.assign(resultJson, rawJson[objectName]);
            }

            return resultJson;
        },

        randomQuestion() {
            const json = this.options["names"] ? this.nameJson : this.pronunciationJson;
            const generatedQuestion = Object.keys(json)[Object.keys(json).length * Math.random() << 0];

            if (generatedQuestion === this.currentQuestion) {
                this.randomQuestion();
                return;
            }

            if (!generatedQuestion) return this.currentQuestion = "N/A";
            this.currentQuestion = generatedQuestion;
        },

        verifyAnswer() {
            this.answer = this.answer.toLowerCase().trim();
            const isCorrect = this.options["names"] 
                ? this.nameJson[this.currentQuestion as keyof typeof nameJson]?.includes(this.answer) 
                : this.pronunciationJson[this.currentQuestion] === this.answer;
            if (!this.answer || !this.currentQuestion || !isCorrect) return this.handleWrongAnswer();
            this.handleCorrectAnswer();
        },

        handleWrongAnswer() {
            if (this.wrongAnswer) return;
            this.wrongAnswer = true;
            this.setLeeches(this.leeches);
        },

        handleCorrectAnswer() {
            this.wrongAnswer = false;
            this.answer = "";
            this.randomQuestion();
        },
        
        setLeeches(leeches: {[key: string]: number}) {
            if (this.leeches[this.currentQuestion as keyof typeof this.leeches]) return this.leeches[this.currentQuestion as keyof typeof this.leeches]++;
            leeches[this.currentQuestion as keyof typeof this.leeches] = 1;
            this.leeches = leeches;
        }
    }
}
</script>

<style scoped>
#main {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 2rem;
}

.wrong-answer {
    color: red;
}

#question {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    & h3 {
        font-weight: 800;
        font-size: 6rem;
    }
    & p {
        font-size: 2rem;
    }
}

input {
    width: 75%;
    height: 10%;
    font-size: 1rem;
    color: var(--color-text);
    background-color: var(--color-border);
    border-radius: 1rem;
    padding: 0 1rem;
}
</style>