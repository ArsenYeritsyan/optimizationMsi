#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== RAM Performance Monitor ===${NC}\n"

# RAM Information
echo -e "${YELLOW}RAM Configuration:${NC}"
sudo dmidecode --type memory | grep -E "Size|Type|Speed|Configured Memory Speed|Manufacturer|Part Number" | grep -v "Unknown"

# Current Memory Usage
echo -e "\n${YELLOW}Current Memory Usage:${NC}"
free -h

# Memory Bandwidth Test (if available)
if command -v mbw &> /dev/null; then
    echo -e "\n${YELLOW}Memory Bandwidth Test:${NC}"
    mbw -n 1 100 | grep "AVG"
else
    echo -e "\n${YELLOW}Memory Bandwidth Test:${NC}"
    echo "mbw not installed. Install with: sudo apt install mbw"
fi

# Memory Latency Test
echo -e "\n${YELLOW}Memory Latency:${NC}"
if command -v lmbench &> /dev/null; then
    lmbench
else
    echo "lmbench not installed. Install with: sudo apt install lmbench"
fi

# Memory Pressure
echo -e "\n${YELLOW}Memory Pressure:${NC}"
cat /proc/pressure/memory

# Memory Statistics
echo -e "\n${YELLOW}Detailed Memory Statistics:${NC}"
cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable|Buffers|Cached|Active|Inactive|Dirty|Writeback"

# Memory Frequency
echo -e "\n${YELLOW}Memory Frequency:${NC}"
sudo dmidecode --type memory | grep -E "Speed|Configured Memory Speed"

# Memory Timings
echo -e "\n${YELLOW}Memory Timings:${NC}"
sudo dmidecode --type memory | grep -A 20 "Memory Device" | grep -E "Speed|Configured Memory Speed|Minimum Voltage|Maximum Voltage"

# Performance Recommendations
echo -e "\n${YELLOW}Performance Recommendations:${NC}"
if [ $(free | grep Mem | awk '{print $3/$2 * 100.0}') -gt 80 ]; then
    echo "1. High memory usage detected. Consider closing unnecessary applications"
fi

if [ $(cat /proc/meminfo | grep "Dirty" | awk '{print $2}') -gt 100000 ]; then
    echo "2. High number of dirty pages. Consider syncing: sudo sync"
fi

# Memory Optimization Status
echo -e "\n${YELLOW}Memory Optimization Status:${NC}"
if grep -q "vm.swappiness=10" /etc/sysctl.d/99-memory-optimization.conf; then
    echo -e "${GREEN}✓ Memory optimization settings are applied${NC}"
else
    echo -e "${RED}✗ Memory optimization settings are not applied${NC}"
    echo "Run: echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-memory-optimization.conf"
fi

# Check if memory frequency is at maximum
MAX_SPEED=$(sudo dmidecode --type memory | grep "Speed" | head -n 1 | awk '{print $2}')
CURRENT_SPEED=$(sudo dmidecode --type memory | grep "Configured Memory Speed" | head -n 1 | awk '{print $4}')

if [ "$MAX_SPEED" = "$CURRENT_SPEED" ]; then
    echo -e "${GREEN}✓ Memory is running at maximum speed (${MAX_SPEED} MT/s)${NC}"
else
    echo -e "${RED}✗ Memory is not running at maximum speed${NC}"
    echo "Current: ${CURRENT_SPEED} MT/s"
    echo "Maximum: ${MAX_SPEED} MT/s"
fi 