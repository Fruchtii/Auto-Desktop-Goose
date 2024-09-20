@echo off
setlocal enabledelayedexpansion

:: Set the URL for Desktop Goose
set "gooseUrl=https://samperson.itch.io/desktop-goose"

:: Set the installation directory
set "installDir=%USERPROFILE%\DesktopGoose"

:: Create the installation directory if it doesn't exist
if not exist "%installDir%" mkdir "%installDir%"

:: Download Desktop Goose if it's not already installed
if not exist "%installDir%\GooseDesktop.exe" (
    echo Downloading Desktop Goose...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('%gooseUrl%', '%installDir%\DesktopGoose.zip')"
    echo Extracting files...
    powershell -Command "Expand-Archive -Path '%installDir%\DesktopGoose.zip' -DestinationPath '%installDir%' -Force"
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
