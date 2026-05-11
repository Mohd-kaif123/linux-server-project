# Linux Server Setup & Management 🖥️

> **AWS EC2 pe Ubuntu 22.04 server launch karna, SSH se securely connect karna, file permissions manage karna, aur bash scripts ke zariye server automation karna.**

---

## 👤 Author
**Mohd Kaif Mansoori**
- 📧 mansoorikaif365@gmail.com
- 🔗 [LinkedIn](https://linkedin.com/in/mohdkaifmansoori)
- 💻 [GitHub](https://github.com/Mohd-kaif123)

---

## 📌 Project Overview

This project demonstrates real-world Linux server administration skills on AWS cloud infrastructure. It covers:

1. **EC2 Instance Launch** — AWS Free Tier pe Ubuntu server setup
2. **SSH Configuration** — Secure remote access with key-pair authentication
3. **File Permission Management** — Linux chmod, chown, permission model
4. **Bash Script Automation** — Log cleanup, user management, health monitoring
5. **Cron Job Scheduling** — Scripts ko automatically schedule karna

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| AWS EC2 (t2.micro) | Virtual Linux server — Free Tier |
| Ubuntu 22.04 LTS | Server Operating System |
| SSH / OpenSSH | Secure remote connection |
| Bash Scripting | Automation scripts |
| Cron | Job scheduler |
| Git & GitHub | Version control & code storage |

---

## 📁 Project Structure

```
linux-server-project/
│
├── scripts/
│   ├── cleanup.sh          # 7+ din purane log files delete karta hai
│   ├── user-setup.sh       # Multiple Linux users ek saath create karta hai
│   ├── server-health.sh    # CPU, RAM, Disk status check karta hai
│   └── setup-cron.sh       # Cron jobs automatically configure karta hai
│
├── logs/                   # Script output logs yahaan save hote hain
│   ├── cleanup_history.log
│   └── health_report.log
│
├── .gitignore              # Private keys aur sensitive files exclude
└── README.md               # Yeh file
```

---

## 🚀 Setup Steps — A to Z

### Step 1: AWS EC2 Instance Launch Karo

```
AWS Console → EC2 → Launch Instance
  AMI         : Ubuntu Server 22.04 LTS (64-bit)
  Type        : t2.micro (Free Tier eligible)
  Key Pair    : Create new → kaif-key.pem (download karke safe rakho)
  Security Grp: Allow SSH (port 22) from My IP only
  Storage     : 8 GB gp2 (default)
```

### Step 2: SSH Se Connect Karo

```bash
# Key file ko safe banao (sirf owner padh sake)
chmod 400 kaif-key.pem

# Server se connect karo
ssh -i "kaif-key.pem" ubuntu@YOUR_EC2_PUBLIC_IP

# Successfully connect hone par yeh dikhega:
# ubuntu@ip-172-xx-xx-xx:~$
```

### Step 3: Server Update Karo

```bash
sudo apt update
sudo apt upgrade -y
```

### Step 4: Project Clone Karo

```bash
cd ~
git clone https://github.com/Mohd-kaif123/linux-server-project.git
cd linux-server-project
```

### Step 5: Scripts Ko Executable Banao

```bash
chmod 755 scripts/cleanup.sh
chmod 755 scripts/user-setup.sh
chmod 755 scripts/server-health.sh
chmod 755 scripts/setup-cron.sh
```

### Step 6: Scripts Run Karo

```bash
# Log cleanup chalao
bash scripts/cleanup.sh

# User management (sudo chahiye)
sudo bash scripts/user-setup.sh

# Server health check
bash scripts/server-health.sh

# Cron jobs setup karo
bash scripts/setup-cron.sh
```

---

## 📜 Scripts Description

### 1. `cleanup.sh` — Log File Cleanup
**Kya karta hai:** `/var/log` directory mein 7 din se purane `.log` files automatically delete karta hai.

**Kyu zaroori hai:** Log files continuously bante rehte hain. Agar delete na karo toh disk full ho jaati hai aur server crash kar sakta hai.

```bash
bash scripts/cleanup.sh
```

Sample Output:
```
========================================
 Log Cleanup Script
 Started  : Wed Jan 1 02:00:00 UTC 2025
 Log Dir  : /var/log
 Removing : Files older than 7 days
========================================
[INFO] Files to be deleted: 12
[INFO] Files remaining after cleanup: 0
 Cleanup COMPLETE
```

---

### 2. `user-setup.sh` — User Management
**Kya karta hai:** Multiple Linux users ek saath create karta hai, password set karta hai, aur select users ko sudo access deta hai.

**Kyu zaroori hai:** Bade servers mein kai developers hote hain. Har ek ke liye alag user security ke liye zaroori hai (isolation + accountability).

```bash
sudo bash scripts/user-setup.sh
```

Sample Output:
```
[SUDO]  'devuser1' ko sudo access diya gaya
[OK]    User 'devuser1' successfully create hua
[OK]    User 'devuser2' successfully create hua
Successfully created : 3 users
```

---

### 3. `server-health.sh` — Health Monitoring
**Kya karta hai:** CPU, RAM, Disk usage, top processes aur network interfaces ek screen pe dikhata hai.

**Kyu zaroori hai:** Server slow ho toh root cause dhundhne ke liye — disk full? RAM use zyada? Yeh script se ek second mein pata chalta hai.

```bash
bash scripts/server-health.sh
```

---

### 4. `setup-cron.sh` — Automation Setup
**Kya karta hai:** Cleanup aur health check scripts ko cron scheduler mein add karta hai taaki woh automatically chalte rahein.

| Cron Job | Schedule | Kya karta hai |
|----------|----------|--------------|
| cleanup.sh | Roz 2:00 AM | Old logs delete karta hai |
| server-health.sh | Har 6 ghante | Health report save karta hai |

```bash
bash scripts/setup-cron.sh

# Verify karo
crontab -l
```

---

## 🔐 File Permissions Used

```
chmod 400 kaif-key.pem     → Private key: sirf owner padh sake (SSH security)
chmod 755 script.sh        → Script: owner run+edit, others sirf run kar sake
chmod 644 file.txt         → Normal file: owner edit, others sirf padhe
```

**Permission format: rwxrwxrwx (owner | group | others)**
- r = read (4), w = write (2), x = execute (1)
- 7 = rwx, 5 = r-x, 4 = r--

---

## ❌ .gitignore — Kya Upload Nahi Karna

```
*.pem           # Private SSH keys — kabhi push mat karo!
.env            # Environment variables / credentials
*.log           # Log files — bade hote hain, GitHub pe nahi chahiye
__pycache__/
.DS_Store
```

> ⚠️ **Security Rule:** Private key (.pem) kabhi bhi GitHub pe push mat karo. Ek baar public ho gayi toh server compromised ho sakta hai.

---

## 💡 Key Learnings

- AWS EC2 pe Ubuntu server launch karna aur configure karna
- SSH key-pair authentication se secure remote access
- Linux file permission model (chmod, chown, rwx)
- Bash scripting — variables, loops, conditionals, functions
- Cron job scheduling for automation
- Git workflow — commit, push, version control

---

## 📊 Project Stats

- **Scripts Written:** 4
- **Lines of Code:** ~200+
- **AWS Service Used:** EC2 (t2.micro, Free Tier)
- **OS:** Ubuntu 22.04 LTS
- **Year:** 2025
