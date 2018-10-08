#!/bin/bash

function peek-config {
  find /etc/nginx/conf.d/ -type f -printf "%T@ %p;"
}

function watch-config {
  last="$(peek-config)"
  while true; do
    next="$(peek-config)"
    if ! [ "$last" == "$next" ]; then
      echo signal
      last="$next"
    fi
    sleep 1s
  done
}

function update-config {
  nginx -s reload
}

function auto-update-config {
  watch-config | while read signal; do
    echo "Configuration changed. Reloading..."
    update-config
  done
}


auto-update-config & nginx -g "daemon off;"
