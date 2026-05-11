#!/bin/bash

# ============================================================
#  git-commands.sh — Is Project Ko GitHub Pe Upload Karne Ke Steps
#  Author: Mohd Kaif Mansoori
#
#  YEH SCRIPT DIRECTLY RUN MAT KARO.
#  Ek-ek command copy karke terminal mein chalao.
# ============================================================

# ----------------------------------------------------------
# STEP 1: Apne laptop/server pe git configure karo
# ----------------------------------------------------------
git config --global user.name "Mohd-kaif123"
git config --global user.email "mansoorikaif****@gmail.com"

# ----------------------------------------------------------
# STEP 2: Project folder mein jaao
# ----------------------------------------------------------
cd ~/linux-server-project

# ----------------------------------------------------------
# STEP 3: Git initialize karo (sirf pehli baar)
# ----------------------------------------------------------
git init

# ----------------------------------------------------------
# STEP 4: GitHub pe naya repository banao
#   - github.com pe login karo
#   - "New Repository" click karo
#   - Name: linux-server-project
#   - Public rakho
#   - README add mat karo (hum khud likhenge)
# ----------------------------------------------------------

# ----------------------------------------------------------
# STEP 5: Remote add karo (apna username daalo)
# ----------------------------------------------------------
git remote add origin git@github.com:Moh**************-server-project.git

# ----------------------------------------------------------
# STEP 6: Saari files stage karo
# ----------------------------------------------------------
git add .

# ----------------------------------------------------------
# STEP 7: Pehla commit karo
# ----------------------------------------------------------
git commit -m "Initial commit: Linux server automation scripts

- cleanup.sh: Auto log cleanup (7 days)
- user-setup.sh: Bulk user creation
- server-health.sh: CPU/RAM/Disk monitoring
- setup-cron.sh: Cron job configuration
- README.md: Full project documentation"

# ----------------------------------------------------------
# STEP 8: GitHub pe push karo
# ----------------------------------------------------------
git branch -M main
git push -u origin main

# ----------------------------------------------------------
# STEP 9: Verify — GitHub pe jaake dekho ✓
# ----------------------------------------------------------
echo "Done! GitHub pe jaao aur apna project dekho:"
echo "git@github.com:Mo***************rver-project.git"
