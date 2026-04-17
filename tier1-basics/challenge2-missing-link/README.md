# Challenge 2: The Missing Link

**Points: 10**

## Situation

The container builds and starts, but the application crashes immediately. The logs show an error but the developer swears "it works on my machine!" Your mission: figure out what the container is missing and fix it.

## Your Task

1. Build and run the container
2. Check the logs to diagnose the issue
3. Fix the problem (it is a configuration issue)
4. Run the validation script to capture your flag

## Commands You'll Need

```bash
# Build the image
docker build -t challenge2:fixed .

# Run and see it fail
docker run challenge2:fixed

# Check logs
docker logs <container_id>

# Run with your fix applied
docker run <your_fix_here> challenge2:fixed

# Validate
./validate.sh
```

## Hints

<details>
<summary>Hint 1 (mild)</summary>
The app needs something from its environment to start.
</details>

<details>
<summary>Hint 2 (medium)</summary>
Check what environment variables the app expects.
</details>

<details>
<summary>Hint 3 (spicy)</summary>
Look at app.py. It requires DATABASE_URL to be set. Use the -e flag when running the container.
</details>
