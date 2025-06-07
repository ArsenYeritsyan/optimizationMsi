#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== CPU Performance Monitor ===${NC}\n"

# CPU Information
echo -e "${YELLOW}CPU Information:${NC}"
lscpu | grep -E "Model name|Socket|Thread|Core|CPU\(s\)"

# CPU Usage
echo -e "\n${YELLOW}CPU Usage (per core):${NC}"
mpstat -P ALL 1 1

# Temperature
echo -e "\n${YELLOW}CPU Temperature:${NC}"
sensors | grep "Core"

# CPU Frequency
echo -e "\n${YELLOW}CPU Frequency:${NC}"
cat /proc/cpuinfo | grep "MHz"

# Load Average
echo -e "\n${YELLOW}System Load:${NC}"
uptime | awk '{print "1 min: " $(NF-2) "\n5 min: " $(NF-1) "\n15 min: " $NF}'

# Top CPU Processes
echo -e "\n${YELLOW}Top CPU Processes:${NC}"
ps aux --sort=-%cpu | head -n 6

# CPU Governor
echo -e "\n${YELLOW}CPU Governor:${NC}"
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor | sort | uniq -c

# Check if performance mode is active
if grep -q "performance" /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; then
    echo -e "\n${GREEN}Performance mode is active${NC}"
else
    echo -e "\n${RED}Performance mode is not active${NC}"
    echo "To enable performance mode, run:"
    echo "echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
fi 