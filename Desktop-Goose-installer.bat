@echo off
setlocal enabledelayedexpansion

:: Set the URL for Desktop Goose
set "gooseUrl=https://github.com/samperson/desktop-goose/releases/download/v0.3/Desktop_Goose_v0.3.zip"

:: Set the installation directory
set "installDir=%USERPROFILE%\DesktopGoose"

:: Create the installation directory if it doesn't exist
if not exist "%installDir%" mkdir "%installDir%"

:: Download Desktop Goose if it's not already installed
if not exist "%installDir%\GooseDesktop.exe" (
    echo Downloading Desktop Goose...
    bitsadmin /transfer DesktopGooseDownload /download /priority normal "%gooseUrl%" "%installDir%\DesktopGoose.zip"
    
    echo Extracting files...
    tar -xf "%installDir%\DesktopGoose.zip" -C "%installDir%"
    del "%installDir%\DesktopGoose.zip"
)

:: Create a shortcut in the Startup folder
set "startupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
if not exist "%startupFolder%\DesktopGoose.lnk" (
    echo Creating startup shortcut...
    powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%startupFolder%\DesktopGoose.lnk'); $Shortcut.TargetPath = '%installDir%\GooseDesktop.exe'; $Shortcut.Save()"
)

:: Start Desktop Goose
start "" "%installDir%\GooseDesktop.exe"

echo Desktop Goose has been installed and started.
echo It will now run automatically at startup.
pause
