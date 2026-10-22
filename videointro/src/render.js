// Render intro.html thành video MP4 (1920x1080, 30fps) bằng Playwright + ffmpeg.
// Cách dùng:
//   npm i playwright-core   (hoặc đặt NODE_PATH tới thư mục có playwright-core)
//   node render.js                 -> ../claude101-intro.mp4
//   node render.js --stills        -> chỉ chụp vài frame preview
// Biến môi trường CHROME_PATH: đường dẫn chrome.exe nếu không dùng bản mặc định của Playwright.
const { chromium } = require('playwright-core');
const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

const FPS = 30;
const W = 1920, H = 1080;
const OUT_DIR = path.resolve(__dirname, '..');
const stills = process.argv.includes('--stills');

(async () => {
  const browser = await chromium.launch({ executablePath: process.env.CHROME_PATH || undefined });
  const page = await browser.newPage({ viewport: { width: W, height: H } });
  await page.goto('file://' + path.join(__dirname, 'intro.html').replace(/\\/g, '/') + '?static');
  await page.evaluate(() => document.fonts.ready);
  const duration = await page.evaluate(() => window.DURATION);

  if (stills) {
    const dir = path.join(OUT_DIR, 'stills');
    fs.mkdirSync(dir, { recursive: true });
    for (const t of [4, 7, 10, 15.5, 17.5, 23.5, 26.5, 29.2]) {
      await page.evaluate((t) => window.seek(t), t);
      await page.screenshot({ path: path.join(dir, `t${String(t).replace('.', '_')}.png`) });
    }
    await browser.close();
    return;
  }

  const silent = path.join(OUT_DIR, 'video_silent.mp4');
  const ff = spawn('ffmpeg', ['-y', '-f', 'image2pipe', '-framerate', String(FPS), '-i', '-',
    '-c:v', 'libx264', '-pix_fmt', 'yuv420p', '-crf', '18', '-preset', 'slow', silent], { stdio: ['pipe', 'ignore', 'inherit'] });

  const total = Math.round(duration * FPS);
  for (let f = 0; f < total; f++) {
    await page.evaluate((t) => window.seek(t), f / FPS);
    const buf = await page.screenshot({ type: 'png' });
    if (!ff.stdin.write(buf)) await new Promise((r) => ff.stdin.once('drain', r));
    if (f % 60 === 0) process.stdout.write(`frame ${f}/${total}\n`);
  }
  ff.stdin.end();
  await new Promise((r) => ff.on('close', r));
  await browser.close();
  console.log('Done:', silent);
})();
