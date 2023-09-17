# <p align="center">Hangul Recognition Test</p>

[This website](https://dotunwrap.github.io/hangul-recognition) provides a simple recognition test for hangul (the Korean "alphabet") to help Korean students master the romanization and names of the characters. 
## Usage

Opening the website will present you with a fairly simple user-interface. There are three buttons at the top right of the page:
- 🇬🇧: Change the text on the site to English.
- 🇰🇷: Change the text on the site to Korean.
- ⚙️: Open the settings modal.

The settings modal contains configuration opens for the test:
- Consonants: Show consonant characters in the test.
- Vowels: Show vowel characters in the test.
- Double Consonants: Show double consonants in the test.
- Diphthongs: Show diphthong characters in the test.
- Names: Change the test to look for the name of the character rather than the romanization. (This disables vowels and diphthongs as they do not have names.)
- Auto Submit: Toggle the functionality of auto-submitting your answer whenever an incorrect character is entered or the correct answer is provided. Turning off will wait for the user to click the enter key to submit.

## Contributing

The site is written in Vue.js and vanilla CSS. To run a dev environment on your local network, run:
```
npm run dev
```

Create all feature branches off of the `develop` branch and submit your PR to merge back into it. Once reviewed and accepted, it will remain in the develop branch until a maintainer runs a deploy from `develop` to `master`.
