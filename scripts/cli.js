#!/usr/bin/env node
// Manual fallback for when postinstall scripts are disabled
// (--ignore-scripts, Yarn 4 enableScripts: false, corporate npm proxies, etc.).
//
// Usage:
//   npx video-optimizer-rn install-binaries

const cmd = process.argv[2];

if (cmd === 'install-binaries' || cmd === 'install') {
  require('./postinstall.js');
} else {
  console.log('@cashify/video-optimizer-rn CLI');
  console.log('');
  console.log('Commands:');
  console.log('  install-binaries   Download FFmpeg binaries into the current project.');
  console.log('');
  console.log('Run from the root of your React Native app.');
  process.exit(cmd ? 1 : 0);
}
