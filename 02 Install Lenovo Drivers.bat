@echo off
pushd %~dp0\Automated
echo.

net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

:: Running DriveCleanup.exe
:: Removes all currently non present "Storage Volumes", "Disk", "CDROM", "Floppy"
:: USB drives and their USB devices from the device tree. Furthermore it removes
:: orphaned registry items related to these device types.
DriveCleanupx64.exe >NUL 2>&1

set Installation=%ProgramFiles(x86)%\Lenovo\System Update\tvsu.exe
if not exist "%Installation%" (
	echo Lenovo System Update not found, installing
	LenovoSystemUpdate.exe /VERYSILENT /NORESTART
) else (
	echo Lenovo System Update installation found.
)
echo Running Lenovo System Update
"%Installation%" /CM -search A -action INSTALL -noicon -nolicense -rebootprompt -includerebootpackages 1,3,4

echo.
echo.
echo Done.
pause