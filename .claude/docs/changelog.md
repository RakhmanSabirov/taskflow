# Changelog

All notable changes to TaskFlow are recorded here.

Format: `[Stage X] Description — YYYY-MM-DD`

---

## [Stage 0] Project Foundation — 2026-04-10

### Added
- Flutter project initialized with Clean Architecture structure
- BLoC / Cubit state management via `flutter_bloc`
- In-memory task CRUD (create, read, update status)
- Dashboard UI: stats cards, task list, sidebar navigation
- Material 3 theme with deep purple color scheme
- Project documentation: `spec.md`, `architecture.md`, `changelog.md`

### Notes
- No backend yet — all data lives in memory (`TaskRepositoryImpl`)
- Auth, Projects, and Kanban are placeholders
- Next: Stage 1 — Docker, PostgreSQL, FastAPI, JWT auth