import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';

class PageNotFoundScreen extends StatelessWidget {
  static const route = '/no_page_found';

  const PageNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TrcHeader("No Page Found"),
      body: Center(
        child: Text("No Page Route Found"),
      ),
    );
  }
}
