#!/bin/bash

# This script monitors CPU usage
while :
do
  hostName=`hostname`

  # Get the current usage of CPU
  cpuUsage=$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print 100 - $1}')  

  # Print the usage
  echo "CPU Usage: $cpuUsage%"

  # Check if CPU usage is beyond 40%, trigger push notification
  if (( $(echo "$cpuUsage > 40" | bc -l) )); then
    currentTime=$(date +"%Y-%m-%d %H:%M:%S:%3N")
    echo "CPU usage is beyond 40%. Calling push notification server..."
    echo "Time : ${currentTime}"
    python3 slackbot_server_alarm/app.py cpu ${cpuUsage} "${currentTime}" "${hostName}" "${hostName}"
  fi
  # Sleep for 10 second
  sleep 10
done
