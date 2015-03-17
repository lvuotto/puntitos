#!/bin/sh

magnet=${1:-}

if [ -n "$magnet" ]; then
    transmission-remote -a "$magnet"
fi
