$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$srcBase = "C:\Users\V1\chen\shu\2026\4\20小时法则：从零到会的极速学习法\output\contents-01"
$dstBase = "C:\Users\V1\jembonbooks\hugo\mybook"

# Language mapping: source dir -> content dir
$langs = @(
    @{ src = "us"; dst = "content.en"; type = "en" },
    @{ src = "cn"; dst = "content.zh"; type = "cn" },
    @{ src = "jp"; dst = "content.ja"; type = "jp" }
)

# 25 files mapping: filename, weight, translationKey, EN prefix, CN prefix, JP prefix
$chapters = @(
    @{ file="ch00-01-the-threshold-illusion.md"; w=1; tk="book-threshold-system-ch01"; en="Prologue:"; cn="序章："; jp="序章：" },
    @{ file="ch01-01-the-collectors-trap.md"; w=2; tk="book-threshold-system-ch02"; en="Ch1 01:"; cn="第1章 01："; jp="第1章 01：" },
    @{ file="ch01-02-redefining-good-enough.md"; w=3; tk="book-threshold-system-ch03"; en="Ch1 02:"; cn="第1章 02："; jp="第1章 02：" },
    @{ file="ch02-01-the-action-track-set-up-to-start.md"; w=4; tk="book-threshold-system-ch04"; en="Ch2 01:"; cn="第2章 01："; jp="第2章 01：" },
    @{ file="ch02-02-the-action-track-practice-to-produce.md"; w=5; tk="book-threshold-system-ch05"; en="Ch2 02:"; cn="第2章 02："; jp="第2章 02：" },
    @{ file="ch03-01-the-cognition-track-map-before-you-move.md"; w=6; tk="book-threshold-system-ch06"; en="Ch3 01:"; cn="第3章 01："; jp="第3章 01：" },
    @{ file="ch03-02-the-cognition-track-learn-through-friction.md"; w=7; tk="book-threshold-system-ch07"; en="Ch3 02:"; cn="第3章 02："; jp="第3章 02：" },
    @{ file="ch04-01-the-simplification-threshold.md"; w=8; tk="book-threshold-system-ch08"; en="Ch4 01:"; cn="第4章 01："; jp="第4章 01：" },
    @{ file="ch04-02-five-poses-one-practice.md"; w=9; tk="book-threshold-system-ch09"; en="Ch4 02:"; cn="第4章 02："; jp="第4章 02：" },
    @{ file="ch05-01-start-with-the-problem-not-the-language.md"; w=10; tk="book-threshold-system-ch10"; en="Ch5 01:"; cn="第5章 01："; jp="第5章 01：" },
    @{ file="ch05-02-reading-code-before-writing-code.md"; w=11; tk="book-threshold-system-ch11"; en="Ch5 02:"; cn="第5章 02："; jp="第5章 02：" },
    @{ file="ch05-03-the-error-driven-loop.md"; w=12; tk="book-threshold-system-ch12"; en="Ch5 03:"; cn="第5章 03："; jp="第5章 03：" },
    @{ file="ch05-04-ship-it-ugly.md"; w=13; tk="book-threshold-system-ch13"; en="Ch5 04:"; cn="第5章 04："; jp="第5章 04：" },
    @{ file="ch06-01-the-replacement-cost.md"; w=14; tk="book-threshold-system-ch14"; en="Ch6 01:"; cn="第6章 01："; jp="第6章 01：" },
    @{ file="ch06-02-sunk-time-is-not-an-argument.md"; w=15; tk="book-threshold-system-ch15"; en="Ch6 02:"; cn="第6章 02："; jp="第6章 02：" },
    @{ file="ch07-01-rules-are-not-skill.md"; w=16; tk="book-threshold-system-ch16"; en="Ch7 01:"; cn="第7章 01："; jp="第7章 01：" },
    @{ file="ch07-02-act-before-you-understand.md"; w=17; tk="book-threshold-system-ch17"; en="Ch7 02:"; cn="第7章 02："; jp="第7章 02：" },
    @{ file="ch07-03-the-practice-threshold.md"; w=18; tk="book-threshold-system-ch18"; en="Ch7 03:"; cn="第7章 03："; jp="第7章 03：" },
    @{ file="ch08-01-four-chords-and-a-thousand-songs.md"; w=19; tk="book-threshold-system-ch19"; en="Ch8 01:"; cn="第8章 01："; jp="第8章 01：" },
    @{ file="ch08-02-structure-before-freedom.md"; w=20; tk="book-threshold-system-ch20"; en="Ch8 02:"; cn="第8章 02："; jp="第8章 02：" },
    @{ file="ch09-01-the-variables-you-dont-control.md"; w=21; tk="book-threshold-system-ch21"; en="Ch9 01:"; cn="第9章 01："; jp="第9章 01：" },
    @{ file="ch09-02-safety-as-a-speed-multiplier.md"; w=22; tk="book-threshold-system-ch22"; en="Ch9 02:"; cn="第9章 02："; jp="第9章 02：" },
    @{ file="ch09-03-learning-in-the-wild.md"; w=23; tk="book-threshold-system-ch23"; en="Ch9 03:"; cn="第9章 03："; jp="第9章 03：" },
    @{ file="ch10-01-the-method-dissolves-into-action.md"; w=24; tk="book-threshold-system-ch24"; en="Epilogue 01:"; cn="结语 01："; jp="結語 01：" },
    @{ file="ch10-02-your-next-twenty-hours.md"; w=25; tk="book-threshold-system-ch25"; en="Epilogue 02:"; cn="结语 02："; jp="結語 02：" }
)

