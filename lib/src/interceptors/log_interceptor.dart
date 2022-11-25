import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';

import '../libraries/alice/csh_alice.dart';

class LogInterceptor implements HttpInterceptor {
  static const LOG_INTERCEPTOR = 'LOG_INTERCEPTOR';

  CshAlice cshAlice = CshAlice(showNotification: true, showInspectorOnShake: false);

  @override
  Stream<HttpResponse> intercept(HttpRequest req, HttpHandler next) {
    Logger.log("Method: ", req.method);
    Logger.log("Req: ", req.url);
    Logger.log("Header: ", req.httpHeaders);
    Logger.log("Params: ", jsonEncode(req.httpParams.getAllParams()));
    Logger.log("Body: ", req.body);

    return next.handle(req).transform(oAuthStreamTransformer());
  }

  StreamTransformer<HttpResponse, HttpResponse> oAuthStreamTransformer() {
    return StreamTransformer.fromHandlers(
      handleData: (HttpResponse data, sink) {
        sink.add(data);
        if (cshAlice.isActive()) {
          dynamic body;
          if (data.request?.body is HttpMultipartFormData) {
            body = (data.request?.body as HttpMultipartFormData).fields.toString();
          } else {
            body = data.request?.body?.toString();
          }
          if (data.response != null) {
            cshAlice.alice?.onHttpResponse(
              data.response!,
              body: {
                'body': body,
                'params': data.request?.httpParams.getAllParams(),
              },
            );
          }
        }
      },
      handleError: (error, stackTrace, sink) {
        if (error is HttpErrorResponse) {
          if (cshAlice.alice != null) {
            dynamic body;
            if (error.request?.body is HttpMultipartFormData) {
              body = (error.request?.body as HttpMultipartFormData).fields.toString();
            } else {
              body = error.request?.body?.toString();
            }
            if (error.response != null) {
              cshAlice.alice?.onHttpResponse(error.response!, body: {
                'body': body,
                'params': error.request?.httpParams.getAllParams(),
              });
            }
          }
        }
        sink.addError(error, stackTrace);
      },
    );
  }

  @override
  String getKey() {
    return "LogInterceptor";
  }
}
