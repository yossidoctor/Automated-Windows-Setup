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
echo		Unzip the PolicyDefinitions.zip
echo.
echo.
pause

:: Deleting current machine and user policies
for %%D in (GroupPolicy, GroupPolicyUsers) do (if exist "%WinDir%\System32\%%D" rd /S /Q "%WinDir%\System32\%%D") >NUL 2>&1

:: Copying and applying DoD Windows Defender exploit mitigation policy
echo D | XCopy LGPO\DOD_EP_V3.xml %SystemDrive%\MitigationPolicy /I /Y /Q /E >NUL 2>&1
PowerShell.exe -ExecutionPolicy Bypass -command "Set-ProcessMitigation -PolicyFilePath %SystemDrive%\MitigationPolicy\DOD_EP_V3.xml" >NUL 2>&1

:: Copying policiy definitions
robocopy LGPO\PolicyDefinitions\ %WinDir%\PolicyDefinitions\ /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1

:: Applying machine and user policies
LGPO\lgpo.exe /m LGPO\machine_registry.pol /q
LGPO\lgpo.exe /u LGPO\user_registry.pol /q
gpupdate /force

echo.
echo.
echo Done.
pause
