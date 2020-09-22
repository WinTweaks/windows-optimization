:: REBOOT SYSTEM
:: Usage: reboot [ /c | /m | /n | /s ]
:: https://github.com/WinTweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || (echo This script must be Run as Administrator. && pause && exit /b 1)

bcdedit /deletevalue safebootalternateshell >nul 2>&1

if "%1"=="/?" goto :Help

if "%1"=="console" goto :Console
if "%1"=="/console" goto :Console
if "%1"=="/c" goto :Console

if "%1"=="minimal" goto :Minimal
if "%1"=="/minimal" goto :Minimal
if "%1"=="/m" goto :Minimal

if "%1"=="network" goto :SafeMode
if "%1"=="/network" goto :SafeMode
if "%1"=="safemode" goto :SafeMode
if "%1"=="/safemode" goto :SafeMode
if "%1"=="/n" goto :SafeMode
if "%1"=="/s" goto :SafeMode

:: Reboot in Normal Mode
bcdedit /deletevalue safebootalternateshell >nul 2>&1
bcdedit /deletevalue safeboot >nul 2>&1
shutdown /r /f /t 5
exit /b 0

:: Reboot in Safe Mode with Command Prompt
:Console
bcdedit /set safeboot minimal >nul 2>&1
bcdedit /set safebootalternateshell yes >nul 2>&1
shutdown /r /f /t 5
goto :eof

:: Reboot in Safe Mode
:Minimal
bcdedit /deletevalue safebootalternateshell >nul 2>&1
bcdedit /set safeboot minimal >nul 2>&1
shutdown /r /f /t 5
goto :eof

:: Reboot in Safe Mode with Networking
:SafeMode
bcdedit /deletevalue safebootalternateshell >nul 2>&1
bcdedit /set safeboot network >nul 2>&1
shutdown /r /f /t 5
goto :eof

:: Help
:Help
echo Reboot the system.
echo.
echo USAGE:
echo     reboot [option]
echo.
echo     Options:
echo         No args           Reboot in normal mode.
echo.        /?                Display this help message.
echo         /c, /console      Reboot in safe mode with command prompt.
echo         /m, /minimal      Reboot in safe mode.
echo         /n, /network      Reboot in safe mode with networking.
echo         /s, /safemode     Reboot in safe mode with networking.
goto :eof
