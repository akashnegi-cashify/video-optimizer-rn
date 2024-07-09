import 'dart:async';

import 'package:components/components.dart';
import 'package:core/core.dart';
import 'package:core/src/http/interceptor/global_retry_when_interceptor.dart';
import 'package:core/src/http/utils/retry_when_util.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/interceptors/auth/request_headers.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/utils/media_upload/image_optimiser_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/session/session_expired_callback.dart';
import 'session_stream.helper.dart';

class AuthHeaderInterceptor extends HttpRetryWhenInterceptor {
  static const List<int> retryStatusCodes = [ApiErrorCodes.USER_SESSION_EXPIRE];
  static const AUTH_HEADER_INTERCEPTOR = 'AUTH_HEADER_INTERCEPTOR';

  AuthHeaderInterceptor() : super(getRetryWhenFactory(retryStatusCodes, 1));

  HttpRequest _addXUserAuthHeader(HttpRequest req) {
    String userAuth = AuthHandler().userAuth!;
    HttpHeaders headers = req.httpHeaders;

    if (headers.has(CoreHeaders.xSSOTokenKey)) {
      return req.clone(setHeaders: {CoreHeaders.xSSOTokenKey: userAuth});
    } else if (headers.has(AppHeaders.X_USER_AUTH_KEY)) {
      return req.clone(setHeaders: {AppHeaders.X_USER_AUTH_KEY: userAuth});
    }
    return req;
  }

  StreamTransformer<HttpResponse, HttpResponse> _userAuthStreamTransformer() {
    return StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add(data);
      },
      handleError: (error, stackTrace, sink) {
        if (isHandleError(error, retryStatusCodes)) {
          print('Session expire: Invalid user auth. Removing auth from AuthHandler');
          AppPreferences().resetAndClearAll();
        }
        sink.addError(error, stackTrace);
      },
    );
  }

  bool _userAuthRequired(HttpHeaders headers) {
    return headers.has(AppHeaders.X_USER_AUTH_KEY) || headers.has(CoreHeaders.xSSOTokenKey);
  }

  @override
  Stream<HttpResponse> interceptRequest(HttpRequest req, HttpHandler next) {
    String? userAuth = AuthHandler().userAuth;
    HttpHeaders headers = req.httpHeaders;
    if (!_userAuthRequired(headers)) {
      return next.handle(req).transform(_userAuthStreamTransformer());
    }
    if (userAuth != null) {
      return next.handle(_addXUserAuthHeader(req)).transform(_userAuthStreamTransformer());
    }
    return SessionStreamHelper.handleSessionExpire(SessionExpiredCallback().getCallback())
        .switchMap((auth) => next.handle(_addXUserAuthHeader(req)).transform(_userAuthStreamTransformer()));
  }

  @override
  String getKey() {
    return 'AuthHeaderInterceptor';
  }
}
