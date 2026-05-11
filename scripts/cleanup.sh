#!/bin/bash

# ============================================================
#  cleanup.sh — Log File Cleanup Script
#  Author  : Mohd Kaif Mansoori
#  Purpose : 7 din se purane log files automatically delete karna
#            Disk space bachane ke liye
# ============================================================

LOG_DIR="/var/log"          # Jahan log files hoti hain
DAYS=7                      # Kitne din purani files delete karni hain
BACKUP_LOG="/home/ubuntu/linux-server-project/logs/cleanup_history.log"

echo "========================================"
echo " Log Cleanup Script"
echo " Started  : $(date)"
echo " Log Dir  : $LOG_DIR"
echo " Removing : Files older than $DAYS days"
echo "========================================"

# Check karo ki LOG_DIR exist karti hai
if [ ! -d "$LOG_DIR" ]; then
    echo "[ERROR] Directory $LOG_DIR not found!"
    exit 1
fi

# Kitni files hain delete hone se pehle
BEFORE=$(find "$LOG_DIR" -name "*.log" -mtime +"$DAYS" 2>/dev/null | wc -l)
echo "[INFO] Files to be deleted: $BEFORE"

# Actual deletion
find "$LOG_DIR" -name "*.log" -mtime +"$DAYS" -exec rm -f {} \; 2>/dev/null

# Confirm karo
AFTER=$(find "$LOG_DIR" -name "*.log" -mtime +"$DAYS" 2>/dev/null | wc -l)
echo "[INFO] Files remaining after cleanup: $AFTER"

# History log mein save karo
echo "$(date) | Deleted $BEFORE old log files from $LOG_DIR" >> "$BACKUP_LOG"

echo "========================================"
echo " Cleanup COMPLETE"
echo " Finished : $(date)"
echo "========================================"
