// Extracts the iOS framework ZIP into the consumer's ios/local-frameworks/
// and drops in our local podspec so CocoaPods picks up the .framework dirs.

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const { ensureAsset } = require('./download-binaries');

const PODSPEC_TEMPLATE = path.join(__dirname, 'templates', 'ffmpeg-kit-ios-full-gpl.podspec');

async function installIos({ iosDir, versions, log }) {
  const { ios } = versions;
  const targetDir = path.join(iosDir, 'local-frameworks');
  const ffmpegFramework = path.join(targetDir, 'ffmpegkit.framework');

  if (fs.existsSync(ffmpegFramework)) {
    log('iOS: ffmpegkit.framework already in place, skipping');
    return { targetDir, alreadyInstalled: true };
  }

  const zipPath = await ensureAsset(ios.frameworkZip, log);

  fs.mkdirSync(targetDir, { recursive: true });

  // Use the system `unzip` — present on macOS by default. Anything fancier
  // would need an npm dep which we can't have (postinstall can't have its own
  // postinstall).
  log(`iOS: extracting ${ios.frameworkZip.filename} into ${path.relative(process.cwd(), targetDir)}`);
  execSync(`unzip -q -o "${zipPath}" -d "${targetDir}"`, { stdio: 'inherit' });

  // Copy the local podspec that points at the extracted .framework dirs.
  fs.copyFileSync(PODSPEC_TEMPLATE, path.join(targetDir, 'ffmpeg-kit-ios-full-gpl.podspec'));
  log('iOS: dropped local podspec');

  return { targetDir, alreadyInstalled: false };
}

module.exports = { installIos };
