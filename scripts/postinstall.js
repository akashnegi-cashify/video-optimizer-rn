#!/usr/bin/env node
// Postinstall orchestrator for @cashify/video-optimizer-rn.
//
// Downloads FFmpeg-kit binaries from the library's GitHub Release into the
// consumer's android/local-maven/ and ios/local-frameworks/ directories.
//
// Skip with VIDEO_OPTIMIZER_RN_SKIP_POSTINSTALL=1 (CI / Docker / etc.)
// Re-run manually with `npx video-optimizer-rn install-binaries`.

const fs = require('fs');
const path = require('path');

const versions = require('./binary-versions.json');
const { installAndroid } = require('./install-android');
const { installIos } = require('./install-ios');

const log = (msg) => console.log(`[video-optimizer-rn] ${msg}`);
const warn = (msg) => console.warn(`[video-optimizer-rn] ${msg}`);
const err = (msg) => console.error(`[video-optimizer-rn] ${msg}`);

if (process.env.VIDEO_OPTIMIZER_RN_SKIP_POSTINSTALL === '1') {
  log('VIDEO_OPTIMIZER_RN_SKIP_POSTINSTALL=1 set — skipping binary install.');
  process.exit(0);
}

// Skip when running inside the library's own repo. We detect this via INIT_CWD,
// which npm/yarn set to the directory from which `install` was originally invoked.
// When a consumer runs `yarn install`, INIT_CWD is their project root; when we run
// it inside the library, INIT_CWD === the library root.
//
// process.cwd() is not reliable here because Yarn 4 runs postinstall with cwd
// set to the linked package dir (inside node_modules), not the invocation dir.
const libRoot = path.resolve(__dirname, '..');
const invocationDir = process.env.INIT_CWD || process.cwd();
if (path.resolve(invocationDir) === libRoot) {
  log('Running inside the library repo — postinstall skipped.');
  process.exit(0);
}

/**
 * Walk up from node_modules/@cashify/video-optimizer-rn/scripts/ to find the
 * consumer project root. Typically that's the dir containing both package.json
 * and either android/ or ios/.
 */
function findConsumerProjectRoot(startDir) {
  let dir = path.resolve(startDir);
  for (let i = 0; i < 10; i++) {
    const hasAndroid = fs.existsSync(path.join(dir, 'android'));
    const hasIos = fs.existsSync(path.join(dir, 'ios'));
    const hasPkg = fs.existsSync(path.join(dir, 'package.json'));
    if (hasPkg && (hasAndroid || hasIos)) {
      return { root: dir, hasAndroid, hasIos };
    }
    const parent = path.dirname(dir);
    if (parent === dir) break;
    dir = parent;
  }
  return null;
}

// Try the standard layout first (node_modules/@cashify/video-optimizer-rn/scripts/ →
// walk up four levels to the consumer root). If that doesn't yield a project
// (manual invocation, monorepo, unusual layout), fall back to process.cwd().
const consumer =
  findConsumerProjectRoot(path.resolve(__dirname, '..', '..', '..', '..')) ||
  findConsumerProjectRoot(process.env.INIT_CWD || process.cwd());

if (!consumer) {
  warn('Could not locate a React Native project (no android/ or ios/ found above node_modules).');
  warn('If this is a monorepo or unusual layout, run `npx video-optimizer-rn install-binaries`');
  warn('from inside your app directory to install manually.');
  process.exit(0); // soft-fail — don't break the install
}

log(`Installing FFmpeg ${versions.version} binaries into ${consumer.root}`);

(async () => {
  const tasks = [];
  if (consumer.hasAndroid) {
    tasks.push(
      installAndroid({
        androidDir: path.join(consumer.root, 'android'),
        versions,
        log,
      }).then((res) => ['android', res]),
    );
  }
  if (consumer.hasIos) {
    tasks.push(
      installIos({
        iosDir: path.join(consumer.root, 'ios'),
        versions,
        log,
      }).then((res) => ['ios', res]),
    );
  }

  try {
    await Promise.all(tasks);
  } catch (e) {
    err(`Binary install failed: ${e.message}`);
    err('You can retry with `npx video-optimizer-rn install-binaries`.');
    process.exit(1);
  }

  // Print copy-paste setup snippets the user still has to apply themselves.
  console.log('');
  log('Binaries installed. Two manual setup steps remain:');
  console.log('');
  if (consumer.hasAndroid) {
    console.log('  Android — in android/settings.gradle, add to dependencyResolutionManagement.repositories:');
    console.log('');
    console.log('      maven { url = uri("local-maven") }');
    console.log('');
    console.log('  Android — in android/app/build.gradle, add to dependencies:');
    console.log('');
    console.log('      implementation \'com.arthenica:smart-exception-java:0.2.1\'');
    console.log('      implementation \'com.arthenica:smart-exception-common:0.2.1\'');
    console.log('');
  }
  if (consumer.hasIos) {
    console.log('  iOS — in ios/Podfile, replace the ffmpeg-kit pod block with:');
    console.log('');
    console.log('      pod \'ffmpeg-kit-ios-full-gpl\', :path => \'local-frameworks\'');
    console.log('      pod \'ffmpeg-kit-react-native\',');
    console.log('        :subspecs => [\'full-gpl-lts\'],');
    console.log('        :podspec => \'../node_modules/ffmpeg-kit-react-native/ffmpeg-kit-react-native.podspec\'');
    console.log('');
    console.log('  iOS — then run: cd ios && pod install');
    console.log('');
  }
  log('Full setup details in https://github.com/akashnegi-cashify/video-optimizer-rn#installation');
})();
