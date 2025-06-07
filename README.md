# MSI Pulse 16 AI Performance Optimizations

A collection of scripts and configurations for optimizing the performance of MSI Pulse 16 AI laptop running Kubuntu.

## System Specifications
- CPU: Intel Core Ultra 9 185H (16 cores, 22 threads)
- RAM: 64GB DDR5 (2x 32GB @ 5600 MT/s)
- Graphics: 
  - Intel Arc Graphics (integrated)
  - NVIDIA RTX 4070 Max-Q (dedicated)
- OS: Kubuntu

## Features

### 1. CPU Performance Optimization
- CPU governor management
- Thermal management
- Power management optimization
- Core isolation and affinity

### 2. Memory Management
- RAM frequency optimization
- Memory pressure monitoring
- Swap configuration
- Memory leak detection

### 3. System Monitoring
- Real-time CPU monitoring
- Memory usage tracking
- Temperature monitoring
- Performance metrics

## Installation

1. Clone the repository:
```bash
git clone https://github.com/ArsenYeritsyan/msi-pulse16-performance.git
cd msi-pulse16-performance
```

2. Install required dependencies:
```bash
sudo apt update
sudo apt install sysstat lm-sensors mbw lmbench
```

3. Make scripts executable:
```bash
chmod +x scripts/*.sh
```

## Usage

### CPU Monitoring
```bash
./scripts/check_cpu.sh
```

### Memory Monitoring
```bash
./scripts/monitor_memory.sh
```

### RAM Performance
```bash
./scripts/monitor_ram.sh
```

## Scripts

### check_cpu.sh
- CPU information and usage
- Temperature monitoring
- Frequency tracking
- Process monitoring
- Performance mode status

### monitor_memory.sh
- Memory usage statistics
- Swap usage
- Process memory usage
- Memory pressure
- Optimization suggestions

### monitor_ram.sh
- RAM configuration
- Memory bandwidth
- Latency testing
- Frequency monitoring
- Performance recommendations

## Configuration Files

### Memory Optimization
Location: `/etc/sysctl.d/99-memory-optimization.conf`
```conf
vm.swappiness=10
vm.vfs_cache_pressure=50
vm.dirty_ratio=10
vm.dirty_background_ratio=5
vm.dirty_expire_centisecs=500
vm.dirty_writeback_centisecs=100
vm.min_free_kbytes=1048576
vm.zone_reclaim_mode=0
```

### Swap Configuration
Location: `/etc/fstab`
```
/swapfile none swap sw 0 0
```

## Known Issues and Troubleshooting

### RAM Performance Issues

#### Symptoms
- IBECC memory errors reported by EDAC system
- Potential memory stability issues
- Memory running at 5600 MT/s with DDR5 modules

#### Current Configuration
- Total RAM: 64GB (2x 32GB DDR5)
- Memory Type: DDR5 SODIMM
- Speed: 5600 MT/s
- Manufacturer: Wilk Elektronik S.A.
- Part Number: GR5600S564L46/32G

#### Troubleshooting Steps

1. **BIOS Updates**
   - Check for latest BIOS update from MSI
   - BIOS updates often include memory controller improvements
   - Update through MSI Center or BIOS flash

2. **Memory Timing Adjustments**
   - Access BIOS settings (F2 during boot)
   - Try running memory at 5200 MT/s for better stability
   - Enable XMP/DOCP profile if available
   - Run Memory Training if option available

3. **System Stability**
   - Monitor system temperatures
   - Run Memtest86+ for hardware verification
   - Check for physical memory module seating

4. **Performance Monitoring**
   - Use `monitor_ram.sh` script to check:
     - Memory bandwidth
     - Latency
     - Error rates
     - Usage patterns

#### Memory Error Logging
```bash
# Check for memory errors
sudo dmesg | grep -i memory

# View detailed memory information
sudo dmidecode -t memory

# Monitor memory pressure
cat /proc/pressure/memory
```

#### Recommended Settings
- Memory Frequency: 5200-5600 MT/s
- Voltage: 1.1V
- Error Correction: Enabled
- Memory Training: Enabled

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Arsen Yeritsyan

## Acknowledgments

- MSI Pulse 16 AI laptop community
- Kubuntu developers
- Linux kernel developers 