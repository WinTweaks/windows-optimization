:: RESET NVIDIA SETTINGS AND RESTART THE DISPLAY ADAPTER
:: https://github.com/wintweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || (echo This script must be Run as Administrator. && pause && exit /b 1)

:: DELETE PROFILES
del "%programdata%\NVIDIA Corporation\Drs\nvdrsdb0.bin" >nul 2>&1
del "%programdata%\NVIDIA Corporation\Drs\nvdrsdb1.bin" >nul 2>&1
del "%programdata%\NVIDIA Corporation\Drs\nvdrssel.bin" >nul 2>&1

:: RESTART DISPLAY ADAPTER
for /f "tokens=3 delims= " %%i in ('pnputil /enum-devices /connected -class Display ^|find "Instance ID"') do (
	pnputil /restart-device %%i
)
