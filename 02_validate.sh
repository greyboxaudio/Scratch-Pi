#!/bin/bash
groups
ulimit -r
ulimit -l
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
pstree -s