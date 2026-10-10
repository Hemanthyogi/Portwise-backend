# PORTWISE — Backend Service
> **Integrated Port Logistics Management System (Backend API)**
> Built with **Java 21**, **Spring Boot 3.3.4**, **Spring Security 6 (JWT)**, **PostgreSQL / H2**, and **Hibernate JPA**.

---

## ⚓ Architecture & Highlights
- **Java 21 & Spring Boot 3.3.4**: Clean, modern enterprise application structure.
- **Role-Based Access Control (RBAC)**: 5 distinct roles (`ADMIN`, `PORT_AUTHORITY`, `SHIPPING_AGENT`, `CARGO_OWNER`, `LOGISTICS_OPERATOR`).
- **Conflict Prevention Engine**:
  - Overlapping berth scheduling rejected with HTTP 409 Conflict.
  - Vessel draft limit checking against berth maximum draft.
  - Vessel LOA (Length Overall) boundary validation against berth max LOA.
  - Equipment double-allocation conflict detection.
- **Dual Database Profiles**:
  - **Local Zero-Setup Profile (`local`)**: Embedded persistent H2 database with automatic seed data initialization (`DataInitializer.java`).
  - **Production Profile (`default`)**: PostgreSQL with Flyway database migrations (`V1__initial_schema.sql`, `V2__demo_seed_data.sql`).
- **Swagger / OpenAPI 3**: Interactive API documentation at `/swagger-ui/index.html`.

---

## 🔑 Pre-Seeded Demo Credentials
All seeded demo accounts share the password: **`Demo@12345`**

| Role | Email ID | Access Scope |
| :--- | :--- | :--- |
| **Administrator** | `admin@portwise.demo` | Full administrative control, user management, audit logs |
| **Port Authority** | `portauthority@portwise.demo` | Berth management, schedule approvals/rejections |
| **Shipping Agent** | `agent@portwise.demo` | Vessel registration, schedule submissions |
| **Cargo Owner** | `cargo@portwise.demo` | Cargo declarations, milestone tracking |
| **Logistics Operator** | `operator@portwise.demo` | Equipment allocations (cranes, tugboats, pilots) |

---

## 🚀 Running the Backend

### Option 1: Standalone Local Run (No Docker / No External DB required)
```powershell
mvn spring-boot:run "-Dspring-boot.run.profiles=local"
```
* **REST API**: `http://localhost:8080/api/v1`
* **Swagger UI**: `http://localhost:8080/swagger-ui/index.html`
* **H2 Console**: `http://localhost:8080/h2-console`
  - **JDBC URL**: `jdbc:h2:file:./data/portwisedb`
  - **User**: `sa`
  - **Password**: `sa`

### Option 2: Running Automated Tests
```powershell
mvn test
```

### Option 3: Docker
```powershell
docker build -t portwise-backend .
docker run -p 8080:8080 portwise-backend
```

---

## 📁 Repository Structure
```
├── src/
│   ├── main/java/com/portwise/
│   │   ├── config/          # Security, OpenAPI, Auditor, DataInitializer
│   │   ├── controller/      # REST API Controllers (13 Controllers)
│   │   ├── dto/             # Request & Response DTOs
│   │   ├── entity/          # JPA Entities & Enums
│   │   ├── exception/       # GlobalExceptionHandler, Custom Exceptions
│   │   ├── repository/      # Spring Data Repositories
│   │   ├── security/        # JWT Authentication Filter & Token Provider
│   │   └── service/         # Business Logic & Conflict Validators
│   └── main/resources/
│       ├── db/migration/    # Flyway Migrations (Schema & Seed)
│       ├── application.yml
│       └── application-local.yml
├── database/                # Standalone SQL schema and seed scripts
├── docs/                    # Architecture, Database ERD, API specs
├── Dockerfile
└── pom.xml
```
