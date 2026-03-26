#!/bin/bash
echo "🔍 Validating Challenge 5: Volume Vanishing Act"
echo ""

echo "📊 Step 1: Checking if compose stack is running..."
if ! docker compose ps 2>/dev/null | grep -q "running"; then
    echo "❌ Stack not running. Start with: docker compose up -d"
    exit 1
fi

echo "✅ Stack running"
echo ""
echo "📊 Step 2: Inserting test flag into database..."
docker compose exec -T db psql -U postgres -d flagdb -c "CREATE TABLE IF NOT EXISTS flags (value VARCHAR(100) PRIMARY KEY);" 2>/dev/null
docker compose exec -T db psql -U postgres -d flagdb -c "INSERT INTO flags VALUES ('FLAG{PERS1ST3NT_D4T4}') ON CONFLICT DO NOTHING;" 2>/dev/null

echo "📊 Step 3: Restarting stack (moment of truth!)..."
docker compose down >/dev/null 2>&1
sleep 2
docker compose up -d >/dev/null 2>&1
sleep 5

echo "📊 Step 4: Checking if data survived..."
RESULT=$(docker compose exec -T db psql -U postgres -d flagdb -c "SELECT value FROM flags;" 2>/dev/null)

if echo "$RESULT" | grep -q "FLAG{"; then
    echo ""
    echo "🎉 SUCCESS! Data persisted across restart! Your flag:"
    echo "$RESULT" | grep -o "FLAG{[^}]*}"
    echo ""
    echo "⏱️  Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
else
    echo ""
    echo "❌ Data did not persist. Add a volume to the db service!"
fi
