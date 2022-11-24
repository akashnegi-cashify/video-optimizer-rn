import 'dart:async';

class SessionExpiredCallback {
  static SessionExpiredCallback instance = SessionExpiredCallback._internal();

  Future<String> Function()? _onSessionExpire;

  factory SessionExpiredCallback() {
    return instance;
  }

  SessionExpiredCallback._internal();

  Future<String> Function()? getCallback() {
    return _onSessionExpire;
  }

  void setCallback(Future<String> Function() onSessionExpire) {
    _onSessionExpire = onSessionExpire;
  }
}
