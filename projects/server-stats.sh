#!/usr/bin/env bash
# server-stats.sh - basic server performance stats for any Linux box
# Usage: ./server-stats.sh   (run as root to see failed login attempts)

set -u

line() { printf '%*s\n' 50 '' | tr ' ' '-'; }
title() { echo; line; echo " $1"; line; }

# ---------- OS / uptime / load ----------
title "SYSTEM INFO"
if [ -r /etc/os-release ]; then
    . /etc/os-release
    echo "OS Version   : ${PRETTY_NAME:-unknown}"
fi
echo "Kernel       : $(uname -r)"
echo "Hostname     : $(hostname)"
echo "Uptime       : $(uptime -p 2>/dev/null || uptime)"
echo "Load Average : $(cut -d' ' -f1-3 /proc/loadavg)  (1, 5, 15 min)"
echo "Logged in    : $(who | wc -l) user(s)"
who | awk '{printf "               - %s (%s)\n", $1, $2}'

# ---------- CPU ----------
title "TOTAL CPU USAGE"
read -r _ u1 n1 s1 i1 w1 q1 sq1 st1 _ < /proc/stat
sleep 1
read -r _ u2 n2 s2 i2 w2 q2 sq2 st2 _ < /proc/stat
idle1=$((i1 + w1));  idle2=$((i2 + w2))
total1=$((u1 + n1 + s1 + i1 + w1 + q1 + sq1 + st1))
total2=$((u2 + n2 + s2 + i2 + w2 + q2 + sq2 + st2))
dt=$((total2 - total1)); di=$((idle2 - idle1))
awk -v dt="$dt" -v di="$di" 'BEGIN {
    if (dt == 0) dt = 1
    printf "CPU Used : %.1f%%\nCPU Idle : %.1f%%\n", (dt-di)*100/dt, di*100/dt
}'

# ---------- Memory ----------
title "MEMORY USAGE"
free -m | awk '/^Mem:/ {
    total=$2; avail=$7; used=total-avail; if (total==0) total=1
    printf "Total : %d MB\nUsed  : %d MB (%.1f%%)\nFree  : %d MB (%.1f%%)\n",
           $2, used, used*100/total, avail, avail*100/total
}'

# ---------- Disk ----------
title "DISK USAGE (all real filesystems)"
df -BM --total -x tmpfs -x devtmpfs -x squashfs -x overlay 2>/dev/null | awk '/^total/ {
    gsub("M","",$2); gsub("M","",$3); gsub("M","",$4)
    t=$2; if (t==0) t=1
    printf "Total : %.1f GB\nUsed  : %.1f GB (%.1f%%)\nFree  : %.1f GB (%.1f%%)\n",
           $2/1024, $3/1024, $3*100/t, $4/1024, $4*100/t
}'

# ---------- Top processes ----------
title "TOP 5 PROCESSES BY CPU"
ps -eo pid,user,comm,%cpu,%mem --sort=-%cpu | head -n 6

title "TOP 5 PROCESSES BY MEMORY"
ps -eo pid,user,comm,%cpu,%mem --sort=-%mem | head -n 6

# ---------- Failed logins ----------
title "FAILED LOGIN ATTEMPTS"
if [ "$(id -u)" -ne 0 ]; then
    echo "Run as root to see failed login attempts."
elif command -v lastb >/dev/null 2>&1 && [ -s /var/log/btmp ]; then
    echo "Total failed (btmp): $(lastb 2>/dev/null | grep -vc -e '^$' -e '^btmp')"
elif [ -r /var/log/auth.log ]; then
    echo "Total failed (auth.log): $(grep -c 'Failed password' /var/log/auth.log)"
elif [ -r /var/log/secure ]; then
    echo "Total failed (secure): $(grep -c 'Failed password' /var/log/secure)"
elif command -v journalctl >/dev/null 2>&1; then
    echo "Total failed (journal): $(journalctl _COMM=sshd 2>/dev/null | grep -c 'Failed password')"
else
    echo "No readable login log found."
fi
echo



#!/usr/bin/bash
# basic server performance stats for any linux box
# run as root to see failed login attempts

set -U

line() { printf '%*s\n' 50 '' | tr ' ' '-'; }
title() { echo; line; echo " $1"; line; }

# OS / Uptime / Load
title "SYSTEM INFO"

if [ -r /etc/os-release ]; then
    . /etc/os-release
    echo "OS Version : ${PRETTY_NAME:-unknown}"
fi
echo "Kernal : $(uname -r)"
echo "Hostname : $(hostname)"
echo "Uptime : $(uptime -p 2>/dev/null || uptime)"
echo "Load Average : $(cut -d' ' -f1-3 /proc/loadavg) (1, 5, 15 min)"
echo "Logged in : $(who | wc -l) user(s)"
who | awk '{printf " - %s (%s)\n", $1, $2}'

# CPU
title "Total CPU Usage"
read -r _ u1 n1 s1 i1 w1 q1 sq1 st1 _ < /proc/stat
sleep 1 
read -r _ u2 n2 s2 i2 w2 q2 sq2 st2 _ < /proc/stat
idle=$((i1 + w1)); idle2=$((i2 + w2))
total1=$((u1 + n1 + s1 + i1 + w1 + q1 + sq1 + st1))
total2=$((u2 + n2 + s2 + i2 + w2 + q2 + sq2 + st2))
dt=$((total2 - total1)); di=$((idle2 - idle1))
awk -v dt="$dt" -v di="$di" 'BEGIN {
    if (dt == 0 ) dt = 1
    printf "CPU used : %.1f%%\nCPU Idle : %.1f%%\n", (dt-di)*100/dt, di*100/dt
}'

# Memory
title "MEMORY USAGE"
free -m | awk '/^Mem:/ {
    total=$2; avail=$7; used=total-avail
}'