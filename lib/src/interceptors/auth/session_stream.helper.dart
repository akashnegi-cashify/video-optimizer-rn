import 'dart:async';

import 'package:rxdart/rxdart.dart';

class SessionStreamHelper {
  static BehaviorSubject<String>? subject;

  static Stream<String> handleSessionExpire(Future<String> Function()? sessionCallback) {
    if (subject == null || (subject?.isClosed ?? false)) {
      subject = BehaviorSubject<String>();
    } else {
      return subject!.stream;
    }

    if (sessionCallback != null) {
      sessionCallback().then((value) {
        print('sessionCallback success: $value');
        subject?.add(value);
        subject?.close();
        subject = null;
      }, onError: (error) {
        print('sessionCallback error: $error');
        subject?.addError(error);
        subject?.close();
        subject = null;
      });
    }

    return subject!.stream;
  }
}
