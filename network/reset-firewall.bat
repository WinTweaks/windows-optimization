:: RESET WINDOWS FIREWALL
:: https://github.com/wintweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || (echo This script must be Run as Administrator. && pause && exit /b 1)

netsh advfirewall set allprofiles state off
netsh advfirewall reset
netsh advfirewall set allprofiles state on
