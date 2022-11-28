import 'dart:async';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import '../auth/request_headers.dart';

class HeaderInterceptor extends HttpInterceptor {
  static const HEADER_INTERCEPTOR = 'HEADER_INTERCEPTOR';

  String appOSHeaderValue;

  HeaderInterceptor(this.appOSHeaderValue);

  @override
  Stream<HttpResponse> intercept(HttpRequest req, HttpHandler next) {
    if (identical(req.initiator, this)) {
      return next.handle(req);
    }
    if (req.serviceGroup != null) {
      return next.handle(_addCommonHeaders(req));
    }

    return next.handle(req);
  }

  HttpRequest _addCommonHeaders(HttpRequest req) {
    Map<String, String> headers = {
      AppHeaders.X_APP_OS_KEY: appOSHeaderValue,
    };

    headers[AppHeaders.X_APP_LANGUAGE_KEY] = LocaleProvider.languageCode;

    return req.clone(setHeaders: headers);
  }

  @override
  String getKey() {
    return 'HeaderInterceptor';
  }
}
