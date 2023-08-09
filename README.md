---

# Server RTM Slack Bot 

This is slack bot for server's Real Time Monitoring (Disk, Memory, CPU Usage)


```bash
git clone https://github.com/maisonde3cochons/slack_bot_rtm.git
cd slackbot

pip install slack-sdk

# update Slack OAuth Token & Channel Name inside 'slack_config.py' file
```

## Usage

run bash shell files


```bash
nohup sh check_cpu_usage.sh &
nohup sh check_memory_usage.sh &
nohup sh check_disk_usage.sh &

```

