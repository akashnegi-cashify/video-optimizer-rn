import 'package:components/components.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/libraries/firebase/firebase_helper.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:flutter_trc/src/libraries/logging/logging_service.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/utils/device_info_util.dart';
import 'package:localization/localization.dart';

import 'actions/project_actions.dart';
import 'app_builder/app_builder.dart';
import 'environments/environment_config.dart';
import 'environments/environments.dart';
import 'environments/types.dart';
import 'interceptors/auth/auth_header_interceptor.dart';
import 'interceptors/header/header_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'l10n/messages_all.dart';
import 'libraries/analytics/analytics_controller.dart';

const RUNNING_SYSTEM_ENV = String.fromEnvironment('env', defaultValue: 'prod');

class AppInitializer {
  static init({Map<String, HttpInterceptorFactory>? interceptors}) async {
    await AppPreferences.instance.init();
    await AuthHandler().syncAuth();
    _hydrateAuthHandlerFromAppStorage();
    await FirebaseHelper().initFirebase();
    await RemoteConfigHelper().initialize();
    await LoggingService.initialize();
    await DeviceInfoUtil.init();
    await AnalyticsController.init();
    await _initApp(interceptors: interceptors);
  }

  static _initApp({Map<String, HttpInterceptorFactory>? interceptors}) async {
    initEnvironment();

    // init localisation
    Localization.setup(initializeMessages: initializeMessages);

    _setLogLevel(environment);
    _registerProjectActions();
    AppComponentBuilder();

    interceptors ??= <String, HttpInterceptorFactory>{};
    if (!isWeb() && environment?.enableAlice == true) {
      interceptors[LogInterceptor.LOG_INTERCEPTOR] = () => LogInterceptor();
    }
    interceptors[AuthHeaderInterceptor.AUTH_HEADER_INTERCEPTOR] = () => AuthHeaderInterceptor();
    String xAppOS = await DeviceUtil.getXOSAPPHeader();
    interceptors[HeaderInterceptor.HEADER_INTERCEPTOR] = () => HeaderInterceptor(xAppOS);

    String authUrl = getAuthUrl(environment!);

    HttpClient.init(
        baseUrl: environment?.baseUrl!,
        apiUrl: environment?.apiUrl!,
        tokenUrl: authUrl,
        interceptorFactoryMap: interceptors);
  }

  static _setLogLevel(Environment? environment) {
    if (environment == null) {
      return;
    }
    if (environment.mode == EnvironmentTypes.BETA.value || environment.mode == EnvironmentTypes.PROD.value) {
      Logger.logLevel = LogLevel.All;
    }
  }

  static void _registerProjectActions() {
    ProjectActions.getAction = ProjectActionType.getAction;
  }

  // Covers RN-wrote-while-Flutter-cold: AppStorage (mmapID lego_shared) may have a token
  // written by RN that AuthHandler's in-memory cache (rehydrated from SharedPreferences) is
  // unaware of. Push it into AuthHandler so the Flutter HTTP interceptor reads the fresh value.
  static void _hydrateAuthHandlerFromAppStorage() {
    final currentAuth = AuthHandler().userAuth;
    if (currentAuth != null && currentAuth.isNotEmpty) return;
    final shared = AppPreferences.app.getAuthToken();
    if (shared != null && shared.isNotEmpty) {
      AuthHandler().setUserAuth(shared);
    }
  }
}
