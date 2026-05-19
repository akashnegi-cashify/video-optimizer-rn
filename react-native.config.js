module.exports = {
  project: {
    ios: {},
    android: {},
  },
  // Single source of truth for fonts lives in flutter_module/assets/fonts/.
  // Run `yarn link-assets` (alias for `react-native-asset`) to copy these into
  // android/app/src/main/assets/fonts/ and add UIAppFonts entries to iOS Info.plist.
  assets: ['./flutter_module/assets/fonts/'],
};
