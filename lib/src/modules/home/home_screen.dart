import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/home/providers/home_provider.dart';
import 'package:flutter_trc/src/modules/home/widgets/home_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenProviders>(
      create: (_) => HomeScreenProviders(),
      lazy: false,
      child: Scaffold(
        appBar: CshHeader("home"),
        body: HomeWidget(),
      ),
    );
  }
}
