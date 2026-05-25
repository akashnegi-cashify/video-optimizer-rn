// Generic downloader: streams a URL to disk, verifies SHA-256, caches across runs.
//
// Uses only Node built-ins (https + crypto + fs) — no npm deps, because a postinstall
// script having its own postinstall is a circular nightmare.

const fs = require('fs');
const path = require('path');
const os = require('os');
const https = require('https');
const crypto = require('crypto');

const CACHE_DIR = path.join(os.homedir(), '.cache', 'cashify-video-optimizer-rn');

function cachePath(asset) {
  return path.join(CACHE_DIR, asset.sha256.slice(0, 16) + '-' + asset.filename);
}

function sha256OfFile(filePath) {
  return new Promise((resolve, reject) => {
    const hash = crypto.createHash('sha256');
    const stream = fs.createReadStream(filePath);
    stream.on('data', (d) => hash.update(d));
    stream.on('end', () => resolve(hash.digest('hex')));
    stream.on('error', reject);
  });
}

function streamDownload(url, destPath, redirectsLeft = 5) {
  return new Promise((resolve, reject) => {
    if (redirectsLeft < 0) {
      reject(new Error(`Too many redirects fetching ${url}`));
      return;
    }
    https
      .get(url, (res) => {
        if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
          // GitHub Release downloads always 302 to a signed S3 URL; follow it.
          res.resume();
          streamDownload(res.headers.location, destPath, redirectsLeft - 1)
            .then(resolve)
            .catch(reject);
          return;
        }
        if (res.statusCode !== 200) {
          reject(new Error(`HTTP ${res.statusCode} fetching ${url}`));
          res.resume();
          return;
        }
        const fileStream = fs.createWriteStream(destPath);
        res.pipe(fileStream);
        fileStream.on('finish', () => fileStream.close(resolve));
        fileStream.on('error', reject);
        res.on('error', reject);
      })
      .on('error', reject);
  });
}

/**
 * Ensure a binary asset is present on disk. Returns the absolute path to the
 * cached + verified file. Re-uses an existing cached copy if its SHA-256 matches.
 */
async function ensureAsset(asset, log) {
  if (!fs.existsSync(CACHE_DIR)) {
    fs.mkdirSync(CACHE_DIR, { recursive: true });
  }
  const target = cachePath(asset);

  if (fs.existsSync(target)) {
    const actual = await sha256OfFile(target);
    if (actual === asset.sha256) {
      log(`✓ cached: ${asset.filename}`);
      return target;
    }
    log(`! cached copy of ${asset.filename} has wrong checksum — re-downloading`);
    fs.unlinkSync(target);
  }

  log(`↓ downloading ${asset.filename} from ${asset.url}`);
  const tmp = target + '.tmp';
  await streamDownload(asset.url, tmp);

  const actual = await sha256OfFile(tmp);
  if (actual !== asset.sha256) {
    fs.unlinkSync(tmp);
    throw new Error(
      `SHA-256 mismatch for ${asset.filename}\n  expected: ${asset.sha256}\n  got:      ${actual}\nRefusing to install a corrupted or tampered binary.`,
    );
  }
  fs.renameSync(tmp, target);
  log(`✓ verified ${asset.filename}`);
  return target;
}

module.exports = { ensureAsset, CACHE_DIR };
