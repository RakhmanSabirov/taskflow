# TaskFlow — Architecture

## 1. High-Level Overview

```
┌─────────────────────┐        HTTP/REST        ┌──────────────────────┐
│   Flutter Web App   │ ──────────────────────► │   FastAPI Backend    │
│                     │ ◄────────────────────── │                      │
└─────────────────────┘       JSON + JWT        └──────────┬───────────┘
                                                           │
                                              ┌────────────┼────────────┐
                                              │            │            │
                                         PostgreSQL  Claude API    Alembic
                                         (data)      (AI features) (migrations)
```

---

## 2. Frontend (Flutter Web)

### Structure
```
lib/
├── main.dart
└── features/
    └── <feature>/
        ├── data/
        │   ├── models/          # JSON serialization, extends domain entity
        │   └── repositories/    # Implements domain repository, calls API
        ├── domain/
        │   ├── entities/        # Pure Dart classes, no Flutter/external deps
        │   ├── repositories/    # Abstract interfaces
        │   └── usecases/        # Single-responsibility business logic
        └── presentation/
            ├── cubit/           # State management (flutter_bloc)
            ├── pages/           # Full-screen routes
            └── widgets/         # Reusable UI components
```

### Patterns
- **Clean Architecture** — domain layer has zero external dependencies
- **BLoC / Cubit** — UI state managed via `flutter_bloc`
- **Repository pattern** — data sources are swappable (in-memory → real API)

### Current Features (implemented)
- Task CRUD (in-memory, no persistence)
- Dashboard with stats cards
- Task list with status toggle
- Material 3 theme, deep purple color scheme

### Planned Features
- Auth screens (login / register)
- Projects list and detail
- Kanban board with drag-and-drop
- AI feature triggers (generate tasks, auto-priority, etc.)

---

## 3. Backend (FastAPI)

> Not yet implemented. Planned structure:

### Structure
```
backend/
├── main.py                  # FastAPI app entrypoint
├── requirements.txt
├── alembic/                 # DB migration files
│   └── versions/
├── app/
│   ├── api/
│   │   └── v1/
│   │       ├── auth.py      # /auth/register, /auth/login
│   │       ├── projects.py  # /projects CRUD
│   │       ├── tasks.py     # /tasks CRUD
│   │       └── ai.py        # /ai/generate-tasks, /ai/priority, etc.
│   ├── core/
│   │   ├── config.py        # Settings (env vars)
│   │   ├── security.py      # JWT creation / verification
│   │   └── database.py      # SQLAlchemy engine + session
│   ├── models/              # SQLAlchemy ORM models
│   └── schemas/             # Pydantic request/response schemas
└── tests/
```

### Key Endpoints (planned)

| Method | Path | Description |
|--------|------|-------------|
| POST | `/auth/register` | Create account |
| POST | `/auth/login` | Get JWT token |
| GET | `/projects` | List user's projects |
| POST | `/projects` | Create project |
| DELETE | `/projects/{id}` | Delete project |
| GET | `/projects/{id}/tasks` | List tasks in project |
| POST | `/projects/{id}/tasks` | Create task |
| PATCH | `/tasks/{id}` | Update task (status, priority, etc.) |
| DELETE | `/tasks/{id}` | Delete task |
| POST | `/ai/generate-tasks` | Generate task list from description |
| POST | `/ai/auto-priority` | Suggest priority for a task |
| POST | `/ai/generate-description` | Generate task description from title |
| GET | `/ai/project-summary/{id}` | Summarize project state |

---

## 4. Database Schema (planned)

```
users
  id          UUID PK
  email       TEXT UNIQUE NOT NULL
  password    TEXT NOT NULL  (bcrypt hash)
  created_at  TIMESTAMP

projects
  id          UUID PK
  owner_id    UUID FK → users.id
  name        TEXT NOT NULL
  description TEXT
  created_at  TIMESTAMP

tasks
  id          UUID PK
  project_id  UUID FK → projects.id
  title       TEXT NOT NULL
  description TEXT
  status      ENUM (todo, in_progress, review, done)
  priority    ENUM (low, medium, high)
  created_at  TIMESTAMP
  updated_at  TIMESTAMP
```

---

## 5. Infrastructure

### Docker Compose (planned)
```
services:
  db        — PostgreSQL 16
  backend   — FastAPI (uvicorn), hot-reload in dev
  frontend  — Flutter Web build served via nginx (or flutter run for dev)
```

### Auth Flow
1. Client sends `POST /auth/login` with email + password
2. Backend verifies password hash, returns `{ access_token, token_type }`
3. Client stores token (e.g., in memory or localStorage)
4. All subsequent requests include `Authorization: Bearer <token>`
5. Backend middleware validates token on protected routes

### AI Request Flow
1. Frontend triggers an AI action (e.g., "generate tasks")
2. Request goes to backend with user context (project description, etc.)
3. Backend calls Claude API using server-side API key
4. Backend returns structured result to frontend
5. Frontend renders suggestions (user can accept / edit / discard)