#!/bin/bash
# Configuration
SERVER_IP="100.111.111.111"
NTFY_SERVER="https://ntfy.webhostack.xyz"
NTFY_TOPIC="home-server"
PING_COUNT=2
STATUS_FILE="/root/home_server_status.txt"
# Check server
if ping -c $PING_COUNT $SERVER_IP &> /dev/null; then
    CURRENT_STATUS="UP"
else
    CURRENT_STATUS="DOWN"
fi
# Read last status
if [ -f $STATUS_FILE ]; then
    LAST_STATUS=$(cat $STATUS_FILE)
else
    LAST_STATUS=""
fi
# Compare and notify if changed
if [ "$CURRENT_STATUS" != "$LAST_STATUS" ]; then
    if [ "$CURRENT_STATUS" = "DOWN" ]; then
        curl -d "⚠️ Home server ($SERVER_IP) is DOWN!" $NTFY_SERVER/$NTFY_TOPIC
    else
        curl -d "✅  Home server ($SERVER_IP) is BACK UP!" $NTFY_SERVER/$NTFY_TOPIC
    fi
    echo $CURRENT_STATUS > $STATUS_FILE
fi
