import 'package:components/components.dart';
import 'package:console_flutter_template/src/modules/pd/pd_screen_example.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:console_flutter_template/src/common/resources/app_update/app_version.service.dart';
import 'package:console_flutter_template/src/types/client_ids.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../modules/dynamic_ui/dynamic_ui_screen.dart';

class HomeScreen extends StatefulWidget {
  static const route = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    getPackageInfo();
    super.initState();
  }

  void getPackageInfo() async {
    Future.delayed(const Duration(seconds: 2), () {
      PackageInfo.fromPlatform().then((info) {
        setState(() {
          packageInfo = info;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CshScaffold(
      headerConfig: HeaderConfig(headerTitle: "Home Screen"),
      middleSection: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: packageInfo != null
                ? Column(
                    children: [
                      CshMediumButton(
                        text: "Users",
                        onPressed: () {
                          Navigator.of(context).pushNamed(UserListScreen.route);
                        },
                      ),
                      const SizedBox(height: 16),

                      CshMediumButton(
                        text: "Users with Quick filter",
                        onPressed: () {
                          Navigator.of(context).pushNamed(UserListWithQuickFilterScreen.route);
                        },
                      ),
                      const SizedBox(height: 16),

                      CshMediumButton(
                        text: "Marketplace",
                        onPressed: () {
                          Navigator.of(context).pushNamed(MarketplaceScreen.route);
                        },
                      ),
                      Text(
                        'Package Name  :  ${packageInfo?.packageName}',
                        style: theme.primaryTextTheme.headline5,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'App Name  :  ${packageInfo?.appName}',
                        style: theme.primaryTextTheme.headline5,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'App Version  :   ${packageInfo?.version}',
                        style: theme.primaryTextTheme.headline5,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Build Number  :  ${packageInfo?.buildNumber}',
                        style: theme.primaryTextTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        'Note  :  Complete the TODOs in boilerplate code and remove the boilerplate entries according to your project.',
                        style: theme.textTheme.subtitle1,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AppVersionService.getAppVersion(ClientIds.ANDROID.value, 'v1', '1.0.0').listen((event) {
                            Logger.log('Success');
                          }, onError: (error) {
                            Logger.log('Error');
                          });
                        },
                        child: const Text('Api Request'),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CshMediumButton(
                        text: "Dynamic Ui",
                        onPressed: () {
                          Navigator.of(context).pushNamed(DynamicUIScreen.route);
                        },
                      ),

                      const SizedBox(
                        height: 32,
                      ),
                      CshMediumButton(
                        text: "PD",
                        onPressed: () {
                          Navigator.of(context).pushNamed(PDScreenExample.route);
                        },
                      ),
                    ],
                  )
                : const Text('Loading package info, please wait...'),
          ),
        ),
      ),
    );
  }
}
