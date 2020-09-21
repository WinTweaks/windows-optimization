:: RESET NVIDIA SETTINGS AND RESTART THE DISPLAY ADAPTER
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

:: DELETE PROFILES
del "%programdata%\NVIDIA Corporation\Drs\nvdrsdb0.bin" >nul 2>&1
del "%programdata%\NVIDIA Corporation\Drs\nvdrsdb1.bin" >nul 2>&1
del "%programdata%\NVIDIA Corporation\Drs\nvdrssel.bin" >nul 2>&1

:: RESTART DISPLAY ADAPTER
for /f "tokens=3 delims= " %%i in ('pnputil /enum-devices /connected -class Display ^|find "Instance ID"') do (
	pnputil /restart-device %%i
)
