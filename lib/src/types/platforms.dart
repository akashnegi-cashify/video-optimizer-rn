enum Platform { ANDROID, IOS, WEB, UNKNOWN }

extension PlatformExtension on Platform {
  get value {
    switch (this) {
      case Platform.ANDROID:
        return 'android';
      case Platform.IOS:
        return 'iOS';
      case Platform.WEB:
        return 'web';
      default:
        return null;
    }
  }
}
