@echo off
setlocal EnableDelayedExpansion

:: Configuration
set "PROJECT_ROOT=C:\Users\V1\jembonbooks\hugo\mybook"
set "BACKUP_ROOT=C:\Users\V1\jembonbooks\hugo\backups"
set "KEEP_COUNT=10"

:: Get date and time using PowerShell
for /f "delims=" %%a in ('powershell -NoProfile -Command "Get-Date -Format 'yyyyMMdd-HHmmss'"') do set "TIMESTAMP=%%a"
for /f "delims=" %%a in ('powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"') do set "DATE_DISPLAY=%%a"

:: Backup paths
set "ARCHIVE_NAME=mybook-template-%TIMESTAMP%"
set "BACKUP_DIR=%BACKUP_ROOT%"
set "ARCHIVE_PATH=%BACKUP_DIR%\%ARCHIVE_NAME%.tar.gz"
set "TEMP_DIR=%BACKUP_DIR%\%ARCHIVE_NAME%-temp"

:: Display header
echo ========================================
echo   MyBook Template Backup (Quick)
echo ========================================
echo.
echo Project root: %PROJECT_ROOT%
echo Backup time: %DATE_DISPLAY%
echo Archive name: %ARCHIVE_NAME%.zip
echo Included: layouts/, hugo.toml, themes/hugo-book/
echo.

:: Check project directory
if not exist "%PROJECT_ROOT%" (
    echo ERROR: Project root not found: %PROJECT_ROOT%
    pause
    exit /b 1
)

:: Create backup directory
if not exist "%BACKUP_DIR%" (
    echo Creating backup directory: %BACKUP_DIR%
    mkdir "%BACKUP_DIR%"
)

:: Step 1: Copy template files to temp directory
echo Step 1/2: Preparing files ...

if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

:: Copy layouts/
if exist "%PROJECT_ROOT%\layouts" (
    echo   Including: layouts/
    xcopy "%PROJECT_ROOT%\layouts" "%TEMP_DIR%\layouts\" /E /I /Y /Q
) else (
    echo   Skipping: layouts/ (not found)
)

:: Copy hugo.toml
if exist "%PROJECT_ROOT%\hugo.toml" (
    echo   Including: hugo.toml
    copy "%PROJECT_ROOT%\hugo.toml" "%TEMP_DIR%\" >nul
) else (
    echo   Skipping: hugo.toml (not found)
)

:: Copy themes/hugo-book/
if exist "%PROJECT_ROOT%\themes\hugo-book" (
    echo   Including: themes/hugo-book/
    xcopy "%PROJECT_ROOT%\themes\hugo-book" "%TEMP_DIR%\themes\hugo-book\" /E /I /Y /Q
) else (
    echo   Skipping: themes/hugo-book/ (not found)
)

echo.

:: Step 2/2: Compress using tar (tar.gz)
echo Step 2/2: Compressing ...

cd /d "%TEMP_DIR%"
tar -czf "%ARCHIVE_PATH%" .
cd /d "%BACKUP_DIR%"

if exist "%ARCHIVE_PATH%" (
    echo   OK - Archive created
    rmdir /s /q "%TEMP_DIR%"
) else (
    echo   WARNING: Compression failed, backup saved as folder
    goto :COMPLETE
)

:COMPLETE
:: Display backup info
echo.
echo ========================================
echo   Backup Complete
echo ========================================
echo Backup time: %DATE_DISPLAY%
echo Archive name: %ARCHIVE_NAME%
echo Location: %BACKUP_DIR%
echo.

if exist "%ARCHIVE_PATH%" (
    for %%A in ("%ARCHIVE_PATH%") do set "SIZE=%%~zA"
    set /a SIZEMB=%SIZE%/1048576
    echo Archive size: %SIZEMB% MB
    echo.
    echo To restore:
    echo   tar -xzf %ARCHIVE_PATH% -C C:\Users\V1\jembonbooks\hugo\
) else (
    echo Backup saved as folder: %TEMP_DIR%
    echo.
    echo To restore:
    echo   Copy back: %TEMP_DIR%
    echo   To: C:\Users\V1\jembonbooks\hugo\mybook
)
echo.

:: Cleanup old backups
echo Cleaning up old backups (keeping latest %KEEP_COUNT%) ...

set /a COUNT=0
for /f "delims=" %%i in ('dir /b /o-d "%BACKUP_DIR%\mybook-template-*.tar.gz" 2^>nul') do (
    set /a COUNT+=1
    if !COUNT! GTR %KEEP_COUNT% (
        echo   Removing: %%i
        del /q "%BACKUP_DIR%\%%i"
    )
)

echo.
echo Done!
pause
