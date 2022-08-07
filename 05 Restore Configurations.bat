@echo off
pushd %~dp0\Automated
echo.

net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

echo.
echo		Make sure your all the software installation is complete before
echo		running the script to make the removal of scheduled tasks and 
echo		the disabling of services effective.
echo.
echo.
pause

echo.
echo		Unzip the RestoreConfigurations.zip
echo.
echo.
pause

echo Killing running services:
set tasks=Everything Greenshot Logi Flow flux qBittorrent vlc Spotify Anki mpv QtWebEngineProcess Notepad++ qBitTorrent Zoom Pycharm64 GoogleDriveFS crashpad_handler chrome Foxit Office
for %%a in (%tasks%) do (
	echo		%%a
	taskkill /IM "%%a*" /f >NUL 2>&1
) 

echo.
echo Copying AppData folders
robocopy AppData %appdata% /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1
echo D | XCopy LocalAppData\DriveFS %LocalAppData%\Google /I /Y /Q /E >NUL 2>&1
echo D | XCopy LocalAppData\Spotify %LocalAppData% /I /Y /Q /E >NUL 2>&1

echo Restarting Everything
"%ProgramFiles%\Everything\Everything.exe" -start-service >NUL 2>&1

echo Importing software registry settings
reg import "reg\7-Zip.reg" >NUL 2>&1
reg import "reg\FoxitSoftware.reg" >NUL 2>&1
reg import "reg\Flux.reg" >NUL 2>&1
reg import "reg\Revo.reg" >NUL 2>&1
reg import "reg\Lenovo.reg" >NUL 2>&1
reg import "reg\GDrive.reg" >NUL 2>&1
reg import "reg\LogiOptions.reg" >NUL 2>&1
if not exist %UserProfile%\Pictures\Screenshots mkdir %UserProfile%\Pictures\Screenshots >NUL 2>&1


echo.
echo.
echo Done.
pause