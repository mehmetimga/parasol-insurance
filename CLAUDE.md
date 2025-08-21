# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Structure

This is a Node.js + React application for managing fictitious insurance claims with AI chatbot functionality. The architecture consists of:

- **Backend**: Fastify-based Node.js server (`app/server.mjs`) with WebSocket support for real-time chat
- **Frontend**: React application built with PatternFly components (`app/webui/`)
- **Database**: SQLite in-memory database initialized from `app/import.sql`
- **AI Integration**: LangChain with OpenAI-compatible API for chatbot functionality

### Key Directories:
- `app/` - Main backend application
  - `routes/` - Fastify route handlers (claims, chatbot WebSocket)
  - `plugins/` - Fastify plugins (SQLite connector)
  - `ai/` - AI and chatbot logic
  - `webui/` - Frontend React application
- `prompt-testing/` - Separate Node.js package for testing prompts

## Development Commands

### Backend (from `app/` directory):
```bash
npm install                    # Install backend dependencies
npm run buildui                # Build React frontend
npm start                      # Start the server (or: node server.mjs)
npm run cleanui                # Clean frontend build artifacts
```

### Frontend (from `app/webui/` directory):
```bash
npm install                    # Install frontend dependencies
npm run build                  # Build for production
npm run start:dev              # Start webpack dev server
npm run test                   # Run Jest tests
npm run test:watch             # Run tests in watch mode
npm run test:coverage          # Run tests with coverage
npm run lint                   # Run ESLint
npm run type-check             # Run TypeScript type checking
npm run ci-checks              # Run all CI checks (type-check + lint + test:coverage)
npm run format                 # Format code with Prettier
```

### Prompt Testing (from `prompt-testing/` directory):
```bash
npm test                       # Run prompt testing suite
```

## Configuration

- Environment variables are configured in `app/.env`
- Key variables: `OPENAI_API_KEY`, `AI_CHAT_MODEL_NAME`, `AI_CHAT_BASE_URL`, `AI_CHAT_MODEL_TEMPERATURE`, `PORT`
- Default server runs on port 8080 (configurable via PORT env var)
- Frontend TypeScript configuration in `app/webui/tsconfig.json` with path mapping for `@app/*`

## Architecture Notes

- **Database**: Uses in-memory SQLite initialized on server start from SQL file
- **WebSocket**: Real-time chat communication between frontend and AI backend
- **AI Chain**: LangChain integration for processing insurance claims context with user queries
- **Frontend**: PatternFly React components with custom routing and state management
- **Build Process**: Frontend builds into `app/webui/dist/` and is served statically by Fastify

## Required Node.js Version
Node.js 18+ (specified in engines field)