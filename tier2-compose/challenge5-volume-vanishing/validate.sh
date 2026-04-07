#!/bin/bash

echo "========================================="
echo "  Challenge 5: Volume Vanishing Act"
echo "========================================="
echo ""

FLAG=$(echo "RkxBR3tQRVJTMVNUM05UX0Q0VDR9" | base64 --decode)

# Check stack is running
if ! docker compose -f "$(dirname "$0")/docker-compose.yml" ps | grep -q "Up"; then
    echo "ERROR: Stack is not running. Start it with: docker compose up -d"
    exit 1
fi

echo "Inserting flag into database..."
docker compose -f "$(dirname "$0")/docker-compose.yml" exec -T db \
    psql -U postgres -d flagdb -c "INSERT INTO flags (value) VALUES ('$FLAG') ON CONFLICT DO NOTHING;"

echo "Restarting stack to test persistence..."
docker compose -f "$(dirname "$0")/docker-compose.yml" down
docker compose -f "$(dirname "$0")/docker-compose.yml" up -d
sleep 8

echo "Checking if data survived the restart..."
RESPONSE=$(curl -s http://localhost:5000/flag 2>/dev/null)

if echo "$RESPONSE" | grep -q "FLAG{"; then
    CAPTURED=$(echo "$RESPONSE" | grep -o 'FLAG{[^}]*}')
    echo ""
    echo "SUCCESS! Data persisted! Flag: $CAPTURED"
    echo "Completed at: $(date)"
else
    echo ""
    echo "Data did not survive the restart."
    echo "Response: $RESPONSE"
    echo "Add a named volume to your docker-compose.yml and try again."
fi
