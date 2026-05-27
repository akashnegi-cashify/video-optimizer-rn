const path = require('path');
const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config');

/**
 * Metro configuration
 * https://reactnative.dev/docs/metro
 *
 * The `@reglobe/admin-ui-*` packages are linked via yarn `portal:` entries, which materialise
 * as symlinks under `node_modules/@reglobe/`. Metro doesn't traverse symlinks by default and
 * also won't watch files outside the project root — so we both enable symlink resolution
 * and add the portal targets to `watchFolders`.
 *
 * @type {import('@react-native/metro-config').MetroConfig}
 */
const adminUiRoot = path.resolve(__dirname, '../flutter_admin_ui/react');
const hostNodeModules = path.resolve(__dirname, 'node_modules');

const config = {
  resolver: {
    unstable_enableSymlinks: true,
    // With symlinks enabled, files inside the portal package resolve relative to the
    // portal target's realpath — which has no `node_modules`. Fall back to the host
    // app's `node_modules` so shared deps (react, react-native, @babel/runtime, etc.)
    // resolve correctly.
    nodeModulesPaths: [hostNodeModules],
  },
  watchFolders: [adminUiRoot],
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
