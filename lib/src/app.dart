import 'dart:async';

import 'package:builder_project/builder_project.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_trc/qc/qc_routes.dart';
import 'package:flutter_trc/rms/rms_routes.dart';
import 'package:flutter_trc/shipex/shipex_routes.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/theme/project_theme.dart';
import 'package:flutter_trc/src/utils/csh_route_observer.dart';
import 'package:flutter_trc/trc/trc_routes.dart';
import 'package:localization/localization/csh_localization.dart';
import 'package:localization/localization/language_util.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:provider/provider.dart';

import './l10n.dart';
import 'app_initializer.dart';
import 'common/cashify_alert/cashify_alert_handler.dart';
import 'common/session/session_expired_callback.dart';
import 'libraries/alice/csh_alice.dart';
import 'modules/elss/common_providers/user_session_provider.dart';
import 'modules/login/screens/trc_and_qc_login_screen.dart';
import 'modules/splash/splash_screen.dart';

class CashifyApp extends StatefulWidget {
  final String appName;

  const CashifyApp(this.appName, {Key? key}) : super(key: key);

  @override
  _CashifyAppState createState() => _CashifyAppState();
}

class _CashifyAppState extends State<CashifyApp> {
  final CshAlice _cshAlice = CshAlice(showNotification: true, showInspectorOnShake: true);
  GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    if (_cshAlice.alice != null) {
      _navKey = _cshAlice.alice?.getNavigatorKey();
    }
    AppNavKey.navKey = _navKey;

    SessionExpiredCallback().setCallback(onSessionExpire);
    CashifyAlertHandler().setAlertCallback(registerAlert);
  }

  Future<String> onSessionExpire() async {
    if (AppPreferences.app.getLoginType() == LoginTypes.qcLogin.value) {
      await AppPreferences.qc.clear();
    }
    await AppPreferences.instance.resetAndClearAll();
    Navigator.of(_navKey!.currentState!.context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
    return Future.error("Session Expire");
  }

  Future<bool> registerAlert(CashifyAlert alert) async {
    return CashifyAlertHandler.instance.onAlertReceived(alert, _navKey?.currentContext);
  }

  @override
  void dispose() {
    // if (_connectionSubscription != null) {
    //   _connectionSubscription!.cancel();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => UserSessionProvider(), lazy: false),
        ],
        builder: (BuildContext context, _) {
          LocaleProvider localProvider = Provider.of<LocaleProvider>(context);
          return CshThemeWidget(
            getProjectTheme: (bool isDarkTheme) => ProjectTheme.getTheme(isDarkTheme),
            builder: (ThemeData theme) {
              return BuilderApp(
                truncate: true,
                showDraft: false,
                skipVersionCheck: true,
                syncWidget: Container(
                  color: theme.primaryColor,
                ),
                env: RUNNING_SYSTEM_ENV,
                lang: localProvider.locale.languageCode,
                child: MaterialApp(
                  navigatorKey: _navKey,
                  locale: localProvider.locale,
                  theme: theme.copyWith(useMaterial3: false),
                  navigatorObservers: [
                    CshRouteObserver().instance,
                    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
                  ],
                  title: L10n(context).appName,
                  localizationsDelegates: const [
                    CshLocalizationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: LanguageUtil.getSupportedLanguageListLocale(),
                  routes: _AppRoutes.getRoutes(),
                  initialRoute: SplashScreen.route,
                ),
              );
              // rider role screens
            },
          );
        },
      ),
    );
  }
}

class _AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> routes = {};
    routes.addAll(TrcRoutes.getRoutes());
    routes.addAll(QcRoutes.getQcRoutes());
    routes.addAll(ShipexRoutes.getRoutes());
    routes.addAll(RmsRoutes.getRoutes());
    return routes;
  }
}

class AppNavKey {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
}
