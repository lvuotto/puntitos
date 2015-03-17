#!/bin/sh

BASE_URL="http://api.openweathermap.org"
WEATHER_AR="/data/2.5/weather?id=3427504&units=metric"
WEATHER_FILE="$HOME/.scripts-data/weather-condition"

weather=$(wget -O - "$BASE_URL$WEATHER_AR" 2> /dev/null | \
          $HOME/.scripts/weather-parser.py)
if [ -z "$weather" ]; then
    weather="n/a" 
fi
echo $weather > $WEATHER_FILE
