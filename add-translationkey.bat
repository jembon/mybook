@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo ========================================
echo   Add translationKey to All Chapters
echo ========================================
echo.

set "BOOK=side-hustle-money"

:: English
echo Adding translationKey to English files...
cd /d "C:\Users\V1\jembonbooks\hugo\mybook\content.en\%BOOK%"

for /L %%i in (1,1,22) do (
    set "NUM=00%%i"
    set "NUM=!NUM:~-2!"
    set "FILE=%%i.md"
    if exist "!FILE!" (
        echo   Processing !FILE!
        powershell -Command "$file='!FILE!'; $content=Get-Content $file -Raw; if($content -notmatch 'translationKey:') { $content=$content -replace '(title:\\s*\"[^\"]+\")','`$1`ntranslationKey: \"!BOOK!-chapter-!NUM!\"'; Set-Content $file $content -NoNewline }"
    )
)

:: Chinese
echo.
echo Adding translationKey to Chinese files...
cd /d "C:\Users\V1\jembonbooks\hugo\mybook\content.zh\%BOOK%"

for /L %%i in (1,1,22) do (
    set "NUM=00%%i"
    set "NUM=!NUM:~-2!"
    set "FILE=%%i.md"
    if exist "!FILE!" (
        echo   Processing !FILE!
        powershell -Command "$file='!FILE!'; $content=Get-Content $file -Raw; if($content -notmatch 'translationKey:') { $content=$content -replace '(title:\\s*\"[^\"]+\")','`$1`ntranslationKey: \"!BOOK!-chapter-!NUM!\"'; Set-Content $file $content -NoNewline }"
    )
)

:: Japanese
echo.
echo Adding translationKey to Japanese files...
cd /d "C:\Users\V1\jembonbooks\hugo\mybook\content.ja\%BOOK%"

for /L %%i in (1,1,22) do (
    set "NUM=00%%i"
    set "NUM=!NUM:~-2!"
    set "FILE=%%i.md"
    if exist "!FILE!" (
        echo   Processing !FILE!
        powershell -Command "$file='!FILE!'; $content=Get-Content $file -Raw; if($content -notmatch 'translationKey:') { $content=$content -replace '(title:\\s*\"[^\"]+\")','`$1`ntranslationKey: \"!BOOK!-chapter-!NUM!\"'; Set-Content $file $content -NoNewline }"
    )
)

echo.
echo ========================================
echo   translationKey Added!
echo ========================================
echo.

pause
