# 🟡 Challenge 5: Volume Vanishing Act

**Points: 20**

## Situation

The database keeps losing all its data whenever the containers restart! The flag is stored in the database, but every time you run `docker compose down && docker compose up`, it's gone. Implement proper volume persistence.

## Your Task

1. Run the stack and insert the test data
2. Run `docker compose down` then `docker compose up`
3. Notice the data is gone!
4. Fix the docker-compose.yml to persist the database
5. Verify data survives restarts
6. Run the validation script to capture your flag

## Commands You'll Need

```bash
# Start stack
docker compose up -d

# Insert test data
docker compose exec db psql -U postgres -d flagdb -c "INSERT INTO flags VALUES ('FLAG{PERS1ST3NT_D4T4}');"

# Restart (data will be lost without fix!)
docker compose down
docker compose up -d

# Check if data survived
docker compose exec db psql -U postgres -d flagdb -c "SELECT * FROM flags;"

# Validate
./validate.sh
```

## Hints

<details>
<summary>Hint 1 (mild)</summary>
Containers are ephemeral. Volumes are not.
</details>

<details>
<summary>Hint 2 (medium)</summary>
PostgreSQL stores data in /var/lib/postgresql/data
</details>

<details>
<summary>Hint 3 (spicy)</summary>
Add a named volume and mount it to /var/lib/postgresql/data in the db service.
</details>
