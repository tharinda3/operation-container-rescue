# 🟢 Challenge 1: The Broken Build

**Points: 10**

## Situation

A developer pushed a Dockerfile that won't build. The CI pipeline is failing and the team is blocked. Your mission: fix the Dockerfile so it builds successfully.

## Your Task

1. Examine the `Dockerfile` in this directory
2. Identify and fix the errors (there are multiple!)
3. Build the image successfully
4. Run the validation script to capture your flag

## Commands You'll Need

```bash
# Build the image
docker build -t challenge1:fixed .

# Validate your solution
./validate.sh
```

## Hints

<details>
<summary>Hint 1 (mild)</summary>
Check the syntax carefully — every instruction matters.
</details>

<details>
<summary>Hint 2 (medium)</summary>
The base image reference and COPY instruction have issues.
</details>

<details>
<summary>Hint 3 (spicy)</summary>
FROM needs a valid image, COPY needs the source to exist, and RUN commands need valid syntax.
</details>
