# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Vue 3 + TypeScript application for learning and recognizing Korean Hangul characters. The application helps users learn consonants, vowels, double consonants, and diphthongs with their romanized pronunciations and Korean names.

## Package Manager

This project uses **Bun** as its package manager. Always use `bun` commands instead of npm/yarn/pnpm.

## Common Commands

### Development

```bash
bun install          # Install dependencies
bun dev              # Start dev server with hot reload
```

### Building

```bash
bun run build        # Type-check and build for production
bun run build-only   # Build without type-checking
bun run preview      # Preview production build locally
```

### Type Checking

```bash
bun run type-check   # Run vue-tsc to check types
```

### Linting and Formatting

```bash
# Linting (uses both oxlint and eslint)
bun run lint         # Run all linters with auto-fix
bun run lint:check   # Run all linters in check mode (no fixes)

# Individual linters
bun run lint:oxlint        # Run oxlint with auto-fix
bun run lint:oxlint:check  # Run oxlint check only
bun run lint:eslint        # Run eslint with auto-fix
bun run lint:eslint:check  # Run eslint check only

# Formatting (uses prettier)
bun run fmt          # Format code
bun run fmt:check    # Check formatting without modifying
```

## Architecture

### Tech Stack

- **Framework**: Vue 3 with Composition API
- **Build Tool**: Vite (using rolldown-vite, an experimental Rust-based Vite variant)
- **Language**: TypeScript
- **Router**: Vue Router 4
- **Styling**: TailwindCSS 4.x with Vite plugin
- **Linting**: Dual linting with oxlint (fast, correctness-focused) + ESLint (comprehensive)
- **Formatting**: Prettier with Tailwind plugin

### Project Structure

```
src/
├── data/           # Static JSON data for Hangul characters
│   ├── names.json          # Korean and romanized names for characters
│   ├── pronunciation.json  # Romanization mappings
│   └── options.json        # Configuration for character categories
├── router/         # Vue Router configuration
├── views/          # Page-level Vue components
├── App.vue         # Root component
└── main.ts         # Application entry point
```

### Data Files

The application's Hangul character data is stored in three JSON files:

1. **`src/data/names.json`**: Contains Korean names and romanized names for all characters
   - Structure: `{ "consonants": {}, "double consonants": {} }`
   - Each entry: `"character": ["romanized_name", "korean_name"]`

2. **`src/data/pronunciation.json`**: Maps Hangul characters to their romanized pronunciations
   - Categories: consonants, double consonants, vowels, diphthongs
   - Each entry: `"character": "pronunciation"`

3. **`src/data/options.json`**: Configuration for which character categories are enabled
   - Boolean flags for: consonants, vowels, double consonants, diphthongs, names, auto submit

### TypeScript Configuration

The project uses a project references setup with three tsconfig files:

- `tsconfig.json`: Root config with project references
- `tsconfig.app.json`: Application code config (extends `@vue/tsconfig/tsconfig.dom.json`)
- `tsconfig.node.json`: Node/build config

Path alias `@/*` maps to `./src/*` for clean imports.

### Linting Strategy

This project uses a dual-linting approach:

1. **oxlint**: Fast Rust-based linter focused on correctness rules
2. **ESLint**: Comprehensive Vue and TypeScript linting with `eslint-plugin-oxlint` to avoid rule conflicts

Both run sequentially via `npm-run-all2` when using `bun run lint`.

### Deployment

The application deploys to GitHub Pages via the CD workflow (`.github/workflows/cd.yml`):

- Triggers on pushes to `main` branch
- Builds the app with Bun (`bun run build`)
- Deploys the `./dist` folder to GitHub Pages
- Uses Bun in CI (not npm)

## Development Notes

### Node Version Requirements

- Requires Node.js `^20.19.0 || >=22.12.0` (defined in package.json engines)

### Vue DevTools

- `vite-plugin-vue-devtools` is enabled for enhanced debugging during development
- For best experience, install Vue.js devtools browser extension and enable Custom Object Formatters

### Router

- Currently has no routes defined (`routes: []` in `src/router/index.ts`)
- Uses `createWebHistory` for HTML5 history mode

### Adding New Hangul Character Data

When adding or modifying Hangul character data, ensure consistency across all three data files:

- Add/update the character in `pronunciation.json` with its romanization
- Add/update the character in `names.json` with both romanized and Korean names
- Update category flags in `options.json` if adding a new category
