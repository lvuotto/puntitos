#!/usr/bin/env python3

import json
import sys

BASE_URL = "http://api.openweathermap.org"
WEATHER_URL = "/data/2.5/weather?q=Vicente%20Lopez,ar&units=metric"

try:
    w = json.load(sys.stdin)
    if len(w) != 0:
        print("{:.1f} ºC".format(w["main"]["temp"]))
    else:
        print("n/a")
except:
    print("n/a")
