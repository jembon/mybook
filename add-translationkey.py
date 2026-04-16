import os
import re

BOOK_SLUG = "side-hustle-money"
CONTENT_DIRS = [
    r"C:\Users\V1\jembonbooks\hugo\mybook\content.en\side-hustle-money",
    r"C:\Users\V1\jembonbooks\hugo\mybook\content.zh\side-hustle-money",
    r"C:\Users\V1\jembonbooks\hugo\mybook\content.ja\side-hustle-money",
]

print("=" * 50)
print("  Adding translationKey to all chapters")
print("=" * 50)

for dir_path in CONTENT_DIRS:
    print(f"\nProcessing: {dir_path}")
    
    for chapter_num in range(1, 23):
        filename = f"{chapter_num:02d}.md"
        file_path = os.path.join(dir_path, filename)
        
        if not os.path.exists(file_path):
            print(f"  Skip: {filename} (not found)")
            continue
        
        translation_key = f"{BOOK_SLUG}-chapter-{chapter_num:02d}"
        print(f"  Processing: {filename} -> translationKey: {translation_key}")
        
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Check if translationKey already exists
        if 'translationKey:' in content:
            print(f"    Already exists, skipping")
        else:
            # Add translationKey after title
            pattern = r'(title:\s*"[^"]+")'
            replacement = f'\\1\ntranslationKey: "{translation_key}"'
            new_content = re.sub(pattern, replacement, content, count=1)
            
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            
            print(f"    Added translationKey")

print("\n" + "=" * 50)
print("  Complete!")
print("=" * 50)
