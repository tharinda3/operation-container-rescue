# Challenge 6: Health Check Hero

**Points: 20**

## Situation

Services are starting in the wrong order, causing cascading failures. The app crashes because the database is not ready when it tries to connect. Your mission: add health checks and proper startup dependencies so everything comes up cleanly.

## Your Task

1. Run `docker compose up` and watch the app fail
2. Add a health check to the database service
3. Configure the app to wait for the database to be healthy before starting
4. Verify there are no errors on startup
5. Run the validation script to capture your flag

## Commands You'll Need

```bash
# Watch it fail
docker compose up

# Check service health
docker compose ps

# View health check status
docker inspect --format='{{.State.Health.Status}}' <container_name>

# After fixing
docker compose down
docker compose up -d

# Validate
./validate.sh
```

## Hints

<details>
<summary>Hint 1 (mild)</summary>
Docker Compose supports healthcheck definitions and depends_on conditions.
</details>

<details>
<summary>Hint 2 (medium)</summary>
PostgreSQL can be health-checked with: pg_isready -U postgres
</details>

<details>
<summary>Hint 3 (spicy)</summary>
Add a healthcheck to the db service, then set depends_on with condition: service_healthy in the app service.
</details>
