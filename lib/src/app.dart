import 'dart:async';

import 'package:components/components.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_trc/src/modules/home/home_screen.dart';
import 'package:flutter_trc/src/modules/login/login_screen.dart';
import 'package:flutter_trc/src/theme/project_theme.dart';
import 'package:flutter_trc/src/utils/csh_route_observer.dart';

import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'common/cashify_alert/cashify_alert_handler.dart';
import 'common/session/session_expired_callback.dart';
import 'libraries/alice/csh_alice.dart';
import 'localization/csh_localization.dart';
import 'modules/splash/splash_screen.dart';

class CashifyApp extends StatefulWidget {
  final String appName;

  const CashifyApp(this.appName, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _CashifyAppState createState() => _CashifyAppState();
}

class _CashifyAppState extends State<CashifyApp> {
  final CshAlice _cshAlice = CshAlice(showNotification: true, showInspectorOnShake: false);
  GlobalKey<NavigatorState>? _navKey = GlobalKey<NavigatorState>();
  StreamSubscription<ConnectivityResult>? _connectionSubscription;

  @override
  void initState() {
    super.initState();

    if (_cshAlice.alice != null) {
      _navKey = _cshAlice.alice?.getNavigatorKey();
    }

    SessionExpiredCallback().setCallback(onSessionExpire);
    CashifyAlertHandler().setAlertCallback(registerAlert);

    _connectionSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      switch (result) {
        case ConnectivityResult.none:
        // TODO: Dev Action Required -> show no internet ui
        // Navigator.pushReplacementNamed(_navKey.currentState.context, NoInternetScreen.routeName);
          break;

        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
        // TODO: Dev Action Required -> Pass the NoInternetScreen route name
          if (_navKey != null && _navKey!.currentContext != null) {
            CshRouteObserver().openScreenBeforeInternetError(_navKey!.currentContext!, '' /* Route name */);
          }
          break;
        case ConnectivityResult.bluetooth:
        // TODO: Handle this case.
          break;
        case ConnectivityResult.ethernet:
        // TODO: Handle this case.
          break;
      }
    });
  }

  Future<String> onSessionExpire() async {
    AuthHandler().onSessionExpire();
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
    return Future.error("Session Expire");
  }

  Future<bool> registerAlert(CashifyAlert alert) async {
    return CashifyAlertHandler.instance.onAlertReceived(alert, _navKey?.currentContext);
  }

  @override
  void dispose() {
    if (_connectionSubscription != null) {
      _connectionSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) =>
                LocaleProvider(
                  onLoad: (Locale locale) {
                    CshLocalizations.load(locale);
                  },
                ),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (_) => ConsoleDrawerProvider("/v1/menu-header", serviceGroup: ServiceGroups.console),
          ),
        ],
        builder: (BuildContext context, _) {
          LocaleProvider localProvider = Provider.of<LocaleProvider>(context);
          return CshThemeWidget(
              getProjectTheme: (bool isDarkTheme) => ProjectTheme.getTheme(isDarkTheme),
              builder: (ThemeData theme) {
                return MaterialApp(
                  navigatorKey: _navKey,
                  locale: localProvider.locale,
                  theme: theme,
                  navigatorObservers: [
                    CshRouteObserver().instance,
                    SentryNavigatorObserver(),
                  ],
                  title: BaseL10n(context).appName,
                  localizationsDelegates: const [
                    CshLocalizationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],

                  supportedLocales: LanguageUtil.getSupportedLanguageListLocale(),
                  routes: {
                    SplashScreen.route: (_) => const SplashScreen(),
                    LoginScreen.route: (_) => const LoginScreen(),
                    HomeScreen.route: (_) => const HomeScreen(),
                  },
                  onUnknownRoute: (settings) {
                    return MaterialPageRoute(
                        builder: (context) {
                          return const PageNotFoundScreen();
                        },
                        settings: settings);
                  },
                  initialRoute: SplashScreen.route,
                  // home: const HomeScreen(),
                );
              });
        },
      ),
    );
  }
}
