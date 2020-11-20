:: RESET NETWORK ADAPTER SETTINGS
:: https://github.com/wintweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || (echo This script must be Run as Administrator. && pause && exit /b 1)

:: RESET ALL NETWORK SETTINGS
ipconfig /flushdns >nul 2>&1
netsh int ipv4 reset >nul 2>&1
netsh int ipv6 reset >nul 2>&1
netsh winsock reset >nul 2>&1

pause
exit /b 0