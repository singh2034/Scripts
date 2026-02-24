Write-Host "Starting Weekly Maintenance..." -ForegroundColor Cyan

# Bypass execution policy only for this session
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Ensure secure protocol
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# ----------------------------
# Windows Updates
# ----------------------------

if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module PSWindowsUpdate -Force -Confirm:$false
}

Import-Module PSWindowsUpdate

Write-Host "Installing Windows Updates..."
Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot

# ----------------------------
# App Updates (winget)
# ----------------------------

Write-Host "Updating Applications..."
winget source reset --force
winget upgrade --all --accept-package-agreements --accept-source-agreements

# ----------------------------
# Cleanup
# ----------------------------

Write-Host "Cleaning TEMP files..."
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# Component Store Cleanup
DISM /Online /Cleanup-Image /StartComponentCleanup

Write-Host "Maintenance Complete. Rebooting in 60 seconds..." -ForegroundColor Green
shutdown /r /t 60
