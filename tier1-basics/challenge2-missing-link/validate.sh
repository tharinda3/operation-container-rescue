#!/bin/bash

echo "========================================="
echo "  Challenge 2: The Missing Link"
echo "========================================="
echo ""

# Check the image exists
if ! docker image inspect challenge2:fixed &>/dev/null; then
    echo "ERROR: Image 'challenge2:fixed' not found."
    echo "Build it first with: docker build -t challenge2:fixed ."
    exit 1
fi

# Ask the participant to provide the DATABASE_URL they want to use
echo "You need to run the container with a DATABASE_URL environment variable."
echo ""
read -p "Enter your DATABASE_URL value: " USER_DB_URL

if [ -z "$USER_DB_URL" ]; then
    echo "ERROR: DATABASE_URL cannot be empty. That is the whole point of this challenge!"
    exit 1
fi

# Run the container with the value they provided
docker stop challenge2-test 2>/dev/null
docker rm challenge2-test 2>/dev/null
docker run -d -p 5002:5000 -e DATABASE_URL="$USER_DB_URL" --name challenge2-test challenge2:fixed
sleep 3

# Check the app is responding
RESPONSE=$(curl -s http://localhost:5002/)

docker stop challenge2-test 2>/dev/null
docker rm challenge2-test 2>/dev/null

if echo "$RESPONSE" | grep -q "FLAG{"; then
    FLAG=$(echo "$RESPONSE" | grep -o 'FLAG{[^}]*}')
    echo ""
    echo "SUCCESS! You captured the flag: $FLAG"
    echo "Completed at: $(date)"
else
    echo ""
    echo "ERROR: App did not return a flag."
    echo "Response was: $RESPONSE"
    echo "Check that your DATABASE_URL is set correctly."
fi
