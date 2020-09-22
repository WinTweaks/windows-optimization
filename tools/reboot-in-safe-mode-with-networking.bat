:: REBOOT IN SAFE MODE WITH NETWORKING
:: https://github.com/WinTweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || (echo This script must be Run as Administrator. && pause && exit /b 1)

:: CHANGE BOOT SETTINGS
bcdedit /deletevalue safebootalternateshell >nul 2>&1
bcdedit /set safeboot network >nul 2>&1

:: RESTART
shutdown /r /f /t 5
