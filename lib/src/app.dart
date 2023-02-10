import 'dart:async';

import 'package:components/components.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_trc/src/modules/elss/screens/add_device_media_screen.dart';
import 'package:flutter_trc/src/modules/elss/screens/add_part_screen.dart';
import 'package:flutter_trc/src/modules/elss/screens/elss_screen.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/widgets/wip_detail_widget.dart';
import 'package:flutter_trc/src/modules/engineer/widgets/engineer_home_widget.dart';
import 'package:flutter_trc/src/modules/home/home_screen.dart';
import 'package:flutter_trc/src/modules/login/login_screen.dart';
import 'package:flutter_trc/src/modules/rider/rider_home_widget.dart';
import 'package:flutter_trc/src/screens/barcode_scanner_screen.dart';
import 'package:flutter_trc/src/theme/project_theme.dart';
import 'package:flutter_trc/src/utils/csh_route_observer.dart';
import 'package:localization/localization/csh_localization.dart';
import 'package:localization/localization/language_util.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'amplify/amplify_provider.dart';
import 'common/cashify_alert/cashify_alert_handler.dart';
import 'common/session/session_expired_callback.dart';
import 'libraries/alice/csh_alice.dart';
import 'modules/elss/providers/user_session_provider.dart';
import 'modules/elss/screens/part_selection_screen.dart';
import 'modules/elss/screens/qc_and_trc_option_screen.dart';
import 'modules/engineer/manage_parts/manage_parts_widget.dart';
import 'modules/engineer/my_devices/widgets/my_devices_widget.dart';
import 'modules/engineer/my_devices/wip_devices/view_parts/widgets/assigned_parts_widget.dart';
import 'modules/engineer/my_devices/wip_devices/view_parts/widgets/order_part_widget.dart';
import 'modules/engineer/my_devices/wip_devices/view_parts/widgets/self_assign_part_widget.dart';
import 'modules/engineer/view_reports/view_report_widget.dart';
import 'modules/rider/pending_delivery/deliver/widgets/delivery_deliver_engineer_parts_widget.dart';
import 'modules/rider/pending_pickup/receive/widgets/pickup_receive_engineer_parts_widget.dart';
import 'modules/rubbing/widgets/received_rubbing_devices_widget.dart';
import 'modules/rubbing/widgets/rubbing_home_widget.dart';
import 'modules/splash/splash_screen.dart';

class CashifyApp extends StatefulWidget {
  final String appName;

  const CashifyApp(this.appName, {Key? key}) : super(key: key);

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
        case ConnectivityResult.vpn:
          // TODO: Handle this case.w
          break;
      }
    });
  }

  Future<String> onSessionExpire() async {
    AuthHandler().onSessionExpire();
    Navigator.of(_navKey!.currentState!.context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
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
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => UserSessionProvider()),
          ChangeNotifierProvider<AmplifyProvider>(
            lazy: false,
            create: (_) => AmplifyProvider(),
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
                    ELSSScreen.route: (_) => const ELSSScreen(),
                    BarcodeScanWidget.route: (_) => const BarcodeScanWidget(),
                    PartSelectionScreen.route: (_) => const PartSelectionScreen(),
                    AddPartScreen.route: (_) => const AddPartScreen(),
                    AddDeviceMediaScreen.route: (_) => const AddDeviceMediaScreen(),
                    QcAndTRCOptionScreen.route: (_) => const QcAndTRCOptionScreen(),
                    // rubbing role screens
                    RubbingHomeWidget.route: (_) => const RubbingHomeWidget(),
                    ReceivedRubbingDevicesWidget.route: (_) => const ReceivedRubbingDevicesWidget(),

                    // engineer routes
                    EngineerHomeScreen.route: (_) => const EngineerHomeScreen(),
                    MyDevicesScreen.route: (_) => const MyDevicesScreen(),
                    AssignedPartsScreen.route: (_) => const AssignedPartsScreen(),
                    WIPDetailScreen.route: (_) => const WIPDetailScreen(),
                    SelfAssignPartScreen.route: (_) => const SelfAssignPartScreen(),
                    OrderPartScreen.route: (_) => const OrderPartScreen(),
                    ManagePartsScreen.route: (_) => const ManagePartsScreen(),
                    ViewReportScreen.route: (_) => const ViewReportScreen(),
                    // rider role screens
                    RiderHomeScreen.route: (_) => const RiderHomeScreen(),
                    DeliveryDeliverEngineerPartsScreen.route: (_) => const DeliveryDeliverEngineerPartsScreen(),
                    PickupReceiveEngineerPartsScreen.route: (_) => const PickupReceiveEngineerPartsScreen(),
                  },
                  initialRoute: SplashScreen.route,
                );
              });
        },
      ),
    );
  }
}
