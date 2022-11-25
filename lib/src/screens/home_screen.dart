import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

    return Scaffold(
      appBar: CshHeader(
        "Home",
      ),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
