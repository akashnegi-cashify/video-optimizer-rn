enum HostPlatform { ANDROID, IOS, WEB, UNKNOWN }

extension PlatformExtension on HostPlatform {
  get value {
    switch (this) {
      case HostPlatform.ANDROID:
        return 'android';
      case HostPlatform.IOS:
        return 'iOS';
      case HostPlatform.WEB:
        return 'web';
      default:
        return null;
    }
  }
}
