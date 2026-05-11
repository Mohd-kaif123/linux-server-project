#!/bin/bash

# ============================================================
#  setup-cron.sh — Cron Jobs Setup Script
#  Author  : Mohd Kaif Mansoori
#  Purpose : Automation ke liye cron jobs set karna
#            Manually roz karne ki zaroorat nahi padegi
# ============================================================

PROJECT_DIR="/home/ubuntu/linux-server-project/scripts"

echo "========================================"
echo " Cron Job Setup Script"
echo " Author  : Mohd Kaif Mansoori"
echo "========================================"
echo ""

# Pehle scripts ko executable banao
chmod 755 "$PROJECT_DIR/cleanup.sh"
chmod 755 "$PROJECT_DIR/server-health.sh"
echo "[OK] Scripts ko executable permissions diye"

# Existing cron jobs backup karo
crontab -l > /tmp/cron_backup.txt 2>/dev/null
echo "[OK] Existing cron jobs backup kiye: /tmp/cron_backup.txt"

# Naye cron jobs add karo
cat >> /tmp/cron_backup.txt << 'EOF'

# === Mohd Kaif Mansoori — Linux Server Project Cron Jobs ===

# Cleanup Script: Roz raat 2:00 AM baje chalega
# Format: minute hour day month weekday command
0 2 * * * /bin/bash /home/ubuntu/linux-server-project/scripts/cleanup.sh >> /home/ubuntu/linux-server-project/logs/cleanup_cron.log 2>&1

# Health Check: Har 6 ghante mein server status check
0 */6 * * * /bin/bash /home/ubuntu/linux-server-project/scripts/server-health.sh >> /home/ubuntu/linux-server-project/logs/health_cron.log 2>&1

EOF

# Cron mein load karo
crontab /tmp/cron_backup.txt
echo "[OK] Cron jobs successfully set kiye!"

echo ""
echo "[ CURRENT CRON JOBS ]"
crontab -l

echo ""
echo "========================================"
echo " Setup COMPLETE"
echo ""
echo " Verify karne ke liye:"
echo "   crontab -l"
echo ""
echo " Log files check karne ke liye:"
echo "   tail -f ~/linux-server-project/logs/cleanup_cron.log"
echo "========================================"
