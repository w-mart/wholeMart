# LocalB2B AI Marketplace

Spring Boot modular monolith for local B2B commerce with JSP web routes and mobile-ready REST APIs.

This repository is the WholeMart project.

## Run Locally

```powershell
docker compose up -d
mvn spring-boot:run
```

Open:

- Web login: `http://localhost:8080/web/auth/login`
- Swagger UI: `http://localhost:8080/swagger-ui.html`

Login continues directly by role; OTP verification is not used in the current development flow.

## Architecture

Controllers are thin:

```text
JSP Controller  -> Service Layer -> Repository Layer
REST Controller -> Service Layer -> Repository Layer
```

Sensitive AI actions are persisted as pending actions and require explicit confirmation before execution. Service methods use the current authenticated/session user rather than accepting caller-owned user IDs for sensitive scope decisions.
