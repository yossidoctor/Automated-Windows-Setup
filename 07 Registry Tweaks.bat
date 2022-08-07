@echo off
pushd %~dp0\Automated
echo.

net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

echo Applying registry tweaks
echo 	Adding Desktop and Downloads folders to user environment variables
setx Desktop "%USERPROFILE%\Desktop" >NUL 2>&1
setx Downloads "%USERPROFILE%\Downloads" >NUL 2>&1
echo 	Overriding Notepad with Notepad++
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v "Debugger" /t REG_SZ /d "\"%ProgramFiles(x86)%\Notepad++\notepad++.exe\" -notepadStyleCmdline -z" /f >NUL 2>&1
echo 	Preventing OneDrive from hooking into Explorer even when disabled
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >NUL 2>&1
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >NUL 2>&1
echo 	Disabling making "-shortcut" text for shortcuts
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V link /T REG_Binary /D 00000000 /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /V ShortcutNameTemplate /f >NUL 2>&1
echo 	Cleaning up context menus
reg delete "HKEY_CLASSES_ROOT\Directory\shell\AddToPlaylistVLC" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\ModernSharing" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\DriveFS 28 or later" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\Sharing" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Drive\shellex\ContextMenuHandlers\Sharing" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\DriveFS 28 or later" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\Sharing" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\Offline Files" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\DriveFS 28 or later" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\background\shellex\ContextMenuHandlers\Sharing" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\background\shellex\ContextMenuHandlers\DriveFS 28 or later" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\Offline Files" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\Library Location" /f >NUL 2>&1
echo 	Removing Music From This PC
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >NUL 2>&1
echo 	Removing Videos From This PC
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f >NUL 2>&1
echo 	Removing 3D Objects From This PC
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f >NUL 2>&1
:: 		Chrome user account early launch execution
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{8A69D345-D564-463c-AFF1-A69D9E530F96}" /f >NUL 2>&1
:: 		Microsoft Edge early user account launch execution
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Logitech Download Assistant" /f >NUL 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Logitech Download Assistant" /f >NUL 2>&1


echo.
echo.
echo Done.
pause