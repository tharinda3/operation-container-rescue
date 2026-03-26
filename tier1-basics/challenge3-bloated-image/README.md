# 🟢 Challenge 3: The Bloated Image

**Points: 10**

## Situation

The image works but it's 1.2GB! The ops team is complaining about registry storage costs and slow deployments. Your mission: slim it down to under 200MB using multi-stage builds.

## Your Task

1. Build the current Dockerfile and note the image size
2. Refactor using a multi-stage build
3. Get the final image under 200MB
4. Run the validation script to capture your flag

## Commands You'll Need

```bash
# Build and check size
docker build -t challenge3:bloated .
docker images challenge3:bloated

# After your fix
docker build -t challenge3:slim .
docker images challenge3:slim

# Validate
./validate.sh
```

## Hints

<details>
<summary>Hint 1 (mild)</summary>
Multi-stage builds let you use one image to build and another to run.
</details>

<details>
<summary>Hint 2 (medium)</summary>
Build with golang:1.21, but run with alpine or scratch.
</details>

<details>
<summary>Hint 3 (spicy)</summary>
Use "FROM golang:1.21 AS builder" then "FROM alpine:3.19" and COPY --from=builder
</details>
