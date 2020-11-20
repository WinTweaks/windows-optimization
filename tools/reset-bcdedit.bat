:: RESET BCDEDIT
:: https://github.com/wintweaks/windows-optimization

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || (echo This script must be Run as Administrator. && pause && exit /b 1)

:: RESET ALL BCDEDIT VALUES
bcdedit /deletevalue allowedinmemorysettings >nul 2>&1
bcdedit /deletevalue avoidlowmemory >nul 2>&1
bcdedit /deletevalue bootems >nul 2>&1
bcdedit /deletevalue bootlog  >nul 2>&1
bcdedit /deletevalue bootmenupolicy >nul 2>&1
bcdedit /deletevalue bootux >nul 2>&1
bcdedit /deletevalue configaccesspolicy >nul 2>&1
bcdedit /deletevalue configflags >nul 2>&1
bcdedit /deletevalue debug >nul 2>&1
bcdedit /deletevalue disabledynamictick  >nul 2>&1
bcdedit /deletevalue disableelamdrivers  >nul 2>&1
bcdedit /deletevalue ems >nul 2>&1
bcdedit /deletevalue extendedinput  >nul 2>&1
bcdedit /deletevalue firstmegabytepolicy >nul 2>&1
bcdedit /deletevalue forcefipscrypto >nul 2>&1
bcdedit /deletevalue forcelegacyplatform >nul 2>&1
bcdedit /deletevalue graphicsmodedisabled >nul 2>&1
bcdedit /deletevalue halbreakpoint >nul 2>&1
bcdedit /deletevalue highestmode  >nul 2>&1
bcdedit /deletevalue hypervisorlaunchtype >nul 2>&1
bcdedit /deletevalue integrityservices >nul 2>&1
bcdedit /deletevalue isolatedcontext >nul 2>&1
bcdedit /deletevalue nointegritychecks >nul 2>&1
bcdedit /deletevalue nolowmem  >nul 2>&1
bcdedit /deletevalue noumex  >nul 2>&1
bcdedit /deletevalue nx >nul 2>&1
bcdedit /deletevalue onecpu >nul 2>&1
bcdedit /deletevalue pae >nul 2>&1
bcdedit /deletevalue perfmem >nul 2>&1
bcdedit /deletevalue quietboot  >nul 2>&1
bcdedit /deletevalue sos  >nul 2>&1
bcdedit /deletevalue testsigning >nul 2>&1
bcdedit /deletevalue tpmbootentropy >nul 2>&1
bcdedit /deletevalue tscsyncpolicy >nul 2>&1
bcdedit /deletevalue usefirmwarepcisettings >nul 2>&1
bcdedit /deletevalue usephysicaldestination >nul 2>&1
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue useplatformtick  >nul 2>&1
bcdedit /deletevalue vm >nul 2>&1
bcdedit /deletevalue vsmlaunchtype >nul 2>&1
pause
exit /b 0