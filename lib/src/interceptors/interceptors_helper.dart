import 'package:core/core.dart';

import 'auth/auth_header_interceptor.dart';

class InterceptorsHelper {
  static Map<String, HttpInterceptorFactory> getGlobalInterceptors() {
    final Map<String, HttpInterceptorFactory> _interceptorMap = <String, HttpInterceptorFactory>{};
    _interceptorMap[AuthHeaderInterceptor.AUTH_HEADER_INTERCEPTOR] = () => AuthHeaderInterceptor();
    return _interceptorMap;
  }
}
