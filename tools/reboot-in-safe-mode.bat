:: REBOOT IN SAFE MODE
:: https://github.com/WinTweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
whoami /groups | find "12288" >nul 2>&1
if %errorlevel% neq 0 (
	echo This batch file must be Run as Administrator.
	pause
	exit /b 1
)

:: CHANGE BOOT SETTINGS
bcdedit /deletevalue safebootalternateshell >nul 2>&1
bcdedit /set safeboot minimal >nul 2>&1

:: RESTART
shutdown /r /f /t 5
