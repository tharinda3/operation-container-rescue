# 🟡 Challenge 4: Network Nightmare

**Points: 20**

## Situation

A three-service stack (web, api, database) can't communicate. The web frontend gets "connection refused" when calling the API, and the API can't reach the database. The Docker Compose file has networking issues.

## Your Task

1. Examine the `docker-compose.yml`
2. Run `docker compose up` and observe the failures
3. Fix the networking configuration
4. Verify all services can communicate
5. Run the validation script to capture your flag

## Commands You'll Need

```bash
# Start the stack (watch it fail)
docker compose up

# After fixing, restart
docker compose down
docker compose up -d

# Check if services can talk
docker compose exec web curl http://api:3000/health

# Validate
./validate.sh
```

## Hints

<details>
<summary>Hint 1 (mild)</summary>
Services need to be on the same network to communicate by service name.
</details>

<details>
<summary>Hint 2 (medium)</summary>
Check if all services are attached to the same network. Also check the network definition.
</details>

<details>
<summary>Hint 3 (spicy)</summary>
The api service is missing the network attachment. Also, service names in URLs must match the compose service names exactly.
</details>

## Network Requirements

Your fixed configuration must satisfy all of the following:
- The web service must be able to reach the api service
- The api service must be able to reach the database service
- The database service should NOT be directly reachable from the web service
- Service names in connection strings must match the Compose service names exactly

There are multiple valid ways to achieve this. Think about which services need
to talk to each other and design your networks accordingly.

