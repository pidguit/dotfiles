#!/bin/bash

TIMESTAMP_FILE="/tmp/media_last_playing"
PLAYER_FILE="/tmp/media_current_player"
CURRENT_TIME=$(date +%s)

# Check if an action argument is provided (for controls)
if [ -n "$1" ]; then
    # Read the current player (default to spotify if file missing)
    PLAYER=$(cat "$PLAYER_FILE" 2>/dev/null || echo "spotify")
    
    # Execute the requested action
    case "$1" in
        play-pause)
            playerctl -p "$PLAYER" play-pause
            ;;
        next)
            playerctl -p "$PLAYER" next
            ;;
        previous)
            playerctl -p "$PLAYER" previous
            ;;
    esac
    exit 0
fi

# Check if playerctl is available
if ! command -v playerctl &> /dev/null; then
    echo ""
    exit 0
fi


# Get the first available player (prioritize Spotify)
PLAYER=""
if playerctl -p spotify status &> /dev/null; then
    PLAYER="spotify"
elif playerctl -l 2>/dev/null | grep -q vlc; then
    PLAYER="vlc"
else
    echo ""
    exit 0
fi

# Save the current player
echo "$PLAYER" > "$PLAYER_FILE"

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
