import os, sys
import slack_config
import json
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

# Slack 토큰 설정
SLACK_TOKEN = slack_config.SLACK_AUTH_CONFIG['token']
client = WebClient(token=SLACK_TOKEN)


# Check if enough arguments are provided
if len(sys.argv) < 6:
    print("Please provide Error Type and Usage(in digits) as arguments.")
    sys.exit(1)

error_type = sys.argv[1]
usage = sys.argv[2]
timestamp = sys.argv[3]
hostName = sys.argv[4]
serverName = sys.argv[5]

print(f"Server Name: {serverName}")
print(f"Error Type: {error_type}")
print(f"Memory Usage: {usage}%")
print(f"Time: {timestamp}")
print(f"Hostname: {hostName}")

# 메시지 내용 
if error_type == "cpu" :
    mrkdwn_message = f"*Service :* {serverName} \n*Host :* {hostName}> \n*Display Name :* CPU Usage \n*발생시각 :* {timestamp} \n*장애구분 :* Critical \n*장애메시지 :* CPU 사용률이 {usage} % 입니다 \n"
elif error_type == "memory" :
    mrkdwn_message = f"*Service :* {serverName} \n*Host :* {hostName} \n*Display Name :* Memory Usage \n*발생시각 :* {timestamp} \n*장애구분 :* Critical \n*장애메시지 :* Memory 사용률이 {usage} % 입니다 \n"
elif error_type == "disk" :
    mrkdwn_message = f"*Service :* {serverName} \n*Host :* {hostName} \n*Display Name :* Disk Usage \n*발생시각 :* {timestamp} \n*장애구분 :* Minor \n*장애메시지 :* Disk 사용률 정보 : {usage} \n"

message = [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": "Cloud Server Usage Monitoring",
                    "emoji": True
                }
            },
            {
                "type": "divider"
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": mrkdwn_message
                }
            },
            {
                "type": "divider"
            }
        ]


# 채널에 메시지 보내기
try:
    response = client.chat_postMessage(
        channel = slack_config.SLACK_AUTH_CONFIG['channel_name'],
        text = "alarm_notification",
        blocks = message
    )
except SlackApiError as e:
    print(f"Error: {e.response['error']}")

