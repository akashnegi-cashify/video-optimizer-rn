import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:console_flutter_template/src/common/cashify_alert/cashify_alert_handler.dart';
import 'package:core_widgets/core_widgets.dart';

class CashifyAlertInterceptor extends HttpInterceptor {
  static const CASHIFY_ALERT_INTERCEPTOR = 'CASHIFY_ALERT_INTERCEPTOR';

  @override
  Stream<HttpResponse> intercept(HttpRequest req, HttpHandler next) {
    return next.handle(req).asyncMap((event) {
      StreamController<HttpResponse> streamController = StreamController();

      CashifyAlert? alert = mayBe(() => CashifyAlert.fromJson(jsonDecode(event.body)['__ca']));

      //TODO added for testing
      // if (req.url.path.contains('relationship-manager')) {
      //   alert = CashifyAlert.fromJson({
      //     "_t": "Title",
      //     "_m": "Message goes here",
      //     "pbt": "Yes",
      //     "nbt": "No",
      //     "_a": {
      //       "at": "ilink",
      //       "ad": {"url": "https://storefront.stage.cashify.in/contact-us"}
      //     }
      //   });
      // }

      if (alert != null) {
        CashifyAlertHandler.instance.registerAlertCallback(alert).then((value) {
          streamController.add(event);
        }, onError: (e) {
          streamController.add(event);
        });
      }
      return streamController.stream.first;
    });
  }

  @override
  String getKey() {
    return 'CashifyAlertInterceptor';
  }
}
