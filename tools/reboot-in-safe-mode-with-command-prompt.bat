:: REBOOT IN SAFE MODE WITH COMMAND PROMPT
:: https://github.com/wintweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || (echo This script must be Run as Administrator. && pause && exit /b 1)

:: CHANGE BOOT SETTINGS
bcdedit /set safeboot minimal >nul 2>&1
bcdedit /set safebootalternateshell yes >nul 2>&1

:: RESTART
shutdown /r /f /t 5
