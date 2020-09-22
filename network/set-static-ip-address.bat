:: SET STATIC IP ADDRESS BASED ON CURRENTLY ASSIGNED DYNAMIC IP
:: https://github.com/wintweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || (echo This script must be Run as Administrator. && pause && exit /b 1)

:: SETTINGS (AUTOMATICALLY SET IF DHCP IS CURRENTLY ACTIVE, OTHERWISE UNCOMMENT AND SET MANUALLY)

:: set INTERFACE=Ethernet
:: set IP=192.168.1.101
:: set MASK=255.255.255.0
:: set GATEWAY=192.168.1.1
:: set DNS1=1.1.1.1
set DNS2=8.8.8.8

:: CALCULATE ANY SETTINGS NOT PROVIDED ABOVE
if "%INTERFACE%"=="" for /f "tokens=3,*" %%i in ('netsh int show interface^|find "Connected"') do set INTERFACE=%%j
if "%IP%"=="" for /f "tokens=3 delims=: " %%i in ('netsh int ip show config name^="%INTERFACE%" ^| findstr "IP Address" ^| findstr [0-9]') do set IP=%%i
if "%MASK%"=="" for /f "tokens=2 delims=()" %%i in ('netsh int ip show config name^="%INTERFACE%" ^| findstr /r "(.*)"') do for %%j in (%%i) do set MASK=%%j
if "%GATEWAY%"=="" for /f "tokens=3 delims=: " %%i in ('netsh int ip show config name^="%INTERFACE%" ^| findstr "Default" ^| findstr [0-9]') do set GATEWAY=%%i
if "%DNS1%"=="" for /f "tokens=2 delims=: " %%i in ('echo quit^|nslookup^|find "Address:"') do set DNS1=%%i

call:isValidIP %IP%
call:isValidIP %MASK%
call:isValidIP %GATEWAY%
call:isValidIP %DNS1%
if defined DNS2 call:isValidIP %DNS2%

:: EXIT PROGRAM IF AN IP IS INVALID
if defined _notValidIP (
	echo Setting a static IP failed. Exiting program . . .
	pause
	exit /b 1
)

:: DISPLAY NEW SETTINGS
echo Setting Static IP Address Using the Following Values . . .
echo.
echo Interface:        %INTERFACE%
echo IP Address:       %IP%
echo Subnet Mask:      %MASK%
echo Default Gateway:  %GATEWAY%
echo Primary DNS:      %DNS1%
if defined DNS2 echo Secondary DNS:    %DNS2%
echo.

:: MAKE CHANGES
netsh int ipv4 set address name="%INTERFACE%" static %IP% %MASK% %GATEWAY% >nul 2>&1
netsh int ipv4 set dns name="%INTERFACE%" static %DNS1% primary >nul 2>&1
if defined DNS2 netsh int ipv4 add dns name="%INTERFACE%" %DNS2% index=2 >nul 2>&1

:: CHECK DHCP STATUS
for /f "tokens=3 delims=: " %%i in ('netsh int ip show config name^="%INTERFACE%" ^| findstr "DHCP" ^| findstr [a-z]') do set DHCP=%%i

:: RESTART NETWORK ADAPTER
if "%DHCP%"=="Yes" (
	echo Setting a static IP failed. Exiting program . . .
	pause
	exit /b 2
) else (
	echo Restarting the Network Adapter . . .
	netsh int set interface name="%INTERFACE%" admin="disabled" && netsh int set interface name="%INTERFACE%" admin="enabled" >nul 2>&1
	echo Done.
	echo.
	pause
	exit /b 0
)

:isValidIP
for /F "tokens=1-4 delims=./" %%a in ("%1") do (
	if %%a LSS 1 set _notValidIP=1
	if %%a GTR 255 set _notValidIP=1
	if %%b LSS 0 set _notValidIP=1
	if %%b GTR 255 set _notValidIP=1
	if %%c LSS 0 set _notValidIP=1
	if %%c GTR 255 set _notValidIP=1
	if %%d LSS 0 set _notValidIP=1
	if %%d GTR 255 set _notValidIP=1
)
