#!/bin/bash

   TIMESTAMP_FILE="/tmp/media_last_playing"
   CURRENT_TIME=$(date +%s)

   # Check if playerctl and Spotify are available
   if ! command -v playerctl &> /dev/null || ! playerctl -p spotify status &> /dev/null; then
       echo ""
       exit 0
   fi

   # Get player status
   STATUS=$(playerctl -p spotify status 2>/dev/null)

   # Update timestamp if playing
   if [ "$STATUS" = "Playing" ]; then
       echo "$CURRENT_TIME" > "$TIMESTAMP_FILE"
   fi

   # Read last playing time (default 0 if file missing)
   LAST_PLAYING_TIME=$(cat "$TIMESTAMP_FILE" 2>/dev/null || echo 0)

   # Check if paused/stopped for more than 30 seconds
   if [ "$STATUS" != "Playing" ] && [ $((CURRENT_TIME - LAST_PLAYING_TIME)) -gt 30 ]; then
       echo ""
       exit 0
   fi

   # Output media info if playing or within 2 minutes
   playerctl -p spotify metadata --format "{\"text\": \"{{artist}} - {{title}}\", \"alt\": \"spotify\", \"class\": \"spotify\"}"
