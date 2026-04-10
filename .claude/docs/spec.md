# TaskFlow — Product Specification

## 1. Overview

TaskFlow is an educational task tracker built to practice full-cycle development with AI tools. Functionally similar to Worksection, Asana, or Linear — but significantly simplified.

**Primary goal:** complete a full development cycle (spec → deploy) of a real application using AI-assisted development, not ship a production product.

---

## 2. Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Flutter Web |
| Backend | FastAPI (Python) |
| Database | PostgreSQL |
| ORM | SQLAlchemy |
| Migrations | Alembic |
| Auth | JWT tokens |
| AI | Anthropic Claude API |
| Local infra | Docker Compose |

---

## 3. MVP Features

### 3.1 Authentication
- Register with email and password
- Login and receive JWT token
- Logout (invalidate session client-side)
- Session persists via JWT stored on client

### 3.2 Projects
- View list of own projects after login
- Create a project (name + description)
- Delete a project

### 3.3 Tasks
- Tasks belong to a project
- Each task has: title, description, status, priority
- **Statuses:** Todo → In Progress → Review → Done
- Display as Kanban board with four columns
- Change status by dragging a card between columns

### 3.4 Filtering
- Filter tasks on the board by status
- Filter tasks on the board by priority

---

## 4. AI Features

All AI requests go through the backend. The Claude API key is never exposed to the frontend.

| Feature | Description |
|---------|-------------|
| Task generation | User describes what they want to do → AI suggests a list of tasks |
| Auto-priority | AI analyzes task title and assigns a priority automatically |
| Description generation | User writes a title → AI generates a full task description |
| Project summary | AI produces a brief summary of the project's current state |

Integration: **Anthropic Claude API**

---

## 5. Out of Scope (MVP)

- Team collaboration and member invitations
- Comments on tasks
- Notifications and deadlines
- Mobile application (web only for now)
- Role-based access control

---

## 6. Roadmap

| Stage | Scope |
|-------|-------|
| 1 | Project setup, Docker Compose, PostgreSQL, Alembic, JWT auth |
| 2 | Projects CRUD, Tasks CRUD, Kanban board, filtering |
| 3 | Claude API integration: task generation, auto-priority, description gen, project summary |
| 4 | Polish: filters, UX improvements, minor fixes |