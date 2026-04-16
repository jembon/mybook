@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo ========================================
echo   Rename English Chapters to Numbers
echo ========================================
echo.

cd /d "C:\Users\V1\jembonbooks\hugo\mybook\content.en\side-hustle-money"

echo Renaming English chapter files...
echo.

ren "01-the-three-dimension-timing-assessment.md" "01.md"
ren "02-the-side-hustle-spectrum-designing-your-unique-combination.md" "02.md"
ren "03-the-three-stage-identity-transition-where-are-you-really.md" "03.md"
ren "04-the-compound-effect-why-your-efforts-arent-accumulating.md" "04.md"
ren "05-the-investment-mindset-stop-buying-courses-start-earning-returns.md" "05.md"
ren "06-uncover-your-money-making-advantage-the-self-discovery-process.md" "06.md"
ren "07-from-advantage-to-income-the-label-positioning-method.md" "07.md"
ren "08-your-day-job-is-your-side-hustle-training-ground.md" "08.md"
ren "09-writing-is-thinking-externalized-the-output-system-that-changes-everything.md" "09.md"
ren "10-expression-is-value-amplification-why-doing-isnt-enough.md" "10.md"
ren "11-the-truth-about-networking-its-not-who-you-know-its-what-you-offer.md" "11.md"
ren "12-the-one-person-team-efficiency-system-work-smarter-not-harder.md" "12.md"
ren "13-teams-dont-get-built-they-grow.md" "13.md"
ren "14-traffic-is-the-blood-of-your-business-find-your-battlefield.md" "14.md"
ren "15-the-platform-hierarchy-why-less-is-more.md" "15.md"
ren "16-influence-isnt-fame-its-trust-at-scale.md" "16.md"
ren "17-publishing-a-book-is-the-shortcut-to-authority.md" "17.md"
ren "18-the-income-reservoir-why-multiple-streams-beat-single-income.md" "18.md"
ren "19-courses-and-communities-the-scalable-income-duo.md" "19.md"
ren "20-the-three-standards-for-quitting-your-day-job.md" "20.md"
ren "21-energy-is-the-real-currency-not-time.md" "21.md"
ren "22-learning-is-the-meta-skill-how-to-learn-faster-and-earn-while-you-do.md" "22.md"

echo.
echo ========================================
echo   English Chapters Renamed!
echo ========================================
echo.

pause
