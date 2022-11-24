import 'package:components/components.dart';
import 'package:console_flutter_template/src/actions/project_actions.dart';
import 'package:console_flutter_template/src/environments/types.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';


import 'environments/environment_config.dart';
import 'environments/environments.dart';
import 'interceptors/header/header_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'libraries/analytics/analytics_controller.dart';

const RUNNING_SYSTEM_ENV = String.fromEnvironment('env', defaultValue: 'prod');

class AppInitializer {
  static init({List<AnalyticTrackers>? trackers, Map<String, HttpInterceptorFactory>? interceptors}) async {
    await AuthHandler().syncAuth();
    // await FirebaseHelper().initFirebase();
    await AnalyticsController.init(trackers);
    await _initApp(interceptors: interceptors);
  }

  static _initApp({Map<String, HttpInterceptorFactory>? interceptors}) async {
    initEnvironment();

    _setLogLevel(environment);
    _registerProjectActions();

    // ChooseLanguageHelper.init();

    interceptors ??= <String, HttpInterceptorFactory>{};
    if (environment?.mode != EnvironmentTypes.PROD.value) {
      interceptors[LogInterceptor.LOG_INTERCEPTOR] = () => LogInterceptor();
    }
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
}
