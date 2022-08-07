@echo off
pushd %~dp0\Automated
echo.

net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

REM echo Stopping and disabling services
REM for /f "tokens=*" %%a in (ServicesToDisable.txt) do (
	REM echo 	%%a
	REM net stop %%a >NUL 2>&1
	REM sc.exe config %%a start= disabled >NUL 2>&1
	REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\%%a" /v "Start" /t REG_DWORD /d "4" /f >NUL 2>&1
REM )

echo.
echo Disabling scheduled tasks
for /f "tokens=*" %%a in (TelemetryTasks.txt) do (
	echo 	%%a
	PowerShell.exe -ExecutionPolicy Bypass -Command "Get-ScheduledTask '%%a' | Disable-ScheduledTask" >NUL 2>&1
)

REM net stop ClickToRunSvc >NUL 2>&1
REM net stop FoxitReaderUpdateService >NUL 2>&1
REM net stop GoogleChromeElevationService >NUL 2>&1
REM net stop ZoomCptService >NUL 2>&1
REM net stop gupdate >NUL 2>&1
REM net stop gupdatem >NUL 2>&1
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClickToRunSvc" /v "DelayedAutostart" /t REG_DWORD /d "1" /f >NUL 2>&1
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClickToRunSvc" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>&1
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FoxitReaderUpdateService" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>&1
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>&1
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ZoomCptService" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>&1
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdate" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>&1
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdatem" /v "Start" /t REG_DWORD /d "3" /f >NUL 2>&1


echo.
echo.
echo Done.
pause