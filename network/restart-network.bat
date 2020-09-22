:: RESTART NETWORK ADAPTER
:: https://github.com/WinTweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || (echo This script must be Run as Administrator. && pause && exit /b 1)

:: RESTART EACH CONNECTED INTERFACE
for /f "tokens=3,*" %%i in ('netsh int show interface^|find "Connected"') do (
	echo %%j
	netsh int set interface name="%%j" admin="disabled" && netsh int set interface name="%%j" admin="enabled" >nul 2>&1
)
