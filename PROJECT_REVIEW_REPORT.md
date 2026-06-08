# Project Review Report

Generated: 2026-06-08  
Updated: 2026-06-09

## Status

All high-priority items from the review were fixed and verified with a clean build.

Verification:

- `mvn test` passed.
- Final `mvn clean test` passed.
- Final result: 7 tests run, 0 failures, 0 errors.

## Fixes Completed

### 1. Clean source build failure

Fixed.

- Added missing `RequestParam` imports in payment and delivery controllers.
- Updated `AuditService` to use the current `AuditEvent` constructor.
- Added latitude/longitude getters to `RetailerProfile`.
- Confirmed `mvn clean test` rebuilds from source successfully.

### 2. Stateful integration test

Fixed.

- `SuspensionIntegrationTest` now uses unique mobile numbers per run instead of hard-coded shared test accounts.
- The test no longer fails when an older local test user is already suspended.

### 3. JSP pages broke on Spring Page responses

Fixed.

- Added shared `wmRows(data)` helper in both common JavaScript locations.
- Updated JSP scripts to support both raw arrays and Spring `Page` responses via `data.content`.
- Affected dashboards, reports, payments, deliveries, orders, users, products, and approval pages now parse paged responses correctly.

### 4. Request validation annotations not activated

Fixed.

- Added `@Valid` to request bodies in product creation, order placement, and cart add/update endpoints.
- Existing auth and AI endpoints already used `@Valid`.

### 5. Payment and delivery data exposure

Fixed.

- Payment API now scopes responses by current user:
  - Admin sees all.
  - Distributor sees payments for distributor orders.
  - Retailer sees payments for retailer orders.
- Delivery API now scopes responses by current user:
  - Admin sees all.
  - Driver sees assigned deliveries.
  - Distributor sees deliveries for distributor orders.
  - Retailer sees deliveries for retailer orders.

### 6. Unbounded page size

Fixed.

- Added `Pageables.bounded(...)` with a maximum page size of 100.
- Applied it to admin, product, payment, and delivery pagination.

### 7. CSRF disabled globally

Improved.

- CSRF is now enabled by default.
- `/api/**` and `/web/auth/**` are excluded so the current bearer-token API calls and login flow continue to work.
- Browser/session web routes are no longer globally exempt.

### 8. Production default secret/config risk

Improved.

- Added `ProductionConfigValidator`.
- If the `prod` profile is active, startup fails when the default dev JWT secret or default `admin` DB password is still in use.

### 9. Locked jar prevented clean builds

Fixed for this workspace.

- Found a running process: `java -jar target\marketplace-0.0.1-SNAPSHOT.jar`.
- Stopped that process.
- `mvn clean test` then completed successfully.

## Remaining Suggestions

- Add controller-level authorization tests for payment and delivery scoping.
- Move integration tests to a dedicated test database or Testcontainers PostgreSQL for stronger isolation.
- Add a CI secret scan and run `mvn clean test` in CI.

## Additional Fixes Completed

- Converted remaining public entity responses to DTOs for cart, ledger, distributor nearby, drivers, product create, order place, and order accept endpoints.
- Added `createdAt` to DTOs used by JSP tables.
- Added `ApiExceptionHandler` so common API validation and authorization failures return clear 400/403 JSON responses.
- Updated `BUG_REPORT.md` so stale open items now reflect resolved status.
