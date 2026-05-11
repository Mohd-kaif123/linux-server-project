#!/bin/bash

# ============================================================
#  user-setup.sh — Linux User Management Script
#  Author  : Mohd Kaif Mansoori
#  Purpose : Multiple Linux users ek saath create karna
#            Manually ek-ek karne ki zaroorat nahi
#  Usage   : sudo bash user-setup.sh
# ============================================================

# ---- Configuration ----------------------------------------
USERS=("devuser1" "devuser2" "testuser" "deployuser")
DEFAULT_PASSWORD="Change@123"   # Production mein alag password rakho
SUDO_USERS=("devuser1")         # Sirf ye users ko sudo access milega
# -----------------------------------------------------------

echo "========================================"
echo " User Management Script"
echo " Author  : Mohd Kaif Mansoori"
echo " Started : $(date)"
echo "========================================"

# Root check — ye script sudo se chalni chahiye
if [ "$EUID" -ne 0 ]; then
    echo "[ERROR] Please run as root: sudo bash user-setup.sh"
    exit 1
fi

SUCCESS=0
FAILED=0

for USER in "${USERS[@]}"; do

    # Check karo user pehle se hai ya nahi
    if id "$USER" &>/dev/null; then
        echo "[SKIP]  User '$USER' already exists — skipping"
        continue
    fi

    # User create karo (-m = home directory bhi banao)
    useradd -m -s /bin/bash "$USER"

    if [ $? -eq 0 ]; then
        # Password set karo
        echo "$USER:$DEFAULT_PASSWORD" | chpasswd

        # Sudo group mein add karo (sirf SUDO_USERS walo ko)
        for SUDO_USER in "${SUDO_USERS[@]}"; do
            if [ "$USER" == "$SUDO_USER" ]; then
                usermod -aG sudo "$USER"
                echo "[SUDO]  '$USER' ko sudo access diya gaya"
            fi
        done

        echo "[OK]    User '$USER' successfully create hua"
        echo "        Home: /home/$USER"
        SUCCESS=$((SUCCESS + 1))
    else
        echo "[FAIL]  User '$USER' create nahi hua"
        FAILED=$((FAILED + 1))
    fi

done

echo ""
echo "========================================"
echo " Summary"
echo " Successfully created : $SUCCESS users"
echo " Failed               : $FAILED users"
echo " Finished             : $(date)"
echo "========================================"
echo ""
echo "Verify karne ke liye yeh command chalao:"
echo "  cat /etc/passwd | grep -E 'devuser|testuser|deployuser'"
