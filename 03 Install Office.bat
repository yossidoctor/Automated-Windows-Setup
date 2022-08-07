@echo off
pushd %~dp0\Automated\Office
echo.

net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

set WordPath=%ProgramFiles%\Microsoft Office\root\Office16\WINWORD.exe
if not exist "%WordPath%" (
	echo Office installation not found.
	
	:: Killing it just in case there's another installation instance running
	taskkill /IM "OfficeClickToRun*" /f >NUL 2>&1
	
	:: Copying the setup and config files to the Desktop
	XCopy Office365ProPlus* %UserProfile%\Desktop\TempOfficeDir  /I /Y /Q >NUL 2>&1
	pushd %UserProfile%\Desktop\TempOfficeDir
	
	echo Downloading Office, do not close this window - About 3.17 GB
	Office365ProPlus.exe /download Office365ProPlus-Config.xml
	
	echo Installing Office, do not close this window
	Office365ProPlus.exe /configure Office365ProPlus-Config.xml
	
	:: Deleting the installation files
	RD /S /Q "TempOfficeDir"
	
	:: Remove the Office installation cache. Usually around ~1.5 GB
	if exist "%SystemDrive%\MSOCache" RD /S /Q "%SystemDrive%\MSOCache"
) else (
	echo Office already installed.
)

echo.
echo.
echo Done.
pause
