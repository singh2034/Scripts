#!/usr/bin/bash

read -p "Enter Target IP or Domain:" target

echo ""
echo "[+] Target: $target"

echo ""
echo "[+] Checking if target is online..."
ping -c 1 "$target" > /dev/null 2>&1

if [ $? -eq 0 ]; then
	echo "[+] Target is online"
else 
	echo "[-] Target did not respond to ping"
fi

echo ""
echo "[+] Checking common ports..."

ports=(21 22 25 53 80 110 139 143 443 445 3306 8080)

for port in "${ports[@]}"; do
	timeout 1 bash -c "echo > /dev/tcp/$target/$port" 2>/dev/null

	if [ $? -eq 0 ]; then
		echo "[OPEN] Port $port"
	fi
done

echo ""
echo "[+] Recon Complete."
