#!/usr/bin/env bash

for i in {1..5}; do
  page=$(curl -s "https://wttr.in/")
  if [[ $? == 0 ]]; then
    temp=$(echo "$page" | sed -n '4p' | awk '{print $(NF-1), $NF}')
    location="Weather in $(echo "$page" | sed -n '1p' | sed 's/^Weather report: //')"
    condition=$(echo "$page" | tail -n +2 | grep -m1 '[A-Za-z]' | sed 's/^.*[[:space:]]\{2,\}//')

    # Emoji mapping
    case "$condition" in
	"Sunny") icon="☀️" ;;
	"Clear") icon="🌙" ;;
	"Partly cloudy") icon="⛅️" ;;
	"Cloudy"|"Overcast") icon="☁️" ;;
	"Mist"|"Fog"|"Freezing fog") icon="🌫️" ;;
	"Patchy rain possible"|"Patchy light drizzle"|"Light drizzle") icon="🌦️" ;;
	"Freezing drizzle"|"Heavy freezing drizzle") icon="🌧️" ;;
	"Light rain"|"Patchy light rain"|"Moderate rain"|"Heavy rain"|"Light rain shower"|"Moderate or heavy rain shower") icon="🌧️" ;;
	"Thundery outbreaks possible"|"Patchy light rain with thunder"|"Moderate or heavy rain with thunder") icon="⛈️" ;;
	"Light snow"|"Patchy light snow"|"Moderate snow"|"Heavy snow"|"Light snow showers") icon="🌨️" ;;
	"Blizzard"|"Patchy heavy snow"|"Moderate or heavy snow showers") icon="❄️" ;;
	"Ice pellets"|"Light showers of ice pellets"|"Moderate or heavy showers of ice pellets") icon="🧊" ;;
	"Light sleet"|"Light sleet showers"|"Moderate or heavy sleet"|"Moderate or heavy sleet showers") icon="🌨️" ;;
	"Patchy snow possible") icon="🌨️" ;;
	"Patchy sleet possible") icon="🌧️" ;;
	"Patchy freezing drizzle possible") icon="🌧️" ;;
	"Blowing snow") icon="🌨️" ;;
	"Torrential rain shower") icon="🌧️" ;;
	"Patchy light snow with thunder"|"Moderate or heavy snow with thunder") icon="🌩️" ;;
	*) icon="❓" ;;
    esac

    if [[ -n "$temp" ]]; then
	echo "{\"text\":"$icon $temp", \"tooltip\":\"$location\"}"
	echo "$condition"
	echo "$icon"
	exit 0
    fi
  fi
  sleep 2
done

echo '{"text":"error", "tooltip":"error"}'
