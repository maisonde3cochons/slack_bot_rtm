#!/bin/bash

while :
do
  if df -h | awk 'NR > 1 && $5+0 > 90 { exit 1 }'; then
    echo "Filesystem usage is within limits."
  else
    disk_usage_info=`df -h | awk 'NR > 1 && $5+0 > 90 { print "Filesystem : " $1 " Usage : " $5 " Mounted on : " $6 " " }'`
    currentTime=$(date +"%Y-%m-%d %H:%M:%S")
    echo "Disk usage is beyond 90%. Calling push notification server..."
    echo "Time : ${currentTime}"
    python3 slackbot/app.py disk "${disk_usage_info}" "${currentTime}" "${hostName}" "${hostName}"
  fi
  sleep 10
done