$totalFiles = 0
$errors = @()

foreach ($lang in $langs) {
    $srcDir = Join-Path $srcBase $lang.src
    $dstDir = Join-Path $dstBase "$($lang.dst)\threshold-system"
    
    foreach ($ch in $chapters) {
        $srcFile = Join-Path $srcDir $ch.file
        $dstFile = Join-Path $dstDir $ch.file
        
        if (-not (Test-Path $srcFile)) {
            $errors += "MISSING: $srcFile"
            continue
        }
        
        # Read source file as UTF-8
        $content = [System.IO.File]::ReadAllText($srcFile, [System.Text.Encoding]::UTF8)
        
        # Get the prefix for this language
        $prefix = switch ($lang.type) {
            "en" { $ch.en }
            "cn" { $ch.cn }
            "jp" { $ch.jp }
        }
        
        # Parse front matter: extract title between --- markers
        if ($content -match '(?s)^---\r?\n(.*?)\r?\n---') {
            $fm = $Matches[1]
            $body = $content.Substring($Matches[0].Length)
            
            # Extract original title
            $origTitle = ""
            if ($fm -match 'title:\s*"([^"]*)"') {
                $origTitle = $Matches[1]
            }
            
            # Extract original slug
            $origSlug = ""
            if ($fm -match 'slug:\s*"?([^\s"]+)"?') {
                $origSlug = $Matches[1]
            }
            
            # Build new title with prefix
            $newTitle = "$prefix $origTitle"
            
            # Build new front matter
            $newFm = "---`ntitle: `"$newTitle`"`nslug: `"$origSlug`"`nweight: $($ch.w)`ndraft: false`ntranslationKey: $($ch.tk)`n---"
            
            # Update H1 in body: find first # Title line and add prefix
            # Match the first H1 that matches the original title
            $escapedTitle = [regex]::Escape($origTitle)
            $body = $body -replace "(?m)^#\s+$escapedTitle\s*$", "# $newTitle"
            
            $newContent = $newFm + $body
            
            # Write with UTF-8 no BOM
            $utf8NoBom = New-Object System.Text.UTF8Encoding $false
            [System.IO.File]::WriteAllText($dstFile, $newContent, $utf8NoBom)
            
            $totalFiles++
            Write-Output "OK: $($lang.type)/$($ch.file) -> w=$($ch.w) tk=$($ch.tk)"
        } else {
            $errors += "NO FRONT MATTER: $srcFile"
        }
    }
}

Write-Output ""
Write-Output "=== DEPLOYMENT SUMMARY ==="
Write-Output "Total files deployed: $totalFiles"
Write-Output "Errors: $($errors.Count)"
if ($errors.Count -gt 0) {
    foreach ($e in $errors) { Write-Output "  ERROR: $e" }
}
