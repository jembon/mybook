# -*- coding: utf-8 -*-
import os, re, shutil

src_base = r"C:\Users\V1\chen\shu\2026\4\20小时法则：从零到会的极速学习法\output\contents-01"
dst_base = r"C:\Users\V1\jembonbooks\hugo\mybook"

langs = [
    {"src": "us", "dst": "content.en", "type": "en"},
    {"src": "cn", "dst": "content.zh", "type": "cn"},
    {"src": "jp", "dst": "content.ja", "type": "jp"},
]

# (filename, weight, translationKey, en_prefix, cn_prefix, jp_prefix)
chapters = [
    ("ch00-01-the-threshold-illusion.md", 1, "book-threshold-system-ch01", "Prologue:", "序章：", "序章："),
    ("ch01-01-the-collectors-trap.md", 2, "book-threshold-system-ch02", "Ch1 01:", "第1章 01：", "第1章 01："),
    ("ch01-02-redefining-good-enough.md", 3, "book-threshold-system-ch03", "Ch1 02:", "第1章 02：", "第1章 02："),
    ("ch02-01-the-action-track-set-up-to-start.md", 4, "book-threshold-system-ch04", "Ch2 01:", "第2章 01：", "第2章 01："),
    ("ch02-02-the-action-track-practice-to-produce.md", 5, "book-threshold-system-ch05", "Ch2 02:", "第2章 02：", "第2章 02："),
    ("ch03-01-the-cognition-track-map-before-you-move.md", 6, "book-threshold-system-ch06", "Ch3 01:", "第3章 01：", "第3章 01："),
    ("ch03-02-the-cognition-track-learn-through-friction.md", 7, "book-threshold-system-ch07", "Ch3 02:", "第3章 02：", "第3章 02："),
    ("ch04-01-the-simplification-threshold.md", 8, "book-threshold-system-ch08", "Ch4 01:", "第4章 01：", "第4章 01："),
    ("ch04-02-five-poses-one-practice.md", 9, "book-threshold-system-ch09", "Ch4 02:", "第4章 02：", "第4章 02："),
    ("ch05-01-start-with-the-problem-not-the-language.md", 10, "book-threshold-system-ch10", "Ch5 01:", "第5章 01：", "第5章 01："),
    ("ch05-02-reading-code-before-writing-code.md", 11, "book-threshold-system-ch11", "Ch5 02:", "第5章 02：", "第5章 02："),
    ("ch05-03-the-error-driven-loop.md", 12, "book-threshold-system-ch12", "Ch5 03:", "第5章 03：", "第5章 03："),
    ("ch05-04-ship-it-ugly.md", 13, "book-threshold-system-ch13", "Ch5 04:", "第5章 04：", "第5章 04："),
    ("ch06-01-the-replacement-cost.md", 14, "book-threshold-system-ch14", "Ch6 01:", "第6章 01：", "第6章 01："),
    ("ch06-02-sunk-time-is-not-an-argument.md", 15, "book-threshold-system-ch15", "Ch6 02:", "第6章 02：", "第6章 02："),
    ("ch07-01-rules-are-not-skill.md", 16, "book-threshold-system-ch16", "Ch7 01:", "第7章 01：", "第7章 01："),
    ("ch07-02-act-before-you-understand.md", 17, "book-threshold-system-ch17", "Ch7 02:", "第7章 02：", "第7章 02："),
    ("ch07-03-the-practice-threshold.md", 18, "book-threshold-system-ch18", "Ch7 03:", "第7章 03：", "第7章 03："),
    ("ch08-01-four-chords-and-a-thousand-songs.md", 19, "book-threshold-system-ch19", "Ch8 01:", "第8章 01：", "第8章 01："),
    ("ch08-02-structure-before-freedom.md", 20, "book-threshold-system-ch20", "Ch8 02:", "第8章 02：", "第8章 02："),
    ("ch09-01-the-variables-you-dont-control.md", 21, "book-threshold-system-ch21", "Ch9 01:", "第9章 01：", "第9章 01："),
    ("ch09-02-safety-as-a-speed-multiplier.md", 22, "book-threshold-system-ch22", "Ch9 02:", "第9章 02：", "第9章 02："),
    ("ch09-03-learning-in-the-wild.md", 23, "book-threshold-system-ch23", "Ch9 03:", "第9章 03：", "第9章 03："),
    ("ch10-01-the-method-dissolves-into-action.md", 24, "book-threshold-system-ch24", "Epilogue 01:", "结语 01：", "結語 01："),
    ("ch10-02-your-next-twenty-hours.md", 25, "book-threshold-system-ch25", "Epilogue 02:", "结语 02：", "結語 02："),
]

total = 0
errors = []

for lang in langs:
    src_dir = os.path.join(src_base, lang["src"])
    dst_dir = os.path.join(dst_base, lang["dst"], "threshold-system")
    os.makedirs(dst_dir, exist_ok=True)
    
    for (fname, weight, tk, en_pre, cn_pre, jp_pre) in chapters:
        src_file = os.path.join(src_dir, fname)
        dst_file = os.path.join(dst_dir, fname)
        
        if not os.path.exists(src_file):
            errors.append(f"MISSING: {src_file}")
            continue
        
        with open(src_file, "r", encoding="utf-8-sig") as f:
            content = f.read()
        
        # Select prefix
        prefix = {"en": en_pre, "cn": cn_pre, "jp": jp_pre}[lang["type"]]
        
        # Parse front matter
        m = re.match(r'^---\s*\n(.*?)\n---\s*\n', content, re.DOTALL)
        if not m:
            errors.append(f"NO FRONT MATTER: {src_file}")
            continue
        
        fm_text = m.group(1)
        body = content[m.end():]
        
        # Extract original title
        tm = re.search(r'title:\s*"([^"]*)"', fm_text)
        orig_title = tm.group(1) if tm else ""
        
        # Extract original slug
        sm = re.search(r'slug:\s*"?([^\s"]+)"?', fm_text)
        orig_slug = sm.group(1) if sm else ""
        
        # Build new title
        new_title = f"{prefix} {orig_title}"
        
        # Build new front matter
        new_fm = f'---\ntitle: "{new_title}"\nslug: "{orig_slug}"\nweight: {weight}\ndraft: false\ntranslationKey: {tk}\n---\n'
        
        # Update H1 in body
        escaped = re.escape(orig_title)
        body = re.sub(rf'^#\s+{escaped}\s*$', f'# {new_title}', body, count=1, flags=re.MULTILINE)
        
        new_content = new_fm + body
        
        with open(dst_file, "w", encoding="utf-8", newline="\n") as f:
            f.write(new_content)
        
        total += 1
        print(f"OK: {lang['type']}/{fname} -> w={weight} tk={tk}")

print()
print("=== DEPLOYMENT SUMMARY ===")
print(f"Total files deployed: {total}")
print(f"Errors: {len(errors)}")
for e in errors:
    print(f"  ERROR: {e}")
