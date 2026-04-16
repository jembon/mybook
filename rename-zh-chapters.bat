@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo ========================================
echo   Rename Chinese Chapters to Numbers
echo ========================================
echo.

cd /d "C:\Users\V1\jembonbooks\hugo\mybook\content.zh\side-hustle-money"

echo Renaming Chinese chapter files...
echo.

for %%f in (01-*.md) do ren "%%f" "01.md"
for %%f in (02-*.md) do ren "%%f" "02.md"
for %%f in (03-*.md) do ren "%%f" "03.md"
for %%f in (04-*.md) do ren "%%f" "04.md"
for %%f in (05-*.md) do ren "%%f" "05.md"
for %%f in (06-*.md) do ren "%%f" "06.md"
for %%f in (07-*.md) do ren "%%f" "07.md"
for %%f in (08-*.md) do ren "%%f" "08.md"
for %%f in (09-*.md) do ren "%%f" "09.md"
for %%f in (10-*.md) do ren "%%f" "10.md"
for %%f in (11-*.md) do ren "%%f" "11.md"
for %%f in (12-*.md) do ren "%%f" "12.md"
for %%f in (13-*.md) do ren "%%f" "13.md"
for %%f in (14-*.md) do ren "%%f" "14.md"
for %%f in (15-*.md) do ren "%%f" "15.md"
for %%f in (16-*.md) do ren "%%f" "16.md"
for %%f in (17-*.md) do ren "%%f" "17.md"
for %%f in (18-*.md) do ren "%%f" "18.md"
for %%f in (19-*.md) do ren "%%f" "19.md"
for %%f in (20-*.md) do ren "%%f" "20.md"
for %%f in (21-*.md) do ren "%%f" "21.md"
for %%f in (22-*.md) do ren "%%f" "22.md"

echo.
echo ========================================
echo   Chinese Chapters Renamed!
echo ========================================
echo.

pause
