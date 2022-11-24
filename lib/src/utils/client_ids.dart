enum ClientIds { ANDROID, IOS, WEB }

// TODO: Dev Action Required -> Update the client ids for each platform
extension ClientIdsExtension on ClientIds {
  get value {
    switch (this) {
      case ClientIds.ANDROID:
        return 'central-admin-panel';
      case ClientIds.IOS:
        return 'central-admin-panel';
      case ClientIds.WEB:
        return 'central-admin-panel';

      default:
        return 'central-admin-panel';
    }
  }
}
