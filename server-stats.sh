#!/bin/bash
#

echo "=============================="
echo "     SERVER PERFORMANCE       "
echo "=============================="
echo

# OS Info
echo "OS Version:"
if [ -f /etc/os-release ]; then
	grep -E 'PRETTY_NAME' /etc/os-release | cut -d= -f2 | tr -d '"'
else
	uname -a
fi
echo

#uptime & Load

echo "Uptime & Load Average:"
uptime
echo

#CPU Usage

echo "Total CPU Usage:"
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
CPU_USED=$((100 - CPU_IDLE))
echo "Used: ${CPU_USED}%"
echo


# Memory Usage
echo "Memory Usage:"
free -m | awk 'NR==2{
    used=$3; free=$4; total=$2;
    printf "Used: %dMB (%.2f%%)\nFree: %dMB (%.2f%%)\n", used, used/total*100, free, free/total*100
}'
echo


# Disk Usage
echo "Disk Usage (/):"
df -h / | awk 'NR==2{
    printf "Used: %s (%s)\nFree: %s (%s)\n", $3, $5, $4, 100-$5"%"
}'
echo


# Top 5 Processes by CPU
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# Top 5 Processes by Memory
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

# Logged-in Users
echo "Logged-in Users:"
who
echo




echo
echo "=============================="
echo "         END OF REPORT        "
echo "=============================="



