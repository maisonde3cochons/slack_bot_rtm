#!/bin/bash

# This script monitors CPU usage
while :
do
  hostName=`hostname`

  # Get used and total memory
  usedMem=$(free | awk '/Mem/{print $3}')
  totalMem=$(free | awk '/Mem/{print $2}')  

  # Calculate memory usage as a percentage
  memUsage=$(echo "scale=2; $usedMem / $totalMem * 100" | bc)

  # Print the usage
  echo "Memory Usage: $memUsage%"

  # Check if CPU usage is beyond 40%, trigger push notification
  if (( $(echo "$memUsage > 40" | bc -l) )); then
    currentTime=$(date +"%Y-%m-%d %H:%M:%S")
    echo "Memory usage is beyond 40%. Calling push notification server..."
    echo "Time : ${currentTime}"
    python3 slackbot_server_alarm/app.py memory ${memUsage} "${currentTime}" "${hostName}" "${hostName}"
  fi
  # Sleep for 10 second
  sleep 10
done
