#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Memory Usage Monitor ===${NC}\n"

# Memory Usage
echo -e "${YELLOW}Memory Usage:${NC}"
free -h

# Swap Usage
echo -e "\n${YELLOW}Swap Usage:${NC}"
swapon --show

# Top Memory Processes
echo -e "\n${YELLOW}Top Memory Processes:${NC}"
ps aux --sort=-%mem | head -n 6

# Memory Statistics
echo -e "\n${YELLOW}Detailed Memory Statistics:${NC}"
cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable|Buffers|Cached|SwapTotal|SwapFree"

# Check if swap is being used
SWAP_USED=$(free | grep Swap | awk '{print $3}')
if [ "$SWAP_USED" -gt 0 ]; then
    echo -e "\n${RED}Warning: Swap is being used${NC}"
    echo "Current swap usage: $SWAP_USED KB"
else
    echo -e "\n${GREEN}Swap is not being used${NC}"
fi

# Memory Pressure
echo -e "\n${YELLOW}Memory Pressure:${NC}"
cat /proc/pressure/memory

# Check for memory leaks
echo -e "\n${YELLOW}Checking for potential memory leaks:${NC}"
ps aux | awk '{print $6/1024 " MB\t\t" $11}' | sort -k1 -n -r | head -n 5

# Memory Optimization Suggestions
echo -e "\n${YELLOW}Memory Optimization Suggestions:${NC}"
if [ "$SWAP_USED" -gt 0 ]; then
    echo "1. Consider increasing RAM if swap usage is frequent"
fi
if [ $(free | grep Mem | awk '{print $3/$2 * 100.0}') -gt 80 ]; then
    echo "2. High memory usage detected. Consider closing unnecessary applications"
fi 