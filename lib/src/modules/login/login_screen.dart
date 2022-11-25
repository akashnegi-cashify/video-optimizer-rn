import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/login/providers/login_provider.dart';
import 'package:flutter_trc/src/modules/login/widgets/login_widget.dart';
import 'package:provider/provider.dart';
import 'l10n.dart';

class LoginScreen extends StatelessWidget {
  static const route = '/login';

  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider<TRCLoginProvider>(
      create: (_) => TRCLoginProvider(),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        return Scaffold(
          appBar: CshHeader(l10n.techRefurbishCenter, showBackBtn: false),
          body: const LoginWidget(),
        );
      },
    );
  }
}
