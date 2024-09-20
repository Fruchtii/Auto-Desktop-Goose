@echo off
setlocal enabledelayedexpansion

:: Set the installation directory
set "installDir=%USERPROFILE%\DesktopGoose"

:: Set the startup shortcut path
set "startupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "shortcutPath=%startupFolder%\DesktopGoose.lnk"

:: Check if Desktop Goose is running and terminate it
tasklist /FI "IMAGENAME eq GooseDesktop.exe" 2>NUL | find /I /N "GooseDesktop.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo Terminating Desktop Goose...
    taskkill /F /IM GooseDesktop.exe
)

:: Remove the startup shortcut
if exist "%shortcutPath%" (
    echo Removing startup shortcut...
    del "%shortcutPath%"
)

:: Remove the installation directory
if exist "%installDir%" (
    echo Removing Desktop Goose files...
    rmdir /S /Q "%installDir%"
)

echo Desktop Goose has been uninstalled.
pause
