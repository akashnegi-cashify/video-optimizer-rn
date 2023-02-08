import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../widgets/elss_home_widget.dart';

class ElssHomeScreen extends StatefulWidget {
  static const route = "/elss-home-screen";

  const ElssHomeScreen({Key? key}) : super(key: key);

  @override
  State<ElssHomeScreen> createState() => _ElssHomeScreenState();
}

class _ElssHomeScreenState extends State<ElssHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);

    return Scaffold(
      appBar: CshHeader(
        l10n.elssHome,
        showBackBtn: false,
      ),
      body: const ElssHomeWidget(),
    );
  }
}
