const fs = require('fs');
const path = require('path');

const srcBase = String.raw`C:\Users\V1\chen\shu\2026\4\20小时法则：从零到会的极速学习法\output\contents-01`;
const dstBase = String.raw`C:\Users\V1\jembonbooks\hugo\mybook`;

const langs = [
  { src: 'us', dst: 'content.en', type: 'en' },
  { src: 'cn', dst: 'content.zh', type: 'cn' },
  { src: 'jp', dst: 'content.ja', type: 'jp' },
];

const chapters = [
  { file: 'ch00-01-the-threshold-illusion.md', w: 1, tk: 'book-threshold-system-ch01', en: 'Prologue:', cn: '\u5E8F\u7AE0\uFF1A', jp: '\u5E8F\u7AE0\uFF1A' },
  { file: 'ch01-01-the-collectors-trap.md', w: 2, tk: 'book-threshold-system-ch02', en: 'Ch1 01:', cn: '\u7B2C1\u7AE0 01\uFF1A', jp: '\u7B2C1\u7AE0 01\uFF1A' },
  { file: 'ch01-02-redefining-good-enough.md', w: 3, tk: 'book-threshold-system-ch03', en: 'Ch1 02:', cn: '\u7B2C1\u7AE0 02\uFF1A', jp: '\u7B2C1\u7AE0 02\uFF1A' },
  { file: 'ch02-01-the-action-track-set-up-to-start.md', w: 4, tk: 'book-threshold-system-ch04', en: 'Ch2 01:', cn: '\u7B2C2\u7AE0 01\uFF1A', jp: '\u7B2C2\u7AE0 01\uFF1A' },
  { file: 'ch02-02-the-action-track-practice-to-produce.md', w: 5, tk: 'book-threshold-system-ch05', en: 'Ch2 02:', cn: '\u7B2C2\u7AE0 02\uFF1A', jp: '\u7B2C2\u7AE0 02\uFF1A' },
  { file: 'ch03-01-the-cognition-track-map-before-you-move.md', w: 6, tk: 'book-threshold-system-ch06', en: 'Ch3 01:', cn: '\u7B2C3\u7AE0 01\uFF1A', jp: '\u7B2C3\u7AE0 01\uFF1A' },
  { file: 'ch03-02-the-cognition-track-learn-through-friction.md', w: 7, tk: 'book-threshold-system-ch07', en: 'Ch3 02:', cn: '\u7B2C3\u7AE0 02\uFF1A', jp: '\u7B2C3\u7AE0 02\uFF1A' },
  { file: 'ch04-01-the-simplification-threshold.md', w: 8, tk: 'book-threshold-system-ch08', en: 'Ch4 01:', cn: '\u7B2C4\u7AE0 01\uFF1A', jp: '\u7B2C4\u7AE0 01\uFF1A' },
  { file: 'ch04-02-five-poses-one-practice.md', w: 9, tk: 'book-threshold-system-ch09', en: 'Ch4 02:', cn: '\u7B2C4\u7AE0 02\uFF1A', jp: '\u7B2C4\u7AE0 02\uFF1A' },
  { file: 'ch05-01-start-with-the-problem-not-the-language.md', w: 10, tk: 'book-threshold-system-ch10', en: 'Ch5 01:', cn: '\u7B2C5\u7AE0 01\uFF1A', jp: '\u7B2C5\u7AE0 01\uFF1A' },
  { file: 'ch05-02-reading-code-before-writing-code.md', w: 11, tk: 'book-threshold-system-ch11', en: 'Ch5 02:', cn: '\u7B2C5\u7AE0 02\uFF1A', jp: '\u7B2C5\u7AE0 02\uFF1A' },
  { file: 'ch05-03-the-error-driven-loop.md', w: 12, tk: 'book-threshold-system-ch12', en: 'Ch5 03:', cn: '\u7B2C5\u7AE0 03\uFF1A', jp: '\u7B2C5\u7AE0 03\uFF1A' },
  { file: 'ch05-04-ship-it-ugly.md', w: 13, tk: 'book-threshold-system-ch13', en: 'Ch5 04:', cn: '\u7B2C5\u7AE0 04\uFF1A', jp: '\u7B2C5\u7AE0 04\uFF1A' },
  { file: 'ch06-01-the-replacement-cost.md', w: 14, tk: 'book-threshold-system-ch14', en: 'Ch6 01:', cn: '\u7B2C6\u7AE0 01\uFF1A', jp: '\u7B2C6\u7AE0 01\uFF1A' },
  { file: 'ch06-02-sunk-time-is-not-an-argument.md', w: 15, tk: 'book-threshold-system-ch15', en: 'Ch6 02:', cn: '\u7B2C6\u7AE0 02\uFF1A', jp: '\u7B2C6\u7AE0 02\uFF1A' },
  { file: 'ch07-01-rules-are-not-skill.md', w: 16, tk: 'book-threshold-system-ch16', en: 'Ch7 01:', cn: '\u7B2C7\u7AE0 01\uFF1A', jp: '\u7B2C7\u7AE0 01\uFF1A' },
  { file: 'ch07-02-act-before-you-understand.md', w: 17, tk: 'book-threshold-system-ch17', en: 'Ch7 02:', cn: '\u7B2C7\u7AE0 02\uFF1A', jp: '\u7B2C7\u7AE0 02\uFF1A' },
  { file: 'ch07-03-the-practice-threshold.md', w: 18, tk: 'book-threshold-system-ch18', en: 'Ch7 03:', cn: '\u7B2C7\u7AE0 03\uFF1A', jp: '\u7B2C7\u7AE0 03\uFF1A' },
  { file: 'ch08-01-four-chords-and-a-thousand-songs.md', w: 19, tk: 'book-threshold-system-ch19', en: 'Ch8 01:', cn: '\u7B2C8\u7AE0 01\uFF1A', jp: '\u7B2C8\u7AE0 01\uFF1A' },
  { file: 'ch08-02-structure-before-freedom.md', w: 20, tk: 'book-threshold-system-ch20', en: 'Ch8 02:', cn: '\u7B2C8\u7AE0 02\uFF1A', jp: '\u7B2C8\u7AE0 02\uFF1A' },
  { file: 'ch09-01-the-variables-you-dont-control.md', w: 21, tk: 'book-threshold-system-ch21', en: 'Ch9 01:', cn: '\u7B2C9\u7AE0 01\uFF1A', jp: '\u7B2C9\u7AE0 01\uFF1A' },
  { file: 'ch09-02-safety-as-a-speed-multiplier.md', w: 22, tk: 'book-threshold-system-ch22', en: 'Ch9 02:', cn: '\u7B2C9\u7AE0 02\uFF1A', jp: '\u7B2C9\u7AE0 02\uFF1A' },
  { file: 'ch09-03-learning-in-the-wild.md', w: 23, tk: 'book-threshold-system-ch23', en: 'Ch9 03:', cn: '\u7B2C9\u7AE0 03\uFF1A', jp: '\u7B2C9\u7AE0 03\uFF1A' },
  { file: 'ch10-01-the-method-dissolves-into-action.md', w: 24, tk: 'book-threshold-system-ch24', en: 'Epilogue 01:', cn: '\u7ED3\u8BED 01\uFF1A', jp: '\u7D50\u8A9E 01\uFF1A' },
  { file: 'ch10-02-your-next-twenty-hours.md', w: 25, tk: 'book-threshold-system-ch25', en: 'Epilogue 02:', cn: '\u7ED3\u8BED 02\uFF1A', jp: '\u7D50\u8A9E 02\uFF1A' },
];

