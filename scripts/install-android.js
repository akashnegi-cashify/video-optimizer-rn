// Places the AAR + POM into the consumer's android/local-maven/ directory.
// Also prints the snippets the consumer must paste into settings.gradle +
// app/build.gradle, since we don't auto-edit those (too risky).

const fs = require('fs');
const path = require('path');
const { ensureAsset } = require('./download-binaries');

const MAVEN_REL =
  'android/local-maven/com/arthenica/ffmpeg-kit-full-gpl';

async function installAndroid({ androidDir, versions, log }) {
  const { android } = versions;
  const versionDir = path.join(androidDir, '..', MAVEN_REL, versions.version);
  const aarDest = path.join(versionDir, android.aar.filename);
  const pomDest = path.join(versionDir, android.pom.filename);

  // Skip if already present and checksums match.
  if (
    fs.existsSync(aarDest) &&
    fs.existsSync(pomDest) &&
    fs.statSync(aarDest).size > 1000
  ) {
    log('Android: AAR already in place, skipping');
    return { aarDest, pomDest, alreadyInstalled: true };
  }

  const aarCache = await ensureAsset(android.aar, log);
  const pomCache = await ensureAsset(android.pom, log);

  fs.mkdirSync(versionDir, { recursive: true });
  fs.copyFileSync(aarCache, aarDest);
  fs.copyFileSync(pomCache, pomDest);

  log(`Android: installed AAR + POM into ${path.relative(process.cwd(), versionDir)}`);
  return { aarDest, pomDest, alreadyInstalled: false };
}

module.exports = { installAndroid };
