# Project Bug Report

Generated: 2026-06-08  
Updated: 2026-06-09

## Current Status

All bugs identified in the review pass have been addressed and verified with tests.

Latest verification:

- `mvn test -q` passed.
- Final full clean verification: `mvn clean test` passed with 7 tests, 0 failures, 0 errors.

## Resolved Bugs

1. Role escalation during login
   - Existing users can no longer silently change roles by logging in with another role.
   - Regression coverage exists in `AuthServiceTest`.

2. Suspended account access
   - Auth service, JWT auth filter, and session auth filter enforce active account status.
   - Refresh token use after suspension is covered by integration test.

3. Direct entity exposure from public APIs
   - Public controllers now return explicit DTOs for users, distributors, products, orders, payments, deliveries, cart items, and ledger entries.
   - Response DTOs include the fields required by JSP pages, including `createdAt` where tables show dates.

4. Admin account lifecycle endpoints
   - Admin approve/suspend endpoints exist and write audit events.

5. Source compile failures
   - Missing imports, stale constructor calls, and missing profile getters were fixed.

6. Page response mismatch in JSP pages
   - JSP scripts now use `wmRows(data)` to support both arrays and Spring `Page` responses.

7. Request validation gaps
   - Request bodies with validation annotations now use `@Valid`.

8. Payment and delivery authorization scope
   - Payment and delivery APIs now scope data by user role.

9. Unbounded page size
   - Paged endpoints now use bounded page sizes with a maximum of 100.

10. CSRF disabled globally
   - CSRF is enabled by default; current bearer/API and auth routes are explicitly excluded.

11. Production default secret risk
   - `ProductionConfigValidator` blocks the `prod` profile when default dev JWT secret or DB password is still configured.

12. API exception handling
   - Common validation, bad request, and authorization failures now return explicit 400/403 JSON responses instead of accidental 500 errors.

## Remaining Recommendations

- Add deeper controller authorization tests for payment, delivery, driver list, cart, and order scope.
- Move integration tests to Testcontainers PostgreSQL or a dedicated test database profile.
- Add CI with `mvn clean test` and a secret scan.