let total = 0;
const errors = [];

for (const lang of langs) {
  const srcDir = path.join(srcBase, lang.src);
  const dstDir = path.join(dstBase, lang.dst, 'threshold-system');
  fs.mkdirSync(dstDir, { recursive: true });

  for (const ch of chapters) {
    const srcFile = path.join(srcDir, ch.file);
    const dstFile = path.join(dstDir, ch.file);

    if (!fs.existsSync(srcFile)) {
      errors.push(`MISSING: ${srcFile}`);
      continue;
    }

    let content = fs.readFileSync(srcFile, 'utf-8');
    // Remove BOM
    if (content.charCodeAt(0) === 0xFEFF) content = content.slice(1);

    const prefix = ch[lang.type];

    // Parse front matter
    const fmMatch = content.match(/^---\s*\n([\s\S]*?)\n---\s*\n/);
    if (!fmMatch) {
      errors.push(`NO FRONT MATTER: ${srcFile}`);
      continue;
    }

    const fmText = fmMatch[1];
    let body = content.slice(fmMatch[0].length);

    // Extract original title
    const titleMatch = fmText.match(/title:\s*"([^"]*)"/);
    const origTitle = titleMatch ? titleMatch[1] : '';

    // Extract original slug
    const slugMatch = fmText.match(/slug:\s*"?([^\s"]+)"?/);
    const origSlug = slugMatch ? slugMatch[1] : '';

    // Build new title
    const newTitle = `${prefix} ${origTitle}`;

    // Build new front matter
    const newFm = `---\ntitle: "${newTitle}"\nslug: "${origSlug}"\nweight: ${ch.w}\ndraft: false\ntranslationKey: ${ch.tk}\n---\n`;

    // Update H1 in body
    const escapedTitle = origTitle.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const h1Regex = new RegExp(`^#\\s+${escapedTitle}\\s*$`, 'm');
    body = body.replace(h1Regex, `# ${newTitle}`);

    const newContent = newFm + body;
    fs.writeFileSync(dstFile, newContent, 'utf-8');

    total++;
    console.log(`OK: ${lang.type}/${ch.file} -> w=${ch.w} tk=${ch.tk}`);
  }
}

console.log('');
console.log('=== DEPLOYMENT SUMMARY ===');
console.log(`Total files deployed: ${total}`);
console.log(`Errors: ${errors.length}`);
for (const e of errors) console.log(`  ERROR: ${e}`);
