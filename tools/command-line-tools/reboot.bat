:: REBOOT SYSTEM
:: Usage: reboot [ /c | /m | /n | /s ]
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
echo Default
exit /b 0

:: Reboot in Safe Mode with Command Prompt
:Console
echo Console
goto :eof

:: Reboot in Safe Mode
:Minimal
echo Minimal
goto :eof

:: Reboot in Safe Mode with Networking
:SafeMode
echo SafeMode
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
