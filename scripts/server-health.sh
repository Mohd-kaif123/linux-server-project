#!/bin/bash

# ============================================================
#  server-health.sh — Server Health Check Script
#  Author  : Mohd Kaif Mansoori
#  Purpose : Server ki CPU, RAM, Disk status ek baar mein dekho
#            Troubleshooting aur monitoring ke liye
# ============================================================

REPORT_FILE="/home/ubuntu/linux-server-project/logs/health_report.log"

echo "========================================"
echo " SERVER HEALTH CHECK"
echo " Time    : $(date)"
echo " Host    : $(hostname)"
echo " User    : $(whoami)"
echo "========================================"

# --- CPU Usage ---
echo ""
echo "[ CPU USAGE ]"
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'%' -f1)
CPU_USED=$(echo "100 - $CPU_IDLE" | bc 2>/dev/null || echo "Check top manually")
echo "  CPU Used  : ${CPU_USED}%"
echo "  CPU Idle  : ${CPU_IDLE}%"

# --- RAM Usage ---
echo ""
echo "[ MEMORY (RAM) USAGE ]"
free -h | awk 'NR==2 {
    printf "  Total     : %s\n", $2
    printf "  Used      : %s\n", $3
    printf "  Free      : %s\n", $4
}'

# --- Disk Usage ---
echo ""
echo "[ DISK USAGE ]"
df -h / | awk 'NR==2 {
    printf "  Total     : %s\n", $2
    printf "  Used      : %s  (%s)\n", $3, $5
    printf "  Available : %s\n", $4
}'

# Warning agar disk 80% se zyada bhar gayi
DISK_PCT=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
if [ "$DISK_PCT" -gt 80 ]; then
    echo "  [WARNING] Disk 80% bhar gaya hai! Cleanup karo."
fi

# --- Running Processes ---
echo ""
echo "[ TOP 5 PROCESSES (CPU) ]"
ps aux --sort=-%cpu | awk 'NR<=6 {printf "  %-20s %s%%\n", $11, $3}'

# --- Network ---
echo ""
echo "[ NETWORK INTERFACES ]"
ip addr show | grep 'inet ' | awk '{printf "  IP: %s\n", $2}'

# --- Uptime ---
echo ""
echo "[ SERVER UPTIME ]"
echo "  $(uptime -p)"

echo ""
echo "========================================"
echo " Health check COMPLETE"
echo "========================================"

# Log mein save karo
echo "$(date) | Disk: ${DISK_PCT}% | $(free -m | awk 'NR==2 {printf "RAM Used: %sMB", $3}')" >> "$REPORT_FILE"
echo "[INFO] Report saved to: $REPORT_FILE"
